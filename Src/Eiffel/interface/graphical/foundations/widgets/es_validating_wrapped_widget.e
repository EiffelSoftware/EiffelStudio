note
	description: "[
		A widget wrapper to give text fields ({EV_TEXT_FIELD}/{EV_COMBO_BOX}) validation capabilities.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_VALIDATING_WRAPPED_WIDGET

inherit
	ES_WIDGET [EV_HORIZONTAL_BOX]
		rename
			make as make_widget
		redefine
			internal_detach_entities,
			on_before_initialize
		end

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_text_field: like text_field; a_function: attached like entry_error_function)
			-- Initializes a validation text field.
			--
			-- `a_text_field': The text field to wrap.
			-- `a_function': The function action used to validated the text box
		require
			not_a_text_field_is_destroyed: not a_text_field.is_destroyed
			not_a_text_field_is_parented: not a_text_field.has_parent
		do
			original_foreground_color := a_text_field.foreground_color
			text_field := a_text_field
			entry_error_function := a_function
			make_widget
		ensure
			original_foreground_color_set: is_valid implies a_text_field.foreground_color ~ original_foreground_color
			text_field_set: text_field = a_text_field
			entry_error_function_set: entry_error_function = a_function
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

feature {NONE} -- Initialization: User interface

	build_widget_interface (a_widget: EV_HORIZONTAL_BOX)
			-- <Precursor>
		do
			a_widget.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)
			a_widget.extend (text_field)
			register_action (text_field.change_actions, agent on_text_field_changed)

			validation_pixmap := stock_pixmaps.general_error_icon.twin
			validation_pixmap.set_minimum_size (16, 16)
			a_widget.extend (validation_pixmap)
			a_widget.disable_item_expand (validation_pixmap)
		end

	on_before_initialize
			-- <Precursor>
		do
			is_valid := True
			Precursor
		end

feature {NONE} -- Clean up

	internal_detach_entities
			-- <Precursor>
		do
			Precursor
			entry_error_function := Void
			entry_validation := Void
			entry_formatter := Void
		ensure then
			entry_error_function_detached: entry_error_function = Void
			entry_validation_detached: entry_validation = Void
			entry_formatter_detached: entry_formatter = Void
		end

feature -- Access

	text: STRING_32 assign set_text
			-- Actual text
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if attached text_field.text as l_text then
				Result := l_text
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Access

	old_text: detachable STRING_32
			-- The preserved old text value of the set widget.

	old_caret_position: INTEGER
			-- The preserved old caret position of the set widget.

feature -- Access: Validataion and formatting

	entry_error_function: detachable FUNCTION [STRING_32, TUPLE [is_valid: BOOLEAN; reason: detachable STRING_32]]
			-- Function used to validate the entered text, which upon failing will display an error message.

	entry_validation: detachable PREDICATE [TUPLE [text: STRING_32]] assign set_entry_validation
			-- An optional predicate used to determine if the changed text is valid for the widget.
			-- Note: This differs from `entry_error_function' because text will be disallowed where
			--       as the `entry_error_function' will allow text but display an error.

	entry_formatter: detachable FUNCTION [STRING_32, STRING_32] assign set_entry_formatter
			-- An optional function used to format the entered text.

feature -- User interface elements

	text_field: EV_TEXT_FIELD
			-- Actual text field.

feature {NONE} -- User interface elements

	validation_pixmap: EV_PIXMAP
			-- Validation pixmap to show when not validated.

	original_foreground_color: EV_COLOR
			-- Original text field forground color.

