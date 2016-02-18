class B [reference G]

feature -- Test

	f (a: G): G
			-- Test that `Result' can be used as detachable until return
			-- and that locals can be used as detachable all the time.
		local
			x: G
		do
			x := Void
			if x = Void or else Result = Void then
				x := a
				Result := x
			end
			Result := Void
			Result := x
		end

end