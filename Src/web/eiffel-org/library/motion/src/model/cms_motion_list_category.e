note
	description: "[
				Objects that represent a report category.
				The name of the product, component or concept where the problem lies.
				In order to get the best possible support, please select the category carefully.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST_CATEGORY

inherit

	CMS_SELECTABLE

create
	make,
	make_empty

feature {NONE} -- Initialization

	make_empty
		do
			id := 0
			set_synopsis ("")
			set_description ("")
			set_is_active (False)
		end

	make (a_id: INTEGER_64; a_synop: READABLE_STRING_32; a_active: BOOLEAN)
			--  Create an object instance with
			-- Set `id' to `a_id'
			-- Set `synopsis' to `a_synop'
			-- Set `is_active' to `a_active'
		do
			id := a_id
			synopsis := a_synop
			set_description ("")
			is_active := a_active
		ensure
			id_set: id = a_id
			synopsis_set: synopsis = a_synop
			is_active_set: is_active = a_active
		end

feature -- Access

	id: INTEGER_64
		-- Unique Id.

	synopsis: READABLE_STRING_32
		-- Short description.

	description: READABLE_STRING_32
		-- Full description	

	is_active: BOOLEAN
		-- Is current active?

feature -- Change Element

	set_id (a_id: INTEGER_64)
			-- <Precursor>
		do
			id := a_id
		end

	set_synopsis (a_synopsis: like synopsis)
			-- <Precursor>
		do
			synopsis := a_synopsis
		end

	set_description  (a_description: like description)
			-- Set description with a_description.
		do
			description := a_description
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
			Result := synopsis.string
			if is_active then
				Result.append (" [Active]")
			else
				Result.append (" [In-Active]")
			end
		end

end
