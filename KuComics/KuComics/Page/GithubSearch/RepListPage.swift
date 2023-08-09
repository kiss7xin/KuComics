//
//  RepListPage.swift
//  KuComics
//
//  Created by weixin on 2023/8/9.
//

import SwiftUI
import Combine

struct RepListPage: View {
    @Binding var isShowDrawer: Bool
    
    var body: some View {
        RepListView(vm: .init())
    }
}

// MARK: RepListView

struct RepListView: View {
    @ObservedObject var vm: RepListVM
    @State var str: String = "Swift"
  var body: some View {
    NavigationView {
        VStack {
            TextField("输入：", text: $str, onCommit: fetch)
            if $vm.isErrorShow.wrappedValue {
                Text("出错了")
            } else {
                List(vm.repos) { rep in
                  RepListCell(rep: rep)
                }
            }
//            .alert(isPresented: $vm.isErrorShow) { () -> Alert in
//              Alert(title: Text("出错了"), message: Text(vm.errorMessage))
//            }
        }
        .navigationBarTitle(Text("仓库"))
    }
    .onAppear {
//        vm.apply(.onAppear)
    }
  }
    
    private func fetch() {
        vm.apply(.search(key: str))
    }
}


struct RepListCell: View {
  @State var rep: RepoModel
  var body: some View {
    HStack() {
      VStack() {
        AsyncImage(url: URL(string: rep.owner.avatarUrl ?? ""), content: { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        },
        placeholder: {
          ProgressView()
            .frame(width: 100, height: 100)
        })
        Text("\(rep.owner.login)")
          .font(.system(size: 10))
      }
      VStack(alignment: .leading, spacing: 10) {
        Text("\(rep.name)")
          .font(.title)
        Text("\(rep.stargazersCount)")
          .font(.title3)
        Text("\(String(describing: rep.description ?? ""))")
        Text("\(String(describing: rep.language ?? ""))")
          .font(.title3)
      }
      .font(.system(size: 14))
    }
     
  }
}

// MARK: Repo View Model
final class RepListVM: ObservableObject, UnidirectionalDataFlowType {
    typealias InputType = Input
    private var cancellables: [AnyCancellable] = []
    
    @Published private var query: String = ""
    // Input
    enum Input {
        case search(key: String)
    }
    
    func apply(_ input: Input) {
        switch input {
        case .search(let key):
            print("key:" + key)
            self.query = key
        }
    }
    
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
    // Output
    @Published private(set) var repos: [RepoModel] = []
    @Published var isErrorShow = false
    @Published var errorMessage = ""
    @Published private(set) var shouldShowIcon = false
    
    private let resSubject = PassthroughSubject<SearchRepoModel, Never>()
    private let errSubject = PassthroughSubject<APISevError, Never>()
    
    private let apiSev: APISev
    
    init(apiSev: APISev = APISev()) {
        self.apiSev = apiSev
        bindInputs()
        bindOutputs()
    }
    
    private func bindInputs() {
        
        $query.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        
        let resPublisher = onAppearSubject.flatMap { [apiSev] in
            apiSev.response(from: SearchRepoRequest(qKey: "Swift"))
                .catch { [weak self] error -> Empty<SearchRepoModel, Never> in
                    self?.errSubject.send(error)
                    return .init()
                }
            }
            
        let resStream = resPublisher
            .share()
            .subscribe(resSubject)
        
        // 其它异步事件，比如日志等操作都可以做成Stream加到下面数组内。
        cancellables += [resStream]
    }
    
    private func bindOutputs() {
        let repStream = resSubject
            .map { $0.items }
            .assign(to: \.repos, on: self)
        let errMsgStream = errSubject
            .map { error -> String in
                switch error {
                case .resError: return "network error"
                case .parseError: return "parse error"
                }
            }
            .assign(to: \.errorMessage, on: self)
        let errStream = errSubject
            .map { _ in
                true
            }
            .assign(to: \.isErrorShow, on: self)
        cancellables += [repStream, errMsgStream, errStream]
    }
}

protocol UnidirectionalDataFlowType {
  associatedtype InputType
  func apply(_ input: InputType)
}

// MARK: Repo Request and Models

struct SearchRepoRequest: APIReqType {
    typealias Res = SearchRepoModel
   
    private var qKey: String = ""
    
    var path: String {
      return "/search/repositories"
    }
    
    var qItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: self.qKey),
            .init(name: "order", value: "desc")
        ]
    }
    
    init(qKey: String) {
        self.qKey = qKey
    }
}

struct SearchRepoModel: Decodable {
  var items: [RepoModel]
}

struct RepoModel: Decodable, Hashable, Identifiable {
  var id: Int64
  var name: String
  var fullName: String
  var description: String?
  var stargazersCount: Int = 0
  var language: String?
  var owner: OwnerModel
}

struct OwnerModel: Decodable, Hashable, Identifiable {
  var id: Int64
  var login: String
  var avatarUrl: String?
}

// MARK: API Request Fundation

enum APISevError: Error {
    case resError
    case parseError(Error)
}

protocol APIReqType {
  associatedtype Res: Decodable
  var path: String { get }
  var qItems: [URLQueryItem]? { get }
}

protocol APISevType {
  func response<Request>(from req: Request) -> AnyPublisher<Request.Res, APISevError> where Request: APIReqType
}

final class APISev: APISevType {
    
    private let rootUrl: URL
    init(rootUrl: URL = URL(string: "https://api.github.com")!) {
        self.rootUrl = rootUrl
    }
    
    func response<Request>(from req: Request) -> AnyPublisher<Request.Res, APISevError> where Request : APIReqType {
        let path = URL(string: req.path, relativeTo: rootUrl)!
        var comp = URLComponents(url: path, resolvingAgainstBaseURL: true)!
        comp.queryItems = req.qItems
        print(comp.url?.description ?? "url wrong")
        
        var req = URLRequest(url: comp.url!)
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let de = JSONDecoder()
        de.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.dataTaskPublisher(for: req)
            .map { data, response in
                print(String(decoding: data, as: UTF8.self))
                return data
            }
            .mapError { _ in
                APISevError.resError
            }
            .decode(type: Request.Res.self, decoder: de)
            .mapError(APISevError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}


struct RepListPage_Previews: PreviewProvider {
    static var previews: some View {
        RepListPage(isShowDrawer: .constant(false))
    }
}
