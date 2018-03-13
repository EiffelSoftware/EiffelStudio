class A

feature

	e: INTEGER = 5
			-- A constant attribute.

	f: detachable ANY
			-- An attribute.

	g: detachable ANY
			-- A function redefined into a function.
		do
		ensure
			instance_free: class
		end

	h: detachable ANY
			-- A function redefined into an attribute.
		do
		end

end
