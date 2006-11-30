class A

feature

	f is
			-- Precondition to be generated in context of class B.
		require
			g = 5
		do
		end

	g: INTEGER is
			-- This function becomes an attribute in class B
		external "C inline"
			alias "1"
		end

end