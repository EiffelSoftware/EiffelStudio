indexing
	description: "Eiffel Vision widget list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_LIST_IMP

inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface
		end

	EV_DYNAMIC_LIST_IMP [EV_WIDGET, EV_WIDGET_IMP]
		redefine
			interface,
			insert_i_th,
			remove_i_th
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_WIDGET_IMP
			wel_win: WEL_WINDOW
		do
				-- Should `v' be a pixmap,
				-- promote implementation to EV_WIDGET_IMP.
			v.implementation.on_parented

			v_imp ?= v.implementation

			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.go_i_th (i)
			ev_children.put_left (v_imp)
			wel_win ?= Current
			check
				wel_win_not_void: wel_win /= Void
			end
			v_imp.wel_set_parent (wel_win)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			notify_change (2 + 1, Current)
			new_item_actions.call ([v])
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			v_imp: EV_WIDGET_IMP
			v_parent_imp: EV_CONTAINER_IMP
		do
			v_imp ?= i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			remove_item_actions.call ([v_imp.interface])
			ev_children.go_i_th (i)
			ev_children.remove
			v_parent_imp ?= v_imp.parent_imp
			check
				v_parent_imp_not_void: v_parent_imp /= Void
			end
			v_parent_imp.notify_change (2 + 1, Current)

				-- Unlink the widget from its parent and
				-- signal it.
			v_imp.set_parent (Void)
			v_imp.on_orphaned
		end

feature {EV_ANY_I} -- WEL Implementation

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		local	
			loc_cursor: CURSOR
		do
			if hwnd_control = wel_item then
				Result := True
			else
				loc_cursor := ev_children.cursor
				from
					ev_children.start
				until
					Result or ev_children.after
				loop
					Result := ev_children.item.
						is_control_in_window (hwnd_control)
					ev_children.forth
				end
				ev_children.go_to (loc_cursor)
			end
		end

feature {NONE} -- Implementation

	interface: EV_WIDGET_LIST

end -- class EV_WIDGET_LIST_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.23  2000/06/07 17:27:59  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.22.2.2  2000/06/05 21:08:04  manus
--| Updated call to `notify_parent' because it requires now an extra parameter which is
--| tells the parent which children did request the change. Usefull in case of NOTEBOOK
--| for performance reasons (See EV_NOTEBOOK_IMP log for more details)
--|
--| Revision 1.22.2.1  2000/05/03 19:09:47  oconnor
--| mergred from HEAD
--|
--| Revision 1.22  2000/05/01 19:36:41  pichery
--| Added feature `is_control_in_window' used
--| to determine if a certain control is contained
--| inside the current window.
--|
--| Revision 1.21  2000/04/28 23:40:44  brendel
--| Improved remove_i_th and insert_i_th.
--|
--| Revision 1.20  2000/04/14 20:46:55  brendel
--| Fixed parenting of widget. on_parented is now called for every widget
--| before trying to conform the implementation to EV_WIDGET_IMP.
--| This is for the new way EV_PIXMAP is done.
--|
--| Revision 1.19  2000/04/12 01:30:21  pichery
--| - added pixmap promoting when adding
--|   a pixmap in a container
--|
--| Revision 1.18  2000/04/06 00:06:57  brendel
--| Corrected argument of action sequence.
--|
--| Revision 1.17  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.16.2.2  2000/04/05 19:58:51  brendel
--| Improved implementation.
--|
--| Revision 1.16.2.1  2000/04/03 18:23:53  brendel
--| Revised with new EV_DYNAMIC_LIST.
--|
--| Revision 1.16  2000/03/21 18:38:57  rogers
--| Item now check ev_children.readable instead of ev_children.item /= Void.
--|
--| Revision 1.15  2000/03/21 02:31:04  brendel
--| Replaced unnecessary assignment attempt with assignment.
--|
--| Revision 1.14  2000/03/14 16:22:48  brendel
--| Fixed bug in put_front.
--|
--| Revision 1.13  2000/03/03 20:02:28  brendel
--| Fixed bug in replace, where before it did not remove the item from the
--| old list if it had one.
--|
--| Revision 1.12  2000/03/03 19:41:05  brendel
--| Removed feature `put_left'.
--|
--| Revision 1.11  2000/03/03 18:34:43  brendel
--| Implemented feature `put_left'.
--|
--| Revision 1.10  2000/03/03 00:56:33  brendel
--| Cosmetics.
--|
--| Revision 1.9  2000/03/02 21:58:45  brendel
--| Reviewed.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

