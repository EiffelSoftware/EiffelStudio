--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: 
		" EiffelVision composed item, implementation interface."
	note: "On windows, only the first pixmap is displayed."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_COMPOSED_ITEM_I

inherit
	EV_ITEM_I

feature {NONE} -- Initialization

--	make_with_text (txt: ARRAY [STRING]) is
--			-- Create a row with text in it.
--		require
--			valid_text: txt /= Void
--		deferred
--		ensure
--			text_set: text_set (txt)
--		end

feature -- Access

	count: INTEGER is
			-- Number of element in the item
		require
		deferred
		ensure
			positive_result: result >= 0
		end

	cell_text (value: INTEGER): STRING is
			-- Return the text of the cell number `value' 
		require
			valid_index: value >= 1 and value <= count
		deferred
		ensure
			valid_result: Result /= Void
		end

	text: LINKED_LIST [STRING] is
			-- Current label of the item
		require
		deferred
		ensure
			valid_result: Result /= Void
			valid_texts: not Result.has (Void)
		end

	cell_pixmap (value: INTEGER): EV_PIXMAP is
			-- Return the pixmap of the cell number
			-- `value'. On windows platform, 
			-- if value > 1, the result is void.
		require
		deferred
		end

	pixmap: LINKED_LIST [EV_PIXMAP] is
			-- Return all the pixmaps of the item.
			-- Only 1 on windows platform.
		require
		deferred
		end

feature -- Element change

	set_count (value: INTEGER) is
			-- Make `value' the new count.
			-- When there is a parent, the item has the
			-- count done by the parent.
		require
			no_parent: parent_imp = Void
			valid_value: value > 0
		deferred
		ensure
			count_set: count = value
		end

	set_cell_text (value: INTEGER; txt: STRING) is
			-- Make `txt' the new label of the `value'-th
			-- cell of the item.
		require
			valid_index: value >= 1 and value <= count
			valid_text: txt /= Void
		deferred
		ensure
			text_set: (cell_text (value)).is_equal (txt)
		end

	set_text (txt: ARRAY [STRING]) is
			-- Make `txt' the new label of the item.
		require
			valid_text: txt /= Void
		local
			i: INTEGER
			list_i: INTEGER
		do
			from
				i := txt.lower
				list_i := 1
			until
				i = txt.upper + 1
			loop
				set_cell_text (list_i, txt @ i)
				i := i + 1
				list_i := list_i + 1
			end
		ensure
			text_set: text_set (txt)
		end

	set_cell_pixmap (value: INTEGER; pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the 
			-- `value'-th cell of the item.
		require
			valid_index: value >= 1 and value <= count
			valid_size: (pix /= Void) implies pixmap_size_ok (pix)
		deferred
		ensure
			pixmap_set: (cell_pixmap (value)).is_equal (pix)
		end

--	unset_cell_pixmap (value: INTEGER) is
--			-- Remove the pixmap of the 
--			-- `value'-th cell of the item.
--		require
--			valid_index: value >= 1 and value <= count
--			has_pixmap: (pixmap @ value) /= Void
--		deferred
--		end

	set_pixmap (pix: ARRAY [EV_PIXMAP]) is
			-- Make `pix' the new pixmaps of the item.
		require
			valid_pixmaps: pix /= Void
			valid_size: pixmaps_size_ok (pix)
		local
			i: INTEGER
			list_i: INTEGER
		do
			from
				i := pix.lower
				list_i := 1
			until
				i = pix.upper + 1
			loop
				set_cell_pixmap (list_i, pix @ i)
				i := i + 1
				list_i := list_i + 1
			end
		ensure
			pixmap_set: pixmap_set (pix)
		end

feature -- Assertion features

	text_set (txt: ARRAY [STRING]): BOOLEAN is
			-- Check if `txt' is equivalent to text.
		local
			list: LINKED_LIST [STRING]
		do
			from
				Result := True
				list := text
				list.start
			until
				list.after or not Result
			loop
				if not list.item.is_equal (txt.item (list.index)) then
					Result := False
				end
				list.forth
			end
		end

	pixmap_set (pix: ARRAY [EV_PIXMAP]): BOOLEAN is
			-- Check if `pix' is equivalent to pixmap.
		local
			list: LINKED_LIST [EV_PIXMAP]
		do
			from
				Result := True
				list := pixmap
				list.start
			until
				list.after or not Result
			loop
				if not list.item.is_equal (pix.item (list.index)) then
					Result := False
				end
				list.forth
			end
		end

	pixmap_size_ok (pix: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container.
		do
			Result := (pix.width <= 16) and (pix.height <= 16)
		end

	pixmaps_size_ok (pix_array: ARRAY[EV_PIXMAP]): BOOLEAN is
			-- Check if the size of the pixmaps is ok for
			-- the container.
		local
			pixmaps: ARRAY [EV_PIXMAP]
			i: INTEGER
			pix: EV_PIXMAP
		do
			from
				pixmaps := pix_array
				i := 1
				Result := True
			until
				(Result = False) or (i > pixmaps.upper)	
			loop
				pix := pixmaps @ i
				Result := (pix.width <= 16) and (pix.height <= 16)
				i := i + 1
			end
		end

end -- class EV_COMPOSED_ITEM_I

--!----------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.3  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.2  1999/12/09 03:15:05  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.6.6.1  1999/11/24 17:30:01  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
