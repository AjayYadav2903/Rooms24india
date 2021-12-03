//
//  Constants.swift
//  AirVting
//
//  Created by Admin on 6/21/18.
//  Copyright © 2018 Admin. All rights reserved.
// http://35.247.142.201:3000/documentation
// trunghm@nexlesoft.com
//oahT0402!
//https://docs.google.com/spreadsheets/d/13c6xylvg1HzgziQjNGBmRn7LHoRKYnelYcdD98AZd8E/edit#gid=116051254
//https://github.com/MillmanY/MMPlayerView

import Foundation
import UIKit
struct Constants {
    struct Network {
        static let host = "18.140.72.26"
        static let baseUrl = "https://rooms24india.com/sh/api"//"http://\(host):3000/api"
        static let baseUrlUploadPhoto = "http://\(host):3000"
        static let AuthTokenName = "Authorization"
        static let faqURL = "http://\(host):4000/faqs.html"
        static let privacy = "http://\(host):4000/privacy.html"//"http://\(host):4000/privacy-policy.html"
        static let privacy_policy = "http://\(host):4000/privacy-policy.html"
        static let termsAndConditions = "http://\(host):4000/user-agreement.html"
        static let aboutUs = "http://\(host):4000/our-company.html"
        static let signIn = "\(baseUrl)/v1/signIn"
        static let signUp = "\(baseUrl)/v1/signUp"
        static let socialSignIn = "\(baseUrl)/v1/socialSignIn"
        static let signOut = "\(baseUrl)/v1/signOut"
        static let forgotPass = "\(baseUrl)/v1/forgotPassword"
        static let getPostByFilter = "\(baseUrl)/v1/posts"
        static let getPostByUserId = "\(baseUrl)/v1/users"
        static let users = "\(baseUrl)/v1/add_profile"
        static let getusersprofile = "\(baseUrl)/v1/get_profile"

        static let getListCategories = "\(baseUrl)/v1/get_post_categories"
        static let getProductListCategories = "\(baseUrl)/v1/categories"

        static let getListItemSell = "\(baseUrl)/v1/products"
        static let post = "\(baseUrl)/v1/posts"
        static let comments = "\(baseUrl)/v1/comments"
        static let product = "\(baseUrl)/v1/products"
        static let postBookmark = "\(baseUrl)/v1/posts"
        static let getExploreUsers = "\(baseUrl)/v1/users/explore"
        static let getUsersPost = "\(baseUrl)/v1/users/%@/posts"
        static let conversation = "\(baseUrl)/v1/conversations"
        static let getListGifts = "\(baseUrl)/v1/gifts"
        static let getGiftsByUser = "\(baseUrl)/v1/users"
        static let buyGift = "\(baseUrl)/v1/gifts/buy"
        static let sendGift = "\(baseUrl)/v1/gifts/send"
        static let likePost = "\(baseUrl)/v1/posts"
        static let paymentMethods = "\(baseUrl)/v1/paymentMethods"
        static let airToken = "\(baseUrl)/v1/airTokens"
        static let search = "\(baseUrl)/v1/search"
        static let notifications = "\(baseUrl)/v1/users"
        static let deactivate = "\(baseUrl)/v1/users/deActive"
        static let configs = "\(baseUrl)/v1/users/configs"
        static let contact = "\(baseUrl)/v1/contact"
        static let readNotification = "\(baseUrl)/v1/notifications"
        static let relationship = "\(baseUrl)/v1/users/relationships"
        static let uploadphoto = "\(baseUrl)/upload"
        static let leftMenu = "\(baseUrl)/v1/leftMenu"
    }
    
    struct APIKey {
        static let googleApiKey = "AIzaSyC8A95Nx-h4J75Dh4XsMMLz0VToNmUn4so"
//        static let googleApiKey = "AIzaSyDevSHGJgwcb6o2eDkfW4zJvh84ccWCN14"
        // Red5 SDK key
        static let red5SDKKey = "K5DX-COM2-FKJZ-Y5XV"//AccountInfo.shared.getKeyRed5ProFromLocal()
    }
    
    struct Notification {
        static let nameNotifOfsetChange = "nameNotifOfsetChange"
        static let nameNotifOfsetThirstTabChange = "nameNotifOfsetThirstTabChange"
        static let nameNotifOfsetOrtherTabChange = "nameNotifOfsetOrtherTabChange"
        static let nameNotifOfPaymentSuccess = "nameNotifOfPaymentSuccess"
        static let nameNotifOfFollowingStateChange = "nameNotifOfFollowingStateChange"
    }
    
    struct Formatters {
        
