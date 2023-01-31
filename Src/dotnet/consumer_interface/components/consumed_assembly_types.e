note
	description: "Table of consumed types for a given assembly"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY_TYPES

create
	make

feature {NONE} -- Initialization

	make (a_count: INTEGER)
			-- Create name arrays.
		require
			a_count_non_negative: a_count >= 0
		do
			create eiffel_names.make_filled (Void, a_count + 1)
			create dotnet_names.make_filled (Void, a_count + 1)
			create flags.make_filled (0, a_count + 1)
			create positions.make_filled (0, a_count + 1)
			create assembly_ids.make_filled (0, a_count + 1)
			count := a_count
		ensure
			count_set: count = a_count
		end

feature -- Access

	eiffel_names: SPECIAL [detachable STRING]
			-- Assembly types eiffel name

	dotnet_names: SPECIAL [detachable STRING]
			-- Assembly types .NET name

	flags: SPECIAL [INTEGER]
			-- Assembly types attributes (i.e. is type an interface an enum etc...)
			--| See class {TYPE_FLAGS} for possible values.

	positions: SPECIAL [INTEGER]
			-- Position of types.

	assembly_ids: SPECIAL [INTEGER]
			-- Potential assembly ids (for forwarded types).

	count: INTEGER
			-- Number of types.

	namespaces: ARRAY [STRING]
			-- Namespaces
		local
			i, l_index, l_count: INTEGER
			namespace: detachable STRING
			name: detachable STRING
			l_namespaces: ARRAYED_LIST [STRING]
		do
			create l_namespaces.make (count)
			l_namespaces.compare_objects
			from
				i := 1
				l_count := dotnet_names.upper
			until
				i > l_count
			loop
				name := dotnet_names.item (i)
				if name /= Void then
					-- `name' may be Void if basic types are encountered in mscorlib types.xml.
					l_index := name.last_index_of ('.', name.count)
				else
					l_index := 0
				end
				namespace := Void
				if name /= Void then
					namespace := name.substring (1, l_index - 1)
				end
				if namespace /= Void and then not l_namespaces.has (namespace) then
					l_namespaces.extend (namespace)
				end
				i := i + 1
			end
			Result := l_namespaces.to_array
				-- We compare by object to satisfy assertions.
			Result.compare_objects
		end

	namespace_types (namespace_name: STRING): ARRAY [INTEGER]
			-- Indices of types that belong to namespace `namespace_name'.
		require
			non_void_name: namespace_name /= Void
			valid_name: namespaces.has (namespace_name)
		local
			i, l_index, l_count: INTEGER
			name: detachable STRING
			l_types_index: ARRAYED_LIST [INTEGER]
		do
			create l_types_index.make (count)
			from
				i := 1
				l_count := dotnet_names.upper
			until
				i > l_count
			loop
				name := dotnet_names.item (i)
				if name /= Void then
					l_index := name.substring_index (namespace_name, 1)
					if l_index = 1 and then name.substring (namespace_name.count, name.count).occurrences ('.') = 1 then
						l_types_index.extend (i)
					end
				end
				i := i + 1
			end
			Result := l_types_index.to_array
		end

feature -- Element Settings	

	put (dn, en: STRING; int, enum, dele, val: BOOLEAN; a_pos: INTEGER)
			-- Add type with Eiffel name `en' and .NET name `dn'.
			-- type is interface if `int' is true, enum if `enum'
			-- is true, delegate if `dele' is true, deferred if
			-- `def' is true and value type if `val' is true.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		local
			flag: INTEGER
		do
			index := index + 1
			eiffel_names.put (en, index)
			dotnet_names.put (dn, index)
			positions.put (a_pos, index)
			if int then
				flag := {TYPE_FLAGS}.Is_interface
			elseif enum then
				flag := {TYPE_FLAGS}.Is_enum
			elseif dele then
				flag := {TYPE_FLAGS}.Is_delegate
			elseif val then
				flag := {TYPE_FLAGS}.Is_value_type
			end
			flags.put (flag, index)
			assembly_ids.put (0, index)
		ensure
			eiffel_name_inserted: eiffel_names.item (index) = en
			dotnet_name_inserted: dotnet_names.item (index) = dn
			position_inserted: positions.item (index) = a_pos
		end

	put_forwarded (dn, en: STRING; int, enum, dele, val: BOOLEAN; a_pos: INTEGER; a_assembly_id: INTEGER)
			-- Add forwarded type with Eiffel name `en' and .NET name `dn'.
			-- type is interface if `int' is true, enum if `enum'
			-- is true, delegate if `dele' is true, deferred if
			-- `def' is true and value type if `val' is true.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		do
			put (dn, en, int, enum, dele, val, a_pos)
			assembly_ids.put (a_assembly_id, index)
		ensure
			eiffel_name_inserted: eiffel_names.item (index) = en
			dotnet_name_inserted: dotnet_names.item (index) = dn
			assembly_id_inserted: assembly_ids.item (index) = a_assembly_id
			position_inserted: positions.item (index) = a_pos
		end

feature {NONE} -- Implementation

	index: INTEGER
			-- Number of items inserted so far in arrays

invariant
	eiffel_names_not_void: eiffel_names /= Void
	dotnet_names_not_void: dotnet_names /= Void
	positions_not_void: positions /= Void
	flags_not_void: flags /= Void
	eiffel_names_valid_count: eiffel_names.count > count
	dotnet_names_valid_count: dotnet_names.count > count
	positions_valid_count: positions.count > count
	flags_valid_count: flags.count > count
	count_non_negative: count >= 0
	valid_index: 0 <= index and index <= count

note
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
