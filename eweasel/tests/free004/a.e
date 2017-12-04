class A

feature

	f
			-- Call `g` redeclared in a descendant.
		do
			g.h
			{like g}.h
		ensure
			is_instance_free: class
		end

	g: X
			-- An instance-free function redeclared in a descendant.
		do
			create Result
		ensure
			is_instance_free: class
		end

end