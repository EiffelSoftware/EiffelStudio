indexing
	description: "Helper routines"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_XML_SERIALIZATION_ROUTINES

inherit
	EIFFEL_XML_SERIALIZER_DICTIONARY

	SHARED_XML_OUTPUT
		export
			{NONE} all
		end

feature -- Basic Operations

	write_tabs (f: TEXT_WRITER; tab_count: INTEGER) is
			-- Write `tab_count' tabulations in `f'.
		require
			non_void_file: f /= Void
		local
			i: INTEGER
		do
			if Has_indented_output.item then
				from
					i := 1
				until
					i > tab_count
				loop
					f.write_string (Tab)
					i := i + 1
				end
			end
		end

end -- class SHARED_ROUTINES
