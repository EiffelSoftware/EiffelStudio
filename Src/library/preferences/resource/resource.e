indexing
	description: "Resource type abstraction."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PREFERENCE

feature -- Status setting

	set_name (new_name: STRING) is
			-- Set `name' to `new_name'.
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
		do
			name := new_name
		ensure
			name_set: name = new_name
		end

	set_description (new_description: STRING) is
			-- Set `description' to `new_description'.
		require
			new_description_exists: new_description /= Void
			new_description_not_empty: not new_description.is_empty
		do
			description := new_description
		ensure
			description_set: description = new_description
		end		
	
	set_default_value (a_value: STRING) is
			-- Set the value to be used for default in the event `value' is not set.
		require
			a_value_not_void: a_value /= Void
			a_value_valid: valid_value_string (a_value)
		do
			default_value := a_value
			change_actions.call ([Current])
		ensure		
			default_value_set: default_value = a_value
		end		
	
	set_value_from_string (a_value: STRING) is
			-- Parse the string value `a_value' and set `value'.
		require
			a_value_not_void: a_value /= Void
			a_value_valid: valid_value_string (a_value)
		deferred
		ensure
-- TODO: neilc, problem in FONT_PREFERENCE with this post condition
--			string_value_set: string_value.as_lower.is_equal (a_value.as_lower)
		end	

	reset is
			-- Reset value to `default_value'.
		require
			has_default_value: has_default_value
		do
			set_value_from_string (default_value)
		ensure
			is_reset: is_default_value
		end		

feature -- Access

	name: STRING
			-- Name of the resource as it appears in the resource file.

	description: STRING
			-- Description of what the resource is all about.

	default_value: STRING
			-- Value to be used for default.

	string_value: STRING is
			-- String value for this resource.
		require
			has_value: has_value
		deferred
		ensure
			not_void: Result /= Void
		end		

	string_type: STRING is
			-- String description of this resource type.
		deferred
		ensure
			string_type_not_void: string_type /= Void
		end		

	generating_resource_type: STRING is
			-- The generating type of the resource for graphical representation.
		deferred
		ensure
			generating_resource_type_not_void: generating_resource_type /= Void
		end	

	manager: PREFERENCE_MANAGER
			-- Manager to which Current belongs.

feature -- Query
		
	has_value: BOOLEAN is
			-- Does this resource have a value to use?
		deferred
		end
		
	has_default_value: BOOLEAN is
			-- Does this resource have a default value to use?
		do
			Result := default_value /= Void	
		end		

	is_default_value: BOOLEAN is
			-- Is this resource value the same as the default value?
		do
			if has_value and then has_default_value then
				Result := string_value.as_lower.is_equal (default_value.as_lower)
			end
		end		

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this resource type to convert into a value?
		require
			string_not_void: a_string /= Void
		deferred
		end	

feature -- Actions

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when `value' changes, after call to `set_value'.

invariant
	has_manager: manager /= Void
	name_not_void: name /= Void
	has_change_actions: change_actions /= Void

end -- class PREFERENCE
