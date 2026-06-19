//
//  Supabase.swift
//  Ripple
//
//  Created by Nissi Sanju on 6/13/26.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://gcaabpvaswkezgkvabci.supabase.co")!,
  supabaseKey: "sb_publishable_T3dz9j-2Dyv_d2kagyQkUA_fvtDLW6z",
  options: SupabaseClientOptions(
    auth: SupabaseClientOptions.AuthOptions(
      emitLocalSessionAsInitialSession: true
    )
  )
)
