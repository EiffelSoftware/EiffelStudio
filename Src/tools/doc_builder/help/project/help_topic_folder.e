indexing
	description: "Help topic folder."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_TOPIC_FOLDER

inherit
	HELP_TOPIC
		rename
			make as make_topic
		redefine
			is_allowed
		end

create
	make_from_directory,
	make_from_node

feature -- Creation

	make_from_directory (title: STRING; folder: DIRECTORY) is
			-- Make with `folder' as root
		require
			title_not_void: title /= Void
			folder_not_void: folder /= Void
			folder_exists: folder.exists
		do
			make_list (5)
			directory := folder
			if folder.has_entry (Default_url) then
				make_from_url (title, directory.name + "\" + Default_url)	
			else
				make_topic (title)
			end
			process_directory (directory)
		end
		
feature -- Access		
		
	directory: DIRECTORY
			-- Directory on disk			
		
feature -- Query

	is_allowed: BOOLEAN is
			-- Is Current acceptable for inclusion in table of contents
		local
			l_file: PLAIN_TEXT_FILE
		do
			if url /= Void then
				Result := True
			end
			if not Result and then directory /= Void then 
				if contains_topic_file (directory) then
					Result := True
				end
			end
		end
		
	has (a_dir: DIRECTORY; a_filename: STRING): BOOLEAN is
			-- Does `a_dir' have a file named `a_filename' (not recursive)
		local
			cnt: INTEGER
			path: STRING
		do
			from
				cnt := 0
				a_dir.open_read
				a_dir.start
				path := a_dir.name
			until
				cnt = a_dir.count or Result
			loop
				a_dir.readentry
				if a_dir.lastentry.is_equal (a_filename) then
					Result := True
				end
				cnt := cnt + 1
			end
			a_dir.close
		end	
		
	has_only_default_url: BOOLEAN is
			-- Does Current have a `default_url' file and no other allowed file type?
		do
			Result := has (directory, default_url) and then topic_file_count = 1
		end		
		
	contains_topic_file (a_dir: DIRECTORY): BOOLEAN is
			-- Does `a_dir' have a file recognized by `topic_file_types'
			-- as a child (recursive)?
		local
			cnt: INTEGER
			sub_dir: DIRECTORY
			path: STRING
		do
			from
				cnt := 0
				a_dir.open_read
				a_dir.start
				path := a_dir.name
			until
				cnt = a_dir.count or Result
			loop
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal ("..")) then
					create sub_dir.make (path + "\" + a_dir.lastentry)
					if sub_dir.exists then
						Result := contains_topic_file (sub_dir)
					end
					if topic_file_types.has (file_type (a_dir.lastentry)) then
						Result := True
					end
				end
				cnt := cnt + 1
			end
			a_dir.close
		end	
		
	topic_file_count: INTEGER is
			-- Number of `topic_file_types' in Current
		local
			cnt: INTEGER
		do
			from
				cnt := 0
				directory.open_read
				directory.start
			until
				cnt = directory.count
			loop
				directory.readentry
				if not (directory.lastentry.is_equal (".") or directory.lastentry.is_equal ("..")) then
					if topic_file_types.has (file_type (directory.lastentry)) then
						Result := Result + 1
					end
				end
				cnt := cnt + 1
			end
			directory.close
		end

feature {NONE} -- Implementation

	process_directory (a_dir: DIRECTORY) is
			-- Process `a_dir' as root directory recursively to build TOC tree
		require
			a_dir_not_void: a_dir /= Void
		local
			file_node: HELP_TOPIC_FILE
			folder_node: HELP_TOPIC_FOLDER
			l_file: PLAIN_TEXT_FILE
			sub_dir: DIRECTORY
			cnt: INTEGER
			path, l_entry_title: STRING
		do
			from
				start
				cnt := 0
				a_dir.open_read
				a_dir.start
				path := a_dir.name
			until
				cnt = a_dir.count
			loop
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal ("..")) then
					create sub_dir.make (path + "\" + a_dir.lastentry)
					if not sub_dir.exists then
						create l_file.make (a_dir.name + "\" + a_dir.lastentry)
						if l_file.exists then
									-- We have a file node
								if topic_file_types.has (file_type (short_name (l_file.name))) then
									l_entry_title := title_tag_value (l_file)
									if l_entry_title /= Void and then not l_entry_title.is_empty then
										create file_node.make_from_url (l_entry_title, l_file.name)
									else
										create file_node.make_from_url (short_name (l_file.name), l_file.name)
									end	
								end	
							if file_node /= Void then
								extend (file_node)							
							end														
						end						
					else
						if sub_dir.has_entry (Default_url) then
							create l_file.make (sub_dir.name + "\" + default_url)
							if l_file.exists then
									-- We have a directory node with a default file
								if topic_file_types.has (file_type (short_name (l_file.name))) then
									l_entry_title := title_tag_value (l_file)
									if l_entry_title /= Void and then not l_entry_title.is_empty then
										create folder_node.make_from_directory (l_entry_title, sub_dir)
									else
										create folder_node.make_from_directory (short_name (l_file.name), sub_dir)
									end
								end
							end
						else
								-- We have a directory node with no default url
							create folder_node.make_from_directory (short_name (sub_dir.name), sub_dir)
						end
						if folder_node /= Void then
							extend (folder_node)
						end						
					end
				end
					-- Set nodes to Void here so that are not duplicated
				file_node := Void
				folder_node := Void
				cnt := cnt + 1
			end
			a_dir.close
		end

feature {NONE} -- Implementation

	title_tag_value (a_file: PLAIN_TEXT_FILE): STRING is
			-- The HTML '<title>' tag value for HTML file `a_file'
		require
			file_not_void: a_file /= Void
			file_exists: a_file.exists
			file_not_open: a_file.is_closed
		local
			l_regex: SYSTEM_DLL_REGEX
			l_string: STRING
		do
			a_file.open_read
			a_file.readstream (a_file.count)
			l_string := a_file.last_string
			l_string.replace_substring_all ("%N", "")
			l_string.replace_substring_all ("%T", "")
			create l_regex.make_from_pattern ("[<][tT][iI][tT][lL][eE][>](?<value>.*)[<][/][tT][iI][tT][lL][eE][>]")
			if l_regex.is_match (l_string) then
				Result := (l_regex.match (l_string)).result_ ("${value}")
			end
			a_file.close
		end		

invariant
	has_folder: directory /= Void

end -- class HELP_TOPIC_FOLDER
