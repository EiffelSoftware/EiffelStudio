indexing
	description: "GB_OBJECT representing an EV_COMBO_BOX"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMBO_BOX_OBJECT

inherit
	GB_PRIMITIVE_OBJECT
		redefine
			object, display_object, accepts_child, is_full
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_COMBO_BOX
		-- The vision2 object that `Current' represents.
	
	display_object: EV_COMBO_BOX
		-- The representation of `object' used in `build_window'.
	
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := False
		end
	
feature {GB_TYPE_SELECTOR_ITEM} -- Implementation

	accepts_child (a_type: STRING): BOOLEAN is
			-- Does current accept new objects of
			-- type `a_type'.
		local
			current_type: INTEGER
		do
			current_type := dynamic_type_from_string (a_type)
			if type_conforms_to (current_type, dynamic_type_from_string (Ev_list_item_string)) then
				Result := True
			end
		end

end -- class GB_LIST_OBJECT