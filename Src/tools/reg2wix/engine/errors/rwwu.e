note
	description: "[
		Warning to describe the use of unsupported registry named value types.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	RWWU

inherit
	ERROR_FILE_WARNING_INFO

create
	make

feature {NONE} -- Initialization

	make (a_file: like file_name; a_type: like type)
			--
		require
			a_file_attached: a_file /= Void
			not_a_file_is_empty: not a_file.is_empty
			a_type_attached: a_type /= Void
			not_a_type_is_empty: not a_type.is_empty
		do
			make_with_context ([a_type])
			file_name := a_file
			type := a_type
		ensure
			file_name_set: file_name = a_file
			type_set: type = a_type
		end

feature -- Access

	type: STRING
			-- Unsupported type

feature {NONE} -- Access

	dollar_description: STRING = "Use of unsupported registry type '{1}'. No WiX data will be generated for this entry"
			-- Dollar encoded description. ${n} are replaced by array indicies.

invariant
	file_name_attached: file_name /= Void
	not_file_name_is_empty: not file_name.is_empty
	type_attached: type /= Void
	not_type_is_empty: not type.is_empty

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
