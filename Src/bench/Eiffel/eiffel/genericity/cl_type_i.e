-- Type class

class CL_TYPE_I

inherit

	TYPE_I
		redefine
			is_reference,
			is_expanded,
			is_separate,
			is_valid,
			same_as,
			c_type,
			instantiation_in,
			conforms_to_array
		end

feature

	base_id: CLASS_ID;
			-- Base class id of the type class

	is_expanded: BOOLEAN;
			-- Is the type expanded ?

	is_separate: BOOLEAN;
			-- Is the type separate ?

	set_base_id (c: CLASS_ID) is
			-- Assign `c' to `base_id'.
		do
			base_id := c;
		end;

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b;
		end;

	set_is_separate (b: BOOLEAN) is
			-- Assign `b' to `is_separate'.
		do
			is_separate := b;
		end;

	meta_generic: META_GENERIC is
			-- Meta generic array describing the type class
		do
			-- No meta generic in non-generic type
		end;

	base_class: CLASS_C is
			-- Base class associated to the class type
		do
			Result := System.class_of_id (base_id);
		end;

	is_valid: BOOLEAN is
			-- Is the base class still in the system ?
		do
			Result := base_class /= Void;
		end;

	is_reference: BOOLEAN is
			-- Is the type a reference type ?
		do
			Result := not is_expanded;
		end; 

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_cl_type: CL_TYPE_I;
		do
			other_cl_type ?= other;
			Result := 	other_cl_type /= Void 
						and then
							-- FIXME
						equal (other_cl_type.base_id, base_id)
						and then
						other_cl_type.is_expanded = is_expanded
						and then
						other_cl_type.is_separate = is_separate
						and then
						other_cl_type.meta_generic = Void
		end;

	instantiation_in (other: GEN_TYPE_I): CL_TYPE_I is
			-- Instantiation of Current in context of `other'
		require else
			True
		do
			Result := Current;
		end;

	description: ATTR_DESC is
			-- Type description for skeletons
		local
			exp: EXPANDED_DESC;
			types: TYPE_LIST;
			pos: INTEGER;
		do
			if is_expanded then
				!!exp;
				is_expanded := False;

				types := base_class.types;
				pos := types.index;
				types.compare_references
				types.search (Current);
				exp.set_class_type (types.item);
				types.go_i_th (pos);

				is_expanded := True;
				Result := exp;
			elseif is_separate then
				-- FIXME
				Result := c_type.description
			else
				Result := c_type.description;
			end;
		end;

	c_type: TYPE_C is
			-- Associated C type
		do
			Result := Reference_c_type;
		end;

	append_signature (st: STRUCTURED_TEXT) is
		do
			if is_expanded then
				st.add_string ("expanded ");
			elseif is_separate then
				st.add_string ("separate ");
			end;
			base_class.append_signature (st)
		end;

	dump (file: FILE) is
		local
			s: STRING
		do
			if is_expanded then
				file.putstring ("expanded ");
			elseif is_separate then
				file.putstring ("separate ");
			end;
			s := clone (base_class.name);
			s.to_upper;
			file.putstring (s);
		end;

	associated_class_type: CLASS_TYPE is
			-- Associated class type
		local
			types: TYPE_LIST;
			pos: INTEGER;
		do
			if is_expanded then
				Result := associated_expanded_class_type
			elseif is_separate then
				Result := associated_separate_class_type
			else
				types := base_class.types;
				pos := types.index;
				types.compare_references
				types.search (Current);
				Result := types.item;
				types.go_i_th (pos);
			end;
		end;

	associated_expanded_class_type: CLASS_TYPE is
			-- Associated expanded class type
		require
			is_expanded: is_expanded
		do
			is_expanded := false;
			Result := associated_class_type;
			is_expanded := true;
		end;

	associated_separate_class_type: CLASS_TYPE is
			-- Associated separate class type
		require
			is_separate: is_separate
		do
			is_separate := false;
			Result := associated_class_type;
			is_separate := true;
		end;

	type_id: INTEGER is
			-- Type id of the correponding class type
		do
			Result := associated_class_type.type_id;
		end;

	expanded_type_id: INTEGER is
			-- Type id of the corresponding expanded class type
		do
			Result := associated_expanded_class_type.type_id
		end;

	generate_cecil_value (file: INDENT_FILE) is
			-- Generate cecil value
		do
				-- FIXME????: separate
			if not is_expanded then
				file.putstring ("SK_DTYPE");
			else
				file.putstring ("SK_EXP + (uint32) ");
				file.putint (base_id.id);
			end;
		end;

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := Other_code + base_id.hash_code
		end;

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
				-- FIXME????: separate
			if not is_expanded then
				Result := Sk_ref + (type_id - 1);
			else
				is_expanded := False;
				Result := Sk_exp + (type_id - 1);
				is_expanded := True;
			end;
		end;

	cecil_value: INTEGER is
		do
				-- FIXME????: separate
			if not is_expanded then
				Result := Sk_dtype
			else
				Result := Sk_exp + base_id.id
			end;
		end;

feature -- Array optimization

	conforms_to_array: BOOLEAN is
		do
			Result := base_class.conform_to (array_class_c)
		end;

feature {NONE} -- Array optimization

	array_class_c: CLASS_C is
		once
			Result := System.array_class.compiled_class
		end;

feature

	type_a: CL_TYPE_A is
		do
			!!Result
			Result.set_is_expanded (is_expanded);
			Result.set_is_separate (is_separate);
			Result.set_base_class_id (base_id)
		end

end
