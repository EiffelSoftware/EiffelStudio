-- Precompiled body ids.

class P_BODY_ID

inherit

	P_COMPILER_ID;
	BODY_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation

	counter: BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Body_id_counter.item (compilation_id)
		end

end -- class P_BODY_ID
