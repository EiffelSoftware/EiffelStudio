-- VOID actual type

class VOID_A

inherit

	TYPE_A
		redefine
			is_void, same_as
		end

feature -- Property

	is_void: BOOLEAN is
			-- Is the current actual type a void type ?
		do
			Result := True;
		end; -- is_void

feature -- Access

	associated_eclass: E_CLASS is
			-- No associated calss
		do
		end;

feature -- Output

	dump: STRING is "Void";
			-- Dumped trace

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("Void");
		end;

feature 

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			Result := other.actual_type.is_void;
		end;

	type_i: VOID_I is
			-- Void type
		once
			!!Result;
		end;

	associated_class: CLASS_C is
		do
			-- No associated calss
		end;

	create_info: CREATE_INFO is
		do
			-- Do nothing
		ensure then
			False
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		do
			Result := other.is_void
		end;

feature -- Storage information for EiffelCase

	storage_info_with_name, storage_info (classc: CLASS_C): S_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		do
		ensure then
			not_to_be_called: False
		end;

end
