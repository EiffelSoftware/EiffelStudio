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

	is_valid: BOOLEAN
			-- Is validation successful?

	error_report: ERROR_REPORT
    		-- Error

feature -- Schema Validation

	validate_by_filename (filename: STRING) is
			-- Validate current schema with 'filename' .  Check to see
			-- if schema is valid according to W3C standard.  Result
			-- put to `is_valid' and error to `error_report'.
		require
			file_not_void: filename /= Void
			is_file: (create {PLAIN_TEXT_FILE}.make (filename)).exists
		local
			reader: XML_XML_TEXT_READER
			validation_reader: XML_XML_VALIDATING_READER
			event_handler: XML_VALIDATION_EVENT_HANDLER
			exception: XML_XML_SCHEMA_EXCEPTION
			retried: BOOLEAN
		do
			create reader.make_from_url (filename.to_cil)
			create event_handler.make  (Current, $validation_callback)
			create validation_reader.make_from_reader (reader)
			validation_reader.add_validation_event_handler (event_handler)
			validation_reader.set_validation_type (feature {XML_VALIDATION_TYPE}.schema)
			from
				is_valid := True
				error_report := Void
			until
				not validation_reader.read 
			loop
			end
		end
		
feature -- Schema and file validation		
		
	validate_against_file (a_filename: STRING) is
			-- Validate 'a_filename' against schema definition.  Assume xml
			-- file with 'a_filename' has declaration of schema within as
			-- a 'SchemaName' attribute.
		local
			vr: XML_XML_VALIDATING_READER
			reader: XML_XML_TEXT_READER
			schemas: XML_XML_SCHEMA_COLLECTION
			vr_handler: XML_VALIDATION_EVENT_HANDLER
		do  
			create reader.make_from_url (a_filename.to_cil)
	        create vr.make_from_reader (reader)
	        vr.set_validation_type (feature {XML_VALIDATION_TYPE}.schema)
	        create vr_handler.make (Current, $validation_callback)
	        vr.add_validation_event_handler (vr_handler)
            from
            	is_valid := True
            	error_report := Void
            until
            	not vr.read
            loop            		
            end
		end	
		
	validate_against_text (text, schema_filename: STRING) is
			-- Validate 'text' against schema definition found in file 
			-- with 'schema_filename'.
		local
			vr: XML_XML_VALIDATING_READER
			xml_reader, schema_reader: XML_XML_TEXT_READER
			schemas: XML_XML_SCHEMA_COLLECTION
			vr_handler: XML_VALIDATION_EVENT_HANDLER
			stream: STRING_READER
			l_schema: XML_XML_SCHEMA
			exception: XML_XML_SCHEMA_EXCEPTION
			retried: BOOLEAN
			l_actions: ERROR_ACTIONS
		do  
			if not retried then
				create schemas.make
				create stream.make (text.to_cil)
				create xml_reader.make_from_input (stream)
				create schema_reader.make_from_url (schema_filename.to_cil)
		        create vr.make_from_reader (xml_reader)
		        create vr_handler.make (Current, $validation_callback)
		        vr.add_validation_event_handler (vr_handler)
		        l_schema := schemas.add_string_xml_reader (Void, schema_reader)
		        vr.schemas.add (schemas)
		        vr.set_validation_type (feature {XML_VALIDATION_TYPE}.schema)
	            from
	            	is_valid := True
	            	error_report := Void
	            until
	            	not vr.read
	            loop            		
	            end
           	else
           		exception ?= feature {EXCEPTION_MANAGER}.last_exception
           		if exception /= Void then
           			create error_report.make ("Invalid Schema Definition", exception.message,
						exception.line_number, exception.line_position)
					create l_actions
					error_report.set_error_action (agent l_actions.highlight_error (?))
					error_report.show
           		end
			end	
		rescue
			retried := True
			retry
		end	
		
feature {NONE} -- Implementation		
		
	validation_callback (object: SYSTEM_OBJECT ; args: XML_VALIDATION_EVENT_ARGS) is
			-- Validation callback.
		local
			l_actions: ERROR_ACTIONS
		do
			if args.severity = feature {XML_XML_SEVERITY_TYPE}.error then
				is_valid := False
			end
			if error_report /= Void then
				error_report.append_error (args.message, args.exception.line_number, args.exception.line_position)
			else
				create error_report.make ("Invalid Schema Definition", args.message,
					args.exception.line_number, args.exception.line_position)
				create l_actions
				error_report.set_error_action (agent l_actions.highlight_error (?))
			end
    	end

end -- class SCHEMA_VALIDATOR
