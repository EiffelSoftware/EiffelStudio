note
	description: "Contains information about the button images of the %
		%toolbar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOL_BAR_BITMAP

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		undefine
			copy, is_equal
		redefine
			destroy_item
		end

	IDENTIFIED_ROUTINES

	WEL_IDB_CONSTANTS
		export
			{ANY} valid_tool_bar_bitmap_constant
			{NONE} all
		end

create
	make,
	make_from_bitmap,
	make_by_predefined_id

feature {NONE} -- Initialization

	make (a_bitmap_id: INTEGER)
			-- Initialize a toolbar bitmap with the resource bitmap
			-- identifier `a_bitmap_id'.
		require
			positive_bitmap_id: a_bitmap_id > 0
		do
			internal_bitmap_id := cwel_integer_to_pointer (a_bitmap_id)
			structure_make
			set_bitmap_id (a_bitmap_id)
		ensure
			bitmap_id_set: bitmap_id = a_bitmap_id
		end

	make_by_predefined_id (a_bitmap_id: INTEGER)
			-- Initialize a toolbar bitmap with the system
			-- predefined resource bitmap identifier `a_bitmap_id'.
			-- See class WEL_IDB_CONSTANTS for `a_bitmap_id' values.
		require
			valid_tool_bar_bitmap_constant:
				valid_tool_bar_bitmap_constant (a_bitmap_id)
		do
			internal_bitmap_id := cwel_integer_to_pointer (a_bitmap_id)
			predefined_id := True
			structure_make
			set_predefined_bitmap_id (a_bitmap_id)
		ensure
			bitmap_id_set: bitmap_id = a_bitmap_id
		end

	make_from_bitmap (a_bitmap: WEL_BITMAP)
			-- Create a toolbar bitmap with a common bitmap.
		require
			bitmap_not_void: a_bitmap /= Void
			bitmap_exists: a_bitmap.exists
		do
			internal_bitmap := a_bitmap
			internal_bitmap_object_id := a_bitmap.object_id
			if a_bitmap.reference_tracked then
				a_bitmap.increment_reference
			end
			structure_make
			cwel_tbaddbitmap_set_nid (item, a_bitmap.item)
		ensure
			bitmap_set: bitmap_id_as_pointer = a_bitmap.item
		end

feature -- Access

	bitmap_id: INTEGER
			-- Resource identifier of the bitmap resource that
			-- contains the button images.
		do
			Result := cwel_tbaddbitmap_get_nid (item).to_integer_32
		end

	bitmap_id_as_pointer: POINTER
			-- Resource identifier of the bitmap resource that
			-- contains the button images.
		do
			Result := cwel_tbaddbitmap_get_nid (item)
		end

	instance: WEL_INSTANCE
			-- Instance that contains the bitmap resource
			-- `bitmap_id'
		do
			create Result.make (cwel_tbaddbitmap_get_hinst (item))
		ensure
			result_not_void: Result /= Void
		end

feature {WEL_TOOL_BAR} -- Internal State

	internal_bitmap: ?WEL_BITMAP
			-- Associated bitmap. Void if a predefined bitmap or
			-- a ressource bitmap is associated.

	internal_bitmap_object_id: INTEGER
			-- Object id of `internal_bitmap'

	internal_bitmap_id: POINTER
			-- Associated bitmap. Void if a predefined bitmap or
			-- a ressource bitmap is associated.

feature -- Status Report

	predefined_id: BOOLEAN
			-- Are we using predefined bitmap (Cut, Copy, ...) ?
			-- (This is not compatible with the ImageList)

feature -- Element change

	set_bitmap_id (a_bitmap_id: INTEGER)
			-- Set `bitmap_id' with `a_bitmap_id'.
		require
			positive_bitmap_id: a_bitmap_id > 0
		local
			l_internal_bitmap: like internal_bitmap
		do
				-- Remove any existing bitmap.
			l_internal_bitmap := internal_bitmap
			if l_internal_bitmap /= Void then
				if l_internal_bitmap.reference_tracked then
					l_internal_bitmap.decrement_reference
				end
				internal_bitmap := Void
				internal_bitmap_object_id := 0
			end

				-- Set the new bitmap id.
			cwel_tbaddbitmap_set_hinst (item, main_args.resource_instance.item)
			cwel_tbaddbitmap_set_nid (item, cwel_integer_to_pointer (a_bitmap_id))
		ensure
			bitmap_id_set: bitmap_id = a_bitmap_id
		end

	set_predefined_bitmap_id (a_bitmap_id: INTEGER)
			-- Set `bitmap_id' with the system predefined resource
			-- bitmap identifier `a_bitmap_id'.
			-- See class WEL_IDB_CONSTANTS for `a_bitmap_id' values.
		require
			valid_tool_bar_bitmap_constant: valid_tool_bar_bitmap_constant (a_bitmap_id)
		local
			l_internal_bitmap: like internal_bitmap
		do
				-- Remove any existing bitmap.
			l_internal_bitmap := internal_bitmap
			if l_internal_bitmap /= Void then
				if l_internal_bitmap.reference_tracked then
					l_internal_bitmap.decrement_reference
				end
				internal_bitmap := Void
				internal_bitmap_object_id := 0
			end

				-- Set the new bitmap id.
			cwel_tbaddbitmap_set_hinst (item, Hinst_commctrl)
			cwel_tbaddbitmap_set_nid (item, cwel_integer_to_pointer (a_bitmap_id))
		ensure
			bitmap_id_set: bitmap_id = a_bitmap_id
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tbaddbitmap
		end

feature {NONE} -- Implementation

	main_args: WEL_MAIN_ARGUMENTS
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Removal

	destroy_item
			-- Free `item'
		do
			Precursor {WEL_STRUCTURE}
			if {l_bitmap: WEL_BITMAP} eif_id_object (internal_bitmap_object_id) and then l_bitmap.reference_tracked then
				l_bitmap.decrement_reference
			end
		end

feature {NONE} -- Externals

	c_size_of_tbaddbitmap: INTEGER
		external
			"C [macro <tbaddbmp.h>]"
		alias
			"sizeof (TBADDBITMAP)"
		end

	cwel_tbaddbitmap_set_hinst (ptr: POINTER; value: POINTER)
		external
			"C [macro <tbaddbmp.h>] (TBADDBITMAP *, HINSTANCE)"
		end

	cwel_tbaddbitmap_set_nid (ptr: POINTER; value: POINTER)
		external
			"C [macro <tbaddbmp.h>] (TBADDBITMAP *, UINT_PTR)"
		end

	cwel_tbaddbitmap_get_hinst (ptr: POINTER): POINTER
		external
			"C [macro <tbaddbmp.h>] (TBADDBITMAP *): EIF_POINTER"
		end

	cwel_tbaddbitmap_get_nid (ptr: POINTER): POINTER
		external
			"C [macro <tbaddbmp.h>] (TBADDBITMAP *): EIF_POINTER"
		end

	Hinst_commctrl: POINTER
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"HINST_COMMCTRL"
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

end
