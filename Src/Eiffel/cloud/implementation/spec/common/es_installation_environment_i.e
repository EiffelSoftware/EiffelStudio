note
	description: "Summary description for {ES_INSTALLATION_ENVIRONMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INSTALLATION_ENVIRONMENT_I

feature {NONE} -- Creation

	make (env: EIFFEL_ENV)
		do
			eiffel_env := env
		end

	eiffel_env: EIFFEL_ENV

feature -- Access

	c_compiler_info: detachable STRING_8
			-- Information about the C compiler if any.
		do
			Result := eiffel_env.eiffel_c_compiler
			if
				attached eiffel_env.eiffel_c_compiler_version as s and then
				not s.is_whitespace
			then
				if Result = Void then
					Result := s
				else
					if not Result.is_empty then
						Result.append_character ('.')
					end
					Result.append (s)
				end
			end
			if Result /= Void and then Result.is_whitespace then
				Result := Void
			end
		end

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

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
