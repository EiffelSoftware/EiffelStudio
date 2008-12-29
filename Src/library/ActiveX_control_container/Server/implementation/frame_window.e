note
	description: "OLE Control Container Frame."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FRAME_WINDOW

inherit
	IOLE_IN_PLACE_FRAME_IMPL

	ECOM_STUB

create
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make
			-- Creation. Implement if needed.
		do
			make_top (wel_class_name)
		end

	make_from_pointer (cpp_obj: POINTER)
			-- Creation.
		do
			set_item (cpp_obj)
			make
		end

feature -- Basic Operations

	create_item
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: like Current): POINTER
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::frame_window %"ecom_control_library_frame_window_s.h%"](EIF_OBJECT)"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- FRAME_WINDOW

