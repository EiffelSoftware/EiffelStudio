indexing
	description: "Parameter"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_PARAMETER

creation
	make

feature {NONE} -- Initialization

	make (new_name, new_type: STRING) is
			-- Create and initialize object with parameters.
		require
			non_void_name: new_name /= Void
			non_void_type: new_type /= Void
			valid_name: not new_name.is_empty
			valid_type: not new_type.is_empty
		do
			set_name (new_name)
			set_type (new_type)
		end

feature -- Access

	name: STRING
			-- Name

	type: STRING
			-- Type

feature -- Element change

	set_name (new_name: STRING) is
			-- Set 'name' to 'new_name'
		require
			non_void_name: new_name /= Void
			valid_name: not new_name.is_empty
		do
			name := clone (new_name)
		ensure
			name_set: name.is_equal (new_name)
		end

	set_type (new_type: STRING) is
			-- Set 'type' to 'new_type'
		require
			non_void_type: new_type /= Void
			valid_type: not new_type.is_empty
		do
			type:= clone (new_type)
		ensure
			type_set: type.is_equal (new_type)
		end

feature -- Output

	code: STRING is
			-- Code output
		do
		end

invariant
	non_void_name: name /= Void
	non_void_type: type /= Void
	valid_name: not name.is_empty
	valid_type: not type.is_empty

end -- class EI_ATTRIBUTE
