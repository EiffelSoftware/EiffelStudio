class C [G -> ANY]

feature -- Test

	f: G
			-- Test that detachable status of locals and `Result' does not allow to assign Void
			-- if they are of a formal generic type.
		local
			x: G
		do
			x := Void -- VJAR
			if x = Void or else Result = Void then
				Result := x
			end
			Result := Void -- VJAR
			Result := x
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

	g: like f
			-- Test that detachable status of locals and `Result' does not allow to assign Void
			-- if they are of a formal generic type.
		local
			x: like f
		do
			x := Void -- VJAR
			if x = Void or else Result = Void then
				Result := x
			end
			Result := Void -- VJAR
			Result := x
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

	h: like {C [like f]}.g
			-- Test that detachable status of locals and `Result' does not allow to assign Void
			-- if they are of a formal generic type.
		local
			x: like {C [like f]}.g
		do
			x := Void -- VJAR
			if x = Void or else Result = Void then
				Result := x
			end
			Result := Void -- VJAR
			Result := x
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out
		end

end