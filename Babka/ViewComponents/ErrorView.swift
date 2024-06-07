//
//  ErrorView.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import SwiftUI

struct ErrorView: View {
    @State var error: Error
        
    var body: some View {
        Text("Error: \(error.localizedDescription)")
    }
}


