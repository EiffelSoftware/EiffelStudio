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

	EV_SIMPLE_ITEM_IMP
		redefine
			interface,
			initialize,
			set_text,
			remove_text,
			text
		end
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
			signal_connect ("activate", ~on_activate, default_translate)
			textable_imp_initialize
			pixmapable_imp_initialize
			initialize_menu_item_box
			{EV_SIMPLE_ITEM_IMP} Precursor
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
			menu_item_box /= default_pointer
		end

feature -- Access

	text: STRING is
			-- Displayed on menu item.
		do
			Result := clone (real_text)
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			real_text := clone (a_text)
			C.gtk_widget_show (text_label)
			C.gtk_label_set_text (text_label,
				eiffel_to_c (filter (a_text)))
		end

	remove_text is
			-- Assign `Void' to `text'.
		do
			real_text := Void
			C.gtk_label_set_text (text_label, Default_pointer)
			C.gtk_widget_hide (text_label)
		end

feature {EV_ANY_I} -- Implementation

	real_text: STRING
			-- Internal `text'. (with ampersands)

	filter_ampersand (s: STRING) is
			-- Remove occurrences of '&' from `s' and
			-- replace occurrences of "&&" with '&'.
		require
			s_not_void: s /= Void
			s_has_at_least_one_ampersand: s.occurrences ('&') > 0
		do
			s.replace_substring_all ("&&", "!AMP!")
			s.prune_all ('&')
			s.replace_substring_all ("!AMP!", "&")
		ensure
			only_ampersands_removed:
				(old clone (s)).count + s.occurrences ('&') =
				s.count + (old clone (s)).occurrences ('&')
		end

	filter (s: STRING): STRING is
			-- Copy of `s' with filtered out ampersands.
			-- (If `s' does not contain ampersands, return `s'.)
		require
			s_not_void: s /= Void
		do
			if s.has ('&') then
				Result := clone (s)
				filter_ampersand (Result)
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
			interface.select_actions.call ([])
			p_imp ?= parent_imp
			if p_imp /= Void then
				p_imp.interface.item_select_actions.call ([interface])
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
