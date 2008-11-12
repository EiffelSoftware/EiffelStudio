indexing
	description: "[
			A {EV_TEXTABLE} widget which has it's text limited to a formattable input.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_RESTRICTED_TEXTABLE_WIDGET [G -> EV_TEXT_COMPONENT]

inherit
	ES_WIDGET [G]
		rename
			make as make_widget
		end

create
	make

convert
	widget: {EV_WIDGET, !EV_WIDGET}

feature {NONE} -- Initialization

	make (a_widget: !G; a_predicate: !like predicate; a_formatter: ?like format_function)
			-- Initializes a bordered widget with a existing widget.
			--
			-- `a_widget'   : The widget to restrict input of.
			-- `a_predicate': A predicate function, returning True when the passed text is valid input.
			-- `a_formatter': A function to format the input.
		require
			not_a_widget_is_destroyed: not a_widget.is_destroyed
			not_a_widget_is_parented: not a_widget.has_parent
		do
			predicate := a_predicate
			format_function := a_formatter
			internal_widget := a_widget
			make_widget
		ensure
			widget_set: widget ~ a_widget
			predicate_set: predicate ~ a_predicate
			format_function_set: format_function ~ a_formatter
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

	build_widget_interface (a_widget: !G)
			-- <Precursor>
		do
			--a_widget.set_default_key_processing_handler (agent on_handle_default_key_processing)
			register_action (a_widget.change_actions, agent on_text_changed)
		end

feature -- Access

	predicate: !PREDICATE [ANY, TUPLE [text: !STRING_32]]
			-- A predicate used to determine if the changed text is valid for the textable widget

	format_function: ?FUNCTION [ANY, TUPLE [!STRING_32], !STRING_32]
			-- The optional function used to format the entered text

feature {NONE} -- Access

	old_text: ?STRING_32
			-- The preserved old text value of the set widget.

	old_caret_position: INTEGER
			-- The preserved old caret position of the set widget.

feature {NONE} -- Action handlers

	on_text_changed
			-- Called when the widget's text has changed
		require
			is_interface_usable: is_interface_usable
		local
			l_text: STRING_32
			l_old_text: ?like old_text
			l_function: ?like format_function
		do
			l_text := widget.text
			if l_text /= Void then
				l_function := format_function
				if l_function /= Void then
					l_text := l_function.item ([l_text])
				end

				l_old_text := old_text
				if l_old_text = Void or else not l_old_text.same_string (l_text) then
					if predicate.item ([l_text]) then
						old_text := l_text.twin
						old_caret_position := widget.caret_position
						widget.set_text (l_text)
						widget.set_caret_position (old_caret_position)
					elseif l_old_text /= Void then
						widget.set_text (l_old_text)
						widget.set_caret_position (old_caret_position)
					else
						widget.set_text ("")
					end
				end
			end
		end

feature {NONE} -- Factory

	create_widget: !G
			-- <Precrsor>
		do
			Result := internal_widget
		end

feature {NONE} -- Implementation: Internal cache

	internal_widget: !G
			-- Cached version of `widget'.
			-- Note: Do not use directly!

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
