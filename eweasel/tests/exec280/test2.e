class
	TEST2 [G]

inherit
	ANY
		redefine
			default_create
		end

feature -- Initialization

	default_create is
		do
			print ("TEST2.default_create%N")
			create string.make_empty
		end

feature -- Access

	string: STRING

invariant
	string_not_void: string /= Void

end
