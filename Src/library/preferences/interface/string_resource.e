indexing
	description	: "A resource value for string resources."
	date		: "$Date$"
	revision	: "$Revision$"

class
	STRING_RESOURCE

inherit
	RESOURCE

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING; a_type: RESOURCE_TYPE) is
			-- Initialize Current
		require
			valid_name: a_name /= Void
			valid_value: a_value /= Void
		do
			type := a_type
			name := a_name
			value := a_value
			default_value := a_value
		end

feature -- Access

	default_value, value: STRING
			-- Value as a `STRING' as represented by Current

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := not equal (default_value, value)
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			value := new_value
		end

	mark_saved is
		do
			default_value := value
		end

end -- class STRING_RESOURCE
