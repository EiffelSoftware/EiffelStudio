indexing

	description: 
		"Abstract notion of value during the execution of the application.";
	date: "$Date$";
	revision: "$Revision $"


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

	e_class: CLASS_C;
			-- Class where attribute is defined
			-- (Void for if not attribute)

	name: STRING
			-- Name of attribute or argument or local

feature -- Access

	dynamic_class: CLASS_C is
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

	append_to (st: STRUCTURED_TEXT; indent: INTEGER) is
			-- Append `Current' to `st' printing the name, type
			-- and its value.
		require
			valid_st: st /= Void;
			valid_indent: indent >= 0;
			valid_name: name /= Void
		do
			append_tabs (st, indent);
			if is_attribute then
				st.add_feature_name (name, e_class)
			else
				st.add_string (name)
			end;
			st.add_string (": ");
			append_type_and_value (st);
			st.add_new_line
		end;

	append_type_and_value (st: STRUCTURED_TEXT) is 
			-- Append value of Current to `st'.
		require
			valid_st: st /= Void;
			valid_name: name /= Void
		deferred 
		end;

feature {ONCE_REQUEST, CALL_STACK_ELEMENT, ATTR_REQUEST, EXPANDED_VALUE, SPECIAL_VALUE}

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

	append_tabs (st: STRUCTURED_TEXT; indent: INTEGER) is
			-- Append `indent' tabulation character to `st'.
		require
			st: st /= Void;
			indent_positive: indent >= 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > indent
			loop
				st.add_indent;
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

	Any_class: CLASS_C is
		once
			Result := Eiffel_system.any_class.compiled_class
		end

invariant

	non_void_name: name /= Void;
	valid_attribute: is_attribute implies e_class /= Void

end -- class DEBUG_VALUE
