note
	description: "[
			Objects that represent a REPORT SERVERY
			The severity of the problem. Accepted values include:

			Critical: The product, component or concept is completely non operational. No workaround is known.
			Serious: The product, component or concept is not working properly. Problems that would otherwise be considered critical are rated serious when a workaround is known.
			Non-critical: The product, component or concept is working in general, but lacks features, has irritating behavior, does something wrong, or doesn't match its documentation.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_SEVERITY

inherit

	REPORT_FIELD

	REPORT_SELECTABLE

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_synop: READABLE_STRING_32)
			-- Create an object instance
			-- Set `id' to `a_id'
			-- Set `synopsis' to `a_synop'.
		do
			id := a_id
			synopsis := a_synop
		ensure
			id_set: id = a_id
			synopsis_set: synopsis = a_synop
		end

feature -- Access

	id: INTEGER
		-- Unique id.

	synopsis: READABLE_STRING_32
		-- Short description.

feature -- Element Change

	set_id (a_id: INTEGER)
			-- <Precursor>
		do
			id := a_id
		end

	set_synopsis (a_synopsis: like synopsis)
			-- <Precursor>
		do
			synopsis := a_synopsis
		end

feature -- Output

	string: READABLE_STRING_8
			-- String representation.
		do
			Result := synopsis.string.to_string_8
		end

end
