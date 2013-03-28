note
	description: "[
		A code template builder dialog with completion capabilities.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CODE_COMPLETABLE_TEMPLATE_BUILDER_DIALOG

inherit
	ES_CODE_TEMPLATE_BUILDER_DIALOG
		redefine
			create_declaration_text_widget
		end

create
	make

feature -- Acccess

	completion_provider: attached COMPLETION_POSSIBILITIES_PROVIDER assign set_completion_provider
			-- Completion provider for completion text boxes

feature -- Status report

	set_completion_provider (a_provider: attached like completion_provider)
			-- Sets the completion provider for the text boxes
			--
			-- `a_provider': A completion provider
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			completion_provider := a_provider
			across declaration_text_fields as l_text_field loop
				if attached {CODE_COMPLETABLE} l_text_field.item as l_completable then
						-- Set completion provider on a code completable text field
					l_completable.set_completion_possibilities_provider (a_provider)
					register_action (l_text_field.item.focus_in_actions, agent a_provider.set_code_completable (l_completable))
				end
			end
		ensure
			completion_provider_set: completion_provider = a_provider
		end

feature {NONE} -- Factory

	create_declaration_text_widget (a_declaration: attached CODE_DECLARATION): attached EV_TEXT_FIELD
			-- <Precursor>
		do
			create {EB_CODE_COMPLETABLE_TEXT_FIELD} Result
		end

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
