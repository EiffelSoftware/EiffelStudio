note
	description: "Summary description for {USER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_USER

inherit

	ESA_REPORT_SELECTABLE

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_32)
		do
			name := a_name
			set_synopsis (a_name)
		end

feature -- Access

	name: READABLE_STRING_32

	id: INTEGER assign set_id

	role_id: INTEGER assign set_role_id

	is_active: BOOLEAN assign set_is_active

	creation_date: detachable READABLE_STRING_8 assign set_creation_date

	synopsis: READABLE_STRING_32


feature -- Element change

	set_id (v: like id)
		do
			id := v
		end

	set_role_id (v: like role_id)
		do
			role_id := v
		end

	set_is_active (v: like is_active)
		do
			is_active := v
		end

	set_creation_date (v: like creation_date)
		do
			creation_date := v
		end

	set_synopsis (a_synopsis: like synopsis)
			-- Set `synopsis' with `a_synopsis'		
		do
			synopsis := a_synopsis
		end


feature -- Output

	string_8: STRING_8
		do
			create Result.make_from_string (name)
			Result.append (" (" + id.out + ")")
			if role_id > 0 then
				Result.append (" Role:" + role_id.out)
			end
			if is_active then
				Result.append (" Active")
			else
				Result.append (" InActive")
			end
		end

end
