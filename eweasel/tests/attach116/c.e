class C [G -> ANY]

feature -- Test

	f (a: G): G
			-- Test that `Result' can be used as detachable until return
			-- and that locals can be used as detachable all the time.
		local
			x: G
		do
			if x = Void or else Result = Void then
				x := a
				Result := x
			end
			Result := x
		ensure
			attached_result: attached Result.out
		end

end