indexing
	description: "Interface Elements, icons, bitmaps, etc."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_CONSTANTS

inherit
	APPLICATION_CONSTANTS
	
feature -- Access

	folder_closed_icon: EV_PIXMAP is
			-- Icon for Closing
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_close_folder.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	folder_open_icon: EV_PIXMAP is
			-- Icon for Opening
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_open_file.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	text_file_icon: EV_PIXMAP is
			-- File icon (text file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_format_text_color.ico")
			Result.set_with_named_file (l_file.string)
		end

	xml_file_icon: EV_PIXMAP is
			-- File icon (xml file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_format_text_color.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	html_file_icon: EV_PIXMAP is
			-- File icon (html file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_html_file.ico")
			Result.set_with_named_file (l_file.string)
		end

end -- class GRAPHICAL_CONSTANTS
