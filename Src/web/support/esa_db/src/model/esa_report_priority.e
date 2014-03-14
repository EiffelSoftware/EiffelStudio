note
	description: "Object with an unique id that represent a report priority"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_PRIORITY

inherit
	ESA_REPORT_FIELD

	ESA_REPORT_SELECTABLE

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_synop: READABLE_STRING_32)
		do
			id := a_id
			synopsis := a_synop
		end

feature -- Access

	id: INTEGER

	synopsis: READABLE_STRING_32


feature -- Element Change

	set_id (a_id: INTEGER)
			-- Set `id' with `a_id'.
		do
			id := a_id
		end

	set_synopsis (a_synopsis: like synopsis)
			-- Set `synopsis' with `a_synopsis'.
		do
			synopsis := a_synopsis
		end

feature -- Output

	string: READABLE_STRING_8
		do
			Result := synopsis.string
		end

end
