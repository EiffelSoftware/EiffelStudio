class SHARED_ID

feature {NONE}

	Normal_compilation: INTEGER is -1
			-- Compilation id in case of a normal compilation
			-- (i.e. not precompiling and not DLE extension)

	Dle_compilation: INTEGER is -2
			-- Compilation id in case of the compilation of a
			-- DC-set

end -- class SHARED_ID
