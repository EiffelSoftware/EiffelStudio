indexing
	description: "Representation of an undefine clause"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	UNDEFINE_CLAUSE
	
inherit
 	INHERITANCE_CLAUSE
 
feature -- Access

	eiffel_keyword: STRING is
		indexing
			description: "Eiffel keyword for inheritance clause"
		do
			Result := Undefine_keyword
		end

	Undefine_keyword: STRING is "undefine"
		indexing
			description: "Undefine keyword"
		end
		
feature -- Basic Operations

	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
		do
			Result := source_name
		end
	
 end -- class UNDEFINE_CLAUSE
 
