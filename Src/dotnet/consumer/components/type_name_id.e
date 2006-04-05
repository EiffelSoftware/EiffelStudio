indexing
	description: "ID associated to a type CONSUMED_..."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	TYPE_NAME_ID

feature {NONE} -- Implementation

	types: ARRAY [STRING] is
			-- types to be serialized.
		once
			create Result.make (1, 20)
			Result.put ("CONSUMED_TYPE", 1)
			Result.put ("CONSUMED_PROPERTY", 2)
			Result.put ("CONSUMED_EVENT", 3)
			Result.put ("CONSUMED_PROCEDURE", 4)
			Result.put ("CONSUMED_FUNCTION", 5)
			Result.put ("CONSUMED_ARGUMENT", 6)
			Result.put ("CONSUMED_REFERENCED_TYPE", 7)
			Result.put ("CONSUMED_ASSEMBLY", 8)
			Result.put ("CACHE_INFO", 9)
			Result.put ("CONSUMED_CONSTRUCTOR", 10)
			Result.put ("CONSUMED_ASSEMBLY_INFO", 11)
			Result.put ("CONSUMED_FIELD", 12)
			Result.put ("CONSUMED_ASSEMBLY_TYPES", 13)
			Result.put ("CONSUMED_ASSEMBLY_MAPPING", 14)
			Result.put ("CONSUMED_ARRAY_TYPE", 15)
			Result.put ("STRING", 16)
			Result.put ("NONE", 17)
			Result.put ("CONSUMED_NESTED_TYPE", 18)
			Result.put ("CONSUMED_LITERAL_FIELD", 19)
			Result.put ("LOCAL_CACHE_INFO", 20)
		ensure
			non_void_types: Result /= Void
		end

	type_from_id (an_id: INTEGER): STRING is
			-- Type associated to `an_id'.
		require
			valid_id: Types.valid_index (an_id)
		do
			Result := types.item (an_id)
		ensure
			non_void_type: Result /= Void
			not_empty_type: not Result.is_empty
		end

	id_from_type (a_type: STRING): INTEGER is
			-- ID associated to `a_type'.
		require
			non_void_type: a_type /= Void
			type_exists: internal_id_type.has (a_type)
		do
			Result := Internal_id_type.item (a_type)
		ensure
			positive_id: Result > 0
		end

	internal_id_type: HASH_TABLE [INTEGER, STRING] is
		local
			i: INTEGER
		once
			from
				i := 1
				create Result.make (types.count)
			until
				i > types.count
			loop
				Result.put (i, types.item (i))
				i := i + 1
			end
		ensure
			non_void_internal_id_type: Result /= Void
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


end -- class TYPE_NAME_ID
