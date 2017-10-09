//
//  AppDelegate.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 04.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//Вопрос 1
//Сделать (или реализовать максимальное количество функций) по выводу текста со стороннего ресурса в виде отдельных карточек на главном экране. Форма карточек – максимально близкая к концепции Material Design.
//Если ты никогда не занимался разработкой, самое время погрузиться в нее.
//Ресурс для вытягивания данных для карточек - https://jsonplaceholder.typicode.com/ (если точнее: Routes)
//
//Описание:
//- Главный экран с 5 карточками.
//- Экран с контактами (вашими).
//- Нижний бар с переключением между 1-ым и 2-ым экраном.
//- Список карточек на главном экране должен состоять из 5 элементов (5 ): posts, comments, users, photos, todos.
//- Для posts – отобразить результат для n-го поста (должна быть возможность вписать n в карточку и нажать «Подтвердить» для отображения результата). Максимальный n = 100. Вызов конкретного ID поста осуществляется через добавление ‘’/n’’ (n - id поста) к концу ссылки
//- Для comments – отобразить результат для n-го комментария (должна быть возможность вписать n в карточку и нажать «Подтвердить» для отображения результата). Максимальный n = 500. Вызов конкретного ID комментария осуществляется через добавление ‘’/n’’ (n - id комментария) к концу ссылки
//- Для users - отобразить результат первых 5-ти пользователей в единой карточке (в 5 линий). Вызов конкретного ID пользователя осуществляется через добавление ‘’/n’’ (n - id пользователя) к концу ссылки.
//- Для photo – отобразить результат 3-го фото в виде картинки, которая отобразится в карточке. Вызов конкретного ID фото осуществляется через добавление ‘’/n’’ (n - id фото) к концу ссылки.
//- Для todos – отобразить результат случайной задачи. Вызов конкретного ID задачи осуществляется через добавление ‘’/n’’ (n - id todo) к концу ссылки.
//
//Если выполнить все не получится, то постарайся сделать по максимуму текущих возможностей.
//
//Мы верим в тебя,
//Команда A-Teams

