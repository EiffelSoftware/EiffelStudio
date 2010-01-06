class
	A [G -> STRING]
	
feature
	
	test is
		local
			i: INTEGER
		do
			i := {G}.minimal_increase
			i := {like g}.minimal_increase
			i := {STRING}.minimal_increase
			i := {like s}.minimal_increase
		end

	g: G
	
	s: STRING
	
end