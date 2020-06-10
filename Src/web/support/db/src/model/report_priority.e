note
	description: "[
			Object with an unique id that represent a report priority
		How soon the solution is required. Accepted values include:
			High: A solution is needed as soon as possible.
			Medium: The problem should be solved in the next release.
			Low: The problem should be solved in a future release.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_PRIORITY

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
			synopsis := a_synopsis.as_lower
		end

feature -- Output

	string: READABLE_STRING_8
			-- String representation.
		do
			Result := synopsis.string.to_string_8
		end

end
