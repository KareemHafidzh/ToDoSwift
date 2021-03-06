//
//  EmptyListView.swift
//  TodoSwiftUI
//
//  Created by Kareem Abdul Hafidzh on 18/02/21.
//

import SwiftUI

struct EmptyListView: View {
    @State private var isAnimated : Bool = false
    
    let images : [String] = [
        "illustration-no1",
        "illustration-no2",
        "illustration-no3"
    ]
    
    let tips : [String] = [
        "gunakan waktumu dengan bijak",
        "keep down to earth",
        "persiapkan hari esok lebih baik",
        "asal perlahan yang penting slesai"
    ]
    var body: some View {
        ZStack{
            VStack(alignment: .center , spacing:20){
                Image("\(images.randomElement() ?? self.images[0])")
                    .resizable()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 380, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                Text("\(tips.randomElement() ?? self.tips[0])").font(.system(.headline, design: .rounded))
            }
            .padding(.horizontal)
            .opacity(isAnimated ? 1:0)
            .offset(y: isAnimated ? 0:-50)
            .animation(.easeOut(duration: 1.5))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView().environment(\.colorScheme, .dark)
    }
}
