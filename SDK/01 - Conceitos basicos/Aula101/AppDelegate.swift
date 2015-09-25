//
//  AppDelegate.swift
//  Aula101
//
//  Created by Eduardo Lima on 9/12/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Customização assim que a aplicação foi carregada.

        println("Aplicação carregada.")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Função executada quando a aplicação está ativa e indo para um estado inativo. Isso pode acontecer quando alguns tipos de interrupções de temporárias acontecem, como uma chamada telefônica recebida, ou quando o usuário minimiza a aplicação e esta ficará em segundo plano.
        // Esta função pode ser usada para parar tarefas em andamento, desativar timers e notificações indesejadas.
        
        println("Aplicação vai sair da ativa.")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Função executada quando o aplicativo entra em segundo plano de fato. Utilize essa função para salvar dados relevantes do usuário e da aplicação para que possa restaurar o estado do aplicativo assim que este voltar à ativa.
        
        println("Aplicação entrou em segundo plano.")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Função chamada como parte da transição de volta à ativa, quando a aplicação estava em segundo plano. Este é o ponto ideal para refazer alterações salvas no método applicationDidEnterBackground acima.
        
        println("Aplicação entrará na ativa.")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Função chamada quando o aplicativo está ativo após ser iniciado ou voltar de segundo plano. Pode ser usado para reativar tarefas interrompidas e atualizar a interface com as novas informações.

        println("Aplicação entrou na ativa.")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Função chamada quando a aplicação está prestes a finalizar. Importante: se o aplicativo suporta tarefas em segundo plano, este método não é chamado.
        
        println("Aplicação será finalizada.")
    }


}

