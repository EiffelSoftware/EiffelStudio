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
			storage_info, storage_info_with_name, associated_eclass
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

	associated_eclass: CLASS_C is
			-- No associated class
		do
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_none
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
			!!Result
		end

	associated_class: CLASS_C is
		require else
			True
		do
			-- No associated class
		end

	internal_conform_to (other: TYPE_A in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			Result := True
		end

    storage_info, storage_info_with_name (classc: CLASS_C): S_CLASS_TYPE_INFO is
            -- Storage info for Current type in class `classc'
            -- and store the name of the class for Current
        do
            !! Result.make ("NONE", 0)
        end

end -- class NONE_A
