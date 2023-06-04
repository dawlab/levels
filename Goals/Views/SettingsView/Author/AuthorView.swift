//
//  AuthorView.swift
//  Goals
//
//  Created by Dawid Łabno on 04/06/2023.
//

import SwiftUI

struct AuthorView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Image("zenslo")
                        .resizable()
                        .cornerRadius(50)
                        .padding(.all, 4)
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(8)
                    Text("L10n.authorDescription")
                }
            }
            
            Section {
                HStack {
                    Link(destination: URL(string:"https://zenslo.com")!) {
                        Text("L10n.myHomepage")
                    }
                    Spacer()
                    Image(systemName: "link")
                }
                
                HStack {
                    Link(destination: URL(string:"https://instagram.com/iamzenslo")!) {
                        Text("L10n.instagram")
                    }
                    Spacer()
                    Image(systemName: "link")
                }
                
                HStack {
                    Link(destination: URL(string:"https://twitter.com/heyzenslo")!) {
                        Text("Twitter")
                    }
                    Spacer()
                    Image(systemName: "link")
                }
            }
        }
    }
}

struct AuthorView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorView()
    }
}
