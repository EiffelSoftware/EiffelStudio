class FORMAL_I

inherit

	TYPE_I
		redefine
			is_formal, same_as, has_formal, instantiation_in
		end

feature

	position: INTEGER;
			-- Position of the formal in declarations

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

	is_formal: BOOLEAN is True;
			-- Is the type a formal type ?

	has_formal: BOOLEAN is True;
			-- Has the type formal in its structure ?

	same_as (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_formal: FORMAL_I;
		do
			other_formal ?= other;
			Result := 	other_formal /= Void
						and then
						other_formal.position = position;
		end;

	instantiation_in (other: GEN_TYPE_I): TYPE_I is
			-- Instantiation of Current in context of `other'
		require else
			good_context: position <= other.meta_generic.count;
		do
			Result := other.meta_generic.item (position);
		end;

	c_type: TYPE_C is
		do
		ensure then
			False
		end; -- c_type

	dump (file: UNIX_FILE) is
			-- Debug purpose
		do
			file.putstring ("Formal #");
			file.putint (position);
		end;

	description: INTEGER_DESC is
		do
		ensure then
			False
		end;

	generate_cecil_value (f: UNIX_FILE) is
		do
		ensure then
			False
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + position;
		end;

	sk_value: INTEGER is
		do
		ensure then
			False
		end;

end
