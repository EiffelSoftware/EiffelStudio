indexing
	description: "Constants and routines for code XML readers"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_XML_READER_CONSTANTS
	
feature -- File related constants	
	
	link_prefix: STRING is "libraries"
			-- Library root directory
			
	reference_dir: STRING is "reference"
			-- Reference directory name	
	
feature {CODE_XML_READER} -- Tag Constants

	tags: ARRAYED_LIST [STRING] is
			-- Tags
		once
			create Result.make (15)
			Result.compare_objects
			Result.extend ("keyword")
			Result.extend ("cluster")
			Result.extend ("class")
			Result.extend ("feature")
			Result.extend ("reserved")
			Result.extend ("symbol")
			Result.extend ("quoted")
			Result.extend ("string")
			Result.extend ("char")
			Result.extend ("number")
			Result.extend ("local")
			Result.extend ("tag")
			Result.extend ("itag")
			Result.extend ("generic")
			Result.extend ("dot")
			Result.extend ("comment")
		end
		
	location_tag: STRING is "location"
	
	include_tag: STRING is "include"
	
	anchor_tag: STRING is "anchor"
	
	feature_tag: STRING is "feature"
	
	html_anchor_tag: STRING is "a"
	
	html_space: STRING is "&nbsp;"

end -- class CODE_XML_READER_CONSTANTS
