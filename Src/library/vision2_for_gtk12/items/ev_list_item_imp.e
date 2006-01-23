indexing
	description: "FIXME"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface
		end

	EV_ITEM_IMP
		undefine
			parent,
			pixmap_equal_to
		redefine
			interface,
			initialize,
			make,
			needs_event_box,
			set_item_parent_imp
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False
	
	is_dockable: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create a list item with an empty name.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_list_item_new)
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create list item box to hold label and pixmap.
		local
			item_box: POINTER
		do
			Precursor {EV_ITEM_IMP}
			textable_imp_initialize
			pixmapable_imp_initialize
			checkable_imp_initialize
			item_box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, item_box)
			{EV_GTK_EXTERNALS}.gtk_widget_show (item_box)
				-- Add the pixmap box to the item but hide it so it
				-- takes up no space in the item.
				
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (item_box, check_box, False, False, 0)
				-- The check box is only shown in an EV_CHECKABLE_LIST
			real_signal_connect (check_box, "toggled", agent (App_implementation.gtk_marshal).list_item_check_intermediary (c_object), Void)

			{EV_GTK_EXTERNALS}.gtk_box_pack_start (item_box, pixmap_box, False, False, 2)
				-- Padding of 2 pixels used for pixmap
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (item_box, text_label, True, True, 0)

			--feature {EV_GTK_EXTERNALS}.gtk_widget_hide (pixmap_box)	
			set_is_initialized (True)
		end
		
	checkable_imp_initialize is
			-- 
		do
			check_box := {EV_GTK_EXTERNALS}.gtk_check_button_new
			{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (check_box, {EV_GTK_EXTERNALS}.gTK_CAN_FOCUS_ENUM)
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation
		
	set_item_parent_imp (a_parent: EV_ITEM_LIST_IMP [EV_ITEM]) is
			-- 
		do
			Precursor {EV_ITEM_IMP} (a_parent)
			if a_parent = Void then
				{EV_GTK_EXTERNALS}.gtk_widget_hide (check_box) 				
			end
		end
		
feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	check_callback is
			-- 
		local
			check_list_par: EV_CHECKABLE_LIST_IMP
		do
			check_list_par ?= parent_imp
			if
				check_list_par /= Void
			then
				if check_list_par.is_item_checked (interface) then
					if check_list_par.check_actions_internal /= Void then
						check_list_par.check_actions_internal.call ([interface])
					end
				else
					if check_list_par.uncheck_actions_internal /= Void then
						check_list_par.uncheck_actions_internal.call ([interface])
					end
				end
			end
		end
		

feature {EV_CHECKABLE_LIST_IMP} -- Implementation
		
	check_box: POINTER
		-- Pointer to the check box used in EV_CHECKABLE_LIST_IMP

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected.
		local
			par: POINTER
			par_imp: EV_LIST_ITEM_LIST_IMP
		do
			par_imp ?= parent_imp
			par := par_imp.list_widget
			if par /= NULL then
				Result := {EV_GTK_EXTERNALS}.g_list_find (
					{EV_GTK_EXTERNALS}.gtk_list_struct_selection (par),
					c_object
				) /= NULL
			end
		end

feature -- Status setting

	enable_select is
			-- Select the item.
		local
			par: POINTER
			par_imp: EV_LIST_ITEM_LIST_IMP
			combo_par: EV_COMBO_BOX_IMP
		do
			if not is_selected then
				par_imp ?= parent_imp
				par := par_imp.list_widget
				if par /= NULL then
					{EV_GTK_EXTERNALS}.gtk_list_select_child (par, c_object);
	--| FIXME hack to ensure the element is selected.				
					if
						{EV_GTK_EXTERNALS}.g_list_find (
							{EV_GTK_EXTERNALS}.gtk_list_struct_selection (par),
							c_object
						) = NULL
					then
						{EV_GTK_EXTERNALS}.gtk_list_select_child (par, c_object);
					end
					combo_par ?= parent_imp
					-- We need to explicitly launch select actions in combo box due to selection workaround
					if combo_par /= Void then
						combo_par.launch_select_actions
					end
				end				
			end
		end

	disable_select is
			-- Deselect the item.
		local
			par: POINTER
			par_imp: EV_LIST_ITEM_LIST_IMP
		do
			if is_selected then
				par_imp ?= parent_imp
				par := par_imp.list_widget
				if par /= NULL then
					{EV_GTK_EXTERNALS}.gtk_list_unselect_child (par, c_object);
				end				
			end

		end

feature -- Element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		local
			combo_par: EV_COMBO_BOX_IMP
			a_cs: EV_GTK_C_STRING
		do
			Precursor (txt)
			a_cs := txt
			-- the gtk part if the parent is a combo_box
			combo_par ?= parent_imp
			if (combo_par /= Void) then
				{EV_GTK_EXTERNALS}.gtk_combo_set_item_string (
					combo_par.container_widget,
					c_object, a_cs.item
				)
			end
		end

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_LIST_I} -- Implementation

	interface: EV_LIST_ITEM;

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




end -- class EV_LIST_ITEM_IMP

