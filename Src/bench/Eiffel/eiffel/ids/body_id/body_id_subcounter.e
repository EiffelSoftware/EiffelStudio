-- Body id counter associated with a compilation unit.

class BODY_ID_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER;
	ENCODER
		export
			{NONE} all
		end
			
creation

	make

feature -- Access

	next_id: BODY_ID is
			-- Next body id
		do
			count := count + 1;
			!! Result.make (count)
		end

feature {BODY_ID} -- Implementation

	prefix_name (type_id: TYPE_ID): STRING is
			-- Prefix for generated C function names
		require
			type_id_not_void: type_id /= Void
		local
			p_type_id: P_TYPE_ID
		do
			p_type_id ?= type_id;
			if p_type_id /= Void then
				Result := A_buffer
				eif011 ($Result, type_id.compilation_id)
			else
				Result := ""
			end
		end

end -- class BODY_ID_SUBCOUNTER
