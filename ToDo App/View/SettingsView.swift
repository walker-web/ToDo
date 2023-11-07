//
//  SettingsView.swift
//  ToDo App
//
//  Created by Ashish on 30/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section(header: Text("Follow us on social media.")) {
                        FormRowLinkView(icon: "globe", colors: Color.black, text: "GitHub", link: "https://www.github.com/walker-web")
                        FormRowLinkView(icon: "person", colors: Color.pink, text: "Instagram", link: "https://www.instagram.com/itx_ashiish/")
                        FormRowLinkView(icon: "bubble.left", colors: Color.blue, text: "LinkedIn", link: "https://www.linkedin.com/in/ashish-goyal-015549206/")
                    }
                    
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "ASHISH")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0")
                    }
                }
//                .listStyle(GroupedListStyle())
//                .environment(\.horizontalSizeClass, .regular)
                
                Text("Copyright © All rights reserved ")
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            } // VSTACK
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }) // BUTTON
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        } // NAVIGATION
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
