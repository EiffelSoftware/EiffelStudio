class EXPANDED_DESC 

inherit

	ATTR_DESC
		rename
			Expanded_level as level
		redefine
			is_expanded, same_as, generate_generic_info
		end
	
feature 

	class_type: CLASS_TYPE;
			-- Class type of the expanded attribute

	set_class_type (i: CLASS_TYPE) is
			-- Assign `i' to `class_type'.
		do
			class_type := i;
		ensure
			set: class_type = i
		end;

	type_i: TYPE_I
			-- Type of attribute

	set_type_i (t : TYPE_I) is
			-- Assign `t' to `type_i'.
		require
			exists: t /= Void
		do
			type_i := t
		ensure
			set: type_i = t
		end

	type_id: INTEGER is
			-- Type id of the expanded type of the attribute
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.type_id
		end;
			
	is_expanded: BOOLEAN is True;
			-- Is the attribute an expanded one ?

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_EXP + ");
			buffer.putint (type_id - 1);
		end;

	generate_generic_info (buffer: GENERATION_BUFFER) is
			-- Generate type array for current attribute description in
			-- `buffer'.
		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= type_i

			if gen_type /= Void then
				gen_type.generate_cid (buffer, False, False)
			end
		end;

	make_gen_type_byte_code (ba: BYTE_ARRAY) is
			-- Generate full type array byte code
		require
			ba /= Void
		local
			gen_type : GEN_TYPE_I
		do
			ba.append_short_integer (0)
			gen_type ?= type_i

			if gen_type /= Void then
				gen_type.make_gen_type_byte_code (ba, False)
			end
			ba.append_short_integer (-1)
		end

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_exp: EXPANDED_DESC;
		do
			if {ATTR_DESC} Precursor (other) then
				other_exp ?= other;
				Result := (other_exp /= Void) 
								and then
						  (other_exp.type_id = type_id)
								and then
						  identical_types (other_exp.type_i)
			end;
		end;

	identical_types (otype : TYPE_I) : BOOLEAN is
			-- Are `type_i' and `otype' identical?
		do
			if type_i = Void then
				Result := (otype = Void)
			else
				if otype /= Void then
					Result := type_i.is_identical (otype) and then
							  otype.is_identical (type_i)
				end
			end
		end

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_exp | (type_id - 1);
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[EXPANDED ");
			io.error.putstring (class_type.associated_class.name);
			io.error.putstring ("]");
		end;

end
