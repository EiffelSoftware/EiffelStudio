indexing
	description: "Eiffel Vision menu item. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_ITEM_IMP
	
inherit
	EV_MENU_ITEM_I
		redefine
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			remove_text,
			text
		end

	EV_MENU_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a menu.
		do
			base_make (an_interface)
			set_c_object (C.gtk_menu_item_new)
		end
	
	initialize is
			-- Call to both precursors.		
		do
			real_signal_connect (c_object, "activate", agent (App_implementation.gtk_marshal).menu_item_activate_intermediary (c_object), Void)
			textable_imp_initialize
			pixmapable_imp_initialize
			initialize_menu_item_box
			real_text := ""
			{EV_ITEM_IMP} Precursor
		end

	initialize_menu_item_box is
			-- Create and initialize menu item box.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (c_object, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_start (box, pixmap_box, False, True, 0)
			C.gtk_box_pack_start (box, text_label, True, True, 1)
		ensure
			menu_item_box /= NULL
		end

feature -- Access

	text: STRING is
			-- Displayed on menu item.
		do
			Result := clone (real_text)
		end

	key: INTEGER
			-- Accelerator for `Current'.

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			temp_string: STRING
			a_gs: GEL_STRING
		do
			real_text := clone (a_text)	
			if a_text.has ('&') then
				temp_string := clone (a_text)
				filter_ampersand (temp_string, '_')
				create a_gs.make (temp_string)
				key := C.gtk_label_parse_uline (text_label,
				a_gs.item)
			else
				key := 0
				create a_gs.make (a_text)
				C.gtk_label_set_text (text_label, a_gs.item)
			end	
			C.gtk_widget_show (text_label)
		end

	remove_text is
			-- Assign `Void' to `text'.
		do
			real_text := ""
			C.gtk_label_set_text (text_label, NULL)
			C.gtk_widget_hide (text_label)
		end
		
feature {EV_MENU_ITEM_LIST_IMP} -- Assignment optimization

	Radio_type, Check_type, Separator_type, Item_type, Menu_type: INTEGER is Unique
	
	menu_item_type: INTEGER is
			-- 
		do
			Result := Item_type
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	real_text: STRING
			-- Internal `text'. (with ampersands)

	filter_ampersand (s: STRING; char: CHARACTER) is
			-- Replace occurrences of '&' from `s'  by `char' and
			-- replace occurrences of "&&" with '&'.
		require
			s_not_void: s /= Void
			s_has_at_least_one_ampersand: s.occurrences ('&') > 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > s.count
			loop
				if s.item (i) = '&' then
					if s.item (i + 1) /= '&' then
						s.put (char, i)
					else
						i := i + 1
					end
				end					
				i := i + 1
			end
			s.replace_substring_all ("&&", "&")
		end

	u_lined_filter (s: STRING): STRING is
			-- Copy of `s' with underscores instead of ampersands.
			-- (If `s' does not contain ampersands, return `s'.)
		require
			s_not_void: s /= Void
		do
			if s.has ('&') then
				Result := clone (s)
				filter_ampersand (Result, '_')
			else
				Result := s
			end
		ensure
			copied_only_if_s_had_ampersand:
				((old clone (s)).has ('&')) = (s /= Result)
			s_not_changed: (old clone (s)).is_equal (s) 
		end

	on_activate is
		local
			p_imp: EV_MENU_ITEM_LIST_IMP
		do
			p_imp ?= parent_imp
			if p_imp /= Void then
				if p_imp.item_select_actions_internal /= Void then
					p_imp.item_select_actions_internal.call ([interface])
				end
				C.gtk_menu_shell_deactivate (p_imp.list_widget)
			end
			C.gtk_menu_item_deselect (c_object)
			if select_actions_internal /= Void then
				select_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
			end
		end

	menu_item_box: POINTER is
		local
			a_child_list: POINTER
		do
			a_child_list := C.gtk_container_children (c_object)
			Result := C.g_list_nth_data (a_child_list, 0)
			C.g_list_free (a_child_list)
		end

	interface: EV_MENU_ITEM

end -- class EV_MENU_ITEM_IMP

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

