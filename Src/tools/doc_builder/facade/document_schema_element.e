indexing
	description: "Schema element."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SCHEMA_ELEMENT
	
feature -- Facade

	name: STRING is "No name"
			-- Element name
	
	annotation: STRING
			-- Annotation string of Current, if any

feature -- Elements

	children: ARRAYED_LIST [like Current]
			-- Children elements
	
	type_children: ARRAYED_LIST [like Current] is
			-- Children elements of Current as type
		do
		end	

end -- class DOCUMENT_SCHEMA_ELEMENT
