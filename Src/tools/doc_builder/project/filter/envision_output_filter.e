indexing
	description: "Outputs Eiffel ENViSioN! only content information"
	date: "$Date$"
	revision: "$Revision$"

class
	ENVISION_OUTPUT_FILTER

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
			Result := envision_desc
		end	

end -- class ENVISION_OUTPUT_FILTER
