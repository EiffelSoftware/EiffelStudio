indexing
	description: "VOID actual type."
	date: "$Date$"
	revision: "$Revision $"

class VOID_A

inherit

	TYPE_A
		redefine
			is_void, same_as
		end

feature -- Property

	is_void: BOOLEAN is True
			-- Is the current actual type a void type ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		do
			Result := other.is_void
		end

	associated_class: CLASS_C is
		do
			-- No associated calss
		end

feature -- Output

	dump: STRING is "Void"
			-- Dumped trace

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_Void_feature)
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			Result := other.actual_type.is_void
		end

	type_i: VOID_I is
			-- Void type
		once
			!!Result
		end

	create_info: CREATE_INFO is
		do
			-- Do nothing
		ensure then
			False
		end

end -- class VOID_A