feature -- Element change

	set_text (a_text: like text)
			-- Set field text.
			--
			-- `a_text': The new text to set.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			text_field.set_text (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end

feature -- Element change

	set_entry_validation (a_predicate: like entry_validation)
			-- Set/reset a new entry validation predication to ensure only specific text can be inserted
			-- into the text field.
			--
			-- `a_predicate': A new predication function to test the validity of a piece of entered text,
			--                or Void to remove the predicate.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			entry_validation := a_predicate
			if is_initialized and then widget.has_parent then
				on_text_field_changed
			end
		ensure
			entry_validation_set: entry_validation = a_predicate
		end

	set_entry_formatter (a_function: like entry_formatter)
			-- Set/reset a new entry formatting function to manipulate any entered test to a desired form.
			--
			-- `a_function': A new formatting function manipulate any entered text, or Void to remove
			--               the formatting.
		require
			is_interface_usable: is_interface_usable
		do
			entry_formatter := a_function
			if is_initialized and then widget.has_parent then
				on_text_field_changed
			end
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

feature -- Actions

	valid_state_changed_actions: ACTION_SEQUENCE [TUPLE [is_valid: BOOLEAN]]
			-- Event published when the valid state of Current changes.
		require
			is_interface_usable: is_interface_usable
		local
			l_result: like internal_valid_state_changed_actions
		do
			l_result := internal_valid_state_changed_actions
			if l_result = Void then
				create Result
				internal_valid_state_changed_actions := Result
				auto_recycle (Result)
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = internal_valid_state_changed_actions
		end

feature {NONE} -- Action handlers

	frozen on_text_field_changed
			-- Called when the widget's text has changed
		require
			is_interface_usable: is_interface_usable
		local
			l_old_text: like text
			l_text: like text
			l_actions: ACTION_SEQUENCE [TUPLE]
			l_running: BOOLEAN
		do
			l_actions := text_field.change_actions
			l_running := l_actions.state = l_actions.normal_state
			if l_running then
				l_actions.block
			end

			l_old_text := text
			internal_on_text_field_changed
			l_text := text

			if l_running then
				l_actions.resume
			end

			if l_text /~ l_old_text then
					-- Text changed
				l_actions.call (Void)
			end
		end

	internal_on_text_field_changed
			-- Called when the widget's text has changed
		require
			is_interface_usable: is_interface_usable
		local
			l_text: like text
			l_old_text: like old_text
			l_formatter: detachable like entry_formatter
			l_predicate: detachable like entry_validation
			l_item: TUPLE [is_valid: BOOLEAN; reason: detachable STRING_32]
			l_old_is_valid: like is_valid
			l_tooltip: STRING_32
			l_reason: detachable STRING_32
			l_actions: like internal_valid_state_changed_actions
		do
			l_text := text
			if l_text /= Void then
				l_formatter := entry_formatter
				if l_formatter /= Void then
					l_text := l_formatter.item ([l_text])
				end

				l_old_text := old_text
				if l_old_text = Void or else not l_old_text.same_string (l_text) then
					l_predicate := entry_validation
					if l_predicate = Void or else l_predicate.item ([l_text]) then
						old_text := l_text.twin
						old_caret_position := text_field.caret_position
						text_field.set_text (l_text)
						text_field.set_caret_position (old_caret_position)
					elseif l_old_text /= Void then
						text_field.set_text (l_old_text)
						text_field.set_caret_position (old_caret_position)
					else
						set_text (create {STRING_32}.make_empty)
					end
				end

				l_old_is_valid := is_valid
				l_item := entry_error_function.item ([l_text])
				is_valid := l_item.is_valid
				if is_valid then
					validation_pixmap.hide
					text_field.set_foreground_color (original_foreground_color)
				else
					validation_pixmap.show
					text_field.set_foreground_color (colors.high_priority_foreground_color)
					l_reason := l_item.reason
					if l_reason = Void or else l_reason.is_empty then
						l_tooltip := locale_formatter.translation (tt_invalid_entry)
						l_tooltip.append_string_general (".")
					else
						l_tooltip := locale_formatter.translation (tt_invalid_entry)
						l_tooltip.append_string_general (": ")
						l_tooltip.append_string_general (l_reason)
					end
					validation_pixmap.set_tooltip (l_tooltip)
				end

				if l_old_is_valid /= is_valid then
						-- Process actions
					l_actions := internal_valid_state_changed_actions
					if l_actions /= Void then
						l_actions.call ([is_valid])
					end
				end
			end
		end

feature {NONE} -- Factory

	create_widget: EV_HORIZONTAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Internationalization

	tt_invalid_entry: STRING = "The entered value is invalid"

feature {NONE} -- Implementation: Internal cache

	internal_valid_state_changed_actions: detachable like valid_state_changed_actions
			-- Cached version of `valid_state_changed_actions'.
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
