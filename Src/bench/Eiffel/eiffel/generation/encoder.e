indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Encoder of C generate names

class ENCODER 

feature -- Name generation

	feature_name (type_id: INTEGER; body_index: INTEGER): STRING is
			-- Name of an Eiffel feature belonging to type of id
			-- `type_id' and of body index
		require
			type_id_not_void: type_id > 0
		do
			Result := Feature_buffer;
			eif000 ($Result, type_id, body_index);
		end

	table_name (rout_id: INTEGER): STRING is
			-- Name of a table of data for the final Eiffel executable.
			-- It is either a name of a routine table or an attribute
			-- offset table name.
		do
			Result := Table_buffer;
			eif011 ($Result, rout_id);
		end;

	type_table_name (rout_id: INTEGER): STRING is
			-- Name of a type table associated to an attribute offset or 
			-- routine table. Useful for creation generation.
		do
			Result := Type_table_buffer
			eif101 ($Result, rout_id)
		end

	address_table_name (feature_id: INTEGER; type_id: INTEGER): STRING is
			-- Name of a table of function pointers used by then
			-- $ operator
		do
			Result := Address_table_buffer;
			eif000 ($Result, type_id, feature_id);
		end

	generate_type_id_name (type_id: INTEGER): STRING is
			-- Textual representation of static type id
			-- used in generated C code
		do
			Result := (type_id - 1).out
		ensure
			generated_id_not_void: Result /= Void
		end

	init_name (type_id: INTEGER): STRING is
			-- Name of the descriptors Init function associated
			-- with current type
		do
			create Result.make (10);
			Result.append ("Init");
			Result.append (type_id.out)
		end

	module_init_name (type_id: INTEGER): STRING is
			-- Name of the init procedure of the C module 
			-- associated with current type
		do
			create Result.make (15);
			Result.append ("EIF_Minit");
			Result.append (type_id.out)
		end

feature {NONE}

	Address_table_buffer: STRING is
			-- String buffer for address table generation
		once
			create Result.make (7)
			Result.append ("A000000")
		end
	
	Feature_buffer: STRING is
			-- String buffer for feature generation.
		once
			create Result.make (7)
			Result.append ("F000000")
		end
	
	Table_buffer: STRING is
			-- String buffer for feature generation.
		once
			create Result.make (7)
			Result.append ("T000000")
		end
	
	Type_table_buffer: STRING is
			-- String buffer for feature generation.
		once
			create Result.make (7)
			Result.append ("Y000000")
		end

feature {NONE} -- External features

	eif000 (s: POINTER; i,j: INTEGER) is
		external
			"C"
		end

	eif101 (s: POINTER; i: INTEGER) is
		external
			"C"
		end

	eif011 (s: POINTER; i: INTEGER) is
		external
			"C"
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

end
