indexing
	description: "Eiffel XML serialization/deserialization error codes"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_XML_SERIALIZATION_ERRORS

inherit
	ERROR_MANAGER

feature -- Access

	Error_category: INTEGER_8 is 0x01
	
	Generic_error: INTEGER is 0x01000001
			-- Unknown error

	Cycle_error: INTEGER is 0x01000002
			-- Cycle in object graph prevents serialization

	Type_not_in_system_error: INTEGER is 0x01000003
			-- Type not in system, cannot deserialize

	Invalid_xml_file_error: INTEGER is 0x01000004
			-- XML file does not contain Eiffel serialization information

	Missing_reference_type_error: INTEGER is 0x01000005
			-- REFERENCE element has no NAME attribute

	Type_xml_mismatch_error: INTEGER is 0x01000006
			-- Type in XML differs from object's field type

	Missing_array_count_error: INTEGER is 0x01000007
			-- Missing COUNT attribute on array definition
	
	Missing_array_lower_bound_error: INTEGER is 0x01000008
			-- Missing LOWER attribute on array definition

	Missing_array_generic_type_error: INTEGER is 0x01000009
			-- Missing TYPE attribute on array definition

feature {NONE} -- Implementation

	error_message_table: HASH_TABLE [STRING, INTEGER] is
			-- Table of error messages keyed by error codes
		once
			create Result.make (10)
			Result.put ("No error", No_error)
			Result.put ("Unknown error", Generic_error)
			Result.put ("Cycle in object graph", Cycle_error)
			Result.put ("Type not in system", Type_not_in_system_error)
			Result.put ("Not an Eiffel serialization XML file", Invalid_xml_file_error)
			Result.put ("REFERENCE element has no NAME attribute", Missing_reference_type_error)
			Result.put ("Type in XML differs from object's field type", Type_xml_mismatch_error)
			Result.put ("Missing count on array definition", Missing_array_count_error)
			Result.put ("Missing lower bound on array definition", Missing_array_lower_bound_error)
			Result.put ("Missing generic type on array definition", Missing_array_generic_type_error)
		end

end -- class EIFFEL_XML_SERIALIZATION_ERRORS
