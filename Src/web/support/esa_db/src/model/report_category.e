note
	description: "Summary description for {REPORT_CATEGORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_CATEGORY

inherit
	REPORT_FIELD

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_synop: READABLE_STRING_32; a_active: BOOLEAN)
		do
			id := a_id
			synopsis := a_synop
			is_active := a_active
		end

feature -- Access

	id: INTEGER

	synopsis: READABLE_STRING_32

	is_active: BOOLEAN

feature -- Output

	string: STRING_8
		do
			Result := synopsis.string
			if is_active then
				Result.append (" [Active]")
			else
				Result.append (" [In-Active]")
			end
		end

end
