indexing
	description: "EiffelBench resource"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_RESOURCE

inherit
	COMPARABLE

feature {NONE} -- Initialization

--	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: like_actual_value) is
--
--	require
--		name_non_void: a_name /= void			
--		table_exists: rt /= void
--	deferred
--	end

--	make_with_values (a_name: STRING; a_value: like actual_value) is
--
--	require
--		name_non_void: a_name /= void			
--	deferred
--	end

--	make_from_string (a_name: STRING; a_string: STRING) is
--	require
--		name_non_void: a_name /= void
--		string_is_valid: is_valid (a_string)
--	deferred
--	end

feature -- Access

	name: STRING
			-- Name of the resource as it appears to the left
			-- of the colona in the resource file

	visual_name: STRING is
			-- Visual name of the resource as it appears in the 
			-- display of the preference tool
		do
			Result := clone (name);
			Result.replace_substring_all ("_", " ");
			Result.put (Result.item (1).upper, 1)
		end

--	actual_value: ANY is
--		deferred
--		end
			-- actual resource value

--	default_value: like actual_value is
--		deferred
--		end
			-- actual resource value


	value: STRING is
			-- value as a string of the resource.
			-- used for data capture and storage
		deferred
		end

feature -- Status report

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		deferred
		end

	is_default: BOOLEAN is
			-- Is the resource equal to its default value?
		deferred
		end

	has_changed: BOOLEAN is
			-- Has the resource changed from its old value?
		deferred
		end

feature -- Status setting

feature -- Element change

--	set_actual_value (a_value: ANY) is
		-- Set `actual_value' to `a_value'.
--	require
--		a_value_not_void: a_value /= Void
--	deferred
--	ensure
--		value_set: actual_value.is_equal (a_value)
--	end

	set_value (new_value: STRING) is
		-- Set `value' according to `new_value'.
	require
		new_value_not_void: new_value /= Void
		is_valid_value: is_valid (new_value)
	deferred
	ensure
		value_set: value.is_equal (new_value)
	end

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current less than `other'?
			--| By default this is based on `name'.
		do
			Result := name < other.name
		end

feature {NONE} -- Obsolete

	make_from_old (old_r: RESOURCE) is
		obsolete
			"Used only for system migration; to be deleted with `old_r' type"
		deferred
		end

feature -- Inapplicable

feature {NONE} -- Implementation

invariant

	valid_name: name /= Void and then not name.empty
	value_not_void: value /= Void

end -- class EB_RESOURCE
