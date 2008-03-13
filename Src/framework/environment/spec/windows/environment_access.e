indexing
	description: "Access environment variables which takes default values in the registry into account."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENVIRONMENT_ACCESS

inherit
	EXECUTION_ENVIRONMENT

feature -- Access

	get_from_application (a_var, a_app: STRING): STRING is
			-- Get `a_var' as if we were `a_app'.
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app /= Void and then not a_app.has ('%U')
		local
			l_reg: WEL_REGISTRY
			l_key: WEL_REGISTRY_KEY_VALUE
			l_s32: STRING_32
			l_eiffel: STRING
		do
			Result := get (a_var)
			if Result = Void then
				l_eiffel := "\Software\ISE\Eiffel" + {EIFFEL_ENVIRONMENT_CONSTANTS}.major_version.out + {EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version.out
				create l_reg
				l_key := l_reg.open_key_value ("hkey_current_user"+l_eiffel+"\" + a_app, a_var.as_lower)
				if l_key = Void then
					l_key := l_reg.open_key_value ("hkey_local_machine"+l_eiffel+"\" + a_app, a_var.as_lower)
					if l_key = Void then
						l_key := l_reg.open_key_value ("hkey_current_user"+l_eiffel, a_var.as_lower)
						if l_key = Void then
							l_key := l_reg.open_key_value ("hkey_local_machine"+l_eiffel, a_var.as_lower)
						end
					end
				end
				if l_key /= Void then
					l_s32 := l_key.string_value
					if l_s32 /= Void then
						Result := l_s32.as_string_8
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
