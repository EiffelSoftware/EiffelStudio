indexing
	description: "Object to hold information for wizard choices."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

feature -- Information

	summary_list: ARRAYED_LIST [SUMMARY_BOX] is
			-- Summary of wizard options
		once
			create Result.make (5)
		end
		
feature -- Access		
		
	html_generated_file_location: DIRECTORY_NAME
			-- Directory to which HTML files will be generated


	replicate_source_contents: BOOLEAN is True
			-- Should HTML conversion copy the non-XML files?

feature -- Wizard type

	is_html_convert: BOOLEAN
			-- Convert to HTML?
			
	is_help_convert: BOOLEAN
			-- Convert to help?
			
	is_html_to_help_convert: BOOLEAN
			-- Convert to HTML and then Help?

feature -- Status Setting

	set_conversion_type (a_type: INTEGER) is
			-- Set chosen generation type
		do
			inspect
				a_type
			when to_html then
				is_html_convert := True
				is_help_convert := False
				is_html_to_help_convert := False
			when to_help then
				is_html_convert := False
				is_help_convert := True
				is_html_to_help_convert := False
			when to_html_to_help then
				is_html_convert := False
				is_help_convert := False
				is_html_to_help_convert := True	
			end
		end

	set_html_generated_file_location (a_location: STRING) is
			-- Set directory in which HTML files will be generated
		do
			create html_generated_file_location.make_from_string (a_location)
		end

feature {NONE} -- Implementation

	to_html,
	to_help,
	to_html_to_help: INTEGER is unique
			-- Conversion type chosen identifier

invariant
	html_conversion_exclusive: is_html_convert implies (not is_help_convert and not is_html_to_help_convert)
	help_conversion_exclusive: is_help_convert implies (not is_html_convert and not is_html_to_help_convert)
	help_to_html_conversion_exclusive: is_html_to_help_convert implies (not is_help_convert and not is_html_convert)

end -- class WIZARD_INFORMATION
