class
	X

inherit
	ANY
		redefine
			default_create
		end

creation
	default_create,
	do_nothing

feature {NONE} -- Creation

	default_create
		do
			io.put_string ("X")
		end

end