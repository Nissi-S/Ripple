//
//  AuthViewModel.swift
//  Ripple
//
//  Created by Nissi Sanju on 6/13/26.
//

import SwiftUI
import Supabase
import Combine

@MainActor

class AuthViewModel: ObservableObject {
    @Published var session: Session?
    @Published var isAuthenticated = false
    @Published var currentUserRole: String?
    
    func getIntialSession() async {
        do {
            let current = try await supabase.auth.session
            self.session = current
            self.isAuthenticated = current != nil
            
            if self.isAuthenticated {
                await fetchUserRole()
            }
        } catch {
            print("No active session: \(error.localizedDescription)")
        }
    }
    
    func signUp(email: String, password: String, role: String) async {
        do {
               let result = try await supabase.auth.signUp(
                   email: email,
                   password: password
               )
               
               let user = result.user
               
               try await supabase
                   .from("profiles")
                   .insert([
                       "id": user.id.uuidString,
                       "email": email,
                       "role": role
                   ])
                   .execute()
               
               self.session = result.session
               self.isAuthenticated = self.session != nil
               
           } catch {
               print("Sign up failed: \(error.localizedDescription)")
           }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let result = try await supabase.auth.signIn(email: email, password: password)
            self.session = result
            self.isAuthenticated = self.session != nil
            
            await fetchUserRole()
        }
        catch {
            print("Sign In failed: \(error.localizedDescription)")
        }
    }
    
    func signOut() async {
        do {
            try await supabase.auth.signOut()
            self.session = nil
            self.isAuthenticated = false
//            isAuthenticated = false
        }
        catch {
            print("Sign Out failed: \(error.localizedDescription)")
        }
    }
    
    func fetchUserRole() async {
        guard let userId = session?.user.id else { return }
        
        do {
            let profile: Profile = try await supabase
                .from("profiles")
                .select()
                .eq("id", value: userId)
                .single()
                .execute()
                .value
            print("Fetched role: \(profile.role)")
            self.currentUserRole = profile.role
            
        } catch {
            print("Failed to fetch role: \(error.localizedDescription)")
        }
    }
    
}
