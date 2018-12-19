note
	description: "Objects that represents an editable grid label with ellipsis button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GRID_EDITABLE_ELLIPSIS_ITEM

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			create_interface_objects,
			activate_action,
			initialize_actions,
			deactivate,
			set_text
		end

	EV_UTILITIES
		undefine
			default_create,
			copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	create_interface_objects
		do
			create ellipsis_actions
			create change_actions
			Precursor
		end

feature -- Status

	has_focus: BOOLEAN
			-- Does this property have the focus?
		require
			is_activated
		do
			Result := (attached text_field as tf and then tf.has_focus)
					or (attached button as but and then but.has_focus)
		end

	is_activated: BOOLEAN
			-- Is the property activated?

	is_text_editing: BOOLEAN
			-- Can the text be directly edited in the text field?

feature -- Access

	button: detachable EV_WIDGET
			-- Ellipsis button used to edit `Current' on activate.
			-- Void when `Current' isn't beeing activated.

	popup_window: detachable EV_POPUP_WINDOW
			-- Popup window used on activate.
			-- Void when `Current' isn't beeing activated.

feature -- Update

	set_text (a_text: READABLE_STRING_GENERAL)
		local
			l_has_changed: BOOLEAN
		do
			l_has_changed := text = Void or else not (text ~ a_text)
			Precursor {EV_GRID_EDITABLE_ITEM} (a_text)
			if l_has_changed then
				change_actions.call (Void)
			end
		end

	disable_text_editing
			-- Disable editing the text directly in the text field.
		do
			is_text_editing := False
		ensure
			not_is_text_editing: not is_text_editing
		end

	enable_text_editing
			-- Enable editing the text directly in the text field.
		do
			is_text_editing := True
		ensure
			is_text_editing: is_text_editing
		end

feature {NONE} -- Implementation

	initialize_actions
			-- Setup the action sequences when the item is shown.
		do
			check
				attached text_field as tf
				and attached button as but
			then
				tf.return_actions.extend (agent return_pressed)
				tf.focus_out_actions.extend (agent focus_lost)
				but.focus_out_actions.extend (agent focus_lost)
				but.pointer_button_release_actions.extend
					(agent (x, y, b: INTEGER_32; x_tilt, y_tilt, p: REAL_64; screen_x, screen_y: INTEGER_32)
						do
							call_ellipsis_actions
						end)

				tf.set_focus
				tf.key_press_actions.extend (agent handle_key)
			end
			user_cancelled_activation := False
		end

	focus_lost
			-- Check if no other element in the popup has the focus.
		do
			if
				is_activated
				and then not inside_outter_edition
				and then not has_focus
				and then is_parented
			then
				deactivate
			end
		end

	activate_action (a_popup_window: EV_POPUP_WINDOW)
			-- Activate action.
		local
			hb: EV_HORIZONTAL_BOX
			d: EV_DRAWING_AREA
			bgcolor,fgcolor: EV_COLOR
			l_sep_color: detachable EV_COLOR
			tf: like text_field
		do
			popup_window := a_popup_window
			if is_text_editing then
				create tf
				text_field := tf
				tf.implementation.hide_border
				if attached font as ft then
					tf.set_font (ft)
				end

				if not is_text_editing then
					tf.disable_edit
				end

				tf.set_text (text)
				bgcolor := implementation.displayed_background_color
				fgcolor := implementation.displayed_foreground_color
				tf.set_background_color (bgcolor)
				a_popup_window.set_background_color (bgcolor)
				tf.set_foreground_color (fgcolor)

				create hb
				hb.extend (tf)

					--| ellipsis button
				create d
				d.set_background_color (bgcolor)
				d.set_minimum_size (4 + ellipsis_width, (height - 1).max (2 + ellipsis_height))
				hb.extend (d)
				hb.disable_item_expand (d)
				d.expose_actions.extend (agent draw_ellipsis (d, ?, ?, ?, ?))
				if attached parent as l_parent_grid then
					l_sep_color := l_parent_grid.separator_color
				end

				d.pointer_enter_actions.extend (agent (ai_d: EV_DRAWING_AREA; ai_col: detachable EV_COLOR)
						local
							old_c: EV_COLOR
						do
							if ai_col /= Void then
								old_c := ai_d.foreground_color
								ai_d.set_foreground_color (ai_col)
								ai_d.draw_rectangle (0, 0, ai_d.width, ai_d.height)
								ai_d.set_foreground_color (old_c)
							end
						end(d, l_sep_color))
				d.pointer_leave_actions.extend (agent (ai_d: EV_DRAWING_AREA; ai_col: EV_COLOR)
						local
							old_c: EV_COLOR
						do
							old_c := ai_d.foreground_color
							ai_d.set_foreground_color (ai_col)
							ai_d.draw_rectangle (0, 0, ai_d.width, ai_d.height)
							ai_d.set_foreground_color (old_c)
						end(d, bgcolor))
				button := d

				a_popup_window.extend (hb)
				update_popup_dimensions (a_popup_window)

				a_popup_window.show_actions.extend_kamikaze (agent initialize_actions)
				is_activated := True
			else
				is_activated := True
				call_ellipsis_actions
			end
		ensure then
			popup_window_set: popup_window /= Void
			text_editing_implies_activation: is_text_editing implies is_activated and text_field /= Void and button /= Void
		end

	deactivate
			-- Cleanup from previous call to `activate'.
		do
			Precursor {EV_GRID_EDITABLE_ITEM}
			if attached button as b then
				b.destroy
				button := Void
			end
			if attached text_field as tf then
				tf.destroy
				text_field := Void
			end
			if attached popup_window as pw then
				pw.destroy
				popup_window := Void
			end
			is_activated := False
			if attached parent as pt and then not pt.is_destroyed and then pt.is_displayed then
				pt.set_focus
			end
		ensure then
			popup_window_void: popup_window = Void
			text_field_void: text_field = Void
			button_void: button = Void
			not_activated: not is_activated
		end

	inside_outter_edition: BOOLEAN
			-- Is inside outter edition?

	enter_outter_edition
			-- Enter outter edition
		require
			is_activated: is_activated
		do
			inside_outter_edition := True
			if attached text_field as tf then
				tf.disable_sensitive
			end
			if attached button as but then
				but.disable_sensitive
			end
			if attached popup_window as w then
				w.hide
			end
		end

	leave_outter_edition
			-- Leave outter edition
		do
			if attached popup_window as pw then
				pw.show
			end
			if attached text_field as tf then
				tf.enable_sensitive
			end
			if attached button as b then
				b.enable_sensitive
			end
			inside_outter_edition := False
		end

