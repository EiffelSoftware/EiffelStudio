indexing
	description: "Actual type for NONE."
	date: "$Date$"
	revision: "$Revision$"

class
	NONE_A

inherit
	TYPE_A
		redefine
			is_none, dump, type_i, same_as, is_full_named_type
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_none: BOOLEAN is True
			-- Is the current type a none type ?

	is_full_named_type: BOOLEAN is True
			-- Current is a full named type.

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_none
		end

	associated_class: CLASS_C is
		do
			-- No associated class
		end

feature -- Output

	dump: STRING is "NONE"
			-- Dumped trace

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_none_class)
		end

feature {COMPILER_EXPORTER}

	create_info: CREATE_TYPE is
			-- Byte code information for entity type creation
		do
			create Result.make (type_i)
		end

	type_i: NONE_I is
			-- Void C type
		once
			Result := None_c_type
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		do
				-- If `other' is expanded, then it does not conform to NONE.
			Result := not other.is_expanded
		end

end -- class NONE_A
