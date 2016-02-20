class A [G]

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
		end

	h (a: like {A [like f]}.f): like {A [like f]}.f
			-- Test that `Result' can be used as detachable until return
			-- and that locals can be used as detachable all the time.
		local
			x: like {A [like f]}.f
		do
			if x = Void or else Result = Void then
				x := a
				Result := x
			end
			Result := x
		end

end