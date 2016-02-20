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

	g (a: like f): like f
			-- Test that `Result' can be used as detachable until return
			-- and that locals can be used as detachable all the time.
		local
			x: like f
		do
			if x = Void or else Result = Void then
				x := a
				Result := x
			end
			Result := x
		ensure
			attached_result: attached Result.out
		end

	h (a: like {C [like f]}.f): like {C [like f]}.f
			-- Test that `Result' can be used as detachable until return
			-- and that locals can be used as detachable all the time.
		local
			x: like {C [like f]}.f
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