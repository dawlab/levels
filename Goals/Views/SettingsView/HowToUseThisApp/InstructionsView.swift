    //
    //  InstructionsView.swift
    //  Goals
    //
    //  Created by Dawid Łabno on 04/06/2023.
    //

    import SwiftUI

    struct InstructionsView: View {
        var body: some View {
                List {
                    Text(L10n.about1)
                        .listRowBackground(Color.clear)
                    
                    Text(L10n.about2)
                    .listRowBackground(Color.clear)
                    .bold()
                    
                    Text(L10n.about3)
                        .listRowBackground(Color.clear)
                    
                    Section(header: Text("Linki")) {
                        HStack {
                            Image(systemName: "questionmark.circle").foregroundColor(.blue)
                            Link(destination: URL(string: "https://youtu.be/mjF1Tv3PM6c")!) {
                                Text(L10n.link1)
                            }
                            Spacer()
                            Image(systemName: "link")
                        }
                        
                        HStack {
                            Image(systemName: "questionmark.circle").foregroundColor(.blue)
                            Link(destination: URL(string: "https://akademia.pl/cele")!) {
                                Text(L10n.link2)
                            }
                            Spacer()
                            Image(systemName: "link")
                        }
                    }
                }
                .navigationBarTitle(L10n.howToUse, displayMode: .inline)
        }
    }

    struct InstructionsView_Previews: PreviewProvider {
        static var previews: some View {
            InstructionsView()
        }
    }
