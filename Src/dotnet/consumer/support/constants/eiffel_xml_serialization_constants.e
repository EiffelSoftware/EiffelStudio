indexing
	description: "Constants used in XML text corresponding to Eiffel class"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_XML_SERIALIZATION_CONSTANTS

feature -- Access

	Integer_node: SYSTEM_STRING is "I"

	Real_node: SYSTEM_STRING is "Re"
	
	Double_node: SYSTEM_STRING is "D"
	
	Character_node: SYSTEM_STRING is "C"
	
	Boolean_node: SYSTEM_STRING is "B"
	
	Pointer_node: SYSTEM_STRING is "P"
	
	String_node: SYSTEM_STRING is "S"
	
	Array_node: SYSTEM_STRING is "A"
	
	Reference_node: SYSTEM_STRING is "R"
	
	None_node: SYSTEM_STRING is "NONE"
	
	Field_name_xml_attribute: SYSTEM_STRING is "N"

	Array_lower_bound_xml_attribute: SYSTEM_STRING is "L"

	Array_count_xml_attribute: SYSTEM_STRING is "C"

	Type_xml_attribute: SYSTEM_STRING is "T"

	Root_reference: STRING is "ROOT"

end -- class EIFFEL_XML_SERIALIZATION_CONSTANTS
