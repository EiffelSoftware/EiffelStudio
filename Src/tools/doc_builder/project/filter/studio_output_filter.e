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
			Result := "EiffelStudio"
		end	

end -- class STUDIO_OUTPUT_FILTER
