//
//  CommonUIFunctions.swift
//  CitiesListDemo
//
//  Created by Omkar Jadhav on 09/05/24.
//

import Foundation
import SwiftUI
import UIKit

extension View {
    func hideNavigationBar() -> some View {
        self
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
    
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
    
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
    
    func navigatePush(whenTrue toggle: Binding<Bool>) -> some View {
        VStack {
            
            NavigationLink(
                destination: self,
                isActive: toggle
            ) { EmptyView() }
        }
    }
    
    func navigationBackButton(color: UIColor, text: String? = nil) -> some View {
        modifier(NavigationBackButton(color: color, text: text))
    }
}

struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

struct NavigationBackButton: ViewModifier {

    @Environment(\.presentationMode) var presentationMode
    var color: UIColor
    var text: String?

    func body(content: Content) -> some View {
        return content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {  presentationMode.wrappedValue.dismiss() }, label: {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(color))

                    if let text = text {
                        Text(text)
                            .foregroundColor(Color(color))
                    }
                }
            })
        )
    }
}
