class TEST1 [G]

feature

	f (g: G) is
		do
		end

	test is
		local
			t: like anchor
			fd: PROCEDURE [ANY, TUPLE [ARRAY [like tutu]]]
		do
			fd := agent t.f
		end

	tutu: ARRAY [INTEGER]
		
	anchor: TEST1 [ARRAY [like tutu]] 

end
