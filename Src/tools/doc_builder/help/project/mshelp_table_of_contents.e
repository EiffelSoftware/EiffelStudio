indexing
	description: "Microsoft Help 2.0 (VSIP) Help Table of Contents."
	date: "$Date$"
	revision: "$Revision$"

class
	MSHELP_TABLE_OF_CONTENTS

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

	create_toc_file is
			-- Create the table of contents file for the project
		local
			template: PLAIN_TEXT_TEMPLATE_FILE
			template_file: FILE_NAME
		do
			create template_file.make_from_string (Shared_constants.Application_constants.Templates_path)
			template_file.extend ("\HelpTOCTemplate.HxT")
			create template.make (template_file)
			template.add_symbol ("toc", full_toc_text)
			template.save_file (project.toc_file_name)
			create contents_file.make (template.template_filename)
		end

	write_contents_file is
			-- Write to `contents_file'
		do
			create_toc_file
		end		

	full_toc_text: STRING is
			-- The full string containing all TOC information for Current
		local
			folder: HELP_TOPIC_FOLDER
			file: HELP_TOPIC_FILE
		do
			from
				start
				create Result.make_empty
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
		end		

	node_text (node: HELP_TOPIC): STRING is
			-- Text for `node'
		require
			allowed: node.is_allowed
		local
			folder: HELP_TOPIC_FOLDER
		do
			folder ?= node
			create Result.make_from_string ("<HelpTOCNode")
			if node.url /= Void then
				Result.append (" Url=%"" + node.relative_url + "%"")
			end
			if node.entry_title /= Void then
				Result.append (" Title=%"" + node.entry_title + "%"")
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
			Result.append ("</HelpTOCNode>%N")
		end

end -- class MSHELP_TABLE_OF_CONTENTS
