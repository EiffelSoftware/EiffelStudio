indexing
	description: "Empty project template"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_TEMPLATE

inherit 
	TEMPLATE

feature -- Access

	description: STRING is
			-- Description
		do
			Result := "An new project file."
		end
		
	content: STRING is
			-- Content
		do
		end
		
end -- class PROJECT_TEMPLATE