        static let debugConsoleDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
//            formatter.timeZone = TimeZone(identifier: "UTC")!
            formatter.timeZone = TimeZone.current
            return formatter
        }()
        
    }
    struct HeightView {
        static let heightBannerHome: CGFloat = {
            if Device.IS_IPHONE_5 {
                return 200
            } else if Device.IS_IPHONE_6_7_8{
                return 220
            } else if Device.IS_IPHONE_X {
                return 280
            } else{
                return 250
            }
        }()
        static let headerViewOfsetHeight: CGFloat = {
            if Device.IS_IPHONE_X {
                return 84
            } else{
                return 64
            }
        }()
//        static let heightHeaderAccount: CGFloat = {
//            print("xxx \(UIScreen.main.bounds.width * 305 / 375 + 10)")
//            return UIScreen.main.bounds.width * 305 / 375 + 10
//        }()
        static let heightHeaderAccount: CGFloat = {
            round((UIScreen.main.bounds.size.width * 330 / 375) + 5)
        }()
    }
    struct cellIdentifier {
        static let cellLiveReuseIdentifier = "LiveNowCell"
        static let cellLiveScheduleReuseIdentifier = "LiveScheduleCell"
        static let cellScheduleReuseIdentifier = "ScheduleCell"
        static let bookmarkReuseIdentifier = "bookmarkCell"
        static let cellLeftSlideReuseIdentifier = "LeftSlideCell"
        static let cellInboxReuseIdentifier = "InboxCell"
        static let giftCellReuseIdentifier = "GiftStoreItemCollectionViewCell"
        static let cellStoreReuseIdentifier = "StoreCell"
        static let cellCategoryReuseIdentifier = "CategoryCell"
    }
    struct nibName {
        static let liveTableViewCell = "LiveTableViewCell"
        static let liveScheduleTableViewCell = "LiveScheduleTableViewCell"
        static let scheduleTableViewCell = "ScheduleTableViewCell"
        static let bookmarkTableViewCell = "BookmarkVideoTableViewCell"
        static let leftSlideTableViewCell = "LeftSlideTableViewCell"
        static let inboxTableViewCell = "InboxTableViewCell"
        static let giftCell = "GiftStoreItemCollectionViewCell"
        static let categoryTableViewCell = "CategoryTableViewCell"
        static let storeTableViewCell = "StoreTableViewCell"
    }
    struct DummyData {
        static let listInbox: String = "{  \"statusCode\": 201,  \"message\": \"List inbox\",  \"data\": {    \"postDetail\": [      {        \"_id\": \"5b598707fda36c62f7e3587d\",        \"userId\": \"5b5987070179669cb3951c65\",        \"title\": \"sunt\",        \"avatar\": \"linkImage\",        \"description\": \"consequat adipisicing officia excepteur cupidatat in in proident ipsum duis\",        \"time\": \"31 min ago\"      },      {        \"_id\": \"5b598707190cf7caf2955326\",        \"userId\": \"5b598707e8fa8402b2961763\",        \"title\": \"eu\",        \"avatar\": \"linkImage\",        \"description\": \"sint eu elit anim proident quis consequat cillum aute nisi\",        \"time\": \"33 min ago\"      },      {        \"_id\": \"5b5987070d49581f8636d5f0\",        \"userId\": \"5b598707628dd004a690dcd3\",        \"title\": \"minim\",        \"avatar\": \"linkImage\",        \"description\": \"minim ullamco incididunt excepteur fugiat ullamco qui sunt cupidatat ullamco\",        \"time\": \"32 min ago\"      },      {        \"_id\": \"5b598707cdff5c8d3500097a\",        \"userId\": \"5b598707c4b20325dd0e12e3\",        \"title\": \"dolore\",        \"avatar\": \"linkImage\",        \"description\": \"ipsum nulla quis magna ipsum laboris ipsum ad proident nulla\",        \"time\": \"40 min ago\"      },      {        \"_id\": \"5b5987070e052e72582a8ecf\",        \"userId\": \"5b59870770b50d7b60638321\",        \"title\": \"eu\",        \"avatar\": \"linkImage\",        \"description\": \"dolore consequat veniam officia ullamco labore eu et nulla qui\",        \"time\": \"22 min ago\"      },      {        \"_id\": \"5b598707f2c1b2d3a09bf1f1\",        \"userId\": \"5b598707c651194abebab00e\",        \"title\": \"eiusmod\",        \"avatar\": \"linkImage\",        \"description\": \"aute aliqua veniam deserunt mollit proident in Lorem ipsum aute\",        \"time\": \"34 min ago\"      },      {        \"_id\": \"5b5987079b4771bc7aa6e3d1\",        \"userId\": \"5b5987078992939defbd7fcb\",        \"title\": \"voluptate\",        \"avatar\": \"linkImage\",        \"description\": \"dolor excepteur dolor eu eiusmod qui velit nostrud do labore\",        \"time\": \"31 min ago\"      },      {        \"_id\": \"5b598707d90158acf1577b52\",        \"userId\": \"5b598707d341f7c825abb22c\",        \"title\": \"culpa\",        \"avatar\": \"linkImage\",        \"description\": \"pariatur fugiat est deserunt veniam voluptate nisi et dolore et\",        \"time\": \"35 min ago\"      },      {        \"_id\": \"5b59870769c07fccce100ee0\",        \"userId\": \"5b5987072392b87b965e79bd\",        \"title\": \"magna\",        \"avatar\": \"linkImage\",        \"description\": \"labore tempor et est labore magna dolore veniam elit proident\",        \"time\": \"22 min ago\"      },      {        \"_id\": \"5b5987071877ad84ba87f229\",        \"userId\": \"5b59870712a37493be5da34c\",        \"title\": \"ad\",        \"avatar\": \"linkImage\",        \"description\": \"occaecat quis ea occaecat eiusmod irure ipsum eiusmod id nulla\",        \"time\": \"34 min ago\"      },      {        \"_id\": \"5b59870740acc1e1b24b386d\",        \"userId\": \"5b59870733f52cf5ed4829cb\",        \"title\": \"veniam\",        \"avatar\": \"linkImage\",        \"description\": \"aliquip nisi tempor et incididunt sit labore ea et ullamco\",        \"time\": \"28 min ago\"      },      {        \"_id\": \"5b598707244ee35cad25d228\",        \"userId\": \"5b598707e2ab38b592a88e11\",        \"title\": \"sit\",        \"avatar\": \"linkImage\",        \"description\": \"ad proident et id magna nisi ad anim mollit ipsum\",        \"time\": \"21 min ago\"      },      {        \"_id\": \"5b59870789457b9e35b93261\",        \"userId\": \"5b59870723175597f388ef47\",        \"title\": \"sunt\",        \"avatar\": \"linkImage\",        \"description\": \"id velit nulla exercitation magna ea incididunt ad ea mollit\",        \"time\": \"34 min ago\"      },      {        \"_id\": \"5b5987070425ee3d0e3e55aa\",        \"userId\": \"5b59870780f18745190fbaf6\",        \"title\": \"enim\",        \"avatar\": \"linkImage\",        \"description\": \"sint ipsum pariatur incididunt anim aliqua non proident mollit est\",        \"time\": \"36 min ago\"      },      {        \"_id\": \"5b5987074a9bccab6fb06373\",        \"userId\": \"5b598707f664a62561c4c245\",        \"title\": \"officia\",        \"avatar\": \"linkImage\",        \"description\": \"eu fugiat est ut pariatur veniam voluptate nostrud non non\",        \"time\": \"29 min ago\"      },      {        \"_id\": \"5b5987078ae2b07719a8e3b3\",        \"userId\": \"5b5987072c2dda8b4a5a6cf7\",        \"title\": \"aliquip\",        \"avatar\": \"linkImage\",        \"description\": \"id officia eu duis ex nisi nostrud ex exercitation veniam\",        \"time\": \"35 min ago\"      },      {        \"_id\": \"5b5987079928fd9f200175e3\",        \"userId\": \"5b598707c112aae343451141\",        \"title\": \"nostrud\",        \"avatar\": \"linkImage\",        \"description\": \"laboris eu labore ut eu veniam consectetur sint magna non\",        \"time\": \"40 min ago\"      },      {        \"_id\": \"5b59870704097340bf58e462\",        \"userId\": \"5b598707557124d4782026a6\",        \"title\": \"labore\",        \"avatar\": \"linkImage\",        \"description\": \"qui reprehenderit amet cupidatat ex cillum Lorem sunt anim Lorem\",        \"time\": \"28 min ago\"      },      {        \"_id\": \"5b598707a6dfce09e6476d93\",        \"userId\": \"5b598707bd3688a2e56309da\",        \"title\": \"qui\",        \"avatar\": \"linkImage\",        \"description\": \"aliquip eiusmod exercitation enim et ea eu velit Lorem nisi\",        \"time\": \"25 min ago\"      },      {        \"_id\": \"5b598707311c231087b40a0f\",        \"userId\": \"5b59870788fc87679a63c079\",        \"title\": \"amet\",        \"avatar\": \"linkImage\",        \"description\": \"nisi do ipsum laboris reprehenderit nulla ex sit ad sunt\",        \"time\": \"29 min ago\"      }    ]  }}"
        static let listSell: String = "{  \"success\": true,  \"message\": \"data success\",  \"data\": [    {      \"id\": 0,      \"urlImage\": \"https://macinsta.vn/wp-content/uploads/2017/09/ad02-sport-1.jpg\",      \"liked\": 3643,      \"name\": \"in mollit anim\",      \"price\": 2510,      \"time\": \"2018-05-24T12:13:49 -07:00\"    },    {      \"id\": 1,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2015/04/18.jpg\",      \"liked\": 3454,      \"name\": \"qui minim excepteur\",      \"price\": 2828,      \"time\": \"2018-03-13T06:16:27 -07:00\"    },    {      \"id\": 2,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2014/05/Black-Gold-Diamond-Wedding-band-For-A-Men-1.jpg\",      \"liked\": 4885,      \"name\": \"tempor qui aliquip\",      \"price\": 2700,      \"time\": \"2018-02-07T11:15:25 -07:00\"    },    {      \"id\": 3,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2018/04/First-wordpress.png\",      \"liked\": 3629,      \"name\": \"sint et aliquip\",      \"price\": 2326,      \"time\": \"2018-02-19T10:56:22 -07:00\"    },    {      \"id\": 4,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2017/10/1-720x505.jpg\",      \"liked\": 3622,      \"name\": \"dolor fugiat sint\",      \"price\": 2141,      \"time\": \"2018-02-27T08:21:03 -07:00\"    },    {      \"id\": 5,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2017/09/Platinum-Yellow-Gold-Matching-Band.png\",      \"liked\": 3529,      \"name\": \"eiusmod pariatur ipsum\",      \"price\": 2323,      \"time\": \"2018-07-06T03:07:07 -07:00\"    },    {      \"id\": 6,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2017/02/Platinum-Diamond-Ring.png\",      \"liked\": 4749,      \"name\": \"amet id et\",      \"price\": 3735,      \"time\": \"2018-05-09T05:24:28 -07:00\"    },    {      \"id\": 7,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2017/02/Black-Diamond-Black-Gold-Ring.png\",      \"liked\": 3156,      \"name\": \"nisi tempor exercitation\",      \"price\": 3729,      \"time\": \"2018-03-27T01:24:29 -07:00\"    },    {      \"id\": 8,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2014/01/2013-10-09_1349.jpg\",      \"liked\": 3653,      \"name\": \"consequat non dolore\",      \"price\": 3137,      \"time\": \"2018-01-08T03:16:03 -07:00\"    },    {      \"id\": 9,      \"urlImage\": \"https://vidarjewelry.com/wp-content/uploads/2014/01/picresized_1373135411_IMG_3680.jpg\",      \"liked\": 3938,      \"name\": \"veniam est laborum\",      \"price\": 3367,      \"time\": \"2018-03-17T10:39:17 -07:00\"    }  ]}"
        
        
        static let listUser: String = "{  \"success\": true,  \"message\": \"data success\",  \"data\": [{\"id\":1,\"username\":\"cstonehewer0\",\"avatar\":\"https://robohash.org/autipsalibero.png?size=50x50&set=set1\",\"des\":\"Lourdes College\",\"photos\":null},{\"id\":2,\"username\":\"ncresswell1\",\"avatar\":\"https://robohash.org/voluptasipsaaperiam.bmp?size=50x50&set=set1\",\"des\":\"Antioch University Los Angeles\",\"photos\":null},{\"id\":3,\"username\":\"lbruinemann2\",\"avatar\":\"https://robohash.org/facilissimiliqueillo.jpg?size=50x50&set=set1\",\"des\":\"Universitas Bunda Mulia Jakarta\",\"photos\":null},{\"id\":4,\"username\":\"jtilliard3\",\"avatar\":\"https://robohash.org/saepenonconsectetur.png?size=50x50&set=set1\",\"des\":\"Baki Business University\",\"photos\":null},{\"id\":5,\"username\":\"mwalklot4\",\"avatar\":\"https://robohash.org/doloreveliteum.jpg?size=50x50&set=set1\",\"des\":\"Universidade Independente de Angola\",\"photos\":null},{\"id\":6,\"username\":\"jcreggan5\",\"avatar\":\"https://robohash.org/voluptatemmollitiased.jpg?size=50x50&set=set1\",\"des\":\"Alpha Omega University\",\"photos\":null},{\"id\":7,\"username\":\"sdibernardo6\",\"avatar\":\"https://robohash.org/fugaquaevoluptatum.bmp?size=50x50&set=set1\",\"des\":\"Jarvis Christian College\",\"photos\":null},{\"id\":8,\"username\":\"raldhouse7\",\"avatar\":\"https://robohash.org/doloreeospossimus.png?size=50x50&set=set1\",\"des\":\"California School of Professional Psychology - Fresno\",\"photos\":null},{\"id\":9,\"username\":\"dtallyn8\",\"avatar\":\"https://robohash.org/quiquicum.jpg?size=50x50&set=set1\",\"des\":\"University of Reggio Calabria\",\"photos\":null},{\"id\":10,\"username\":\"athurling9\",\"avatar\":\"https://robohash.org/sequivoluptatevoluptas.png?size=50x50&set=set1\",\"des\":\"Hamilton Technical College\",\"photos\":null},{\"id\":11,\"username\":\"mperrotteta\",\"avatar\":\"https://robohash.org/accusamuslaborumtempora.jpg?size=50x50&set=set1\",\"des\":\"San Juan Bautista School of Medicine\",\"photos\":null},{\"id\":12,\"username\":\"glantb\",\"avatar\":\"https://robohash.org/quiseligendiadipisci.png?size=50x50&set=set1\",\"des\":\"Sree Chitra Tirunal Institute for Medical Sciences and Technology\",\"photos\":null},{\"id\":13,\"username\":\"upreslandc\",\"avatar\":\"https://robohash.org/sitcommodiquis.png?size=50x50&set=set1\",\"des\":\"Palestine Technical University - Kadoorie\",\"photos\":null},{\"id\":14,\"username\":\"jchatwoodd\",\"avatar\":\"https://robohash.org/maioresvoluptasconsectetur.bmp?size=50x50&set=set1\",\"des\":\"Yanbu University College\",\"photos\":null},{\"id\":15,\"username\":\"sminghettie\",\"avatar\":\"https://robohash.org/consequunturillovoluptas.jpg?size=50x50&set=set1\",\"des\":\"Francis Marion University\",\"photos\":null},{\"id\":16,\"username\":\"tsparwayf\",\"avatar\":\"https://robohash.org/teneturveniammagnam.png?size=50x50&set=set1\",\"des\":\"University of Greenland\",\"photos\":null},{\"id\":17,\"username\":\"rrelphg\",\"avatar\":\"https://robohash.org/sedquosequi.jpg?size=50x50&set=set1\",\"des\":\"Fachhochschule München\",\"photos\":null},{\"id\":18,\"username\":\"kbeedenh\",\"avatar\":\"https://robohash.org/nequenonquia.jpg?size=50x50&set=set1\",\"des\":\"Moscow State Academy of Applied Biotechnology\",\"photos\":null},{\"id\":19,\"username\":\"dhasketti\",\"avatar\":\"https://robohash.org/voluptatibusnobisexercitationem.jpg?size=50x50&set=set1\",\"des\":\"Universitas Swadaya Gunung Djati\",\"photos\":null},{\"id\":20,\"username\":\"ffriftj\",\"avatar\":\"https://robohash.org/quiomnisqui.png?size=50x50&set=set1\",\"des\":\"Salam University\",\"photos\":null},{\"id\":21,\"username\":\"jantcliffek\",\"avatar\":\"https://robohash.org/nonrepellendusin.png?size=50x50&set=set1\",\"des\":\"Sapporo University\",\"photos\":null},{\"id\":22,\"username\":\"kalgerl\",\"avatar\":\"https://robohash.org/evenietipsaaut.bmp?size=50x50&set=set1\",\"des\":\"China Medical College\",\"photos\":null},{\"id\":23,\"username\":\"mcalderam\",\"avatar\":\"https://robohash.org/velitesttempora.png?size=50x50&set=set1\",\"des\":\"Spring Arbor College\",\"photos\":null},{\"id\":24,\"username\":\"dtathamn\",\"avatar\":\"https://robohash.org/dictalaboresaepe.bmp?size=50x50&set=set1\",\"des\":\"Westminster College New Wilmington\",\"photos\":null},{\"id\":25,\"username\":\"mpohlako\",\"avatar\":\"https://robohash.org/sitabdolor.jpg?size=50x50&set=set1\",\"des\":\"Stratford College London\",\"photos\":null},{\"id\":26,\"username\":\"iclapisonp\",\"avatar\":\"https://robohash.org/placeatnumquamenim.bmp?size=50x50&set=set1\",\"des\":\"Canterbury Christ Church University\",\"photos\":null},{\"id\":27,\"username\":\"ryewmanq\",\"avatar\":\"https://robohash.org/saepeiustonemo.jpg?size=50x50&set=set1\",\"des\":\"University of Mosul\",\"photos\":null},{\"id\":28,\"username\":\"babrahmovicir\",\"avatar\":\"https://robohash.org/estoditmaiores.jpg?size=50x50&set=set1\",\"des\":\"Athenaeum Pontificium Regina Apostolorum\",\"photos\":null},{\"id\":29,\"username\":\"wjeckells\",\"avatar\":\"https://robohash.org/aperiamdistinctioqui.jpg?size=50x50&set=set1\",\"des\":\"Universidad Iberoamericana, Campus León\",\"photos\":null},{\"id\":30,\"username\":\"ptrenfieldt\",\"avatar\":\"https://robohash.org/solutacumut.bmp?size=50x50&set=set1\",\"des\":\"Multimedia University\",\"photos\":null}]}"
        
        static let listPeopleCategories = "{  \"success\": true,  \"message\": \"data success\",  \"data\":[{\"title\": \"Rising Star\",\"users\": [{\"id\":1,\"username\":\"cstonehewer0\",\"avatar\":\"https://robohash.org/autipsalibero.png?size=50x50&set=set1\",\"des\":\"Lourdes College\",\"photos\":null,\"isLive\":true},{\"id\":2,\"username\":\"ncresswell1\",\"avatar\":\"https://robohash.org/voluptasipsaaperiam.bmp?size=50x50&set=set1\",\"des\":\"Antioch University Los Angeles\",\"photos\":null},{\"id\":3,\"username\":\"lbruinemann2\",\"avatar\":\"https://robohash.org/facilissimiliqueillo.jpg?size=50x50&set=set1\",\"des\":\"Universitas Bunda Mulia Jakarta\",\"photos\":null},{\"id\":4,\"username\":\"jtilliard3\",\"avatar\":\"https://robohash.org/saepenonconsectetur.png?size=50x50&set=set1\",\"des\":\"Baki Business University\",\"photos\":null,\"isLive\":true},{\"id\":5,\"username\":\"mwalklot4\",\"avatar\":\"https://robohash.org/doloreveliteum.jpg?size=50x50&set=set1\",\"des\":\"Universidade Independente de Angola\",\"photos\":null}]},{\"title\": \"Top Users\",\"users\": [{\"id\":6,\"username\":\"jcreggan5\",\"avatar\":\"https://robohash.org/voluptatemmollitiased.jpg?size=50x50&set=set1\",\"des\":\"Alpha Omega University\",\"photos\":null},{\"id\":7,\"username\":\"sdibernardo6\",\"avatar\":\"https://robohash.org/fugaquaevoluptatum.bmp?size=50x50&set=set1\",\"des\":\"Jarvis Christian College\",\"photos\":null,\"isLive\":true},{\"id\":8,\"username\":\"raldhouse7\",\"avatar\":\"https://robohash.org/doloreeospossimus.png?size=50x50&set=set1\",\"des\":\"California School of Professional Psychology - Fresno\",\"photos\":null},{\"id\":9,\"username\":\"dtallyn8\",\"avatar\":\"https://robohash.org/quiquicum.jpg?size=50x50&set=set1\",\"des\":\"University of Reggio Calabria\",\"photos\":null},{\"id\":10,\"username\":\"athurling9\",\"avatar\":\"https://robohash.org/sequivoluptatevoluptas.png?size=50x50&set=set1\",\"des\":\"Hamilton Technical College\",\"photos\":null}]},{\"title\": \"new\",\"users\": [{\"id\":11,\"username\":\"mperrotteta\",\"avatar\":\"https://robohash.org/accusamuslaborumtempora.jpg?size=50x50&set=set1\",\"des\":\"San Juan Bautista School of Medicine\",\"photos\":null},{\"id\":12,\"username\":\"glantb\",\"avatar\":\"https://robohash.org/quiseligendiadipisci.png?size=50x50&set=set1\",\"des\":\"Sree Chitra Tirunal Institute for Medical Sciences and Technology\",\"photos\":null},{\"id\":13,\"username\":\"upreslandc\",\"avatar\":\"https://robohash.org/sitcommodiquis.png?size=50x50&set=set1\",\"des\":\"Palestine Technical University - Kadoorie\",\"photos\":null},{\"id\":14,\"username\":\"jchatwoodd\",\"avatar\":\"https://robohash.org/maioresvoluptasconsectetur.bmp?size=50x50&set=set1\",\"des\":\"Yanbu University College\",\"photos\":null},{\"id\":15,\"username\":\"sminghettie\",\"avatar\":\"https://robohash.org/consequunturillovoluptas.jpg?size=50x50&set=set1\",\"des\":\"Francis Marion University\",\"photos\":null}]}]}"
        static let postCategory = "{  \"success\": true,  \"message\": \"data success\",  \"data\":[{\"id\":1,\"name\":\"Legal Assistant\"},{\"id\":2,\"name\":\"Editor\"},{\"id\":3,\"name\":\"Accountant IV\"},{\"id\":4,\"name\":\"Librarian\"},{\"id\":5,\"name\":\"Associate Professor\"},{\"id\":6,\"name\":\"Occupational Therapist\"},{\"id\":7,\"name\":\"Marketing Assistant\"},{\"id\":8,\"name\":\"Actuary\"},{\"id\":9,\"name\":\"Help Desk Operator\"},{\"id\":10,\"name\":\"Budget/Accounting Analyst I\"}]}"
        static let listGift = "{  \"statusCode\": 401,  \"message\": \"data success\",  \"data\": [    {      \"id\": 0,      \"featuredImage\": \"https://www.freeiconspng.com/uploads/star-icon-2.jpg\",      \"name\": \"Star\",      \"price\": 31,      \"quantity\": 15    },    {      \"id\": 1,      \"featuredImage\": \"https://icon2.kisspng.com/20180405/fae/kisspng-flower-bouquet-computer-icons-gift-clip-art-bouquet-of-flowers-5ac65814992314.7406530015229481166273.jpg\",      \"name\": \"Flowers\",      \"price\": 26,      \"quantity\": 2    },    {      \"id\": 2,      \"featuredImage\": \"http://files.softicons.com/download/holidays-icons/heart-romance-icon-set-by-daily-overview/png/256x256/ring.png\",      \"name\": \"Ring\",      \"price\": 46,      \"quantity\": 10    },    {      \"id\": 3,      \"featuredImage\": \"https://d1nhio0ox7pgb.cloudfront.net/_img/v_collection_png/512x512/shadow/champagne_bottle.png\",      \"name\": \"Champagne\",      \"price\": 36,      \"quantity\": 5    },    {      \"id\": 4,      \"featuredImage\": \"http://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/headphone-icon.png\",      \"name\": \"Headphone\",      \"price\": 28,      \"quantity\": 20    }  ]}"
        
        
    }
    struct Device {
        // iDevice detection code
        static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
        static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
        static let IS_RETINA           = UIScreen.main.scale >= 2.0
        
        static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
        static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
        static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
        static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
        
        static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
        static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
        static let IS_IPHONE_6_7_8         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
        static let IS_IPHONE_6_7_8P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
        static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH == 812
    }
     
    
    struct ArrayLeftSlide {
        static let strLeftMenu: [String] = ["Portland","San Francisco","Cupertino","Seattle"]
    }
    
    static let listAd: String = "{  \"statusCode\": 201,  \"message\": \"List banner\",  \"data\": {    \"postDetail\": [      {        \"_id\": \"5b55ade20a29eb97eb8e7547\",        \"owner\": {          \"userId\": \"5b55ade2d158e11f7027acb2\",          \"username\": \"magna\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"mollit in velit fugiat Lorem do fugiat cillum ea ullamco\",          \"schedules\": {            \"friends\": [              {                \"dates\": 5              },              {                \"dates\": 2              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade2d29ede6e69b89706\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2016-03-06T01:53:48 -07:00\"        },        \"viewers\": 2883,        \"isLive\": true      },      {        \"_id\": \"5b55ade209c17adc10c6f319\",        \"owner\": {          \"userId\": \"5b55ade287aff07216cae022\",          \"username\": \"velit\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"officia consequat dolore ipsum deserunt irure aliqua amet aute nulla\",          \"schedules\": {            \"friends\": [              {                \"dates\": 7              },              {                \"dates\": 3              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade273b75ed46c9b6910\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2014-12-05T09:46:43 -07:00\"        },        \"viewers\": 1972,        \"isLive\": true      },      {        \"_id\": \"5b55ade241accf6478812732\",        \"owner\": {          \"userId\": \"5b55ade27648c0ca4fc4f603\",          \"username\": \"labore\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"do anim qui occaecat magna anim irure esse eu in\",          \"schedules\": {            \"friends\": [              {                \"dates\": 5              },              {                \"dates\": 8              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade2e16f890ef006406d\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2016-09-18T10:57:12 -07:00\"        },        \"viewers\": 3268,        \"isLive\": true      },      {        \"_id\": \"5b55ade227d92f0b481d1f42\",        \"owner\": {          \"userId\": \"5b55ade23ee2e3a3658935b5\",          \"username\": \"ipsum\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"ea elit proident labore deserunt adipisicing ex pariatur eiusmod ad\",          \"schedules\": {            \"friends\": [              {                \"dates\": 4              },              {                \"dates\": 7              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade20db12e3752248d71\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2015-12-04T07:44:47 -07:00\"        },        \"viewers\": 2056,        \"isLive\": true      },      {        \"_id\": \"5b55ade25ac44ef1f6123365\",        \"owner\": {          \"userId\": \"5b55ade226d56570d094ac01\",          \"username\": \"eu\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"culpa eiusmod pariatur sit laboris dolore est minim dolore ad\",          \"schedules\": {            \"friends\": [              {                \"dates\": 6              },              {                \"dates\": 7              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade243c94c18ce311cb0\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2014-08-17T10:55:46 -07:00\"        },        \"viewers\": 2118,        \"isLive\": true      },      {        \"_id\": \"5b55ade249b5a9c027bba87c\",        \"owner\": {          \"userId\": \"5b55ade2b2fc3b51a4b5f819\",          \"username\": \"quis\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"do Lorem elit nulla cupidatat nulla exercitation nostrud elit pariatur\",          \"schedules\": {            \"friends\": [              {                \"dates\": 5              },              {                \"dates\": 4              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade299cf4be60d820ec2\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2018-06-30T03:59:27 -07:00\"        },        \"viewers\": 1783,        \"isLive\": true      },      {        \"_id\": \"5b55ade28a697d07e6828c61\",        \"owner\": {          \"userId\": \"5b55ade23e1fa7cdbeb28bcf\",          \"username\": \"non\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"ea consequat fugiat anim deserunt in magna labore veniam labore\",          \"schedules\": {            \"friends\": [              {                \"dates\": 4              },              {                \"dates\": 2              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade2d20138a09a9f2ea9\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2014-03-31T09:57:23 -07:00\"        },        \"viewers\": 1878,        \"isLive\": true      },      {        \"_id\": \"5b55ade2e8338817829d5f56\",        \"owner\": {          \"userId\": \"5b55ade2f099c0f5ec786c5f\",          \"username\": \"duis\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"mollit occaecat laboris culpa deserunt ullamco est commodo cupidatat consectetur\",          \"schedules\": {            \"friends\": [              {                \"dates\": 3              },              {                \"dates\": 7              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade2c184069d384ad671\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2014-03-14T08:23:34 -07:00\"        },        \"viewers\": 2743,        \"isLive\": true      },      {        \"_id\": \"5b55ade2205ccbb0edb91019\",        \"owner\": {          \"userId\": \"5b55ade2fa6560521cfa2ab2\",          \"username\": \"consequat\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"tempor sint exercitation proident excepteur quis ea pariatur amet laboris\",          \"schedules\": {            \"friends\": [              {                \"dates\": 8              },              {                \"dates\": 7              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade21c5e3046363af18a\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2017-01-07T11:47:53 -07:00\"        },        \"viewers\": 3329,        \"isLive\": true      },      {        \"_id\": \"5b55ade29a1fd5b3c5f58be6\",        \"owner\": {          \"userId\": \"5b55ade2ae975460adcb75f0\",          \"username\": \"Lorem\",          \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",          \"description\": \"veniam adipisicing mollit laborum sit cupidatat labore voluptate ad excepteur\",          \"schedules\": {            \"friends\": [              {                \"dates\": 5              },              {                \"dates\": 2              }            ],            \"startTime\": \"2018-07-22T15:51:55.003Z\",            \"endTime\": \"2018-07-22T15:51:55.003Z\"          }        },        \"type\": \"stream\",        \"featuredImage\": \"https://webtrangdiem.com/wp-content/uploads/2015/12/my-pham-han-quoc-1.jpg\",        \"mediaUrl\": \"https://youtu.be/Jy6Hu5_c-V8\",        \"product\": {          \"productId\": \"5b55ade20540e6742fd0a16f\",          \"featuredImage\": \"https://myphambo.com/wp-content/uploads/2014/11/Son-mui-MAC-Lipstick11.jpg\",          \"expiredAt\": \"2017-02-04T01:50:54 -07:00\"        },        \"viewers\": 2952,        \"isLive\": true      }    ]  }}"
    
    
}

