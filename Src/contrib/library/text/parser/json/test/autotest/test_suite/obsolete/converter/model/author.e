class
	AUTHOR

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32)
			-- Create an author with `a_name' as `name'.
		do
			set_name (a_name)
		ensure
			name_set: name = a_name
		end

feature -- Access

	name: STRING_32
			-- Author name

feature -- Change

	set_name (a_name: STRING_32)
			-- Set `name' with `a_name'.
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

end -- class AUTHOR
