indexing
	description: "Eiffel feature parameter used for language service"
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETER_DESCRIPTOR

inherit
	IEIFFEL_PARAMETER_DESCRIPTOR_IMPL_STUB
		redefine
			name,
			display
		end

create
	make

feature {NONE} -- Initialization

	make (a_name, a_type: STRING) is
			-- Initialize parameter with name `name' and type name `type'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_type: a_type /= Void
			valid_type: not a_type.is_empty
		do
			name := a_name
			display := a_name + ": " + a_type
			type := a_type
		ensure
			name_set: name = a_name
			type_set: type = a_type
			display_set: display /= Void
		end
		
feature -- Access

	name: STRING
			-- Argument name
			
	type: STRING
			-- Argument type

	display: STRING
			-- Argument display (i.e. "a: ANY")

end -- class PARAMETER_DESCRIPTOR
