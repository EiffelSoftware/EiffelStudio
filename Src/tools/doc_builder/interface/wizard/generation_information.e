indexing
	description: "Object to hold information for generation choices."
	date: "$Date$"
	revision: "$Revision$"

class 
	GENERATION_INFORMATION

feature -- Access

	generated_file_location: DIRECTORY_NAME

	Replicate_source_contents: BOOLEAN is True

	is_html_convert: BOOLEAN

	is_help_convert: BOOLEAN

	is_html_to_help_convert: BOOLEAN
	
	is_generating: BOOLEAN
			-- Is project currently being generated?
	
	filter_toc_hash: HASH_TABLE [STRING, STRING] is
			-- Hash of output filter by table of contents description
		once
			create Result.make (2)
			Result.compare_objects
		end
	
feature -- Status Setting

	set_generating (a_flag: BOOLEAN) is
			-- Set if is currently generating
		do
			is_generating := a_flag	
		end		

	set_conversion_type (a_type: INTEGER) is
		do
			inspect a_type
			when to_html then 
				is_html_convert := True;
				is_help_convert := False;
				is_html_to_help_convert := False
			when to_help then 
				is_html_convert := False;
				is_help_convert := True;
				is_html_to_help_convert := False
			when to_html_to_help then 
				is_html_convert := True;
				is_help_convert := True;
				is_html_to_help_convert := True
			end
		end

	set_generated_file_location (a_location: STRING) is
		do
			create generated_file_location.make_from_string (a_location)
		end
	
feature {GENERATION_DIALOG} 

	To_html: INTEGER is unique
			-- Was declared in GENERATION_INFORMATION as synonym of `to_help' and `to_html_to_help'.

	To_help: INTEGER is unique
			-- Was declared in GENERATION_INFORMATION as synonym of `to_html' and `to_html_to_help'.

	To_html_to_help: INTEGER is unique
			-- Was declared in GENERATION_INFORMATION as synonym of `to_html' and `to_help'.
	
invariant

	html_conversion_exclusive: is_html_convert implies (not is_help_convert and not is_html_to_help_convert)
	help_conversion_exclusive: is_help_convert implies (not is_html_convert and not is_html_to_help_convert)
	help_to_html_conversion_exclusive: is_html_to_help_convert implies (is_help_convert and is_html_convert)

end -- class GENERATION_INFORMATION
