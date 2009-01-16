deferred class
	B

inherit
	A
		rename
			a as c,
			b as c
		redefine
			c
		end


feature

	c
		deferred
		end

end