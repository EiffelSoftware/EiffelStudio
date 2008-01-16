class
	E

inherit
	D [ANY]
		redefine
			snapshot
		end

feature

	snapshot: B
		-- It should be B [ANY] to have correct code after the first compilation, but instead
		-- of reporting the error the compiler is crashing.

end
