indexing
	description	: "This class is an ancestor to all GDI classes."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

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
	
	make_by_pointer (a_pointer: POINTER) is
			-- Set `item' with `a_pointer'.
			-- Since `item' is shared, it does not need
			-- to be freed.
			-- Caution: `a_pointer' must be a pointer
			-- coming from Windows.
		do
			Precursor (a_pointer)
			gdi_make
		end

	gdi_make is
			-- Initialize the GDI part of `Current'.
			--
			-- `gdi_make' should be called by all creation procedure.
		do
			debug ("GDI_COUNT")
				increase_gdi_objects_count
			end
		end

feature -- Access

	gdi_objects_count: INTEGER is
			-- Number of GDI object currently allocated by the
			-- program.
			--
			-- Note: debug option "GDI_COUNT" should be set, otherwise
			-- this function will return zero.
		do
			Result := gdi_objects_count_cell.item
		end

feature {NONE} -- Removal

	destroy_item is
			-- Ensure the current gdi object is deleted when
			-- garbage collected.
		do
			delete_gdi_object
		end

	delete_gdi_object is
			-- Delete the current gdi object
		local
			p: POINTER
			delete_result: BOOLEAN
		do
			if item /= p then
				debug ("GDI_COUNT")
					decrease_gdi_objects_count
				end
				delete_result := cwin_delete_object (item)
				debug ("WEL")
					if not delete_result then
						io.putstring ("DeleteObject failed for the following object%N")
						print (Current)
					end
				end
				item := p
			end
		ensure
			not_exists: not exists
		end

feature {NONE} -- Implementation

	increase_gdi_objects_count is
			-- Increase the number of GDI objects allocated by this program.
		do
			gdi_objects_count_cell.replace (gdi_objects_count_cell.item + 1)
			debug ("GDI_COUNT")
				io.putstring ("GDI Objects = "+gdi_objects_count.out)
				io.putstring ("%N")
			end
		end

	decrease_gdi_objects_count is
			-- Decrease the number of GDI objects allocated by this program.
		do
			gdi_objects_count_cell.replace (gdi_objects_count_cell.item - 1)
			debug ("GDI_COUNT")
				io.putstring ("GDI Objects = "+gdi_objects_count.out)
				io.putstring ("%N")
			end
		end

	gdi_objects_count_cell: CELL [INTEGER] is
			-- Cell to store the number of GDI objects allocated by this progran.
		once
			create Result.put (0)
		end

feature {NONE} -- Externals

	cwin_delete_object (a_item: POINTER): BOOLEAN is
			-- SDK DeleteObject
		external
			"C [macro <wel.h>] (HGDIOBJ): BOOL"
		alias
			"DeleteObject"
		end

end -- class WEL_GDI_ANY

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

