indexing
	description: "XML Schema Validator."
	date: "$Date$"
	revision: "$Revision$"

class
	SCHEMA_VALIDATOR
	
inherit
	SHARED_OBJECTS

create
	default_create

feature -- Access

	is_valid: BOOLEAN is True
			-- Is validation successful?

	error_report: ERROR_REPORT
    		-- Error
		
	validate_against_text (text, schema_filename: STRING) is
			-- Validate 'text' against schema definition found in file 
			-- with 'schema_filename'.
		do  
		end	

end -- class SCHEMA_VALIDATOR
