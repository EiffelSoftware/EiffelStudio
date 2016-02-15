class A [G]

feature -- Test

	f: G
			-- Test that detachable status of locals and `Result' does not allow to assign Void
			-- if they are of a formal generic type.
		local
			x: G
		do
			x := Void
			if x = Void and then Result = Void then
				Result := x
			end
			Result := Void
			Result := x
		ensure
			result_set: attached Result.out
		end

end