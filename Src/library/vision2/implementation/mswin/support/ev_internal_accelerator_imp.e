--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" An internal accelerator used by EV_ACCELERATOR_TABLE_IMP.%
		% Corresponds to a WEL_ACCELERATOR with a little more%
		% informations."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_ACCELERATOR_IMP

inherit
	WEL_ACCELERATOR
		rename
			make as wel_make
		end

	WEL_ACCELERATOR_FLAG_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make (acc: EV_ACCELERATOR) is
			-- Create an accelerator that correspond to the
			-- given accelerator.
		local
			modifier: INTEGER
		do
			if acc.shift_key then
				modifier := set_flag (modifier, Fshift)
			end
			if acc.alt_key then
				modifier := set_flag (modifier, Falt)
			end
			if acc.control_key then
				modifier := set_flag (modifier, Fcontrol)
			end
			modifier := set_flag (modifier, Fvirtkey)
			wel_make (acc.keycode, acc.id, modifier)
		end

feature -- Access

	clients: INTEGER
			-- Nb of widget that implement this accelerators.

feature -- Basic operation

	reference is
			-- Add one reference to the object
		do
			clients := clients + 1
		end

	unreference is
			-- Remove one reference to the object.
		do
			clients := clients - 1
		end

feature {NONE} -- Implementation

end -- class EV_INTERNAL_ACCELERATOR_IMP

--|----------------------------------------------------------------
--| EiffelVision library: library of reusable components for ISE Eiffel.
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



--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.2  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
