//
//  AppsController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/4/20.
//

import UIKit

struct ItemCollection: Hashable {
    let title: String
    let items: [ItemModel]
    let sectionKindId: Int
    
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

class ItemCollections {

    func getItemCollections() -> [ItemCollection] {
        [ItemCollection(title: "Popular Apps to Try",
                        items: [
                            ItemModel(previewImageName: "picsartpreview",
                                      title: "PicsArt Photo & Video Editor",
                                      subTitle: "Try the sketch effect",
                                      commentText: "get creative"),
                            ItemModel(previewImageName: "30dayfitness",
                                      title: "30 Day Fitness",
                                      subTitle: "Tone your body in 30 days",
                                      commentText: "featured"),
                            ItemModel(previewImageName: "picturethis",
                                      title: "PictureThis - Plant Identifier",
                                      subTitle: "Find out what's growing there",
                                      commentText: "Rediscover this"),
                            ItemModel(previewImageName: "discord",
                                      title: "Discord - Talk, Chat, Hang Out",
                                      subTitle: "Chat with your friends",
                                      commentText: "featured"),
                            ItemModel(previewImageName: "mygreencity",
                                      title: "My Green City",
                                      subTitle: "A city designed by kids",
                                      commentText: "For Kids")
                        ],
                        sectionKindId: 0),
         ItemCollection(title: "Popular Apps to Try",
                        items: [
                            ItemModel(iconName: "picsart",
                                      title: "PicsArt Photo & Video Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "photocollage",
                                      title: "PhotoGrid Video Collage maker",
                                      subTitle: "Video Collage & Video Editor"),
                            ItemModel(iconName: "instagram",
                                      title: "Instagram",
                                      subTitle: "#2 in Photo & Video"),
                            ItemModel(iconName: "linkedin",
                                      title: "LinkedIn: Network & Job Finder",
                                      subTitle: "Connect, Apply & Get Hired"),
                            ItemModel(iconName: "messenger",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "pitperest",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "facebook",
                                      title: "Facebook",
                                      subTitle: "#2 in Social Networking"),
                            ItemModel(iconName: "skype",
                                      title: "Skype for iPhone",
                                      subTitle: "Talk. Chat. Collaborate."),
                            ItemModel(iconName: "testflight",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                        ],
                        sectionKindId: 2),
         ItemCollection(title: "Top Free",
                        items: [
                            ItemModel(iconName: "tiktok",
                                      title: "TikTok - Trends Start Here",
                                      subTitle: "Videos, Music & Live Streams"),
                            ItemModel(iconName: "photolab",
                                      title: "Photo Lab: Picture Editor App",
                                      subTitle: "Art Face Editing, Filter Edit"),
                            ItemModel(iconName: "bazart",
                                      title: "Bazaart Photo Editor & Design",
                                      subTitle: "Collage, Edit, Cut, Paste Pics"),
                            ItemModel(iconName: "instagram",
                                      title: "Instagram",
                                      subTitle: "#2 in Photo & Video"),
                            ItemModel(iconName: "messenger",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "pitperest",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "facebook",
                                      title: "Facebook",
                                      subTitle: "Connect with friends"),
                            ItemModel(iconName: "skype",
                                      title: "Skype for iPhone",
                                      subTitle: "Talk. Chat. Collaborate."),
                            ItemModel(iconName: "testflight",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                        ],
                        sectionKindId: 2),
         ItemCollection(title: "Apps We love Right Now",
                        items: [
                            ItemModel(iconName: "picsartcolor",
                                      title: "PicsArt Color Paint",
                                      subTitle: "Sketch, Doodle, Create Pro Art"),
                            ItemModel(iconName: "twitter",
                                      title: "Twitter",
                                      subTitle: "Chat about what's happening"),
                            ItemModel(iconName: "viber",
                                      title: "Viber Messenger: Chats & Calls",
                                      subTitle: "Video Chat & Group Messages"),
                            ItemModel(iconName: "vk",
                                      title: "VK — social network",
                                      subTitle: "Photos, videos and calls"),
                            ItemModel(iconName: "whatsup",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "youtube",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "messenger",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "pitperest",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "facebook",
                                      title: "VivaVideo - Video Maker and Photo Editor",
                                      subTitle: "Movie Maker & Video Editor"),
                            ItemModel(iconName: "skype",
                                      title: "Skype for iPhone",
                                      subTitle: "Talk. Chat. Collaborate.")
                        ],
                        sectionKindId: 1),
         ItemCollection(title: "Apps for professionals",
                        items: [
                            ItemModel(iconName: "enrepreneurs",
                                      title: "Apps for enrepreneurs"),
                            ItemModel(iconName: "cooks",
                                      title: "Apps for cooks"),
                            ItemModel(iconName: "musicians",
                                      title: "Apps for musicians"),
                            ItemModel(iconName: "designers",
                                      title: "Apps for designers"),
                            ItemModel(iconName: "filmmakers",
                                      title: "Apps for filmmakers"),
                            ItemModel(iconName: "architects",
                                      title: "Apps for architects"),
                            ItemModel(iconName: "teachers",
                                      title: "Apps for teachers"),
                            ItemModel(iconName: "journalists",
                                      title: "Apps for journalists"),
                        ],
                        sectionKindId: 3),
         ItemCollection(title: "Top Categories",
                        items: [
                            ItemModel(iconName: "photoandvideo",
                                      title: "Photo & Video"),
                            ItemModel(iconName: "socialnetworking",
                                      title: "Social Networking"),
                            ItemModel(iconName: "utilities",
                                      title: "Utilities"),
                            ItemModel(iconName: "shopping",
                                      title: "Shopping"),
                            ItemModel(iconName: "fitness",
                                      title: "Health & Fitness"),
                            ItemModel(iconName: "music",
                                      title: "Music")
                        ],
                        sectionKindId: 4)
        ]
    }
}
