indexing
	description: "Document implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_WINDOW

inherit
	IOLE_IN_PLACE_UIWINDOW_IMPL

	ECOM_STUB

creation
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make is
			-- Creation. Implement if needed.
		do
			make_top (wel_class_name)
		end

	make_from_pointer (cpp_obj: POINTER) is
			-- Creation.
		do
			set_item (cpp_obj)
			make
		end

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: like Current): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::ui_window %"ecom_control_library_ui_window_s.h%"](EIF_OBJECT)"
		end

end -- UI_WINDOW

