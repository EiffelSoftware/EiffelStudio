note
	description: "Foundations extension for Estudio debug menu ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_EXTENSION_FOUNDATIONS

inherit
	ESTUDIO_DEBUG_EXTENSION
		redefine
			new_menu_item
		end

	SYSTEM_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Execution

	execute
		do
		end

	build_debug_sub_menu (a_menu: EV_MENU)
			-- Builds the debug submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: EV_MENU_ITEM
			l_check_menu_item: EV_CHECK_MENU_ITEM
		do
			create l_check_menu_item.make_with_text_and_action ("Non Discardable Prompts", agent on_toggle_discardable_prompts)
			if discardable_overrides.is_non_discardable then
				l_check_menu_item.enable_select
			end
			l_menu_item := l_check_menu_item
			a_menu.extend (l_menu_item)
		end

feature {NONE} -- Actions

	on_toggle_discardable_prompts
			-- Toggles the state of non-discardable prompts (makes discardable prompts non-discardable)
		local
			l_overrides: like discardable_overrides
		do
			l_overrides := discardable_overrides
			l_overrides.is_non_discardable := not l_overrides.is_non_discardable
		end

feature {NONE} -- Access

	frozen discardable_overrides: ES_DISCARDABLE_PROMPT_OVERRIDES
			-- Access to discardable overrides
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature -- Access

	menu_path: ARRAY [STRING]
		do
			Result := <<"Foundations">>
		end

feature {NONE} -- Implementation

	new_menu_item (a_title: STRING): EV_MENU
		do
			Result := imp_new_menu_item (a_title)
			build_debug_sub_menu (Result)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
