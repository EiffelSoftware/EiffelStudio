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

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Void")
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

feature -- Storage information for EiffelCase

	storage_info_with_name, storage_info (classc: CLASS_C): S_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		do
		ensure then
			not_to_be_called: False
		end

end -- class VOID_A
