indexing

	description:
		"A resource as it appears in the resource files.";
	date: "$Date$";
	revision: "$Revision$"

deferred class RESOURCE

inherit
	COMPARABLE

feature -- Setting

	set_name (new_name: STRING) is
			-- Set `name' to `new_name'.
		require
			new_name_valid: new_name /= Void
		do
			name := new_name
		end;

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		require
			is_valid_value: is_valid (new_value)
		deferred
		ensure
			value_set: value.is_equal (new_value)
		end

feature -- Access

	name: STRING
			-- Name of the resource as it appears to the left
			-- of the colon

	value: STRING is
			-- Value of the resource as it appears to the right
			-- of the colon
		deferred
		end;

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		deferred
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current less than `other'?
			--| By default this is based on `name'.
		do
			Result := name < other.name
		end

feature -- Update

	update_with (other: like Current) is
			-- Update Current with the value of `other'
		do
			set_value (other.value)
		end
		
end -- class RESOURCE
