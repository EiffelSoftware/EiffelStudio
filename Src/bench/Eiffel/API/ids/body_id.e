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
		do
			Result := clone (prefix_name (type_id))
			buff := E_buffer;
			eif000 ($buff, type_id.internal_id, internal_id);
			Result.append (buff)
		end

feature {NONE} -- Implementation

	counter: BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Body_id_counter.item (Normal_compilation)
		end

	prefix_name (type_id: TYPE_ID): STRING is
			-- Prefix for generated C function names
		require
			type_id_not_void: type_id /= Void
		do
			Result := counter.prefix_name (type_id)
		end

end -- class BODY_ID
