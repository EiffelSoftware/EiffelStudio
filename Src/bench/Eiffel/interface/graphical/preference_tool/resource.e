indexing

	description:
		"A resource as it appears in the resource files.";
	date: "$Date$";
	revision: "$Revision$"

deferred class RESOURCE

inherit
	COMPARABLE

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		require
			new_value_not_void: new_value /= Void;
			is_valid_value: is_valid (new_value)
		deferred
		ensure
			value_set: value.is_equal (new_value)
		end

feature -- Access

	name: STRING
			-- Name of the resource as it appears to the left
			-- of the colona in the resource file

	visual_name: STRING is
			-- Visual name of the resource as it appears to the left
			-- of the colon in the preference tool
		do
			Result := clone (name);
			Result.replace_substring_all ("_", " ");
			Result.put (Result.item (1).upper, 1)
		end;

	value: STRING is
			-- Value of the resource as it appears to the right
			-- of the colon
		deferred
		end;

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		deferred
		end;

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		deferred
		end;

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
		require
			same_name: name.is_equal (other.name)
		do
			set_value (other.value)
		end
		
invariant

	valid_name: name /= Void and then not name.is_empty;
	value_not_void: value /= Void

end -- class RESOURCE
