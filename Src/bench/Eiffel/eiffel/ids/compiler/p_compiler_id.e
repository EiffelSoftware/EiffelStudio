-- Notion of precompiled id

deferred class P_COMPILER_ID

inherit
	COMPILER_ID
		rename
			make as make_id
		redefine
			compilation_id, is_precompiled
		end

feature {NONE} -- Initialization

	make (val: like internal_id; unit: like compilation_id) is
			-- Create a new id associated with 
			-- precompilation id `unit'.
		do
			internal_id := val;
			compilation_id := unit
		end;

feature -- Status report

	is_precompiled: BOOLEAN is
			-- Is the entity identified by `Current' precompiled?
		do
			Result := not Compilation_modes.is_precompiling or
				compilation_id /= System.compilation_id
		end

feature {NONE} -- Implemetation

	compilation_id: INTEGER;
			-- Precompilation unit associated with the
			-- current id

end -- class P_COMPILER_ID
