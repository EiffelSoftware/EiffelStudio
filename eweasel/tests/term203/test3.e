class TEST3 [G]

feature

	inherited_routine_causing_crash: ANY
		local
			t: like Current
			g: TEST3 [G]
		do
			t.do_nothing
			g.do_nothing
			Result := Current
		ensure
			using_twin: old twin = twin
		end

end
