-- Body id counter associated with a DC-set.

class DLE_BODY_ID_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	BODY_ID_SUBCOUNTER
		redefine
			next_id, prefix_name
		end

creation

	make

feature -- Access

	next_id: DLE_BODY_ID is
			-- Next body id
		do
			count := count + 1;
			!! Result.make (count);
		end;

feature {BODY_ID} -- Implementation

	prefix_name (type_id: TYPE_ID): STRING is
			-- Prefix for generated C function names
		local
			p_type_id: P_TYPE_ID
		do
			p_type_id ?= type_id;
			if p_type_id /= Void then
				Result := F_buffer;
				eif011 ($Result, type_id.compilation_id)
			elseif type_id.is_dynamic then
				Result := "D"
			else
				Result := "DN"
			end
		end

end -- class DLE_BODY_ID_SUBCOUNTER
