-- Routine Ids

class ROUTINE_ID

inherit

	COMPILER_ID

creation

	make

feature -- Status report

	is_attribute: BOOLEAN is
			-- Is the current id an attribute id?
			-- (routine id otherwise)
		do
		end;

feature -- Access

	table_name: STRING is
			-- Name of a table of data for the final Eiffel executable.
			-- It is either a name of a routine table or an attribute
			-- offset table name.
		local
			buff: STRING
		do
			Result := clone (prefix_string);
			buff := Buffer;
			eif011 ($buff, internal_id);
			Result.append (Buffer)
		end;

	type_table_name: STRING is
			-- Name of a type table associated to an attribute offset or 
			-- routine table. Useful for creation generation.
		local
			buff: STRING
		do
			Result := clone (prefix_string);
			buff := Buffer;
			eif101 ($buff, internal_id);
			Result.append (Buffer)
		end;

feature {NONE} -- Implementation

	counter: COMPILER_SUBCOUNTER [ROUTINE_ID] is
			-- Counter associated with the id
		do
			Result := System.routine_id_counter.item (compilation_id)
		end;

end -- class ROUTINE_ID
