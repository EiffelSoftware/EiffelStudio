expanded class A

inherit
	ANY
		redefine
			default_create
		end

feature

	default_create is
		do
			io.put_string ("A")
		end

end