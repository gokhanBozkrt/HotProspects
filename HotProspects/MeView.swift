//
//  MeView.swift
//  HotProspects
//
//  Created by Gokhan Bozkurt on 7.06.2022.
//
import CoreImage.CIFilterBuiltins
import CoreImage
import SwiftUI

struct MeView: View {
  @State private var name = "Ananmymous"
  @State private var emailAddress = "you@yoursite.com"
  @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name",text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("Email Address",text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                    let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                        
                    }
            }
            .navigationTitle("Your Code")
            .onAppear(perform: updateCode)
            .onChange(of: name) { _ in updateCode() }
            .onChange(of: emailAddress) { _ in updateCode() }

        }
    }
    func updateCode() {
      qrCode = generateQRCoce(from: "\(name)\n\(emailAddress)")
    }
    func generateQRCoce(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
               return  UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}


