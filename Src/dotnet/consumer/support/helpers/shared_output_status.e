indexing
	description: "Hold how XML code generation is performed"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_XML_OUTPUT

feature -- Access

	has_indented_output: BOOLEAN_REF is
			-- Will current XML output contain tabs?
			--| Default: no
		once
			Result := False
		end
		
end -- class SHARED_XML_OUTPUT
