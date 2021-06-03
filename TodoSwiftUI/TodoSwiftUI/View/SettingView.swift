//
//  SettingView.swift
//  TodoSwiftUI
//
//  Created by Kareem Abdul Hafidzh on 22/02/21.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Form{
                    Section(header: Text("Choose the app icon")){
                                      Picker(selection: $iconSettings.currentIndex, label: Text("App Icons")){
                                         ForEach(0..<iconSettings.iconNames.count){index in
                                            HStack{
                                               Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                                  .renderingMode(.original)
                                                  .resizable()
                                                  .scaledToFit()
                                                  .frame(width: 44,height: 44)
                                                  .cornerRadius(8)
                                               
                                               Spacer().frame(width: 8)
                                               
                                               Text(self.iconSettings.iconNames[index] ?? "Blue")
                                                  .frame(alignment: .leading)
                                            }
                                            .padding(3)
                                         }
                                      }
                                      .onReceive([self.iconSettings.currentIndex].publisher.first()){
                                         (value) in
                                         let index = self.iconSettings.iconNames.firstIndex(of:
                                                                                               UIApplication.shared.alternateIconName) ?? 0
                                         if index != value {
                                            UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){
                                               error in
                                               if let error = error {
                                                  print(error.localizedDescription)
                                               }else{
                                                  print("Success")
                                               }
                                            }
                                         }
                                      }
                                   }
                                   .padding(.vertical,3)
                    Section(header: Text("follow me on my social media")){
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "my website", link:"todo.app")
                        FormRowLinkView(icon:"link", color:Color.blue, text: "twitter", link : "")
                        FormRowLinkView(icon:"desktop", color:Color.purple, text: "instagram", link : "")
                    }
                    .padding(.vertical,3)
                    
                    Section(header: Text("about the application")){
                        FormRowStaticView(icon:"gear", firtsText: "Application", secondText: "Todo")
                        FormRowStaticView(icon:"checkmark.seal", firtsText: "Compatibility", secondText: "iphone,ipad")
                        FormRowStaticView(icon:"keyboard", firtsText: "developer", secondText: "Kareem")
                        FormRowStaticView(icon:"flag", firtsText: "Version", secondText: "1.1.0")
                    }
                    .padding(.vertical,3)
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                Text("Copyright All right reserved. less code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top,6)
                    .padding(.bottom,8)
                    .foregroundColor(.secondary)
            }
            
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }){
                                        Image(systemName: "xmark")
                                    }
            )
            .navigationBarTitle("settings",displayMode: .inline)
            .background(Color("colorbase")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
