note
	description: "Summary description for {REPORT_STATUS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_STATUS

inherit
	REPORT_FIELD

create
	make

feature {NONE} -- Initialization

	make (a_id:INTEGER; a_synop: READABLE_STRING_32)
		do
			id := a_id
			synopsis := a_synop
		end

feature -- Access

	id: INTEGER

	synopsis: READABLE_STRING_32

	selected_id: INTEGER

	is_selected : BOOLEAN
		do
			Result := id = selected_id
		end


feature --Change Element

	set_id (a_id: INTEGER)
		do
			id := a_id
		end

	set_selected_id (a_val: INTEGER)
			-- Set `selected_id' with `a_val'
		do
			selected_id := a_val
		end

	set_synopsis (a_synopsis: like synopsis)
		do
			synopsis := a_synopsis
		end

feature -- Output

	string: READABLE_STRING_8
		do
			Result := id.out + " | " + synopsis.string
		end

end
