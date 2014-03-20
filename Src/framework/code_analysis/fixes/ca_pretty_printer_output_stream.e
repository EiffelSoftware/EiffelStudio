note
	description: "EXACT COPY from {PRETTY_PRINTER_OUTPUT_STREAM} in order to make available from library. Output stream to produce prettified text."

class
	CA_PRETTY_PRINTER_OUTPUT_STREAM

inherit
	SHARED_LOCALE

create
	make_string

feature {NONE} -- Creation

	make_string (s: STRING_32)
			-- Associate output with a string `s'.
		do
			output := agent s.append_string_general (?)
			is_open_query := agent: BOOLEAN do Result := True end
		end

feature -- Status report

	is_open: BOOLEAN
			-- Is stream open for writing?
		do
			Result := is_open_query.item (Void)
		end

feature -- Output

	put_string (s: READABLE_STRING_GENERAL)
			-- Write string `s' to output.
		require
			is_open: is_open
		do
			output.call ([s])
		end

feature {NONE} -- Access

	output: PROCEDURE [ANY, TUPLE [READABLE_STRING_GENERAL]]
			-- Procedure to write.

	is_open_query: PREDICATE [ANY, TUPLE]
			-- Function to check stream status.

end
