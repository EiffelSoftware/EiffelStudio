note
	description: "Summary description for {PE_SIGNATURE_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_SIGNATURE_GENERATOR

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initilization

	default_create
		do
			create work_area.make_filled (0, 400 * 1024)
			create basic_types.make_empty (0)
		end

feature -- Access

	work_area: SPECIAL [INTEGER]
			-- 400 * 1024

	basic_types: SPECIAL [INTEGER]

	object_base: INTEGER assign set_object_base

feature -- Element Change

	set_object_base (a_base: INTEGER)
			-- Set `object_base` with `a_base`
		do
			object_base := a_base
		ensure
			object_base_set: object_base = a_base
		end

end
