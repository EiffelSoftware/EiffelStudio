class A [G, H]

feature
	
	toto: A [G, expanded C [H]] -- This line generates an infinite loop in compiler
	
end