extension Notification.Name {
    static let abc = Notification.init(name: Notification.Name(rawValue: "abc"))
    //
    //        NotificationCenter.default.post(.abc)
}

extension Notification.Name {
    static let thirdTabChanged = Notification.Name("thirdTabChanged")
}

let ABOUTUS = """
airVting is a live-streaming platform where the uprising trend of
live videos and e-commerce combines to bring about a whole new level of marketing
and advertising, applicable to everyone and businesses big and small. Made up with
a diversity of talents, airVting is a unique team with a common agenda - to bring
forward the new era of Live-Commerce. Join us on this wonderful journey to discover
how exciting live-streaming is, how talented people are, how great some products
canbe and how similar and different we all are. Just be yourself and airVting will
bring the World to you.
"""


let PRIVACYPOLICY = """
airVting Privacy Policy

Scope of this Privacy Policy
This privacy policy is applicable to how airVting handles personally identifiable information that is left when you log in to the website and server, as well as other personally identifiable information shared with our business partners.


This privacy policy constitutes an integral part of airVting User Agreement and must be read together with airVting User Agreement.


Account Information
You may avail some of our services without creating a airVting account, such as watching airVting broadcasts on our website.

If you choose to create a airVting account, airVting may ask for your name (you may use your real name if you are comfortable to do so, and you may also use an alias), birthday, gender, hometown, bio, education, career, profile image, email address and cell phone number, so that we could identify you and provide better Services to you. Some of the aforementioned information is not mandatory.

If you create a airVting account by connecting with a third-party service, such as Facebook, Twitter, Google, YouTube, Instagram or VK, or if you connect a airVting account with a third-party account, we will use information from such third-party service, including your third-party service user name, gender, profile image and birthday.

Certain information will be displayed publicly on your profile page, such as your user name, your age and who you are following. Your recent videos will also be displayed publicly on your profile page.

We use your birthday to determine whether you have reached the minimum age to avail our Services. We use your contact information, such as your phone number, to authenticate your account, and keep your account as well as our Services secure. We use your background information, such as your hometown, to recommend contents that may interest you and to improve our Services.

If you provide us with your phone number or email address, you agree that we may send text messages to that phone number, or email to that email address. We will do so only in compliance with applicable laws and regulations. If you deactivate our Services, you will no longer receive any text or email from us.


Address Book
You may choose to share with us your address book so that we can cross-reference with airVting database and show you contacts who are also using airVting.


Cookie
A cookie is a small piece of data that is stored on your computer or mobile device. Like many other websites and mobile applications, airVting will set or access airVting cookies on your computer or mobile device.


Location
We require your location information, such as your IP address, in order to set up and maintain connection and provide Services to you.

If your privacy settings allow, we will make recommendations using on your location information.


History
We will keep record of your interests, such as your viewing history, to recommend contents that may interest you. We will also keep record of the virtual gift you send or receive on airVting for the gift system to function.


Device Information
airVting automatically receives and records additional information about your device, such as device model. We will use such information to detect abnormal activities and prevent security breach. We will also use such information to identify a banned account or device.


Bank Information
We require your bank information and other sensitive information in order to make payment to you. You shall be solely responsible for the accuracy of such information in order for us to process the payment.


Information Shared by You
Most communications on airVting are public and some may be immediately viewed by others. Therefore, you should think twice before sharing any sensitive information.

Your group messages and private messages may also be monitored by us to prevent illegal activities. Your group messages and private messages (including any image or video contained) may be shared with law enforcement agencies if we are requested to do so.


Children Protection
If you are under the minimum age as specified in airVting User Agreement, you may not create a airVting account or use airVting services.

airVting has zero tolerance to any form of child abuse or exploitation. Your data (including group messages and private messages) may be shared with law enforcement agencies if we have reasonable grounds to believe that you have engaged in child pornography, or if we are requested to do so by law enforcement agencies.


Global Operation
In order to provide Services to our users all over the world, we operate globally. You hereby authorize us to transfer, store, and use your data in any country and region we operate, including Singapore, the People’s Republic of China and the European Union. In doing so we shall ensure the security of your data.


How to Manage Your Personal Information
The privacy settings allow you to control whether or not to share certain information and whether you may be found by certain airVting function.

You may download the short videos you have shared through our Services. If you need to download your short videos on a massive basis (more than 50 videos), please email us. You will need to use other services in order to record or download your live streaming that is conducted through our Services.

You may modify your account information on your profile page.

If you believe the personal information we have about you is inaccurate, you may also email us to update such inaccurate information.

You may also deactivate your account by emailing to us. Once your account is deactivated, you will not be able to restore your account again.

Please note that third parties may still retain copies of your information even after your account is deactivated.

If your account is deactivated due to your violation of our Terms of Use, we may retain certain information (such as device information, phone number) to prevent you from accessing our Services again.


Disclosure
I. The protection of user privacy is a fundamental policy of airVting. airVting guarantees that it will not publicly disclose or provide a third party with your non-public information, unless in the following circumstances as follows:

a) When prior express authorization is obtained from you;


b) When and as required by prevailing laws and/or regulations;


c) When and as required by relevant competent authorities of the government;


d) When it is necessary to safeguard the public interest;


e) When it is necessary to protect the safety of any person (including you);


f) When it is necessary to address fraud, security or technical issues; and


g) When it is necessary to safeguard the legal rights and interests of airVting.


II. airVting may collaborate with a third party (an affiliate or otherwise) to provide you with relevant Services. In this scenario, airVting has the right to share your information with a third party, if the third party agrees to bear responsibility for providing privacy protection no less favorable to that of airVting.

III. Under the condition that no private information of an individual user is disclosed, airVting has the right to analyze the entire user database and utilize the database for commercial purposes.


Contact Information
You may reach us via the following email address: wevalueyou@airVting.com


Law Enforcement
airVting is willing to cooperate with law enforcement agencies to combat crimes.

Due to security concerns, we are unable to accept requests for non-public user information that are served via email. Except for exigent emergency involving imminent danger to life, original document of the formal request (subpoena, search warrant, court order or other legal proceedings) and any supporting document (such as scan copy of identification card or police badges) must be served to the office address of airVting Pte. Ltd. (as indicated above) before the user information is released to the law enforcement agencies. We encourage law enforcement agencies to notarize the formal request to help us verify its authenticity. We will not release sensitive user information unless we are convinced of the authenticity of the request.

The formal request should: (a) identify the airVting ID or UID of requested account, (b) identify the information requested, (c) indicate the purpose of the request or indicate that the purpose is confidential; and (d) state the legal basis for the request. If the formal request is not in English, we encourage the law enforcement agencies to provide an English translation.

We will keep the existence of the request confidential if requested by the law enforcement agencies. However, we may take actions against any account that violates the User Agreement, including disabling the account.

We encourage law enforcement agencies to contact us via email (legal@airVting.com) regarding the availability of user information before serving the formal request.


Amendments to the Privacy Policy
airVting periodically makes changes to the privacy policy. And the current version will be found at the following link: About us>Privacy Policy. By continuing to avail our Services, you agree to be bound by the revised Privacy Policy.

"""

