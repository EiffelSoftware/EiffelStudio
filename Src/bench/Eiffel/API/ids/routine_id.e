indexing
	description:	"Routine identifiers.";
	date: "$Date$";
	revision: "$Revision $"

class ROUTINE_ID

inherit
	COMPILER_ID
		export
			{COMPILER_EXPORTER} all;
			{ANY} is_equal
		end

	ENCODER
		export
			{NONE} all
		end

creation
	make

feature {COMPILER_EXPORTER} -- Status report

	is_attribute: BOOLEAN is
			-- Is the current id an attribute id?
			-- (routine id otherwise)
		do
		end;

feature {COMPILER_EXPORTER} -- Access

	table_name: STRING is
			-- Name of a table of data for the final Eiffel executable.
			-- It is either a name of a routine table or an attribute
			-- offset table name.
		local
			buff: STRING
		do
			Result := clone (prefix_name);
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
			Result := clone (prefix_name);
			buff := Buffer;
			eif101 ($buff, internal_id);
			Result.append (Buffer)
		end;

feature {NONE} -- Implementation

	counter: ROUTINE_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Routine_id_counter.item (Normal_compilation)
		end;

	prefix_name: STRING is
			-- Prefix for generated C function and table names
		once
			Result := counter.prefix_name
		end

end -- class ROUTINE_ID
