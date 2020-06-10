note
	description: "[
				Objects that represent a REPORT_CLASS
				The class of a problem can be one of the following:
				Bug: A general product problem.
				Documentation: A problem with documentation.
				Change Request: A request for a change in behavior, etc.
				Support: A support problem or question.
				Installation: A problem with installing the product.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_CLASS

inherit
	REPORT_FIELD

	REPORT_SELECTABLE

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_synop: READABLE_STRING_32)
			-- Create an object instance
			-- Set `id' to `a_id'
			-- set `synopsis' to `a_synop'.
		do
			id := a_id
			synopsis := a_synop
		ensure
			id_set: id = a_id
			synopsis_set:  synopsis = a_synop
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
			-- String Representation.
		do
			Result := synopsis.string.to_string_8
		end

end
