indexing
	description: "Constants for Table of Contents."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_CONSTANTS

inherit
	SHARED_OBJECTS

feature -- HTML Help 1.x

	html_help_header: STRING is "<HTML>%N<HEAD>%N</HEAD><BODY>%N"

	html_help_footer: STRING is "</BODY></HTML>"
	
	Toc_folder_name: STRING is "toc"
	
	topic_file_types: ARRAYED_LIST [STRING] is
			-- List of acceptable file types for display
		do
			Create Result.make (2)
			Result.compare_objects
			Result.extend ("htm")
			Result.extend ("html")
		end
		
	default_url: STRING is
			-- Url identifier to be used for folder nodes (i.e "index.xml"), if any
		once
			Result := Shared_constants.Application_constants.index_file_name
		end

	use_title_tag: BOOLEAN is True
			-- Use HTML <title> tag to determine node names?  If False then
			-- just take file/folder name directly
			
------------------------------------------------			
			
feature -- Pixmaps

	folder_closed_icon: EV_PIXMAP is
			-- Icon for Closing
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Shared_constants.Application_constants.Icon_resources_directory)
			l_file.extend ("icon_toc_folder_closed.ico")
			Result.set_with_named_file (l_file)
		end
		
	folder_open_icon: EV_PIXMAP is
			-- Icon for Opening
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Shared_constants.Application_constants.Icon_resources_directory)
			l_file.extend ("icon_toc_folder_open.ico")
			Result.set_with_named_file (l_file)
		end
		
	file_icon: EV_PIXMAP is
			-- File icon
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Shared_constants.Application_constants.Icon_resources_directory)
			l_file.extend ("icon_format_text_color.ico")
			Result.set_with_named_file (l_file)
		end
			
feature -- XML tags			
			
	id_string: STRING is "id"
			
	title_string: STRING is "title"
	
	url_string: STRING is "url"
	
	file_string: STRING is "file"
	
	folder_string: STRING is "folder"
	
	root_string: STRING is "table_of_contents"

end -- class TABLE_OF_CONTENTS_CONSTANTS
