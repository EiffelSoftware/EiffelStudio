class A

feature

	f
			-- Call `g` redeclared in a descendant.
		note
			option: instance_free
		do
			g.h
			{like g}.h
		end

	g: X
			-- An instance-free function redeclared in a descendant.
		note
			option: instance_free
		do
			create Result
		end

end