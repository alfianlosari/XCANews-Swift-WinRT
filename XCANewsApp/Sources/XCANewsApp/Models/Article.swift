//
//  Article.swift
//  XCANews
//
//  Created by Alfian Losari on 6/27/21.
//

import Foundation

// fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article {
    // This id will be unique and auto generated from client side to avoid clashing of Identifiable in a List as NewsAPI response doesn't provide unique identifier
    let id = UUID()
    
    let source: Source
    
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d HH:mm"
        return dateFormatter
    }()
    
    enum CodingKeys: String, CodingKey {
        case source
        case title
        case url
        case publishedAt
        case author
        case description
        case urlToImage
    }
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        "\(source.name) ‧ \(Self.dateFormatter.string(from: publishedAt))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {}
extension Article {
    static var stubs: [Article] {
        [
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg"),
            Article(source: .init(name: "Livemint"), title: "Atal Setu inauguration LIVE updates: PM Modi inaugurates India\'s longest sea bridge, projects worth over ₹12,700 crore | Mint - Mint", url: "https://www.livemint.com/news/india/atal-setu-mthl-bridge-inauguration-live-updates-pm-modi-to-inaugurate-indias-longest-sea-bridge-in-mumbai-11705025406987.html", publishedAt: Date(), author: "Livemint", description: "Atal Setu inauguration LIVE updates: Prime Minister Narendra Modi inaugurated the Mumbai Trans Harbour Link (MTHL) on Friday. Has bridge has now been named ‘Atal Bihari Vajpayee Sewri - Nhava Sheva Atal Setu’.", urlToImage: "https://www.livemint.com/lm-img/img/2024/01/12/1600x900/PTI01-12-2024-000188B-0_1705062386742_1705062410997.jpg")
        ]
    }
}


struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}
