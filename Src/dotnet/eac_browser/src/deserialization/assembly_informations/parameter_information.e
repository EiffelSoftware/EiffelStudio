class
	PARAMETER_INFORMATION


creation
	make
	
feature -- Initialization
	
	make is
			-- Initialization
		do
			create name.make_empty
			create description.make_empty
		ensure
			non_void_name: name /= Void
			non_void_description: description /= Void
		end

feature -- Access

	name: STRING
	
	description: STRING
	

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_a_name: a_name /= Void
		do
			name := a_name	
		ensure
			name_set: name = a_name
		end

	set_description (a_description: like description) is
			-- Set `description' with `a_description'.
		require
			non_void_a_description: a_description /= Void
		do
			description := a_description	
		ensure
			description_set: description = a_description
		end


invariant
	non_void_name: name /= Void
	non_void_description: description /= Void

end -- class PARAMETER_INFORMATION
