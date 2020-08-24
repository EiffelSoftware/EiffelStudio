deferred class A [G]

feature

	f (v: G; i: INTEGER): DOUBLE
		deferred
		end

	g
		local
			d: DOUBLE
		do
			d := f (value, 1) 
		end

	value: G

end -- class A
