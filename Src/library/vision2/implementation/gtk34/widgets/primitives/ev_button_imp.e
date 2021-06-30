note
	description:
		"Eiffel Vision button. GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		export
			{EV_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface,
			init_select_actions
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
			set_foreground_color,
			foreground_color_style_context,
			on_focus_changed,
			needs_event_box,
			event_widget
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			align_text_left,
			align_text_center,
			align_text_right
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			fontable_widget
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Connect interface and initialize `c_object'.
		do
			assign_interface (an_interface)
		end

	new_gtk_button: POINTER
		do
			Result := {GTK}.gtk_button_new
		end

	make
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		do
			set_c_object (new_gtk_button)
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			align_text_center
			Precursor {EV_PRIMITIVE_IMP}
		end

	initialize_button_box
			-- Create and initialize button box.
		local
			hbox: POINTER
		do
			hbox := {GTK}.gtk_box_new ({GTK_ORIENTATION}.gtk_orientation_horizontal, 0)
			{GTK}.gtk_container_add (visual_widget, hbox)
			{GTK3}.gtk_widget_set_halign(hbox, {GTK_ALIGN}.gtk_align_start)
			{GTK3}.gtk_widget_set_valign(hbox, {GTK_ALIGN}.gtk_align_start)
			{GTK}.gtk_widget_set_hexpand(hbox, False)
			{GTK}.gtk_widget_set_vexpand(hbox, False)
--			{GTK}.gtk_widget_show (hbox)
			{GTK}.gtk_container_add (hbox, pixmap_box)
 			{GTK3}.gtk_widget_set_halign (text_label, {GTK_ALIGN}.gtk_align_start)
 			{GTK3}.gtk_widget_set_margin_start (text_label, 4)
 			{GTK3}.gtk_widget_set_margin_end (text_label, 4)
			{GTK}.gtk_container_add (hbox, text_label)
			{GTK}.gtk_widget_show (hbox)
		ensure
			button_box /= default_pointer
		end

	fontable_widget: POINTER
			-- Pointer to the widget that may have fonts set.
		do
			Result := text_label
		end

	event_widget: POINTER
			-- Widget that handles the events.
		do
			Result := visual_widget
		end

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

feature -- Access

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button
			-- for a particular container?

feature -- Status Setting

	align_text_center
			-- Display `text' centered.
		do
			Precursor {EV_TEXTABLE_IMP}
			{GTK3}.gtk_widget_set_halign (button_box, {GTK_ALIGN}.gtk_align_center)
			{GTK3}.gtk_widget_set_valign (button_box, {GTK_ALIGN}.gtk_align_center)
				-- TODO check if hexpand and vexpand are really needed.
			{GTK}.gtk_widget_set_hexpand (button_box, false)
			{GTK}.gtk_widget_set_vexpand (button_box, false)
		end

	align_text_left
			-- Display `text' left aligned.
		do
			Precursor {EV_TEXTABLE_IMP}
			{GTK3}.gtk_widget_set_halign (button_box, {GTK_ALIGN}.gtk_align_start)
			{GTK3}.gtk_widget_set_valign (button_box, {GTK_ALIGN}.gtk_align_center)
			{GTK}.gtk_widget_set_hexpand (button_box, false)
			{GTK}.gtk_widget_set_vexpand (button_box, false)
		end

	align_text_right
			-- Display `text' right aligned.
		do
			Precursor {EV_TEXTABLE_IMP}
			{GTK3}.gtk_widget_set_halign(button_box, {GTK_ALIGN}.gtk_align_end)
			{GTK3}.gtk_widget_set_valign(button_box, {GTK_ALIGN}.gtk_align_center)
			{GTK}.gtk_widget_set_hexpand(button_box, false)
			{GTK}.gtk_widget_set_vexpand(button_box, false)
		end

	enable_default_push_button
			-- Set the style of the button corresponding
			-- to the default push button.
		do
			enable_can_default
		end

	disable_default_push_button
			-- Remove the style of the button corresponding
			-- to the default push button.
		do
			is_default_push_button := False
			{GTK2}.gtk_widget_set_can_default (visual_widget, False)
			{GTK}.gtk_widget_queue_draw (visual_widget)
			process_pending_events
		end

	enable_can_default
			-- Allow the style of the button to be the default push button.
		do
			is_default_push_button := True
			{GTK2}.gtk_widget_set_can_default (visual_widget, True)
			{GTK}.gtk_widget_queue_draw (visual_widget)
			process_pending_events
		end

	set_foreground_color (a_color: EV_COLOR)
		do
			Precursor {EV_PRIMITIVE_IMP} (a_color)
			real_set_foreground_color (text_label, a_color)
		end

feature {NONE} -- implementation

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		local
			top_level_dialog_imp: detachable EV_DIALOG_IMP
			rad_but: detachable EV_RADIO_BUTTON_IMP
		do
			Precursor {EV_PRIMITIVE_IMP} (a_has_focus)
			top_level_dialog_imp ?= top_level_window_imp
			if
				top_level_dialog_imp /= Void
			then
				if a_has_focus then
					rad_but ?= Current
					if rad_but = Void then
						-- We do not want radio buttons to affect current push button behavior
						top_level_dialog_imp.set_current_push_button (interface)
					end
				elseif top_level_dialog_imp.internal_current_push_button = interface then
					top_level_dialog_imp.set_current_push_button (Void)
				end
			end
		end

	foreground_color_style_context: POINTER
			-- <Precursor>
		do
			Result := {GTK}.gtk_widget_get_style_context (text_label)
		end

	button_box: POINTER
			-- GtkHBox in button.
			-- Holds label and pixmap.
		do
			Result := {GTK}.gtk_bin_get_child (visual_widget)
		end

	init_select_actions (a_select_actions: like select_actions)
			-- <Precursor>
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp := app_implementation
			real_signal_connect (visual_widget,
					{EV_GTK_EVENT_STRINGS}.clicked_event_name,
				 	agent (l_app_imp.gtk_marshal).button_select_intermediary (c_object),
				 	Void
				 )
		end

feature {EV_ANY, EV_ANY_I} -- implementation

	interface: detachable EV_BUTTON note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	button_box_not_null: is_usable implies button_box /= NULL

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

end -- class EV_BUTTON_IMP
