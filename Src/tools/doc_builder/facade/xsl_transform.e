indexing
	description: "XSL transformation."
	date: "$Date$"
	revision: "$Revision$"

class
	XSL_TRANSFORM
	
inherit	
	SHARED_OBJECTS
		
	EXECUTION_ENVIRONMENT

	UTILITY_FUNCTIONS
	
	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		end

create
	make_from_xsl_file

feature	-- Facade

	make_from_xsl_file (a_filename: STRING) is
			-- Make from existing `xsl' file
		do
		end

	name: STRING is "XSL is not supported in non .NET mode"
			-- Name

	is_valid_xml: BOOLEAN is True
			-- Is Current valid xml?

	is_valid_xsl: BOOLEAN is True
			-- Is Current a valid Xslt file

	load_error_message: STRING is "XSL is not supported in non .NET mode"
			-- Load error message		

end -- class XSL_TRANSFORM
