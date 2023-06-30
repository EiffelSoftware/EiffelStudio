note
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

	get_from_application (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- Get `a_var' as if we were `a_app'.
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
		local
			l_constants: EIFFEL_CONSTANTS
			v: STRING
		do
			Result := item (a_var)
			if Result = Void then
				create l_constants
				create v.make (5)
				v.append (l_constants.two_digit_minimum_major_version)
				v.append_character ('.')
				v.append (l_constants.two_digit_minimum_minor_version)
				Result := application_item (a_var, a_app, v)
			end
		end

	application_item (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: STRING): detachable STRING_32
			-- Variable `a_var' as if we were `a_app' for version `a_version` (formatted as MM.mm).
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
			a_version_ok: a_version /= Void and then not a_version.is_whitespace
		do
			Result := item (a_var)
			if Result = Void then
				Result := application_item_from_settings (a_var, a_app, a_version)
			end
		end

	application_item_from_settings (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: STRING): detachable STRING_32
			-- Variable `a_var' as if we were `a_app' for version `a_version` (formatted as MM.mm).
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
			a_version_ok: a_version /= Void and then not a_version.is_whitespace
		local
			l_reg: WEL_REGISTRY
			l_key: detachable WEL_REGISTRY_KEY_VALUE
			l_eiffel: STRING_32
			l_lowered_var: READABLE_STRING_GENERAL
		do
			l_lowered_var := a_var.as_lower
			if {EIFFEL_ENV}.is_workbench then
				l_eiffel := {STRING_32} "\SOFTWARE\ISE\" + {EIFFEL_ENV}.Wkbench_suffix + {STRING_32} "\Eiffel_" + a_version
			else
				l_eiffel := {STRING_32} "\SOFTWARE\ISE\Eiffel_" + a_version
			end
			create l_reg
			if a_app /= Void then
					-- Lookup application-specific setting.
				l_key := l_reg.open_key_value ({STRING_32} "HKEY_CURRENT_USER" + l_eiffel + {STRING_32} "\" + a_app.to_string_32, l_lowered_var)
				if l_key = Void then
					l_key := l_reg.open_key_value ({STRING_32} "HKEY_LOCAL_MACHINE" + l_eiffel + {STRING_32} "\" + a_app.to_string_32, l_lowered_var)
				end
			end
			if l_key = Void then
					-- Lookup general setting.
				l_key := l_reg.open_key_value ({STRING_32} "HKEY_CURRENT_USER" + l_eiffel, l_lowered_var)
				if l_key = Void then
					l_key := l_reg.open_key_value ({STRING_32} "HKEY_LOCAL_MACHINE" + l_eiffel, l_lowered_var)
				end
			end
			if l_key /= Void then
				Result := l_key.string_value
			end
		end

	installed_product_version_names (env: EIFFEL_ENV): detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
		local
			l_reg: WEL_REGISTRY
			l_es_root_keyname: STRING_32
			p: POINTER
			l_key_path: STRING_32
			i,n: INTEGER
		do
			l_es_root_keyname := {STRING_32} "\SOFTWARE\ISE"
			if {EIFFEL_ENV}.is_workbench then
				l_es_root_keyname.append_character ('\')
				l_es_root_keyname.append_string_general ({EIFFEL_ENV}.wkbench_suffix)
			end
			create l_reg
			l_key_path := {STRING_32} "HKEY_CURRENT_USER" + l_es_root_keyname
			p := l_reg.open_key_with_access (l_key_path, l_reg.key_read)
			if p.is_default_pointer then
				l_key_path := {STRING_32} "HKEY_LOCAL_MACHINE" + l_es_root_keyname
				p := l_reg.open_key_with_access (l_key_path, l_reg.key_read)
			end
			if p.is_default_pointer then
					-- Not found!
			else
				n := l_reg.number_of_subkeys (p)
				if n > 0 then
					create Result.make (n)
					from
						i := 1
					until
						i > n
					loop
						if attached l_reg.enumerate_key (p, i - 1) as k then
							if k.name.same_string ({EIFFEL_ENV}.wkbench_suffix) then
									-- Ignore
							else
								Result.force (k.name)
							end
						end
						i := i + 1
					end
				end
			end
		end

feature -- Environment change

	set_application_item (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: STRING; a_value: detachable READABLE_STRING_GENERAL)
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
			l_eiffel := {STRING_32} "\SOFTWARE\ISE\Eiffel_" + a_version
			create l_reg

			create kn.make_from_string_general ("HKEY_CURRENT_USER")
			kn.append (l_eiffel)

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
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
