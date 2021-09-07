note
	description: "EiffelVision tool-bar radio button. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			init_select_actions,
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			set_item_parent_imp,
			init_select_actions,
			new_tool_bar_button
		end

	EV_RADIO_PEER_IMP
		redefine
			interface,
			widget_object
		end

create
	make

feature {NONE} -- Initialization

	new_tool_bar_button: POINTER
		do
			Result := {GTK2}.gtk_radio_tool_button_new (default_pointer)
		end

feature -- Status setting

	enable_select
			-- Select `Current'.
		do
			if not is_selected then
				{GTK2}.gtk_toggle_tool_button_set_active (visual_widget, True)
			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do
			Result := {GTK2}.gtk_toggle_tool_button_get_active (visual_widget)
		end

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	init_select_actions (a_select_actions: EV_NOTIFY_ACTION_SEQUENCE)
			-- <Precursor>
		do
			real_signal_connect (visual_widget,
					{EV_GTK_EVENT_STRINGS}.clicked_event_name,
					agent (App_implementation.gtk_marshal).toolbar_item_select_actions_intermediary (internal_id))
		end

feature {NONE} -- Implementation

	set_item_parent_imp (a_container_imp: EV_ITEM_LIST_IMP [EV_ITEM])
			-- Set `parent_imp' to `a_container_imp'.
		do
			Precursor {EV_TOOL_BAR_BUTTON_IMP} (a_container_imp)
			if a_container_imp = Void then
				-- `Current' is being unparented so we unset the radio group
				{GTK2}.gtk_radio_tool_button_set_group (visual_widget, default_pointer)
			end
		end

feature {EV_ANY_I} -- Implementation

	widget_object (a_list: POINTER): POINTER
			-- Returns c_object relative to a_list data.
		do
			Result := {GTK}.gslist_struct_data (a_list)
			Result := {GTK}.gtk_widget_get_parent (Result)
		end

	radio_group: POINTER
			-- Pointer to the GSList used for holding the radio grouping of `Current'
		do
			Result := {GTK2}.gtk_radio_tool_button_get_group (visual_widget)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_RADIO_BUTTON note option: stable attribute end;
			-- Interface of `Current'

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP
