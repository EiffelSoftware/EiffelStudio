-- Actual type for integer type

class NONE_A

inherit

	BASIC_A
		redefine
			is_none, dump, type_i, associated_class, same_as,
			internal_conform_to, append_clickable_signature,
			storage_info, storage_info_with_name, associated_eclass
		end

feature -- Properties

	is_none: BOOLEAN is
			-- Is the current type a none type ?
		do
			Result := True;
		end;

	associated_eclass: E_CLASS is
			-- No associated class
		do
		end;

feature -- Output

	dump: STRING is "NONE";
			-- Dumped trace

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("NONE");
		end;

feature

	type_i: NONE_I is
			-- Void C type
		once
			!!Result;
		end;

	associated_class: CLASS_C is
		require else
			True
		do
			-- No associated class
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_none;
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			Result := True;
		end;

    storage_info, storage_info_with_name (classc: CLASS_C): S_CLASS_TYPE_INFO is
            -- Storage info for Current type in class `classc'
            -- and store the name of the class for Current
        do
            !! Result.make ("NONE", 0)
        end;

end
