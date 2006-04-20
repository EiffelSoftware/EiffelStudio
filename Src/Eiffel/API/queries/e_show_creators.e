indexing
	description: "Command to display class creation procedures of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class E_SHOW_CREATORS

inherit
	E_CLASS_FORMAT_CMD
	
create
	make, default_create

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		local
			l_creators: HASH_TABLE [EXPORT_I, STRING]
		do
				-- Note that this is not the most efficient way to know if `f'
				-- is a creation routine, as the quicked way would be to iterate
				--  through `current_class.creators', but this enables the reuse
				-- of the existing framework.
			l_creators := current_class.creators
			if l_creators = Void then
					-- Simply search for the version of `{ANY}.default_create'.
				Result := f.rout_id_set.has (eiffel_system.system.default_create_id)
			elseif not l_creators.is_empty then
				Result := l_creators.has (f.name)
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
