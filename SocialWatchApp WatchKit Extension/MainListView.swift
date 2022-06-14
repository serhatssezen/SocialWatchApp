//
//  MainListView.swift
//  SocialWatchApp WatchKit Extension
//
//  Created by Aydın Serhat SEZEN on 14.06.2022.
//

import SwiftUI
import CachedAsyncImage

struct MainListView: View {
    var body: some View {
        List(postList) {
            CustomRowView(post: $0)
        }
    }
}

private struct CustomRowView: View {
    var post: Post
    
    var body: some View {
        VStack() {
            HStack() {
                CachedAsyncImage(url: URL(string: post.postImage), urlCache: .imageCache) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .frame(width: 24, height: 24)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(post.user.name)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 16) {
                CachedAsyncImage(url: URL(string: post.postImage)) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .frame(width: 128, height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding([.leading, .trailing], 20)
                Text(post.desc)
                    .font(.subheadline)
                    .lineLimit(5)
            }
        }
    }
}


struct User: Identifiable {
    let name: String
    let id = UUID()
}

struct Post: Identifiable {
    let id = UUID()
    let title: String
    let desc: String
    let user : User
    let postImage: String
}

private var postList = [
    Post(title: "Deneme Watch",
         desc: "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960'larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.",
         user: User(name: "Aydın"),
         postImage: "https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2015/07/take-better-landscape-photos-with-low-camera-angles.jpg"),
    Post(title: "Watch post",
         desc: "iWatch Deneme Post",
         user: User(name: "Serhat"),
         postImage: "https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2015/07/how-to-use-a-low-camera-angle-in-landscape-photos.jpg"),
    Post(title: "Post",
         desc: "iWatch Deneme Post",
         user: User(name: "Aydın SEZEN"),
         postImage: "https://m.economictimes.com/thumb/msid-68721417,width-1200,height-900,resizemode-4,imgsize-1016106/nature1_gettyimages.jpg"),
    Post(title: "iWATCH 7",
         desc: "iWatch Deneme Post asd asdsad sad sadasdasd asd as",
         user: User(name: "Serhat SEZEN"),
         postImage: "https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/09/hiking-park-nature-trees-1296x728-header.jpg?w=1155&h=1528"),
    Post(title: "Deneme Saat",
         desc: "iWatch Deneme Post",
         user: User(name: "Aydın Serhat SEZEN"),
         postImage: "https://img-aws.ehowcdn.com/700x/cdn.onlyinyourstate.com/wp-content/uploads/2017/07/6288780218_ed5bd3f602_o-700x525-700x525.jpg")
]

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
