note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NOTIFICATION_WIDGET

inherit
	EV_CELL

	ES_SHARED_FONTS_AND_COLORS
		undefine
			default_create,
			copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

	EB_CONSTANTS
		undefine
			default_create,
			copy
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_message: like message)
		do
			default_create
			message := a_message
			build_interface
		end

feature -- Access

	message: NOTIFICATION_MESSAGE

feature -- Element change

	build_interface
		local
			lab: EVS_LABEL
			l_action_label: EVS_LINK_LABEL
			l_action_box: EV_HORIZONTAL_BOX
			l_main: EV_BOX
			fr, l_action_frame: EV_VERTICAL_BOX
			l_scaler: EVS_DPI_SCALER
			l_cross: EV_PIXMAP
			l_title_bar: EV_HORIZONTAL_BOX
			l_label_title: EV_LABEL
		do
			create l_scaler.make
			set_minimum_width (l_scaler.scaled_size (300))

			create lab.make_with_text (message.text)
			lab.set_font (text_font)
			lab.set_is_text_wrapped (True)

			if lab.font.string_width (lab.text) > minimum_width then
				create {EV_VERTICAL_BOX} l_main
			else
				create {EV_HORIZONTAL_BOX} l_main
			end
			l_main.set_border_width (l_scaler.scaled_size (5))

			create l_action_box
			l_action_box.set_padding_width (l_scaler.scaled_size (1))
			l_main.extend (lab)
			l_main.extend (l_action_box)

			create fr
			extend (fr)
			fr.set_background_color (colors.stock_colors.color_3d_shadow)
			fr.set_border_width (l_scaler.scaled_size (1))
			fr.set_padding_width (l_scaler.scaled_size (1))

			l_cross := close_icon

			if attached message.title as l_title then
				create l_label_title.make_with_text (l_title)
			else
				create l_label_title.make_with_text (title_from_category (message.category))
			end
			l_label_title.align_text_left
			l_label_title.set_font (title_font)

--			create l_in
--			fr.extend (l_in)
			create l_title_bar
			l_title_bar.set_border_width (l_scaler.scaled_size (5))
			l_title_bar.set_padding_width (l_scaler.scaled_size (5))
			l_title_bar.extend (l_label_title)
--			l_title_bar.extend (create {EV_CELL})
			l_title_bar.extend (l_cross)
			l_title_bar.disable_item_expand (l_cross)

			fr.extend (l_title_bar)
			fr.disable_item_expand (l_title_bar)
			fr.extend (l_main)


			l_main.set_foreground_color (text_foreground_color)
			l_main.set_background_color (text_background_color)
			l_main.propagate_background_color
			l_main.propagate_foreground_color

			l_title_bar.set_foreground_color (title_foreground_color)
			l_title_bar.set_background_color (title_background_color)
			l_title_bar.propagate_foreground_color
			l_title_bar.propagate_background_color

			if attached {NOTIFICATION_MESSAGE_WITH_ACTIONS} message as mwa then
				across
					mwa.actions as ic
				loop
					create l_action_label.make_with_text (ic.key)
					l_action_label.set_font (text_font)
					create l_action_frame
					l_action_frame.set_border_width (l_scaler.scaled_size (1))
					l_action_frame.extend (l_action_label)
					l_action_box.extend (l_action_frame)
					l_action_frame.set_background_color (l_action_box.foreground_color)
					l_action_label.set_foreground_color (l_action_box.foreground_color)
					l_action_label.set_background_color (l_action_box.background_color)

					l_action_label.select_actions.extend (agent (act: PROCEDURE)
							do
								terminate
								ev_application.add_idle_action_kamikaze (act)
							end(ic.item)
						)
				end
			end

			lab.pointer_double_press_actions.extend (agent terminate_on_pointer_action)
			l_main.pointer_double_press_actions.extend (agent terminate_on_pointer_action)
			l_cross.pointer_button_release_actions.extend (agent terminate_on_pointer_action)

		end

feature -- Helpers

	title_from_category (a_cat: READABLE_STRING_32): STRING_32
		local
			l_up: BOOLEAN
			i,n: INTEGER
			c: CHARACTER_32
		do
			create Result.make (a_cat.count)
			l_up := True
			from
				i := 1
				n := a_cat.count
			until
				i > n
			loop
				c := a_cat [i]
				if c = '_' then
					c := ' '
				end
				if c.is_space then
					l_up := True
				elseif l_up then
					c := c.as_upper
					l_up := False
				else
					c := c.as_lower
				end
				Result.extend (c)
				i := i + 1
			end
		end

feature -- Colors

	title_font: EV_FONT
		do
			Result := preferences.dialog_data.notification_title_font
		end

	title_foreground_color: EV_COLOR
		do
			Result := preferences.dialog_data.notification_title_foreground_color
		end

	title_background_color: EV_COLOR
		do
			Result := preferences.dialog_data.notification_title_background_color
		end

	text_font: EV_FONT
		do
			Result := preferences.dialog_data.notification_text_font
		end

	text_foreground_color: EV_COLOR
		do
			Result := preferences.dialog_data.notification_text_foreground_color
		end

	text_background_color: EV_COLOR
		do
			Result := preferences.dialog_data.notification_text_background_color
		end

feature -- Icons

	close_icon: EV_PIXMAP
		do
			Result := pixmaps.mini_pixmaps.toolbar_close_icon.twin
			Result.set_minimum_size (Result.width, Result.height)
		end

feature -- Actions

	terminate_on_pointer_action (i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
		do
			if i_button = {EV_POINTER_CONSTANTS}.left then
				terminate
			end
		end

	terminate
		do
			if attached terminate_action as act then
				act.call (Void)
			end
		end

feature -- Access		

	terminate_action: detachable PROCEDURE

feature -- Element change

	set_terminate_action (p: like terminate_action)
		do
			terminate_action := p
		end

invariant

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
