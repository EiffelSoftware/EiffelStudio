class  TEMPLATE_DIRECTORY_GLOBAL

inherit
    
    TEMPLATE 

feature -- Templates

    entries 
            -- Iterate on entries of current directory.
        note
            title: "Entries for a directory"
            tags: "Algorithm, entries , DIRECTORY"
        local
            l_dir: DIRECTORY
        do
            create l_dir.make_with_path (create {PATH}.make_current)
            if l_dir.exists and then l_dir.is_readable then
               across
                   l_dir.entries as ic
               loop
                  if ic.item.is_current_symbol or ic.item.is_parent_symbol then
                      -- Skip
                  else
                       -- Use entry `ic.item`  such as `io.put_string (ic.item.name); io.put_new_line`
                  end
               end
           end
        end
end