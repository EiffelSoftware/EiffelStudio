indexing

	description: 
		"Like types that have not been evaluated (has not gone past Degree 4).";
	date: "$Date$";
	revision: "$Revision $"

class UNEVALUATED_LIKE_TYPE

inherit

	TYPE_A
		redefine
			has_like, dump, is_like_current, has_associated_class
		end

creation

	make

feature -- Initialization

	make (a_string: like dump) is
			-- Initialize `anchor' to `a_string'
		require
			non_void_string: a_string /= Void
		do
			anchor := a_string
		ensure
			set: anchor = a_string
		end

feature -- Properties

	anchor: STRING;
			-- Anchor name

	is_like_current: BOOLEAN
			-- Is Current like Current?

	has_like: BOOLEAN is
			-- Does Current has likes?
		do
			Result := True
		end;

	has_associated_class: BOOLEAN is
			-- Does Current have associated class?
		do
			Result := False
		ensure then
			false_result: not Result
		end;

	associated_eclass: E_CLASS is
		do
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := anchor.is_equal (other.anchor) and then
				is_like_current = other.is_like_current
		end

feature -- Setting

	set_like_current is
			-- Set `is_like_current' to True.
		do
			is_like_current := True
		ensure
			is_like_current: is_like_current
		end;

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
			-- Append Current type to `st'.
		do
			st.add_string (dump)
		end;

	dump: STRING is
		do
			!! Result.make (0);
			Result.append ("like ");
			Result.append (anchor)
		end;

feature {NONE} -- Implementation

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		do
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
		do
		end;

	associated_class: CLASS_C is
			-- Class associated to the current type
		do
		end;

	storage_info_with_name (classc: CLASS_C): S_TYPE_INFO is
			-- Storage info for Current type in class `classc'
			-- and store the name of the class for Current
		do
		end;

	type_i: TYPE_I is
			-- C type
		do
		end;

	storage_info (classc: CLASS_C): S_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		do
		end;

invariant

	non_void_anchor: anchor /= Void;
	is_like_current_implies_current_anchor: is_like_current
				implies anchor.is_equal ("Current");

end -- class UNEVALUATED_LIKE_TYPE
