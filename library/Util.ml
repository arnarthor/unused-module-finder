let walk_directory_tree dir pattern =
  let re = Str.regexp pattern in
  let node_modules = Str.regexp ".*/node_modules/.*" in
  let esy = Str.regexp ".*/_esy/.*" in
  let select str =
    (not (Str.string_match node_modules str 0))
    && (not (Str.string_match esy str 0))
    && Str.string_match re str 0
  in
  let rec walk acc = function
    | [] ->
        acc
    | dir :: tail ->
        let contents = Array.to_list (Sys.readdir dir) in
        let contents = List.rev_map (Filename.concat dir) contents in
        let dirs, files =
          List.fold_left
            (fun (dirs, files) f ->
              match (Unix.stat f).st_kind with
              | S_REG ->
                  (dirs, f :: files)
              | S_DIR ->
                  (f :: dirs, files)
              | _ ->
                  (dirs, files))
            ([], []) contents
        in
        let matched = List.filter select files in
        walk (matched @ acc) (dirs @ tail)
  in
  walk [] [dir]

let exec_command cmd =
  let ic, oc = Unix.open_process cmd in
  let buf = Buffer.create 16 in
  ( try
      while true do
        Buffer.add_channel buf ic 1
      done
    with End_of_file -> () ) ;
  let _ = Unix.close_process (ic, oc) in
  Buffer.contents buf

let extract src_root =
  walk_directory_tree src_root ".*\\.re$"
  |> List.rev_map (fun filename -> (Filename.basename filename, filename))
  |> List.iter (fun (filename, file) ->
         let module_name = Filename.chop_suffix filename ".re" in
         print_endline (String.concat " " ["git"; "grep"; module_name]))

let run src_folder = extract src_folder
