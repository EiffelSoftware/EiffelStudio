indexing
	description: "Empty file template with no content"
	date: "$Date$"
	revision: "$Revision$"

class
	EMPTY_TEMPLATE

inherit
	TEMPLATE
	
feature -- Access

	description: STRING is
			-- Description
		do
			Result := "An empty document."
		end
		
	content: STRING is
			-- Content
		do			
		end	

end -- class EMPTY_TEMPLATE
