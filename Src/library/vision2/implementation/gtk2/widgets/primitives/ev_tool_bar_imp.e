indexing
	description: "EiffelVision2 toolbar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			visual_widget,
			needs_event_box
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM]
		undefine
			item_by_data,
			destroy
		redefine
			interface,
			add_to_container,
			insert_i_th,
			list_widget,
			initialize
		end

create
	make

feature {NONE} -- Implementation

	needs_event_box: BOOLEAN is True

	make (an_interface: like interface) is
			-- Create the tool-bar.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_toolbar_new)
		end
		
	initialize is
			-- Initialize `Current'
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_toolbar_set_show_arrow (list_widget, False)
			has_vertical_button_style := True
		end
		
	list_widget: POINTER is
			-- 
		do
			Result := visual_widget
		end
		
feature -- Status report

	has_vertical_button_style: BOOLEAN
			-- Is the `pixmap' displayed vertically above `text' for
			-- all buttons contained in `Current'? If `False', then
			-- the `pixmap' is displayed to left of `text'.
		
feature -- Status setting

	enable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `True'.
		do
			has_vertical_button_style := True
			update_toolbar_style
		end
		
	disable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `False'.
		do
			has_vertical_button_style := False
			update_toolbar_style
		end
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation
		
	block_selection_for_docking is
			-- 
		do
			-- For now, do nothing.
		end

feature -- Implementation

	update_toolbar_style is
			-- Set the style of `Current' relative to items
		local
			tbb_imp: EV_TOOL_BAR_BUTTON_IMP
			has_text, has_pixmap: BOOLEAN
			i, a_style: INTEGER
		do
			from
				i := 1
			until
				i > interface.count
			loop
				tbb_imp ?= interface.i_th (i).implementation
				if tbb_imp /= Void and then not tbb_imp.text.is_equal ("") then
					has_text := True
				end
				if tbb_imp /= Void and then tbb_imp.pixmap /= Void then
					has_pixmap := True
				end
				i := i + 1
			end
			
			if has_text and has_pixmap then
				if has_vertical_button_style then
					a_style := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_toolbar_both_enum
				else
					a_style := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_toolbar_both_horiz_enum
				end
			elseif has_text then
				a_style := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_toolbar_text_enum
			else
				a_style := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_toolbar_icons_enum
			end
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_toolbar_set_style (visual_widget, a_style)
		end	

	insertion_position: INTEGER is
			-- `Result' is index - 1 of item beneath the
			-- current mouse pointer or count + 1 if over the toolbar
			-- and not over a button.
		local
			wid_imp: EV_WIDGET_IMP
			tbi: EV_TOOL_BAR_ITEM
		do
			Result := count + 1
			wid_imp := widget_imp_at_pointer_position
			if wid_imp /= Void then
				tbi ?= wid_imp.interface
				if tbi /= Void and has (tbi) then
					Result := index_of (tbi, 1) - 1
				end
			end
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			v_imp.set_item_parent_imp (Current)
			feature {EV_GTK_EXTERNALS}.gtk_toolbar_insert (visual_widget, v_imp.c_object, i - 1)
			update_toolbar_style
			add_radio_button (v)
			child_array.go_i_th (i)
			child_array.put_left (v)
		end

	add_to_container (v: like item; v_imp: EV_ITEM_IMP) is
			-- Add `v' to tool bar, set to non-expandable.
		do
			check
				do_not_call: False
			end
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check
				do_not_call: False
			end
		end

	add_radio_button (w: like item) is
			-- Connect radio button to tool bar group.
		require
			w_not_void: w /= Void
		local
			r: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				feature {EV_GTK_EXTERNALS}.gtk_radio_tool_button_set_group (r.visual_widget, radio_group)
				radio_group := r.radio_group
			end
		end

feature {EV_TOOL_BAR_RADIO_BUTTON_IMP} -- Implementation

	radio_group: POINTER
		-- GSList containing the radio peers held within `Current'

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR

end -- class EV_TOOL_BAR_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

