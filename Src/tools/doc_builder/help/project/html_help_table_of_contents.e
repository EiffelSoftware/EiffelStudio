indexing
	description: "HTML Help Table of Contents."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_HELP_TABLE_OF_CONTENTS

inherit
	HELP_TABLE_OF_CONTENTS
	
	TABLE_OF_CONTENTS_CONSTANTS
		undefine
			copy,
			is_equal
		end

create
	make_from_directory,
	make_from_widget
	
feature -- Access

	write_contents_file is
			-- Write to `contents_file'
		local
			folder: HELP_TOPIC_FOLDER
			file: HELP_TOPIC_FILE
		do
			create contents_file.make_create_read_write (project.toc_file_name)
			contents_file.put_string (html_help_header)
			contents_file.put_string ("<OBJECT type=%"text/site properties%">%
				%<param name=%"Window Styles%" value=%"0x800025%"><param name=%"ImageType%" value=%"Folder%"></OBJECT>")
			from
				start
			until
				after
			loop
				folder ?= item
				file ?= item
				if folder /= Void then
					contents_file.put_string ("<UL>%N")
					contents_file.put_string (node_text (folder))
					contents_file.put_string ("</UL>%N")	
				elseif file /= Void then
					if file.is_allowed then
						contents_file.put_string (node_text (file))	
					end
				end
				forth
			end
			contents_file.put_string (html_help_footer)
			contents_file.flush
			contents_file.close
		end		

	node_text (node: HELP_TOPIC): STRING is
			-- HTML text representing `node' for TOC file
		require
			node_not_void: node /= Void
			allowed: node.is_allowed
		local
			folder: HELP_TOPIC_FOLDER
		do
			folder ?= node
			create Result.make_from_string ("<LI> <OBJECT type=%"text/sitemap%">%N<param name=%"Name%" value=%"")
			Result.append (node.entry_title)
			Result.append ("%">")
			if node.url /= Void then
				Result.append ("%N<param name=%"Local%" value=%"")
				Result.append (node.url)
				Result.append ("%">")
			end
			Result.append ("%N</OBJECT>%N")
			if folder /= Void then
				from
					folder.start
					Result.append ("<UL>%N")
				until
					folder.after
				loop
					if folder.item.is_allowed then
						Result.append (node_text (folder.item))
					end
					folder.forth
				end
				Result.append ("</UL>%N")
			end
		end

end -- class HTML_HELP_TABLE_OF_CONTENTS
