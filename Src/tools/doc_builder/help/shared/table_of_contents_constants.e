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
			-- Url to be used for folder nodes (i.e "index"), if any
		once
			Result := Shared_constants.Application_constants.index_file_name + ".html"
		end

	use_title_tag: BOOLEAN is True
			-- Use HTML <title> tag to determine node names?  If False then
			-- just take file/folder name directly

end -- class TABLE_OF_CONTENTS_CONSTANTS
