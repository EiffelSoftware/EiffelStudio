indexing
	description: "Interface Elements, icons, bitmaps, etc."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_CONSTANTS

inherit
	APPLICATION_CONSTANTS
	
feature -- Icon constants

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
		
	css_file_icon, 
	js_file_icon,
	text_file_icon: EV_PIXMAP is
			-- File icon (text files)
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

	png_file_icon: EV_PIXMAP is
			-- File icon (png file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_png_file.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	jpg_file_icon: EV_PIXMAP is
			-- File icon (jpg file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_jpeg_file.ico")
			Result.set_with_named_file (l_file.string)
		end

	gif_file_icon: EV_PIXMAP is
			-- File icon (gif file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_gif_file.ico")
			Result.set_with_named_file (l_file.string)
		end

feature -- Color constants

	tag_color: EV_COLOR is
			-- Color for tags (<,>,=,/,")
		once
			create Result.make_with_rgb (0.0, 0.0, 1.0)	
		end		

	element_color: EV_COLOR is
			-- Color for elements
		once
			create Result.make_with_rgb (1.0, 0.0, 0.0)	
		end		
		
	attribute_color: EV_COLOR is
			-- Color for attributes
		once
			create Result.make_with_rgb (203, 203, 152)	
		end		

	content_color: EV_COLOR is
			-- Color for attributes
		once
			Result := (create {EV_STOCK_COLORS}).black
		end	

	white: EV_COLOR is
			-- Color for attributes
		once
			Result := (create {EV_STOCK_COLORS}).white
		end	

end -- class GRAPHICAL_CONSTANTS
