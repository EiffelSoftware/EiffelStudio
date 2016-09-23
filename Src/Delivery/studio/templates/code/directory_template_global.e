class  TEMPLATE_DIRECTORY_GLOBAL

inherit
	
	TEMPLATE 

feature -- Templates

	entries 
			-- Display entries of current directory.
		note
			title: "Entries for a directory"
			tags: "Algorithm, entries , DIRECTORY"
		local
			l_path: PATH
			l_dir: DIRECTORY
			i,j: INTEGER
		do
			create l_path.make_current
			create l_dir.make_with_path (l_path)

			across
				l_dir.entries as ic
			loop
				print (ic.item.name) 
				io.put_new_line
			end
		end
end
