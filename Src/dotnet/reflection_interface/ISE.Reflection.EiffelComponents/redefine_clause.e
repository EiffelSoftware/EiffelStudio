indexing
	description: "Representation of a redefine clause"
	external_name: "ISE.Reflection.RedefineClause"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	REDEFINE_CLAUSE
	
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
			Result := Redefine_keyword
		end

	Redefine_keyword: STRING is "redefine"
		indexing
			description: "Redefine keyword"
			external_name: "RedefineKeyword"
		end
		
feature -- Basic Operations

	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
			external_name: "StringRepresentation"
		do
			Result := source_name
		end
	
 end -- class REDEFINE_CLAUSE
 
