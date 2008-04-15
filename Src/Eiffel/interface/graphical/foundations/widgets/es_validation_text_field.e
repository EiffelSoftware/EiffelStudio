indexing
	description: "[
		A widget wrapper to give text fields ({EV_TEXT_FIELD}) validation capabilities.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_VALIDATION_TEXT_FIELD

inherit
	ES_WIDGET [EV_HORIZONTAL_BOX]
		rename
			make as make_widget
		redefine
			on_before_initialize
		end

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_text_field: !like text_field; a_function: !like validation_function)
			-- Initializes a validation text field.
			--
			-- `a_text_field': The text field to wrap.
			-- `a_function': The function action used to validated the text box
		require
			not_a_text_field_is_destroyed: not a_text_field.is_destroyed
			not_a_text_field_is_parented: not a_text_field.has_parent
		do
			original_foreground_color ?= a_text_field.foreground_color
			text_field := a_text_field
			validation_function := a_function
			make_widget
		ensure
			original_foreground_color_set: equal (a_text_field.foreground_color, original_foreground_color)
			text_field_set: text_field = a_text_field
			validation_function_set: validation_function = a_function
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

feature {NONE} -- User interface initialization

	build_widget_interface (a_widget: !EV_HORIZONTAL_BOX)
			-- <Precursor>
		do
			a_widget.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)
			a_widget.extend (text_field)
			register_action (text_field.change_actions, agent on_text_field_changed)

			validation_pixmap ?= stock_pixmaps.general_error_icon.twin
			validation_pixmap.set_minimum_size (16, 16)
			a_widget.extend (validation_pixmap)
			a_widget.disable_item_expand (validation_pixmap)
		end

	on_before_initialize
			-- <Precursor>
		do
			is_valid := True
			create valid_state_changed_event
			Precursor
		end

feature -- Access

	text: !STRING_32 assign set_text
			-- Actual text
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_text: STRING_32
		do
			l_text := text_field.text
			if l_text /= Void then
				Result ?= l_text
			else
				create Result.make_empty
			end
		end

feature -- Element change

	set_text (a_text: !like text)
			-- Set field text
		do
			text_field.set_text (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Indicates if the text in the text box is valid.

feature -- Basic operations

	validate
			-- Forces a validation. This should be called by the client to set the initial validation state
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			on_text_field_changed
		end

feature -- Events

	valid_state_changed_event: !EVENT_TYPE [TUPLE [is_valid: BOOLEAN]]
			-- Event published when the valid state of Current changes.

feature -- User interface elements

	text_field: !EV_TEXT_FIELD
			-- Actual text field.

feature {NONE} -- User interface elements

	validation_pixmap: !EV_PIXMAP
			-- Validation pixmap to show when not validated.

	validation_function: !FUNCTION [ANY, TUPLE [!STRING_32], !TUPLE [is_valid: BOOLEAN; reason: ?STRING_32]]
			-- Function used to validate the entered text.

	original_foreground_color: !EV_COLOR
			-- Original text field forground color.

feature {NONE} -- Action handlers

	on_text_field_changed
			-- Called when the text field changes
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_item: !TUPLE [is_valid: BOOLEAN; reason: ?STRING_32]
			l_old_is_valid: like is_valid
		do
			l_old_is_valid := is_valid
			l_item := validation_function.item ([text])
			is_valid := l_item.is_valid
			if is_valid then
				validation_pixmap.hide
				text_field.set_foreground_color (original_foreground_color)
			else
				validation_pixmap.show
				text_field.set_foreground_color (colors.high_priority_foreground_color)
				if l_item.reason = Void or else l_item.reason.is_empty then
					validation_pixmap.set_tooltip ("The entered value is invalid.")
				else
					validation_pixmap.set_tooltip ("The entered value is invalid: " + l_item.reason)
				end
			end

			if l_old_is_valid /= is_valid then
					-- Publish events
				valid_state_changed_event.publish ([is_valid])
			end
		end

feature {NONE} -- Factory

	create_widget: !EV_HORIZONTAL_BOX
			-- <Precursor>
		do
			create Result
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
