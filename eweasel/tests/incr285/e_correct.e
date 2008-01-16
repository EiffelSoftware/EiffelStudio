class
	E

inherit
	D [ANY]
		redefine
			snapshot
		end

feature

	snapshot: B [ANY]
		-- It should be B [ANY] to have correct code, but instead of reporting the
		-- error the compiler is crashing.

end
