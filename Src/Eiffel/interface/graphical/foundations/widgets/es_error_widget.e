indexing
	description: "[
		Simple, general purpose, error label widget with an error icon.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_ERROR_WIDGET

inherit
	ES_WIDGET [EV_HORIZONTAL_BOX]
		redefine
			on_before_initialize
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	frozen make_with_text (a_text: STRING_GENERAL)
			-- Initialize a new error label widget with a text error message.
			--
			-- `a_text': The message text to set on the label.
		require
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
		do
			make
			set_text (a_text)
		ensure
			text_set: a_text.as_string_32.is_equal (text)
		end

	build_widget_interface (a_widget: !EV_HORIZONTAL_BOX)
			-- Builds widget's interface.
			--
			-- `a_widget': The widget to initialize of build upon.
		local
			l_vbox: EV_VERTICAL_BOX
			l_buffer: EV_PIXEL_BUFFER
		do
			create l_vbox

				-- Icon
			l_buffer := stock_pixmaps.general_error_icon_buffer
			create icon.make_with_size (l_buffer.width, l_buffer.height)
			icon.set_minimum_size (l_buffer.width, l_buffer.height)
			register_kamikaze_action (icon.expose_actions, agent (a_buffer: EV_PIXEL_BUFFER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
				do
					check
						is_interface_usable: is_interface_usable
						is_initialized: is_initialized
					end
					icon.draw_sub_pixel_buffer (0, 0, a_buffer, create {EV_RECTANGLE}.make (0, 0, a_buffer.width, a_buffer.height))
				end (l_buffer, ?, ?, ?, ?))

			l_vbox.extend (icon)
			l_vbox.disable_item_expand (icon)
			l_vbox.extend (create {EV_CELL})

			a_widget.extend (l_vbox)

				-- Label
			create label
			label.align_text_left
			a_widget.extend (label)

				-- Register the select actions
			propagate_register_action (a_widget, agent {EV_WIDGET}.pointer_button_release_actions, agent on_pointer_pressed, Void)
		end

	on_before_initialize
			-- Use to perform additional creation initializations, before the UI has been created.
			-- Note: No user interface initialization should be done here! Use `build_widget_interface' instead
		do
			create select_actions

			Precursor {ES_WIDGET}
		end

feature -- Access

	text: !STRING_32
			-- Text, as displayed on the label.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			create Result.make_from_string (label.text.as_string_32)
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL)
			-- Set error message text.
			--
			-- `a_text': The message text to set on the label.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
		do
			label.set_text (a_text)
			if is_shown then
				label.refresh_now
			end
		ensure
			text_set: a_text.as_string_32.is_equal (text)
		end

feature {NONE} -- User interface elements

	icon: !EV_PIXMAP
			-- Error icon.

	label: !EV_LABEL
			-- Label shown as error message.

feature -- Actions

	select_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions called when the widget is selected.

feature {NONE} -- Actions handlers

	on_pointer_pressed (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Called when the pointer is pressed anywhere in the widget structure.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if a_button = 1 then
				select_actions.call (Void)
			end
		end

feature {NONE} -- Factory

	create_widget: !EV_HORIZONTAL_BOX
			-- Creates a new widget, which will be initialized when `build_interface' is called.
		do
			create Result
			Result.set_border_width ({ES_UI_CONSTANTS}.vertical_padding)
			Result.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
