indexing
	description: "Serialize Codedom passed as argument to be reused in tests"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_DOTNET_SERIALIZER

inherit
	ECDS_SHARED_SETTINGS
		export
			{NONE} all
		end

feature -- Basic Operations

	serialize (a_graph: SYSTEM_OBJECT) is
			-- Serialize object graph `a_graph'.
		require
			non_void_graph: a_graph /= Void
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
			l_file_name, l_name, l_root, l_extension: STRING
			l_index, i: INTEGER
			l_exists: BOOLEAN
		do
			l_file_name := serialized_tree_location
			l_index := l_file_name.last_index_of ('.', l_file_name.count)
			if l_index > 0 then
				l_root := l_file_name.substring (1, l_index - 1)
				l_extension := l_file_name.substring (l_index, l_file_name.count)
			else
				l_root := l_file_name.twin
				l_extension := ""
			end
			from
				l_exists := (create {RAW_FILE}.make (l_file_name)).exists
				i := 1
			until
				not l_exists
			loop
				i := i + 1
				l_file_name := l_root + "_" + i.out + l_extension
				l_exists := (create {RAW_FILE}.make (l_file_name)).exists
			end
			create l_stream.make (l_file_name, {FILE_MODE}.Create_)
			create l_formatter.make
			l_formatter.serialize (l_stream, a_graph)
			l_stream.close
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
end -- class ECDS_DOTNET_SERIALIZER
