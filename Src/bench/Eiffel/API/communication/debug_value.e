
deferred class DEBUG_VALUE

inherit

	SHARED_EIFFEL_PROJECT
		undefine
			is_equal
		end;
	COMPARABLE

feature -- Properties

	is_attribute: BOOLEAN;
			-- Is current value an attribute

	e_class: E_CLASS;
			-- Class where attribute is defined
			-- (Void for if not attribute)

	name: STRING
			-- Name of attribute or argument or local

	feature_stone: FEATURE_NAME_STONE is
			-- Feature stone for attribute
		require
			is_attribute: is_attribute
		do
			!! Result.make (name, e_class)
		end;

feature -- Access

	dynamic_class: E_CLASS is
			-- Return class of value
		deferred
		end;

	attribute: E_FEATURE is
			-- Attribute feature
		require
			is_attribute: is_attribute
		do
			Result := e_class.feature_with_name (name)
		ensure
			valid_result: Result /= Void implies Result.is_attribute and then
				equal (Result.name, name)
		end;

feature -- Comparison

	infix "<" (other: DEBUG_VALUE): BOOLEAN is
			-- Is `Current''s name lexicographically lower than `other''s?
		do
			Result := name < other.name
		end;

feature -- Output

	append_to (cw: CLICK_WINDOW; indent: INTEGER) is
			-- Append `Current' to `cw' printing the name, type
			-- and its value.
		require
			valid_cw: cw /= Void;
			valid_indent: indent >= 0;
			valid_name: name /= Void
		do
			append_tabs (cw, indent);
			if is_attribute then
				cw.put_clickable_string (feature_stone, name)
			else
				cw.put_string (name)
			end;
			cw.put_string (": ");
			append_type_and_value (cw);
			cw.new_line
		end;

	append_type_and_value (cw: CLICK_WINDOW) is 
			-- Append value of Current to `cw'.
		require
			valid_cw: cw /= Void;
			valid_name: name /= Void
		deferred 
		end;

feature {ONCE_REQUEST, CALL_INFO, ATTR_REQUEST, EXPANDED_VALUE, SPECIAL_VALUE}

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
		end;

feature {RECV_VALUE} -- Setting

	set_name (n: like name) is
			-- Set `name' to `n'.
		do
			name := n
		ensure
			set: name = n
		end

feature {NONE} -- Implementation

	append_tabs (cw: CLICK_WINDOW; indent: INTEGER) is
			-- Append `indent' tabulation character to `cw'.
		require
			cw_exists: cw /= Void;
			indent_positive: indent >= 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > indent
			loop
				cw.put_string ("%T");
				i := i + 1
			end
		end;

	set_default_name is
			-- Set the name to `default' in order to	
			-- satisfy the invariant and the less than routine.
			-- When the client uses this
			-- class the name will be set after the call info is
			-- processed. This is done for optimization reasons.
		require
			not_is_attribute: not is_attribute
		do
			name := "default"
		end

	Any_class: E_CLASS is
		once
			Result := Eiffel_system.any_class.compiled_eclass
		end

invariant

	non_void_name: name /= Void;
	valid_attribute: is_attribute implies e_class /= Void

end -- class DEBUG_VALUE