let USERAGREEMENT = """
airVting User Agreement

1. Special Notices
1.1 This airVting User Agreement (this “Agreement”) governs your usage of our services, (hereinafter, “Services”) including airVting App, a video streaming application and social network developed by us. You are one party and the other party is airVting PTE.LTD. (“we” or “airVting”), a company with its registered ACRA number UEN:20173727208N. For the purposes of this Agreement, you and airVting will be jointly referred to as the “Parties” and respectively as a “Party”.

1.2 By using our Services, or by clicking on "Sign Up" during the registration process, you agree to all terms of this Agreement. We, at our sole discretion, may revise this Agreement from time to time, and the current version will be found at the following website: www.airVting.com >User Agreement. By continuing to avail our Services, you agree to be bound by the revised Agreement.

1.3 You may only use our Service if you are 16 years or older, and if you are not subject to statutory age limit to enter into this Agreement according to the applicable laws and regulations in your country. If you are below the aforementioned minimum age, you may only use airVting if your guardian has provided us with valid consent for you to use airVting. You may not falsely claim you have reached the minimum age.

1.4 You shall be solely responsible for the safekeeping of your airVting account and password. All behaviors and activities conducted through your airVting account will be deemed as your behaviors and activities for which you shall be solely responsible.

2. Services Content
2.1.We reserve the right to change the content of our Services from time to time, at our discretion, with or without notice.

2.2 Some of the Services provided by airVting require payment. For paid-for Services, airVting will give you explicit notice in advance and you may only access such Services if you agree to and pay the relevant charges. If you choose to decline to pay the relevant charges, airVting shall not be bound to provide such paid-for Services to you.

2.3 airVting needs to perform scheduled or unscheduled repairs and maintenance. If such situations cause an interruption of paid-for Services for a reasonable duration, airVting shall not bear any liability to you and/or to any third parties. However, airVting shall provide notice to you as soon as possible.

2.4 airVting has the right to suspend, terminate or restrict provision of the Services under this Agreement at any time and is not obligated to bear any liability to you or any third party, if any of the following events occur:

2.4.1 You are under the minimum age in order to receive airVting services;

2.4.2 You violate the Terms of Use stipulated in this Agreement;

2.4.3 You fail to make a payment for using paid-for Services.

2.5 EXCEPT FOR THE EXPRESS REPRESENTATIONS AND WARRANTIES SET FORTH IN THIS AGREEMENT, airVting MAKES NO WARRANTY IN CONNECTION WITH THE SUBJECT MATTER OF THIS AGREEMENT AND airVting HEREBY DISCLAIMS ANY AND ALL OTHER WARRANTIES, WHETHER STATUTORY, EXPRESS OR IMPLIED, INCLUDING ALL IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND ANY IMPLIED WARRANTIES ARISING FROM COURSE OF DEALING OR PERFORMANCE, REGARDING SUCH SUBJECT MATTER.

3. Privacy
3.1 You acknowledge that you have read and fully understand our Privacy Policy, which describes how we handle the data you provide to us or generated when you use our Services. If you have any question, please contact us at: wevalueyou@airVting.com

4. Terms of Use
4.1 You are responsible for the accuracy of information that you provide to airVting, and upon request from airVting, verify accuracy of the information given.

4.2 You may not create airVting account for others, or allow others to use your airVting account. You shall immediately notify airVting if you discover unlawful use of your account by others.

4.3 In consideration for our Services, you agree that airVting has the right to place advertisement or other types of commercial information. You also agree to receive advertisement or other relevant commercial information from airVting via email or other methods.

4.4 While using airVting Services, you must abide by all applicable laws and regulations, and all rules and policies of airVting.

4.5 You may only share information that you are comfortable sharing with the public. You may not distribute via airVting any content that may be considered:

4.5.1 pornographic, obscene or indecent, or any adult content, including any form of child exploitation;

4.5.2 excessively violent, including any content that is related to death or serious injury;

4.5.3 depicting, encouraging or assisting suicide or self-harm;

4.5.4 rumor, false or misleading information;

4.5.5 hateful speech or conduct, including any content that promote racism, terrorism, ageism or sexism;

4.5.6 profane, blasphemous or any content that may offend people of certain faith, or otherwise related to religion;

4.5.7 related to gambling, abortion, weapon, or other highly explosive subject matter;

4.5.8 abusive, libelous, or otherwise harassing other people or group;

4.5.9 spam, junk mail or other unsolicited advertisement;

4.5.10 other contents that in the judgement of airVting that are negative contents or otherwise not suitable for distribution.

4.6 You may not impersonate any other individual, entity, governmental agency or organizations.

4.7 You may not publish or distribute other people's private information without their express authorization and permission.

4.8 You affirm, represent, and warrant that you own or have the necessary licenses, rights, consents, and permissions to publish or distribute any copyrighted or proprietary works. You are solely responsible to clear such licenses, rights, consents, and permissions.

4.9 You may not publish or link to any malicious code, phishing website or other content that may threaten the security of the Internet.

4.10 airVting has the right to review and monitor your behavior on airVting. If airVting, at its sole discretions, reasonably considers that you have violated the Terms of Use, airVting may freeze, suspend, disable, ban or revoke your account. You understand that any virtual gift associated with your account will be frozen, suspended, disabled, banned or revoked as well.

4.11 If airVting discovers or reasonably suspects that any of your virtual gift is acquired in a fraudulent or illegal manner, or is in an abnormal status, airVting may freeze, suspend, disable, ban or revoke such virtual gift.

4.12 If your account is frozen, suspended, disabled, banned or revoked, you may not create a second account or ask any other to create a second account for you.

4.13 If you violate any Terms of Use, you shall indemnify and hold harmless of airVting against any liability resulting from a claim by a third party in relation to your violation.

5. Refund Policy
5.1 Unless otherwise required by the applicable law, no refund will be entertained after the virtual items (such as “tokens”) has been purchased.

6. Intellectual Property Rights
6.1 All text, data, images, graphics, audio and/or video information and other materials within the Services provided by airVting are property of airVting are protected by copyright, trademark and/or other property rights laws. Nothing in this Agreement shall be construed as conferring any license of any intellectual property rights or such materials by airVting to you.

6.2 By using and/or uploading any live stream content or other content through a airVting Services to publicly accessible areas of airVting website, you grant to airVting and its sub-licensees the permission, free, permanent, irrevocable, non-exclusive and fully sub-licensable rights and license, without any territorial or time limitations and without requiring any approvals and/or compensations, to use, copy, modify, adapt, publish, translate, edit, dispose, create derivate works of, distribute, perform and publicly display such content (in whole or in part), and/or incorporate such content into existing or future forms of work, media or technology.

7. Terminating Services
7.1 You may terminate airVting Services and this Agreement by revoking your airVting account. You may contact us at: wevalueyou@airVting.com

8. Disclaimers
8.1 You shall be fully responsible for any risks involved in using airVting Services. Any use or reliance on airVting Services will be at your own risk.

8.2 Under no circumstance does airVting guarantee that the Services will satisfy your requirements, or guarantee that the Services will be uninterrupted. The timeliness, security and accuracy of the Services are also not guaranteed. You acknowledge and agree that the Services is provided by airVting on an “as is” basis. airVting make no representations or warranties of any kind express or implied as to the operation and the providing of such Services or any part thereof. airVting shall not be liable in any way for the quality, timeliness, accuracy or completeness of the Services and shall not be responsible for any consequences which may arise from your use of such Services.

8.3 airVting does not guarantee the accuracy and integrity of any external links that may be accessible by using the Services and/or any external links that have been placed for the convenience of you. airVting shall not be responsible for the content of any linked site or any link contained in a linked site, and airVting shall not be held responsible or liable, directly or indirectly, for any loss or damage in connection with the use of the Services by you. Moreover, airVting shall not bear any responsibility for the content of any webpage that you are directed via an external link that is not under the control of airVting.

8.4 airVting shall not bear any liability for the interruption of or other inadequacies in the Services caused by circumstances of force majeure, or that are otherwise beyond the control of airVting. However, as far as possible, airVting shall reasonably attempt to minimize the resulting losses of and impact upon you.

9. Legal Jurisdiction
9.1 This Agreement shall be governed by and construed in accordance with the laws of Singapore, without regard to choice of law principles. Any dispute arising out of or in connection with this Agreement, including any question regarding its existence, validity or termination, shall be referred to and finally resolved by arbitration administered by the Singapore International Arbitration Centre in accordance with the Arbitration Rules of the Singapore International Arbitration Centre for the time being in force, which rules are deemed to be incorporated by reference in this clause. The seat of the arbitration shall be Singapore. The language of the arbitration shall be English.

10. Other Terms
10.1 This Agreement constitutes the entire agreement of agreed items and other relevant matters between both parties. Other than as stipulated by this Agreement, no other rights are vested in either Party to this Agreement.

10.2 If any provision of this Agreement is rendered void or unenforceable by competent authorities, in whole or in part, for any reason, the remaining provisions of this Agreement shall remain valid and binding.

10.3 The headings within this Agreement have been set for the sake of convenience, and shall be disregarded in the interpretation of this Agreement.

"""
