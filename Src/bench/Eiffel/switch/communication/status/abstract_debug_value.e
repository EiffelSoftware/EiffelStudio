indexing

	description: 
		"Abstract notion of value during the execution of the application.";
	date: "$Date$";
	revision: "$Revision $"


deferred class ABSTRACT_DEBUG_VALUE

inherit

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			is_equal
		end;
	COMPARABLE
		export
			{NONE} all
		end		

	VALUE_TYPES
		export
			{NONE} all
		undefine
			is_equal
		end;

feature -- Properties

	is_attribute: BOOLEAN;
			-- Is current value an attribute

	name: STRING
			-- Name of attribute or argument or local
			
	is_external_type: BOOLEAN
			-- Is this value an instance of an external type ?
			-- which means whose information are not completly known 
			-- by the compiler

feature {NONE} -- Internal Properties

	e_class: CLASS_C;
			-- Class where attribute is defined
			-- (Void for if not attribute)
			
feature -- Access

	dynamic_class: CLASS_C is
			-- Return class of value
		deferred
		end;

	item_number: INTEGER
			-- number of the object in the local list, attribute list, etc...

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		deferred
		ensure
			valid_result: Result /= Void
		end

feature -- Comparison

	infix "<" (other: ABSTRACT_DEBUG_VALUE): BOOLEAN is
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

feature {ABSTRACT_DEBUG_VALUE} -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
			-- Append type and value of Current to `st'.
		require
			valid_st: st /= Void;
			valid_name: name /= Void
		deferred 
		end;
		
feature {NONE}

	append_value (st: STRUCTURED_TEXT) is
			-- Append only the value of Current to `st'.
		deferred
		end

	output_value: STRING is
			-- A STRING representation of the value of `Current'.
		deferred
		end

	type_and_value: STRING is
			-- Return a string representing `Current'.
		deferred
		end

feature -- Output

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		deferred
		end

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		deferred
		end

	address: STRING is
			-- Address of the object represented by `Current'. Void if none.
		do
			Result := Void
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		deferred
		ensure
			valid_kind: Result >= Immediate_value and then Result <= External_reference_value
		end

feature {CALL_STACK_ELEMENT, DEBUG_DYNAMIC_EVAL_HOLE, SHARED_DEBUG}

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
		end;

feature {ATTR_REQUEST, CALL_STACK_ELEMENT} -- Setting

	set_item_number(n: like item_number) is
			-- set `item_number' to `n'
		require
			n >= 0
		do
			item_number := n
		ensure
			item_number = n
		end

feature {RECV_VALUE, CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER} -- Setting

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
		
feature {NONE} -- Constants

	NONE_representation: STRING is "NONE = Void"

	Left_square_bracket: STRING is " ["

	Right_square_bracket: STRING is "]"

	Equal_sign_str: STRING is " = "

	Is_unknown: STRING is " = Unknown"		

invariant

	non_void_name: name /= Void;
	valid_attribute: is_attribute implies e_class /= Void

end -- class ABSTRACT_DEBUG_VALUE
