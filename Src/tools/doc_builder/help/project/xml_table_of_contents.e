indexing
	description: "Table of contents in XML representation."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_TABLE_OF_CONTENTS

inherit
	HELP_TABLE_OF_CONTENTS

create
	make_from_directory,
	make_from_widget

feature -- Access

	write_contents_file is
			-- Write XML	
		do
			create contents_file.make_create_read_write (project.toc_file_name)
			contents_file.put_string (full_toc_text)
		end

	full_toc_text: STRING is
			-- The full string containing all TOC information for Current
		local
			folder: HELP_TOPIC_FOLDER
			file: HELP_TOPIC_FILE
		do
			from
				start
				create Result.make_from_string ("<toc>")
			until
				after
			loop
				folder ?= item
				file ?= item
				if folder /= Void then
					Result.append (node_text (folder))
				elseif file /= Void then
					if file.is_allowed then
						Result.append (node_text (file))	
					end
				end
				forth
			end
			Result.append ("</toc>")
		end		

	node_text (node: HELP_TOPIC): STRING is
			-- Text for `node'
		require
			allowed: node.is_allowed
		local
			folder: HELP_TOPIC_FOLDER
			l_node_type_name: STRING
		do
			folder ?= node
			if folder /= Void then
				l_node_type_name := "<toc_folder "
			else
				l_node_type_name := "<toc_file "				
			end
			create Result.make_from_string (l_node_type_name)
			
			if node.url /= Void then
				Result.append ("file_url=%"" + node.relative_url + "%"")
			end
			if node.entry_title /= Void then
				Result.append (" toc_title=%"" + node.entry_title + "%"")
			end
			Result.append (">")
			if folder /= Void then
				from
					folder.start
				until
					folder.after
				loop
					if folder.item.is_allowed then
						Result.append (node_text (folder.item))
					end
					folder.forth
				end
			end
			Result.append ("</" + l_node_type_name + ">")
		end

end -- class XML_TABLE_OF_CONTENTS
