note
	description: "Object that represent a user"
	date: "$Date$"
	revision: "$Revision$"

class
	USER

inherit

	REPORT_SELECTABLE

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_32)
			-- Create an object instance
			-- set `name' to `a_name'
			-- set `synopsis' to `a_name'
		do
			name := a_name
			set_synopsis (a_name)
		ensure
			name_set: name = a_name
			synopsis_set: synopsis = a_name
		end

feature -- Access

	name: READABLE_STRING_32
		-- User name.

	id: INTEGER assign set_id
		-- Unique id

	role_id: INTEGER assign set_role_id
		-- Associated role id.

	is_active: BOOLEAN assign set_is_active
		-- Is the user active?

	creation_date: detachable READABLE_STRING_8 assign set_creation_date
		-- creation date.

	synopsis: READABLE_STRING_32
		-- Short description.

feature -- Element change

	set_id (v: like id)
			-- <Precursor>
		do
			id := v
		end

	set_role_id (v: like role_id)
			-- Set  `role_id' to `v'.
		do
			role_id := v
		ensure
			role_id_set: role_id = v
		end

	set_is_active (v: like is_active)
			-- Set `is_active' to `v'.
		do
			is_active := v
		ensure
			is_active_set: is_active = v
		end

	set_creation_date (v: like creation_date)
			-- Ser `creation_date' to `v'.
		do
			creation_date := v
		ensure
			creation_date_set: creation_date = v
		end

	set_synopsis (a_synopsis: like synopsis)
			-- <Precursor>		
		do
			synopsis := a_synopsis
		end


feature -- Output

	string_8: STRING_8
			-- String representation.
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
