indexing
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			make,
			interface,
			set_item_parent_imp,
			create_select_actions
		end

	EV_RADIO_PEER_IMP
		undefine
			visual_widget
		redefine
			interface,
			widget_object
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Make a radio button with a default of selected.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_radio_tool_button_new (NULL))
				-- Needed to prevent calling of action sequence.
		end

feature -- Status setting

	enable_select is
			-- Select `Current'.
		do
			if not is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_tool_button_set_active (visual_widget, True)
			end
		end	

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_toggle_tool_button_get_active (visual_widget)
		end

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			real_signal_connect (visual_widget, "clicked", agent (App_implementation.gtk_marshal).toolbar_item_select_actions_intermediary (internal_id), Void)
		end

feature {NONE} -- Implementation

	set_item_parent_imp (a_container_imp: EV_ITEM_LIST_IMP [EV_ITEM]) is
			-- Set `parent_imp' to `a_container_imp'.
		do
			Precursor {EV_TOOL_BAR_BUTTON_IMP} (a_container_imp)
			if a_container_imp = Void then
				-- `Current' is being unparented so we unset the radio group
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_radio_tool_button_set_group (visual_widget, NULL)
			end
		end

feature {EV_ANY_I} -- Implementation

	widget_object (a_list: POINTER): POINTER is
			-- Returns c_object relative to a_list data.
		do
			Result := {EV_GTK_EXTERNALS}.gslist_struct_data (a_list)
			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (Result)
		end

	radio_group: POINTER is
			-- Pointer to the GSList used for holding the radio grouping of `Current'
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_radio_tool_button_get_group (visual_widget)
		end

	interface: EV_TOOL_BAR_RADIO_BUTTON;
			-- Interface of `Current'

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




end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

