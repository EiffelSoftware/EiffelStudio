indexing
	description: 
		"EiffelVision cell. Holds one other widget."
	status: "See notice at end of class"
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_CELL

inherit
	EV_CONTAINER
		redefine
			implementation
		end

feature -- Access

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := item = v	
		end

feature -- Status report

	empty, extendible: BOOLEAN is
			-- Is there no element?
		do
			Result := item = Void
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			Result := item /= Void
		end

	prunable: BOOLEAN is True
			-- May items be removed?

	writable: BOOLEAN is True
			-- Is there a current item that may be modified?

feature -- Removal

	prune (v: like item) is
			-- Remove one occurrence of `v' if any.
		do
			if item = v then
				wipe_out
			end
		end

	wipe_out is
			-- Remove all items.
		do
			implementation.replace (Void)
		end

feature -- Conversion

	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure
		local
			l: LINKED_LIST [like item]
		do
			create l.make
			l.extend (item)
			Result := l
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_CELL_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of cell.
		do
			create {EV_CELL_IMP} implementation.make (Current) 
		end

end -- class EV_CELL

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.10  2000/02/10 21:55:26  oconnor
--| simpler implementation of prune
--|
--| Revision 1.1.4.9  2000/02/08 09:27:44  oconnor
--| moved put and extend to ev_container, added writable is True
--|
--| Revision 1.1.4.8  2000/01/31 19:28:42  brendel
--| Added precondition "require else true" on extend like on put.
--|
--| Revision 1.1.4.7  2000/01/28 20:00:13  oconnor
--| released
--|
--| Revision 1.1.4.6  2000/01/27 19:30:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.5  2000/01/20 18:46:54  oconnor
--| made non deferred
--|
--| Revision 1.1.4.4  1999/12/17 20:03:53  rogers
--| redefined implementation to be a a more refined type.
--|
--| Revision 1.1.4.3  1999/12/15 23:49:25  oconnor
--| removed inheritance of TRAVERSABLE
--|
--| Revision 1.1.4.2  1999/12/15 17:15:11  oconnor
--| formatting
--|
--| Revision 1.1.4.1  1999/11/24 00:15:37  oconnor
--| merged from REVIEW_BRANCH_19991006
--|
--| Revision 1.1.2.1  1999/11/17 02:00:09  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
