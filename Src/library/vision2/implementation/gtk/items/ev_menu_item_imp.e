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
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize
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
			signal_connect ("activate", ~on_activate, Void)
			textable_imp_initialize
			pixmapable_imp_initialize
			initialize_menu_item_box
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
			C.gtk_widget_hide (pixmap_box)
			C.gtk_box_pack_start (box, text_label, True, True, 0)
			C.gtk_widget_show (text_label)
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
		do
			real_text := clone (a_text)
			key := C.gtk_label_parse_uline (text_label,
				eiffel_to_c (u_lined_filter (a_text)))
		end

	remove_text is
			-- Assign `Void' to `text'.
		do
			real_text := Void
			C.gtk_label_set_text (text_label, NULL)
			C.gtk_widget_hide (text_label)
		end

feature {EV_ANY_I} -- Implementation

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

	filter (s: STRING): STRING is
			-- Copy of `s' with filtered out ampersands.
			-- (If `s' does not contain ampersands, return `s'.)
		require
			s_not_void: s /= Void
		do
			if s.has ('&') then
				Result := clone (s)
				filter_ampersand (Result, ' ')
			else
				Result := s
			end
		ensure
			copied_only_if_s_had_ampersand:
				((old clone (s)).has ('&')) = (s /= Result)
			s_not_changed: (old clone (s)).is_equal (s) 
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
				select_actions_internal.call ([])
			end
		end

	menu_item_box: POINTER is
		do
			Result := C.gtk_container_children (c_object)
			Result := C.g_list_nth_data (Result, 0)
		end

	interface: EV_MENU_ITEM

end -- class EV_MENU_ITEM_IMP

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
--| Revision 1.48  2001/06/07 23:08:01  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.36.4.7  2001/02/23 17:26:08  king
--| Re-implemented `filter_ampersand'.
--| Added `u_lined_filter' to be used for underlined accelerators.
--|
--| Revision 1.36.4.6  2000/08/10 17:22:25  oconnor
--| call parent before self on select
--|
--| Revision 1.36.4.5  2000/08/02 23:08:16  king
--| Fixed on_activate to call AS only if not void
--|
--| Revision 1.36.4.4  2000/07/24 21:33:39  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.36.4.3  2000/06/02 21:00:42  king
--| Removed previous bug fix, reimplement in radio menu item
--|
--| Revision 1.36.4.2  2000/06/02 20:55:43  king
--| Bug fix for select_actions firing on deselection
--|
--| Revision 1.36.4.1  2000/05/03 19:08:35  oconnor
--| mergred from HEAD
--|
--| Revision 1.46  2000/05/02 18:55:19  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.45  2000/04/07 22:35:53  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.44  2000/04/04 20:50:18  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.43  2000/03/27 18:04:59  brendel
--| Redefined `text', `set_text' and `remove_text' as specified in the note
--| in EV_MENU_ITEM.
--| Replaced press_actions with select_actions.
--|
--| Revision 1.42  2000/03/24 00:13:16  brendel
--| Removed ampersand filtering for the moment. Will be handled by future
--| class EV_MENU_TEXTABLE (or something).
--|
--| Revision 1.41  2000/03/23 19:32:41  brendel
--| redefined text ans set_text to ignore ampersands which are used as menu
--| shortcuts on Windows.
--|
--| Revision 1.40  2000/03/23 02:27:13  brendel
--| Added call to item_select_actions.
--|
--| Revision 1.39  2000/03/06 23:51:51  brendel
--| Moved connection of action sequence to initialize, to make sure that it
--| is called by descendants.
--|
--| Revision 1.38  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.37  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.36.6.8  2000/02/05 01:37:14  brendel
--| Cleanup.
--|
--| Revision 1.36.6.7  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.36.6.6  2000/02/04 01:15:02  brendel
--| Added connect to activate signal in creation.
--|
--| Revision 1.36.6.5  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.36.6.4  2000/02/02 00:06:44  oconnor
--| hacking menus
--|
--| Revision 1.36.6.3  2000/01/27 19:29:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.36.6.2  1999/11/30 17:25:13  brendel
--| Added redefine of initialize because of change in EV_TEXTABLE_IMP.
--|
--| Revision 1.36.6.1  1999/11/24 17:29:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.36.2.3  1999/11/09 16:53:14  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.36.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
