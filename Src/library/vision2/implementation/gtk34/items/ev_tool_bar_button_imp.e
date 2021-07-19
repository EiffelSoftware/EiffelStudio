note
	description:
		"EiffelVision2 Toolbar button,%
		%a specific button that goes in a tool-bar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface,
			init_select_actions
		end

	EV_ITEM_IMP
		undefine
			update_for_pick_and_drop
		redefine
			interface,
			make,
			event_widget,
			set_pixmap,
			needs_event_box
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

--	EV_SENSITIVE_IMP
--		rename
--			enable_sensitive as enable_sensitive_internal,
--			disable_sensitive as disable_sensitive_internal
--		redefine
--			interface,
--			enable_sensitive_internal
--		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface,
			set_tooltip,
			tooltip
		end

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := False
		end

	old_make (an_interface: attached like interface)
			-- Create the tool bar button.
		do
			assign_interface (an_interface)
		end

	new_tool_bar_button: POINTER
			-- Create a new gtk tool bar button item.
		do
			Result := {GTK2}.gtk_tool_button_new (default_pointer, default_pointer)
		end

	make
			-- Initialization of button box and events.
		do
			set_c_object (new_tool_bar_button)
			Precursor {EV_ITEM_IMP}
			pixmapable_imp_initialize
			{GTK2}.gtk_tool_button_set_icon_widget (visual_widget, pixmap_box)

				-- Initialize gtk events
			{GTK}.gtk_widget_add_events (visual_widget, gdk_events_mask)

			{GTK2}.gtk_tool_item_set_is_important (visual_widget, True)
			set_is_initialized (True)
		end

	event_widget: POINTER
			-- Pointer to the Gtk widget that handles the events
		do
			Result := {GTK}.gtk_widget_get_parent (pixmap_box)
		end

feature -- Access

	text: STRING_32
			-- Text of the label.
		local
			a_txt: POINTER
			a_cs: EV_GTK_C_STRING
		do
			a_txt := {GTK2}.gtk_tool_button_get_label (visual_widget)
			if a_txt /= Default_pointer then
				create a_cs.share_from_pointer (a_txt)
				Result := a_cs.string
			else
				Result := ""
			end
		end

	gray_pixmap: detachable EV_PIXMAP
			-- Image displayed on `Current'.

	tooltip: STRING_32
			-- Tooltip use for describing `Current'.
		do
			if attached internal_tooltip as l_internal_tooltip then
				Result := l_internal_tooltip.twin
			else
				Result := ""
			end
		end

	internal_tooltip: detachable STRING_32
		-- Tooltip for `Current'.

feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			a_parent_imp: detachable EV_TOOL_BAR_IMP
			a_cs: EV_GTK_C_STRING
		do
			a_cs := App_implementation.c_string_from_eiffel_string (a_text)
			{GTK2}.gtk_tool_button_set_label (visual_widget, a_cs.item)
			a_parent_imp ?= parent_imp
			if a_parent_imp /= Void and then a_parent_imp.parent_imp /= Void then
				a_parent_imp.update_toolbar_style
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		local
			a_parent_imp: detachable EV_TOOL_BAR_IMP
		do
			Precursor {EV_ITEM_IMP} (a_pixmap)
			a_parent_imp ?= parent_imp
			if a_parent_imp /= Void and then a_parent_imp.parent_imp /= Void then
				a_parent_imp.update_toolbar_style
			end
		end

	set_tooltip (a_text: READABLE_STRING_GENERAL)
			-- Set `tooltip' to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			internal_tooltip := a_text.as_string_32.twin
			a_cs := App_implementation.c_string_from_eiffel_string (a_text)
			--| FIXME IEK Needs proper implementation
			{GTK2}.gtk_tool_item_set_tooltip_text (visual_widget, a_cs.item)
		end

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP)
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
			gray_pixmap := a_gray_pixmap.twin
			--| FIXME IEK Needs proper implementation
		end

	remove_gray_pixmap
			-- Make `pixmap' `Void'.
		do
			gray_pixmap := Void
			--| FIXME IEK Needs proper implementation
		end

	enable_sensitive
			-- Enable `Current'.
		local
			l_gdkwin: POINTER
			i, l_screen_x, l_screen_y, l_x, l_y: INTEGER
		do
			{GTK}.gtk_widget_set_sensitive (c_object, True)
			if {GTK}.gtk_is_event_box (c_object) then
					-- Restore visible window for event box.
				{GTK2}.gtk_event_box_set_visible_window (c_object, True)
			end
				--| This is a hack for gtk 2.6.x that renders the button unusable if the mouse pointer is over `Current' when `enable_sensitive' is called.
			if is_displayed then
				l_gdkwin := {GDK_HELPERS}.window_at ($l_x, $l_y)
				if l_gdkwin /= default_pointer then
					if Current = app_implementation.gtk_widget_from_gdk_window (l_gdkwin) then
						i := {GTK}.gdk_window_get_origin (l_gdkwin, $l_screen_x, $l_screen_y)
						app_implementation.pnd_screen.set_pointer_position (l_screen_x + l_x + width + 10, l_screen_y + l_y + height + 10)
						app_implementation.pnd_screen.set_pointer_position (l_screen_x + l_x, l_screen_y + l_y)
					end
				end
			end
		end

	disable_sensitive
			-- Disable `Current'.
		do
			{GTK}.gtk_widget_set_sensitive (c_object, False)
			if {GTK}.gtk_is_event_box (c_object) then
					-- We hide the event box Window so that it cannot be seen disabled.
				{GTK2}.gtk_event_box_set_visible_window (c_object, False)
			end
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is the object sensitive to user input.
		do
			-- Shift to put bit in least significant place then take mod 2
			if not is_destroyed then
				Result := {GTK}.gtk_widget_is_sensitive (c_object)
			end
		end

	has_parent: BOOLEAN
			-- Is `Current' parented?
		do
			Result := parent /= Void
		end

	parent_is_sensitive: BOOLEAN
			-- Is `parent' sensitive?
		local
			sensitive_parent: detachable EV_SENSITIVE
		do
			sensitive_parent ?= parent
			if sensitive_parent /= Void then
				Result := sensitive_parent.is_sensitive
			end
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	call_select_actions
			-- Call the select_actions for `Current'
		do
			if not in_select_actions_call then
				in_select_actions_call := True
				if select_actions_internal /= Void then
					select_actions_internal.call (Void)
				end
			end
			in_select_actions_call := False
		end

	in_select_actions_call: BOOLEAN
		-- Is `Current' in the process of having its select actions called

feature {EV_ANY_I, EV_GTK_CALLBACK_MARSHAL} -- Implementation

	init_select_actions (a_select_actions: EV_NOTIFY_ACTION_SEQUENCE)
			-- <Precursor>
		do
			real_signal_connect (c_object,
					{EV_GTK_EVENT_STRINGS}.clicked_event_name,
					agent (App_implementation.gtk_marshal).new_toolbar_item_select_actions_intermediary (internal_id),
					Void
				)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_BUTTON note option: stable attribute end;

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

end -- class EV_TOOL_BAR_BUTTON_IMP
