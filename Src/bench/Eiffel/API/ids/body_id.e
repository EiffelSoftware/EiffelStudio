indexing
 
	description:
		"Feature body identifiers.";
	date: "$Date$";
	revision: "$Revision $"

class BODY_ID

inherit

	COMPILER_ID
		export
			{COMPILER_EXPORTER} all;
			{ANY} is_equal
		end;
	ENCODER
		export
			{NONE} all
		end

creation

	make

feature {COMPILER_EXPORTER} -- Access

	feature_name (type_id: TYPE_ID): STRING is
			-- Name of an Eiffel feature belonging to type of id
			-- `type_id' and of body id `Current'
		require
			type_id_not_void: type_id /= Void
		local
			buff: STRING
			old_body_id: INTEGER
		do
			Result := clone (prefix_name);
			Result.append (type_id.prefix_name);
			buff := Buffer;
			eif000 ($buff, type_id.internal_id, internal_id);
			Result.append (buff)
		end

feature {NONE} -- Implementation

	counter: BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.body_id_counter.item (compilation_id)
		end

	prefix_name: STRING is
			-- Prefix for generated C function names
		do
			Result := counter.prefix_name
		end

end -- class BODY_ID
