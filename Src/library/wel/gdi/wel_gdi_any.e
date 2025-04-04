﻿note
	description: "This class is an ancestor to all GDI classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDI_ANY

inherit
	WEL_ANY
		undefine
			dispose
		redefine
			make_by_pointer
		end

	WEL_REFERENCE_TRACKABLE

feature {NONE} -- Creation

	make_by_pointer (a_pointer: POINTER)
			-- Set `item' with `a_pointer'.
			-- Since `item' is shared, it does not need
			-- to be freed.
			-- Caution: `a_pointer' must be a pointer
			-- coming from Windows.
		do
			Precursor {WEL_ANY} (a_pointer)
			gdi_make
		end

	gdi_make
			-- Initialize the GDI part of `Current'.
			--
			-- `gdi_make' should be called by all creation procedure.
		do
			debug ("WEL_GDI_COUNT")
				increase_gdi_objects_count
			end
		end

feature -- Access

	gdi_objects_count: INTEGER
			-- Number of GDI object currently allocated by the
			-- program.
			--
			-- Note: debug option "WEL_GDI_COUNT" should be enabled, otherwise
			-- this function will return zero.
		do
			Result := gdi_objects_count_cell.item
		end

feature {NONE} -- Removal

	destroy_item
			-- Ensure the current gdi object is deleted when
			-- garbage collected.
		do
			delete_gdi_object
		end

	delete_gdi_object
			-- Delete the current gdi object
		local
			delete_result: BOOLEAN
		do
			if item /= default_pointer then
				debug ("WEL_GDI_COUNT")
					decrease_gdi_objects_count
				end
				delete_result := cwin_delete_object (item)
				debug ("WEL")
					if not delete_result then
						io.put_string ("DeleteObject failed for the following object%N")
						print (Current)
					end
				end
				item := default_pointer
			end
		ensure
			not_exists: not exists
		end

feature {NONE} -- Implementation

	increase_gdi_objects_count
			-- Increase the number of GDI objects allocated by this program.
		do
			gdi_objects_count_cell.replace (gdi_objects_count_cell.item + 1)
			debug ("WEL_GDI_COUNT")
				io.put_string_32 ({STRING} "GDI Objects = "+gdi_objects_count.out+"%N")
			end
		end

	decrease_gdi_objects_count
			-- Decrease the number of GDI objects allocated by this program.
		do
			gdi_objects_count_cell.replace (gdi_objects_count_cell.item - 1)
			debug ("WEL_GDI_COUNT")
				io.put_string_32 ({STRING} "GDI Objects = "+gdi_objects_count.out+"%N")
			end
		end

	gdi_objects_count_cell: CELL [INTEGER]
			-- Cell to store the number of GDI objects allocated.
		once
			create Result.put (0)
		end

feature {NONE} -- Externals

	cwin_delete_object (a_item: POINTER): BOOLEAN
			-- SDK DeleteObject
		external
			"C [macro <wel.h>] (HGDIOBJ): BOOL"
		alias
			"DeleteObject"
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
