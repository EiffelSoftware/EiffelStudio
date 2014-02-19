note
	description: "Summary description for {REPORT_PRIORITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_PRIORITY

inherit
	REPORT_FIELD

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

feature -- Output

	string: READABLE_STRING_8
		do
			Result := synopsis.string
		end

end
