note
	description: "[
		A windows-specific implementation of a configuration cleaner, used to erase configuration data.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	WINDOWS_CLEANER

inherit
	CLEANER
		redefine
			path_provider
		end

create
	make

feature {NONE} -- Access

	path_provider: WINDOWS_PATH_PROVIDER
			-- Access to Eiffel related paths
		do
			Result ?= package.path_provider
		end

feature {NONE} -- Basic operations

	remove_preferences
			-- Removes preferences from the windows registry
		local
			l_path: STRING_8
			l_reg: WEL_REGISTRY
			l_key: POINTER
			l_items: LIST [STRING_8]
			retried: BOOLEAN
		do
			if not retried then
				l_path := path_provider.preferences_registy_path
				create l_reg
				l_key := l_reg.open_key_with_access (l_path, {WEL_REGISTRY_ACCESS_MODE}.key_all_access)
				if l_key /= default_pointer then
					l_items := l_reg.enumerate_values_as_string_8 (l_key)
					l_items.do_all (agent (a_item: STRING; a_reg: WEL_REGISTRY; a_parent: POINTER)
						do
							a_reg.delete_value (a_parent, a_item)
						end (?, l_reg, l_key))
				end
			else
				if l_path = Void then
					l_path := "Unable to retrieve path"
				end
				error_handler.add_error (create {ESC_C02}.make_with_context ([l_path]), False)
			end

			check l_reg_attached: l_reg /= Void end
			if l_key /= default_pointer then
				l_reg.close_key (l_key)
			end
		rescue
			retried := True
			retry
		end

;note
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
