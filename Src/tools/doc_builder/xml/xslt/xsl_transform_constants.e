indexing
	description: "Constants for XSL transformation."
	date: "$Date$"
	revision: "$Revision$"

class
	XSL_TRANSFORM_CONSTANTS

feature -- Access

	temp_xsl_in_filename: STRING is "temp_transform.xml"
			-- Temporary name of XML file to transform
	
	temp_xsl_out_filename: STRING is "temp_transform.html"	
			-- Temporary name of HTML file from most recent transform

	add_custom_text: BOOLEAN is True
			-- Should any custom text be added XML BEFORE trasformation?

end -- class XSL_TRANSFORM_CONSTANTS
