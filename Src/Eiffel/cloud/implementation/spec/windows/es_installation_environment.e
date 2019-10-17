note
	description: "Summary description for {ES_INSTALLATION_ENVIRONMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INSTALLATION_ENVIRONMENT

create
	make

feature {NONE} -- Creation

	make (env: EIFFEL_ENV)
		do
			eiffel_env := env
		end

	eiffel_env: EIFFEL_ENV

feature -- Access

	username: detachable STRING_32
		do
			Result := eiffel_env.get_environment_32 ("USERNAME")
			if Result = Void then
				Result := eiffel_env.get_environment_32 ("USER")
				if Result = Void then
					Result := eiffel_env.get_environment_32 ("LOGNAME")
				end
			end
		end

	device_name: STRING_32
		do
			if attached eiffel_env.get_environment_32 ("COMPUTERNAME") as n then
				Result := n
			else
				Result := {STRING_32} "unknown"
			end
		end

	application_item (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: detachable STRING): detachable STRING_32
			-- Variable `a_var' as if we were `a_app' for version `a_version` (formatted as MM.mm).
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
			a_version_ok: a_version /= Void implies not a_version.is_whitespace
		local
			l_reg: WEL_REGISTRY
			l_key: detachable WEL_REGISTRY_KEY_VALUE
			l_eiffel: STRING_32
			l_lowered_var: READABLE_STRING_GENERAL
		do
			l_lowered_var := a_var.as_lower
			if a_version /= Void then
				l_eiffel := {STRING_32} "\SOFTWARE\ISE\Eiffel_" + a_version
			else
				l_eiffel := {STRING_32} "\SOFTWARE\ISE\Eiffel_" + eiffel_env.version_name
			end
			create l_reg

			if a_app /= Void then
					-- Lookup application-specific setting.
				l_key := l_reg.open_key_value ({STRING_32} "HKEY_CURRENT_USER" + l_eiffel + {STRING_32} "\installation\" + a_app.to_string_32, l_lowered_var)
			else
				l_key := l_reg.open_key_value ({STRING_32} "HKEY_CURRENT_USER" + l_eiffel + {STRING_32} "\installation" , l_lowered_var)
			end
			if l_key /= Void then
				Result := l_key.string_value
			end
		end

feature -- Element change

	set_application_item (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: detachable STRING; a_value: READABLE_STRING_GENERAL)
			-- Set value `a_value` in variable `a_var` as if we were `a_app` for version `a_version` (formatted as MM.mm).
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
			a_version_ok: a_version /= Void implies not a_version.is_whitespace
		local
			l_reg: WEL_REGISTRY
			l_eiffel: STRING_32
			l_lowered_var: READABLE_STRING_GENERAL
			val: WEL_REGISTRY_KEY_VALUE
			kn: STRING_32
		do
			l_lowered_var := a_var.as_lower
			if a_version /= Void then
				l_eiffel := {STRING_32} "\SOFTWARE\ISE\Eiffel_" + a_version
			else
				l_eiffel := {STRING_32} "\SOFTWARE\ISE\Eiffel_" + eiffel_env.version_name
			end
			create l_reg


			create kn.make_from_string_general ("HKEY_CURRENT_USER")
			kn.append (l_eiffel)
			kn.append_string_general ("\installation")

			if a_app /= Void then
					-- Lookup application-specific setting.
				kn.extend ('\')
				kn.append_string_general (a_app)
			end
			if a_value /= Void then
				create val.make ({WEL_REGISTRY_KEY_VALUE}.reg_sz, a_value)
				l_reg.save_key_value (kn, l_lowered_var, val)
			else
				l_reg.delete_key_value (kn, l_lowered_var)
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
