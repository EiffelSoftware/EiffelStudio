indexing
	description: "Representation of an undefine clause"
	external_name: "ISE.Reflection.UndefineClause"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	UNDEFINE_CLAUSE
	
inherit
 	INHERITANCE_CLAUSE
 
 create
 	make

feature -- Access

	eiffel_keyword: STRING is
		indexing
			description: "Eiffel keyword for inheritance clause"
			external_name: "EiffelKeyword"
		do
			Result := Undefine_keyword
		end

	Undefine_keyword: STRING is "undefine"
		indexing
			description: "Undefine keyword"
			external_name: "UndefineKeyword"
		end
		
feature -- Basic Operations

	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
			external_name: "StringRepresentation"
		do
			Result := source_name
		end
	
 end -- class UNDEFINE_CLAUSE
 
