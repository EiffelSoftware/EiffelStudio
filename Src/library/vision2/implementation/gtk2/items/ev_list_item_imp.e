indexing
	description: "FIXME"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
	
	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a list item with an empty name.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'
		do
			internal_text := ""
			is_initialized := True
		end

feature -- PND

	enable_transport is 
		do
			is_transport_enabled := True
			if parent_imp /= Void then
			--	parent_imp.update_pnd_connection (True)
			end
		end

	disable_transport is
		do
			is_transport_enabled := False
			if parent_imp /= Void then
			--	parent_imp.update_pnd_status
			end
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER) is 
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_CURSOR) is
		do
			check
				do_not_call: False
			end
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

--	check_callback is
--			-- 
--		local
--			check_list_par: EV_CHECKABLE_LIST_IMP
--		do
--			check_list_par ?= parent_imp
--			if
--				check_list_par /= Void
--			then
--				if check_list_par.is_item_checked (interface) then
--					if check_list_par.check_actions_internal /= Void then
--						check_list_par.check_actions_internal.call ([interface])
--					end
--				else
--					if check_list_par.uncheck_actions_internal /= Void then
--						check_list_par.uncheck_actions_internal.call ([interface])
--					end
--				end
--			end
--		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected.
		do
			if parent_imp /= Void then
				Result := parent_imp.selected_items.has (interface)
			end
		end

feature -- Status setting

	enable_select is
			-- Select the item.
		do
			parent_imp.select_item (parent_imp.index_of (interface, 1))
		end

	disable_select is
			-- Deselect the item.
		do
			parent_imp.deselect_item (parent_imp.index_of (interface, 1))
		end


	text: STRING is
			-- 
		do
			Result := internal_text.twin
		end
		

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		do
		end

	tooltip: STRING
			-- Tooltip displayed on `Current'.

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		do
			internal_text := txt.twin
			if parent_imp /= Void then
				
			end
		end
		
	set_pixmap (a_pix: EV_PIXMAP) is
			-- Set the rows `pixmap' to `a_pix'.
		do
			pixmap := a_pix.twin
			if parent_imp /= Void then
			--	parent_imp.set_row_pixmap (index, internal_pixmap)
			end
		end

	remove_pixmap is
			-- Remove the rows pixmap.
		do
			--internal_pixmap := Void
			if parent_imp /= Void then
			--	parent_imp.remove_row_pixmap (index)
			end
		end
	
	pixmap: EV_PIXMAP

feature {NONE} -- Implementation

	internal_text: STRING

	destroy is
			-- 
		do
			pixmap := Void
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	set_list_iter (a_iter: EV_GTK_TREE_ITER_STRUCT) is
			-- Set `list_iter' to `a_iter'
		do
			list_iter := a_iter
		end

	list_iter: EV_GTK_TREE_ITER_STRUCT
		-- Object representing position of `Current' in parent tree model

	parent_imp: EV_LIST_ITEM_LIST_IMP
	
	set_parent_imp (a_parent_imp: EV_LIST_ITEM_LIST_IMP) is
			-- 
		do
			parent_imp := a_parent_imp
		end

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_LIST_I} -- Implementation

	interface: EV_LIST_ITEM

end -- class EV_LIST_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