feature -- Events

	ellipsis_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called if the ellipsis button is pressed.

	change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called if the text changed.

feature {NONE} -- Implementation

	return_pressed
			-- On control+Enter call ellipsis actions, otherwise deactivate
		do
			if ev_application.ctrl_pressed then
				call_ellipsis_actions
			else
				deactivate
			end
		end

	call_ellipsis_actions
			-- Call ellipsis_actions
		do
			ellipsis_actions.call (Void)
		end

	draw_ellipsis (a_drawable: EV_DRAWABLE; a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
		local
			l_x_offset, l_y_offset: INTEGER
		do
			a_drawable.clear
			a_drawable.set_foreground_color (implementation.displayed_foreground_color)
			l_x_offset := (a_width - ellipsis_width) // 2
			l_y_offset := (a_height - ellipsis_height) // 2

				-- Draw a drop down triangle.
			a_drawable.fill_rectangle (l_x_offset + 0, l_y_offset + 0, 2, 2)
			a_drawable.fill_rectangle (l_x_offset + 3, l_y_offset + 0, 2, 2)
			a_drawable.fill_rectangle (l_x_offset + 6, l_y_offset + 0, 2, 2)
		end

	ellipsis_width: INTEGER = 8
	ellipsis_height: INTEGER = 2

	ellipsis: EV_PIXMAP
			-- Icon for ellipsis
		local
			l_mask: EV_BITMAP
		once
				-- Draw a drop down triangle.
			create Result.make_with_size (ellipsis_width, ellipsis_height)
			Result.fill_rectangle (0, 0, 2, 2)
			Result.fill_rectangle (3, 0, 2, 2)
			Result.fill_rectangle (6, 0, 2, 2)

			create l_mask.make_with_size (ellipsis_width, ellipsis_height)
			l_mask.fill_rectangle (0, 0, 2, 2)
			l_mask.fill_rectangle (3, 0, 2, 2)
			l_mask.fill_rectangle (6, 0, 2, 2)

			Result.set_mask (l_mask)
		ensure
			Result_set: Result /= Void
		end

invariant

	ellipsis_actions_not_void: ellipsis_actions /= Void

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
