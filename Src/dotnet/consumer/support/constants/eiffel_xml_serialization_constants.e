indexing
	description: "Constants used in XML text corresponding to Eiffel class"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_XML_SERIALIZATION_CONSTANTS

feature -- Access

	Integer_node: SYSTEM_STRING is
		once
			Result := ("I").to_cil
		end

	Real_node: SYSTEM_STRING is
		once
			Result := ("Re").to_cil
		end
	
	Double_node: SYSTEM_STRING is 
		once
			Result := ("D").to_cil
		end
	
	Character_node: SYSTEM_STRING is 
		once
			Result := ("C").to_cil
		end
	
	Boolean_node: SYSTEM_STRING is 
		once
			Result := ("B").to_cil
		end
	
	Pointer_node: SYSTEM_STRING is 
		once
			Result := ("P").to_cil
		end
	
	String_node: SYSTEM_STRING is 
		once
			Result := ("S").to_cil
		end
	
	Array_node: SYSTEM_STRING is 
		once
			Result := ("A").to_cil
		end
	
	Reference_node: SYSTEM_STRING is 
		once
			Result := ("R").to_cil
		end
	
	None_node: SYSTEM_STRING is 
		once
			Result := ("NONE").to_cil
		end
	
	Field_name_xml_attribute: SYSTEM_STRING is 
		once
			Result := ("N").to_cil
		end

	Array_lower_bound_xml_attribute: SYSTEM_STRING is 
		once
			Result := ("L").to_cil
		end

	Array_count_xml_attribute: SYSTEM_STRING is 
		once
			Result := ("C").to_cil
		end

	Type_xml_attribute: SYSTEM_STRING is 
		once
			Result := ("T").to_cil
		end

	Root_reference: STRING is "ROOT"

end -- class EIFFEL_XML_SERIALIZATION_CONSTANTS
