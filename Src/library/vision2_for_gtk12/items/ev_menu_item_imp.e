indexing
	description: "Eiffel Vision menu item. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			initialize,
			needs_event_box
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			text
		end

	EV_MENU_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False
	
	is_dockable: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create a menu.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_menu_item_new)
		end
	
	initialize is
			-- Call to both precursors.		
		do
			real_signal_connect (c_object, "activate", agent (App_implementation.gtk_marshal).menu_item_activate_intermediary (c_object), Void)
			textable_imp_initialize
			pixmapable_imp_initialize
			initialize_menu_item_box
			real_text := ""
			Precursor {EV_ITEM_IMP}
		end

	initialize_menu_item_box is
			-- Create and initialize menu item box.
		local
			box: POINTER
		do
			box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, box)
			{EV_GTK_EXTERNALS}.gtk_widget_show (box)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, False, True, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, text_label, True, True, 1)
		ensure
			menu_item_box /= NULL
		end

feature -- Access

	text: STRING is
			-- Displayed on menu item.
		do
			if real_text /= Void then
				Result := real_text.twin
			end
		end

	key: NATURAL_32
			-- Accelerator for `Current'.

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			temp_string: STRING
			a_cs: EV_GTK_C_STRING
		do
			a_text.replace_substring_all ("%T", " ")
				-- Replace tab characters with spaces.
			real_text := a_text.twin	
			if a_text.has ('&') then
				temp_string := a_text.twin
				filter_ampersand (temp_string, '_')
				a_cs := temp_string
				key := {EV_GTK_EXTERNALS}.gtk_label_parse_uline (text_label,
				a_cs.item).to_natural_32
			else
				key := 0
				a_cs := a_text
				{EV_GTK_EXTERNALS}.gtk_label_set_text (text_label, a_cs.item)
			end	
			{EV_GTK_EXTERNALS}.gtk_widget_show (text_label)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

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
				Result := s.twin
				filter_ampersand (Result, '_')
			else
				Result := s
			end
		ensure
			copied_only_if_s_had_ampersand:
				((old s.twin).has ('&')) = (s /= Result)
			s_not_changed: (old s.twin).is_equal (s) 
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
				{EV_GTK_EXTERNALS}.gtk_menu_shell_deactivate (p_imp.list_widget)
			end
			{EV_GTK_EXTERNALS}.gtk_menu_item_deselect (c_object)
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	menu_item_box: POINTER is
		local
			a_child_list: POINTER
		do
			a_child_list := {EV_GTK_EXTERNALS}.gtk_container_children (c_object)
			Result := {EV_GTK_EXTERNALS}.g_list_nth_data (a_child_list, 0)
			{EV_GTK_EXTERNALS}.g_list_free (a_child_list)
		end

	interface: EV_MENU_ITEM;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_ITEM_IMP

