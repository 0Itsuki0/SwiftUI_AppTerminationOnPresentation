
import SwiftUI

struct AppTerminationDemo: View {
    @State private var presentDialog: Bool = false
    @State private var preventTerminateOnDialogPresent: Bool? = nil

    @State private var presentSheet: Bool = false
    @State private var preventTerminateOnSheetPresent: Bool? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("App Termination Behavior & Control")
                .font(.title3)
                .fontWeight(.bold)
            
            
            VStack(alignment: .leading) {
                Text("Sheet")
                    .font(.headline)
                Text("Terminable **ONLY IF** A tool bar is presented and it only contains a singular toolbar item with the placement being `confirmationAction`, `cancellationAction` or `destructiveAction`. ")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.subheadline)
                
                HStack(spacing: 24) {
                    Picker(selection: $preventTerminateOnSheetPresent, content: {
                        Text("Default behavior")
                            .tag(nil as Bool?)
                        Text("Allow Termination")
                            .tag(false)
                        Text("Prevent Termination")
                            .tag(true)
                    }, label: {})
                    Button(action: {
                        self.presentSheet = true
                    }, label: {
                        Text("Show Sheet")
                    })
                }
            }
            
            
            VStack(alignment: .leading) {
                Text("Dialog (Alert or ConfirmationDialog)")
                    .font(.headline)
                Text("""
Terminable **ONLY IF** 
- A single non-destructive button, ie: the standard dismiss action included by the dialog by default.
- The `dialogSeverity(_:)` is not `critical`
- no `TextField`
""")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.subheadline)
                
                HStack(spacing: 24) {
                    Picker(selection: $preventTerminateOnDialogPresent, content: {
                        Text("Default behavior")
                            .tag(nil as Bool?)
                        Text("Allow Termination")
                            .tag(false)
                        Text("Prevent Termination")
                            .tag(true)
                    }, label: {})

                    Button(action: {
                        self.presentDialog = true
                    }, label: {
                        Text("Show Dialog")
                    })
                }
            }

        }
        .padding()
        .frame(minWidth: 360, minHeight: 240, alignment: .top)
        .confirmationDialog("Dialog", isPresented: $presentDialog, actions: {
            Text("Some content")
        })
        .dialogPreventsAppTermination(preventTerminateOnDialogPresent)
        .sheet(isPresented: $presentSheet, content: {
            Text("Sheet Content")
                .padding(.all, 24)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction, content: {
                        Button(action: {
                            self.presentSheet = false
                        }, label: {
                            Text("Cancel")
                        })
                    })
                    
                    ToolbarItem(placement: .confirmationAction, content: {
                        Button(action: {
                            self.presentSheet = false
                        }, label: {
                            Text("Confirm")
                        })
                    })
                })
                .presentationPreventsAppTermination(preventTerminateOnSheetPresent)
        })
    }
}

#Preview {
    AppTerminationDemo()
}
