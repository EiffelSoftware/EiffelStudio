indexing
	description: "Constants used in XML text corresponding to Eiffel class"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_XML_SERIALIZATION_CONSTANTS

feature -- Access

	Integer_node: SYSTEM_STRING is
		once
			Result := ("INTEGER").to_cil
		end

	Real_node: SYSTEM_STRING is
		once
			Result := ("REAL").to_cil
		end
	
	Double_node: SYSTEM_STRING is 
		once
			Result := ("DOUBLE").to_cil
		end
	
	Character_node: SYSTEM_STRING is 
		once
			Result := ("CHARACTER").to_cil
		end
	
	Boolean_node: SYSTEM_STRING is 
		once
			Result := ("BOOLEAN").to_cil
		end
	
	Pointer_node: SYSTEM_STRING is 
		once
			Result := ("POINTER").to_cil
		end
	
	String_node: SYSTEM_STRING is 
		once
			Result := ("STRING").to_cil
		end
	
	Array_node: SYSTEM_STRING is 
		once
			Result := ("ARRAY").to_cil
		end
	
	Reference_node: SYSTEM_STRING is 
		once
			Result := ("REFERENCE").to_cil
		end
	
	None_node: SYSTEM_STRING is 
		once
			Result := ("NONE").to_cil
		end
	
	Field_name_xml_attribute: SYSTEM_STRING is 
		once
			Result := ("NAME").to_cil
		end

	Array_lower_bound_xml_attribute: SYSTEM_STRING is 
		once
			Result := ("LOWER").to_cil
		end

	Array_count_xml_attribute: SYSTEM_STRING is 
		once
			Result := ("COUNT").to_cil
		end

	Type_xml_attribute: SYSTEM_STRING is 
		once
			Result := ("TYPE").to_cil
		end

	Root_reference: STRING is "ROOT"

end -- class EIFFEL_XML_SERIALIZATION_CONSTANTS
