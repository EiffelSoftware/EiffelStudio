--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "A WEL control holding the EiffelVision Tool Bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_TOOL_BAR_IMP

inherit
	WEL_CONTROL_WINDOW
		redefine
			default_style,
			on_wm_erase_background,
			on_control_id_command
		end

creation
	make

feature {NONE} -- WEL Implementation

	toolbar: EV_TOOL_BAR_IMP is
			-- Child toolbar
		do
			Result ?= children.first
		end

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
			-- Ne need to erase the background because this
			-- containers has always the same size than the
			-- tool-bar.
		do
			disable_default_processing
		end

	on_control_id_command (control_id: INTEGER) is
			-- A command has been received from `control_id'.
		local	
			original_index: INTEGER
			matched: BOOLEAN
		do
			from
				original_index := toolbar.ev_children.index
				toolbar.ev_children.start
			until
				toolbar.ev_children.off or matched
			loop
				if toolbar.ev_children.item.id = control_id then
					toolbar.ev_children.item.on_activate
					matched := True
				end
				toolbar.ev_children.forth
			end
			toolbar.ev_children.go_i_th (original_index)
		end

	default_style: INTEGER is
			-- We redefine the default style.
		do
			Result := Ws_child + Ws_visible
		end

end -- class EV_INTERNAL_TOOL_BAR_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.7  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.10.3  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.10.2  2000/01/24 21:26:34  rogers
--| on_control_id_command has been re-implemented as the hash table of children has been removed.
--|
--| Revision 1.6.10.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
