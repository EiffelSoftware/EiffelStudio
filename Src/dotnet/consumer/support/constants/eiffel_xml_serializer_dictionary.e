indexing
	description: "String constants used for Eiffel XML serialization"

class
	EIFFEL_XML_SERIALIZER_DICTIONARY

inherit
	EIFFEL_XML_SERIALIZATION_CONSTANTS

feature -- Access

	Open_integer_field: SYSTEM_STRING is
			-- <INTEGER NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (Integer_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_integer_field: SYSTEM_STRING is
			-- "</INTEGER>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (Integer_node) + ">").to_cil
		end

	Open_real_field: SYSTEM_STRING is
			-- <REAL NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (Real_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_real_field: SYSTEM_STRING is
			-- "</REAL>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (Real_node) + ">").to_cil
		end

	Open_double_field: SYSTEM_STRING is
			-- <DOUBLE NAME="
		once
			Result := ("<" +create {STRING}.make_from_Cil (Double_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_double_field: SYSTEM_STRING is
			-- "</DOUBLE>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (Double_node) + ">").to_cil
		end

	Open_character_field: SYSTEM_STRING is
			-- <CHARACTER NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (Character_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_character_field: SYSTEM_STRING is
			-- "</CHARACTER>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (Character_node) + ">").to_cil
		end

	Open_boolean_field: SYSTEM_STRING is
			-- <BOOLEAN NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (Boolean_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_boolean_field: SYSTEM_STRING is
			-- "</BOOLEAN>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (Boolean_node) + ">").to_cil
		end

	Open_pointer_field: SYSTEM_STRING is
			-- <POINTER NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (Pointer_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_pointer_field: SYSTEM_STRING is
			-- "</POINTER>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (Pointer_node) + ">").to_cil
		end

	Open_string_field: SYSTEM_STRING is
			-- <POINTER NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (String_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_string_field: SYSTEM_STRING is
			-- "</POINTER>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (String_node) + ">").to_cil
		end

	Open_array_field: SYSTEM_STRING is
			-- <ARRAY NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (Array_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_array_field: SYSTEM_STRING is
			-- "</ARRAY>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (Array_node) + ">").to_cil
		end

	Open_reference_field: SYSTEM_STRING is
			-- <REFERENCE NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (Reference_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_reference_field: SYSTEM_STRING is
			-- "</REFERENCE>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (Reference_node) + ">").to_cil
		end

	Open_none_field: SYSTEM_STRING is
			-- <NONE NAME="
		once
			Result := ("<" + create {STRING}.make_from_Cil (None_node) + " " + create {STRING}.make_from_Cil (Field_name_xml_attribute) + "=%"").to_cil
		end
			
	Close_none_field: SYSTEM_STRING is
			-- "</NONE>"
		once
			Result := ("</" + create {STRING}.make_from_Cil (None_node) + ">").to_cil
		end

	Quote_space: SYSTEM_STRING is
			-- "%" "
		once
			Result := ("%" ").to_cil
		end

	Equal_quote: SYSTEM_STRING is
			-- "=%""
		once
			Result := ("=%"").to_cil
		end

	End_element: SYSTEM_STRING is
			-- 	"%">%N"
		once
			Result := ("%">").to_cil
		end
	
	New_line: SYSTEM_STRING is
			-- "%N"
		once
			Result := ("%N").to_cil
		end
	
	Empty_string: SYSTEM_STRING is
			-- ""
		once
			Result := ("").to_cil
		end

	Tab: SYSTEM_STRING is
			-- "%T"
		once
			Result := ("%T").to_cil
		end
		
end -- class EIFFEL_XML_SERIALIZER_DICTIONARY
