indexing
	description: "Objects that contains an external signature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SIGNATURE_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (args: like arguments; ret: EXTERNAL_TYPE_AS) is
			-- Create SIGNATURE_AS node
		do
			arguments := args
			return_type := ret
		ensure
			arguments_set: arguments = args
			return_type_set: return_type = ret
		end

feature -- Access

	arguments: ARRAYED_LIST [EXTERNAL_TYPE_AS]
			-- Arguments of external.

	return_type: EXTERNAL_TYPE_AS
			-- Return type of external if any.

feature -- Transformation

	arguments_id_array: ARRAY [INTEGER] is
			-- Array representation of `arguments'
		local
			list: like arguments
			i: INTEGER
		do
			if arguments /= Void then
				from
					list := arguments
					create Result.make (1, list.count)
					i := 1
					list.start
				until
					list.after
				loop
					Result.put (list.item.value_id, i)
					i := i + 1
					list.forth
				end
			end
		end

	return_type_id: INTEGER is
		do
			if return_type /= Void then
				Result := return_type.value_id
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class SIGNATURE_AS
