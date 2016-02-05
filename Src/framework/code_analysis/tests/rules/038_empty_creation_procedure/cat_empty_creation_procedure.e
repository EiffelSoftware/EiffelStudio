class
	CAT_EMPTY_CREATION_PROCEDURE

-- Violates the empty creation procedure code analysis rule.

create
	a,
	b,
	c,
	d,
	e,
	f


feature {None} --Test

	d
		do

		end

	a, b, c
		do
			io.putstring ("test")
		end

	e, f
		do

		end

end

