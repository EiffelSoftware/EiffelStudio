indexing
	description : "[
			IPC_ENGINE implementation
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IPC_ENGINE_IMP


inherit
	EXECUTION_ENVIRONMENT

feature -- Environment

	eif_getenv_from_app (vname, vapp: STRING): STRING is
		local
			reg: WEL_REGISTRY
			key: WEL_REGISTRY_KEY_VALUE
			l_major_version: STRING_8
			s32: STRING_32
		do
			Result := get (vname)
			if Result = Void then
				create reg
				key := reg.open_key_value ("hkey_current_user\Software\ISE\Eiffel57\" + vapp, vname.as_lower)
				if key = Void then
					key := reg.open_key_value ("hkey_local_machine\Software\ISE\Eiffel57\" + vapp, vname.as_lower)
				end
				if key /= Void then
					s32 := key.string_value
					if s32 /= Void then
						Result := s32.as_string_8
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
