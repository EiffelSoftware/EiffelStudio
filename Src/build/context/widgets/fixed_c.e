indexing
	description: "Context that represents a fixed container.%
				% It allows free placement on any of its children."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIXED_C

inherit
	INVISIBLE_CONTAINER_C
		redefine
			gui_object,
			is_fixed, intermediate_name
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.container_page.fixed_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature -- Default event

-- 	default_event: MOUSE_ENTER_EV is 
-- 		do
-- 			Result:= mouse_enter_ev
-- 		end

feature -- Status report

	is_fixed: BOOLEAN is
		do
			Result := True
		end
feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Fixed")
		end

-- 	add_to_option_list (opt_list: ARRAY [INTEGER]) is
-- 		do
-- 			opt_list.put (Context_const.geometry_form_nbr,
-- 							Context_const.Geometry_format_nbr)
-- 		end

feature -- Code generation

	eiffel_type: STRING is "EV_FIXED"

	full_type_name: STRING is "Fixed"

	intermediate_name: STRING is
			-- full name of the context i.e. with root, group, ...
		local
			bup: FIXED_C
		do
			bup ?= parent
			if bup /= Void then
				Result := parent.intermediate_name
			else
				Result := parent.full_name
			end
		end

feature -- Implementation

	gui_object: EV_FIXED

feature -- Storage 

-- 	stored_node: S_BULLETIN is
-- 			--XX replace by S_FIXED
-- 		do
-- 			create Result.make (Current)
-- 		end

end -- class FIXED_C

