indexing
	description: "FIXME"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_NEW_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_ITEM_IMP
		undefine
			parent,
			pixmap_equal_to
		redefine
			interface,
			initialize,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal,
			make,
			set_parent_imp
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

	make (an_interface: like interface) is
			-- Create a list item with an empty name.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_list_item_new)
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create list item box to hold label and pixmap.
		local
			item_box: POINTER
		do
			{EV_ITEM_IMP} Precursor
			textable_imp_initialize
			pixmapable_imp_initialize
			checkable_imp_initialize
			item_box := feature {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (c_object, item_box)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (item_box)
				-- Add the pixmap box to the item but hide it so it
				-- takes up no space in the item.
				
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (item_box, check_box, False, False, 0)
				-- The check box is only shown in an EV_CHECKABLE_LIST
			real_signal_connect (check_box, "toggled", agent (App_implementation.gtk_marshal).list_item_check_intermediary (c_object), Void)

			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (item_box, pixmap_box, False, False, 2)
				-- Padding of 2 pixels used for pixmap
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (item_box, text_label, True, True, 0)

			--feature {EV_GTK_EXTERNALS}.gtk_widget_hide (pixmap_box)	
			is_initialized := True
		end
		
	checkable_imp_initialize is
			-- 
		do
			check_box := feature {EV_GTK_EXTERNALS}.gtk_check_button_new
			gtk_widget_unset_flags (check_box, feature {EV_GTK_EXTERNALS}.gTK_CAN_FOCUS_ENUM)
		end
		
	set_parent_imp (a_container: EV_CONTAINER_IMP) is
			-- 
		do
			Precursor {EV_ITEM_IMP} (a_container)
			if a_container = Void then
				feature {EV_GTK_EXTERNALS}.gtk_widget_hide (check_box) 				
			end
		end
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

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

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				Result := 1 + feature {EV_GTK_EXTERNALS}.gtk_list_child_position (par, c_object)
			end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				Result := feature {EV_GTK_EXTERNALS}.g_list_find (
					feature {EV_GTK_EXTERNALS}.gtk_list_struct_selection (par),
					c_object
				) /= NULL
			end
		end

feature -- Status setting

	enable_select is
			-- Select the item.
		local
			par: POINTER
		do
			if not is_selected then
				par := parent_imp.list_widget
				if par /= NULL then
					feature {EV_GTK_EXTERNALS}.gtk_list_select_child (par, c_object);
	--| FIXME hack to ensure the element is selected.				
					if
						feature {EV_GTK_EXTERNALS}.g_list_find (
							feature {EV_GTK_EXTERNALS}.gtk_list_struct_selection (par),
							c_object
						) = NULL
					then
						feature {EV_GTK_EXTERNALS}.gtk_list_select_child (par, c_object);
					end
				end				
			end
		end

	disable_select is
			-- Deselect the item.
		local
			par: POINTER
		do
			if is_selected then
				par := parent_imp.list_widget
				if par /= NULL then
					feature {EV_GTK_EXTERNALS}.gtk_list_unselect_child (par, c_object);
				end				
			end

		end

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

feature -- Element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		local
			combo_par: EV_NEW_COMBO_BOX_IMP
			a_cs: C_STRING
		do
			Precursor (txt)
			create a_cs.make (txt)
			-- the gtk part if the parent is a combo_box
			combo_par ?= parent_imp
			if (combo_par /= Void) then
				feature {EV_GTK_EXTERNALS}.gtk_combo_set_item_string (
					combo_par.container_widget,
					c_object, a_cs.item
				)
			end
		end

feature {EV_NEW_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_LIST_I} -- Implementation

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

