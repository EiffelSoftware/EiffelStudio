indexing
	description: "Constants for Table of Contents."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_CONSTANTS

feature -- HTML Help 1.x

	html_help_header: STRING is "<HTML>%N<HEAD>%N</HEAD><BODY>%N"

	html_help_footer: STRING is "</UL></BODY></HTML>"
	
	icon_type_text: STRING is "<OBJECT type=%"text/site properties%"><param name=%"Window Styles%" value=%"0x800025%"></OBJECT>"
			-- Uses folders instead of books
	
feature -- File	
	
	default_url: STRING is "index.xml"
			-- Url identifier to be used for folder nodes (i.e "index.xml"), if any
			
	xml_extension: STRING is "xml"
			-- XML extension
			
feature -- Pixmaps

	folder_closed_icon: EV_PIXMAP is
			-- Icon for Closing
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_toc_folder_closed.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	folder_open_icon: EV_PIXMAP is
			-- Icon for Opening
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_toc_folder_open.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	file_icon: EV_PIXMAP is
			-- File icon
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_format_text_color.ico")
			Result.set_with_named_file (l_file.string)
		end
			
	excluded_node_icon: EV_PIXMAP is
			-- Excluded node icon
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_toc_exclude.ico")
			Result.set_with_named_file (l_file.string)
		end		
			
	cluster_icon: STRING is
			-- Cluster icon
		local
			l_file: FILE_NAME
		once
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_code_cluster.ico")
			Result := l_file.string
		end	
		
	class_icon: STRING is
			-- Class icon
		local
			l_file: FILE_NAME
		once
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_code_class.ico")
			Result := l_file.string
		end	
		
	feature_icon: STRING is
			-- Feature icon
		local
			l_file: FILE_NAME
		once
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_code_feature.ico")
			Result := l_file.string
		end	
			
feature -- XML tags			
			
	id_string: STRING is "id"
			
	title_string: STRING is "title"
	
	url_string: STRING is "url"
	
	icon_string: STRING is "icon"
	
	topic_string: STRING is "topic"
	
	heading_string: STRING is "heading"
	
	root_string: STRING is "table_of_contents"

feature -- Id generation

	unique_id: INTEGER
			-- Unique node id

	next_id: INTEGER is
			-- Next unique id
		do
			Result := unique_id + 1
			unique_id := unique_id + 1
		end
		
feature {NONE} -- Implementation		
		
	Constants: APPLICATION_CONSTANTS is
			-- Constants
		once
			create Result
		end		

end -- class TABLE_OF_CONTENTS_CONSTANTS
