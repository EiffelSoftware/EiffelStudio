indexing
	description: "Outputs EiffelStudio only content information"
	date: "$Date$"
	revision: "$Revision$"

class
	STUDIO_OUTPUT_FILTER
	
inherit
	OUTPUT_FILTER
		redefine
			description
		end

create
	make

feature -- Access

	description: STRING is
			-- Textual description of filter
		do
			Result := studio_desc
		end	

end -- class STUDIO_OUTPUT_FILTER
