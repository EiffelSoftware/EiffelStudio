-- DC-set entity ids

deferred class DLE_COMPILER_ID

inherit

	COMPILER_ID
		redefine
			is_dynamic, compilation_id
		end

feature -- Status report

	is_dynamic: BOOLEAN is True;
			-- Is the entity identified by `Current' part of a DC-set?

feature {NONE} -- Implementation

	compilation_id: INTEGER is
			-- Compilation unit associated with the current id
		do
			Result := Dle_compilation
		end

end -- class DLE_COMPILER_ID
