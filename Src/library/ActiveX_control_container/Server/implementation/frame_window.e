indexing
	description: "OLE Control Container Frame."
	date: "$Date$"
	revision: "$Revision$"

class
	FRAME_WINDOW

inherit
	IOLE_IN_PLACE_FRAME_IMPL

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
			"C++ [new ecom_control_library::frame_window %"ecom_control_library_frame_window_s.h%"](EIF_OBJECT)"
		end

end -- FRAME_WINDOW

