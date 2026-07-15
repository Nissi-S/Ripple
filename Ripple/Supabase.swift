//
//  Supabase.swift
//  Ripple
//
//  Created by Nissi Sanju on 6/13/26.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://nzqaobzmngmtdivkzkmw.supabase.co")!,
  supabaseKey: "sb_publishable_DrjtiH2S9vF12xF-Al7eqg_MZxcY-Ja",
  options: SupabaseClientOptions(
    auth: SupabaseClientOptions.AuthOptions(
      emitLocalSessionAsInitialSession: true
    )
  )
)

