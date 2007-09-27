class
	TEST2

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature -- Initialization

	default_create is
		do
			create string.make_empty
		end

feature -- Access

	string: STRING

invariant
	string_not_void: string /= Void

end
