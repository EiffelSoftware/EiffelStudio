indexing
	description	: "A resource as it appears in the resource files."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	RESOURCE

inherit
	COMPARABLE

feature -- Setting

	set_description (new_description: STRING) is
			-- Set `description' to `new_description'.
		require
			new_description_exists: new_description /= Void
		do
			description := new_description
		ensure
			description_set: description.is_equal (new_description)
		end

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		require
			new_value_not_void: new_value /= Void
		deferred
		ensure
			value_set: value.is_equal (new_value)
		end

	mark_saved is
			-- Update curent do that `has_changed' becomes false,
			-- and `value' does not change.
		deferred
		end

	set_effect_is_delayed (new_value: BOOLEAN) is
			-- Set `immediate_change' to `new_value'.
		do
			effect_is_delayed := new_value
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
			Result.replace_substring_all ("_", " ")
			Result.put (Result.item (1).upper, 1)
		end

	description: STRING
			-- Description of what the resource is all about.

	effect_is_delayed: BOOLEAN
			-- Will a change in the resource not be immediately taken into
			-- account by the application ?

	value: STRING is
			-- Value of the resource as it appears to the right
			-- of the colon
		deferred
		end

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
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
		require
			same_name: name.is_equal (other.name)
		do
			set_value (other.value)
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		deferred
		end

	registry_name: STRING is
			-- name of Current in the registry
		deferred
		end

invariant

	valid_name: name /= Void and then not name.is_empty
	value_not_void: value /= Void

end -- class RESOURCE
