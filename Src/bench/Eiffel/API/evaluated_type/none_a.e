indexing
	description: "Actual type for integer type."
	date: "$Date$"
	revision: "$Revision $"

class
	NONE_A

inherit
	TYPE_A
		redefine
			is_none, dump, type_i, same_as,
			internal_conform_to, append_to,
			storage_info, storage_info_with_name
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

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("NONE")
		end

feature {COMPILER_EXPORTER}

	create_info: CREATE_TYPE is
			-- Byte code information for entity type creation
		do
			!! Result
			Result.set_type (type_i)
		end

	type_i: NONE_I is
			-- Void C type
		once
			Result := None_c_type
		end

	internal_conform_to (other: TYPE_A in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
				-- If `other' is a basic, a BIT or an expanded type, it is not
				-- conform to NONE.
				--| When doing the check for `is_basic', we also check that `other'
				--| can be a BIT type, so we do not need to add the check `other.is_bits'.
			Result := not (other.is_basic or else other.is_expanded)
		end

    storage_info, storage_info_with_name (classc: CLASS_C): S_CLASS_TYPE_INFO is
            -- Storage info for Current type in class `classc'
            -- and store the name of the class for Current
        do
            !! Result.make ("NONE", 0)
        end

end -- class NONE_A
