indexing
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

	completion_provider: !COMPLETION_POSSIBILITIES_PROVIDER assign set_completion_provider
			-- Completion provider for completion text boxes

feature -- Status report

	set_completion_provider (a_provider: !like completion_provider)
			-- Sets the completion provider for the text boxes
			--
			-- `a_provider': A completion provider
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			completion_provider := a_provider
			declaration_text_fields.do_all (agent (ia_item: !EV_TEXT_FIELD; ia_provider: !like completion_provider)
				do
					if {l_completable: CODE_COMPLETABLE} ia_item then
							-- Set completion provider on a code completable text field
						l_completable.set_completion_possibilities_provider (ia_provider)
						register_action (ia_item.focus_in_actions, agent ia_provider.set_code_completable (l_completable))
					end
				end (?, a_provider))
		ensure
			completion_provider_set: completion_provider = a_provider
		end

feature {NONE} -- Factory

	create_declaration_text_widget (a_declaration: !CODE_DECLARATION): !EV_TEXT_FIELD
			-- <Precursor>
		do
			create {EB_CODE_COMPLETABLE_TEXT_FIELD} Result.make
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
