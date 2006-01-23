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
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			parent_imp,
			make,
			interface,
			initialize,
			create_select_actions,
			enable_sensitive,
			disable_sensitive,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_RADIO_PEER_IMP
		undefine
			visual_widget
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Make a radio button with a default of selected.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_toggle_button_new)
			avoid_reselection := True
				-- Needed to prevent calling of action sequence.
			enable_select
			avoid_reselection := False
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Redefined to prevent unwanted signal connection.
		do
			create Result
		end

	initialize is
			-- Initialize default settings for radio item.
		do
			Precursor
			connect_signals
				-- Make the label text left aligned
			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0, 0.5)
			{EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, {EV_GTK_EXTERNALS}.gtk_justify_left_enum)
		end

feature -- Status setting

	enable_select is
			-- Select `Current' in its grouping.
		do
			if not is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, True)
			end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (visual_widget)
		end

feature {NONE} -- Implementation

	parent_imp: EV_TOOL_BAR_IMP is
		do
			Result ?= Precursor
		end

	connect_signals is
			-- Connect on_activate to toggled signal.
		do
			real_signal_connect (visual_widget, "toggled", agent (App_implementation.gtk_marshal).on_tool_bar_radio_button_activate (c_object), Void)
		end
		
feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation
		
	on_activate is
			-- The button has been activated by the user (pushed).
		local
			a_peers: like peers
			radio_imp: like Current
		do
			if is_selected and then not avoid_reselection then
				a_peers := peers
				from
					a_peers.start
				until
					a_peers.after
				loop
					radio_imp ?= a_peers.item.implementation
					if radio_imp.is_selected and radio_imp /= Current then
						radio_imp.disable_select
					end
					a_peers.forth
				end
				if select_actions_internal /= Void then
					select_actions_internal.call (Void)
				end
			end

			if not avoid_reselection then
				avoid_reselection := True
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, True)
				-- Calls on_activate callback immediately
				avoid_reselection := False
			end				
		end

feature {EV_ANY_I} -- Implementation

	disable_select is
			-- Unselect the radio button.
		do
			if is_selected then
				avoid_reselection := True
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, False)
				-- Calls on_activate callback immediately
				avoid_reselection := False
			end
		end
		
	enable_sensitive is
			-- 
		do
			if not is_sensitive then
				{EV_GTK_EXTERNALS}.gtk_widget_set_sensitive (c_object, True)
				{EV_GTK_EXTERNALS}.gtk_widget_set_state (c_object, gtk_state)
			end
		end
	
	disable_sensitive is
			-- 
		do
			if is_sensitive then
				gtk_state := {EV_GTK_EXTERNALS}.gtk_widget_struct_state (c_object)
				{EV_GTK_EXTERNALS}.gtk_widget_set_sensitive (c_object, False)
			end		
		end
	
	gtk_state: INTEGER
		-- Used to get around gtk sensitive bug that doesn't take flat style in to account.

	avoid_reselection: BOOLEAN

	radio_group: POINTER is
		do
			if parent_imp /= Void then
				Result := parent_imp.radio_group
			end
		end

	interface: EV_TOOL_BAR_RADIO_BUTTON

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE;

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

