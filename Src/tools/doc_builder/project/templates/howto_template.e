indexing
	description: "Template for How To's documentation."
	date: "$Date$"
	revision: "$Revision$"

class
	HOWTO_TEMPLATE

inherit
	TEMPLATE
	
feature -- Access

	description: STRING is
			-- Description
		do
			Result := "A file containing short, 'how-to' information for quick reference."
		end		

	content: STRING is
			-- Content
		do			
		end		

end -- class HOWTO_TEMPLATE
