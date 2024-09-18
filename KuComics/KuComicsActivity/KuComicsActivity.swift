//
//  KuComicsActivity.swift
//  KuComicsActivity
//
//  Created by weixin on 2024/3/18.
//

import WidgetKit
import SwiftUI
import Kingfisher

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DetailEntry {
        let detail = ProductDetail(spuId: "", imageUrl: "https://www.w3cschool.cn/statics/images/course/pulpit.jpg", name: "御品膏方-人参枇杷草本膏", sellPrice: 120, marketPrice: 150)
        return DetailEntry(date: Date(), detail: detail)
    }

    func getSnapshot(in context: Context, completion: @escaping (DetailEntry) -> ()) {
        let detail = ProductDetail(spuId: "", imageUrl: "https://www.w3cschool.cn/statics/images/course/pulpit.jpg", name: "御品膏方-人参枇杷草本膏", sellPrice: 120, marketPrice: 150)
        let entry = DetailEntry(date: Date(), detail: detail)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DetailEntry] = []
        let currentDate = Date()
//        let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        
        let spuId = "105ff7a66cc04a89a1faf76782c0ef13"
        NetWork.requestModel(KangBossAPI.productDetail(spuId, ""), modelType: ProductDetail.self) { model in
            ImageDownloader.default.downloadImage(with: URL(string: model.imageUrl)!) { result in
                switch result {
                case .success(let imageResult):
                    let entry = DetailEntry(date: currentDate, detail: model, imageData: imageResult.originalData)
                    entries.append(entry)
                    let timeline = Timeline(entries: entries, policy: .atEnd)
                    completion(timeline)
                case .failure(_):
                    break
                }
            }
        } errorHandler: { error in
            let detail = ProductDetail(spuId: "", imageUrl: "https://www.w3cschool.cn/statics/images/course/pulpit.jpg", name: "请求错误", sellPrice: 120, marketPrice: 150)
            let entry = DetailEntry(date: currentDate, detail: detail)
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)

        }
    }
}

// 小组件的数据模型
struct DetailEntry: TimelineEntry {
    var date: Date
    var detail: ProductDetail
    var imageData: Data?
}

struct KuComicsActivityEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    var body: some View {
        VStack {
            ZStack {
                HStack(alignment: .center) {
                    Image("KB_Mine_Abount")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    Text("康老板商品")
                        .foregroundStyle(.white)
                        .font(.subheadline.bold())
                    Spacer()
                }
                .padding(8)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(.green)
            Spacer()
            HStack(alignment: .top, spacing: 8) {
                if let imageData = entry.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } else {
                    KFImage(URL(string: entry.detail.imageUrl))
                        .placeholder{
                            Rectangle().foregroundColor(Color.primary)}
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.detail.name)
                        .lineLimit(2)
                        .font(.subheadline)
                    Text("￥\(String(format: "%.f", entry.detail.sellPrice))")
                        .foregroundStyle(.red)
                        .font(.subheadline.bold())
                }
                if family != .systemSmall {
                    Spacer()
                }
            }
            .padding(6)
            Spacer()
        }
        .widgetBackground(Color.white)
        .widgetURL(URL(string: "iosKangBoss://iosKangBoss.com/p1=1&p2=2"))
    }
}

struct KuComicsActivity: Widget {
    let kind: String = "KuComicsActivity"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                KuComicsActivityEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                KuComicsActivityEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    KuComicsActivity()
} timeline: {
    let detail = ProductDetail(spuId: "", imageUrl: "https://tojoy-mall-test.oss-cn-beijing.aliyuncs.com/product/swiper/1695278694614.jpg", name: "御品膏方-人参枇杷草本膏", sellPrice: 120, marketPrice: 150)
    DetailEntry(date: Date(), detail: detail)
}
