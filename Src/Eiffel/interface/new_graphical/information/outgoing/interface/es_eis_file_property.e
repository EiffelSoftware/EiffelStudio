note
	description: "EIS file property with completable text field"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_FILE_PROPERTY

inherit
	FILE_PROPERTY
		rename
			make as make_property
		redefine
			text_field,
			activate_action
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_provider: like variable_provider)
			-- Initialization
		require
			a_name_not_void: a_name /= Void
			a_provider_not_void: a_provider /= Void
		do
			make_property (a_name)
			variable_provider := a_provider
		end

feature {NONE} -- Access

	text_field: ES_EIS_COMPLETABLE_TEXT_FIELD

feature {NONE} -- Implementation

	activate_action (a_popup_window: EV_POPUP_WINDOW)
			-- Activate action.
		do
			Precursor (a_popup_window)
			if is_text_editing and then attached text_field as l_text_field then
				l_text_field.set_tooltip (names.t_show_variable_suggestion)
				l_text_field.set_completion_possibilities_provider (variable_provider)
				l_text_field.set_preferred_width_agent (agent l_text_field.width)
				variable_provider.set_code_completable (l_text_field)
			end
		end

	variable_provider: COMPLETION_POSSIBILITIES_PROVIDER
			-- Provider

invariant
	variable_provider_set: variable_provider /= Void

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
