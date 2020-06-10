note
	description: "[
				Objects that represent a report category. 
				The name of the product, component or concept where the problem lies. 
				In order to get the best possible support, please select the category carefully.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_CATEGORY

inherit
	REPORT_FIELD

	REPORT_SELECTABLE

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_synop: READABLE_STRING_32; a_active: BOOLEAN)
			--  Create an object instance with
			-- Set `id' to `a_id'
			-- Set `synopsis' to `a_synop'
			-- Set `is_active' to `a_active'
		do
			id := a_id
			synopsis := a_synop
			is_active := a_active
		ensure
			id_set: id = a_id
			synopsis_set: synopsis = a_synop
			is_active_set: is_active = a_active
		end

feature -- Access

	id: INTEGER
		-- Unique Id.

	synopsis: READABLE_STRING_32
		-- Short description.

	is_active: BOOLEAN
		-- Is current active?

feature -- Change Element

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

	set_is_active (a_val: BOOLEAN)
			-- Set `is_active' with `a_val'.
		do
			is_active := a_val
		ensure
			is_active_set: is_active = a_val
		end

feature -- Output

	string: STRING_8
			-- String representation.
		do
			Result := synopsis.string.to_string_8
			if is_active then
				Result.append (" [Active]")
			else
				Result.append (" [In-Active]")
			end
		end

end
