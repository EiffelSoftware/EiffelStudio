-- Representation of an type anchored on a routine argument

class LIKE_ARGUMENT

inherit

	TYPE_A
		rename
			base_type as position,
			set_base_type as set_position
		redefine
			actual_type, solved_type, has_like, instantiation_in, is_like,
			is_basic, instantiated_in, same_as, conformance_type, meta_type,
			is_like_argument, is_deep_equal
		end;
	SHARED_LIKE_CONTROLER;
	SHARED_ARG_TYPES;

feature -- Attributes

	actual_type: TYPE_A;
			-- Actual type of the argument

feature -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
		end;

	is_like_argument: BOOLEAN is
			-- Is Current a like argument? (True)
		do
			Result := True;
		end;

	is_like: BOOLEAN is
			-- Is the type an anchored one ?
		do
			Result := True;
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to `actual_type' ?
		do
			Result := actual_type.internal_conform_to (other, in_generics);
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_ARGUMENT is
			-- Check if the anchor type is still a non like type and
			-- update `actual_type'.
		local
			argument_type: TYPE;
		do
			if Like_control.is_on then
				Like_control.raise_error
			else
				argument_type := f.arguments.i_th (position);
				Result := twin;
					-- Recalculation of the anchor
				Result.set_actual_type 
					(argument_type.solved_type (feat_table, f).actual_type);
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end;
			end;
		end;

	instantiation_in (type: TYPE_A; written_id: INTEGER): LIKE_ARGUMENT is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			Result := twin;
			Result.set_actual_type
					(actual_type.instantiation_in (type, written_id));
		end;

	instantiated_in (class_type: CL_TYPE_A): like Current is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := twin;
			Result.set_actual_type (actual_type.instantiated_in (class_type));
		end;

	conformance_type: TYPE_A is
			-- Type for conformance.
			-- `actual_type' is the declared type and is the wrong one for
			-- conformance validation.
		do
			Result := Argument_types.i_th (position).actual_type;
		end;

	associated_class: CLASS_C is
			-- Associated class
		require else
			actual_type_not_void: actual_type /= Void
		do
			Result := actual_type.associated_class;
		end;

	dump: STRING is
			-- Dumped trace
		local
			actual_dump: STRING;
		do
			actual_dump := actual_type.dump;
			!!Result.make (16 + actual_dump.count);
			Result.append ("(like arg #");
			Result.append_integer (position);
			Result.append (")");
			Result.append (actual_dump);
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("(like arg #");
			a_clickable.put_int (position);
			a_clickable.put_char (')');
			actual_type.append_clickable_signature (a_clickable);
		end;

	has_like: BOOLEAN is
			-- Does the type have anchored type in its definition ?
		do
			Result := True;
		end;

	type_i: TYPE_I is
			-- Reduced type of `actual_type'
		do
			Result := actual_type.type_i;
		end;

	meta_type: TYPE_I is
			-- C type for `actual_type'
		do
			Result := actual_type.meta_type
		end;

	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_arg: LIKE_ARGUMENT;
		do
			other_like_arg ?= other;
			Result := 	other_like_arg /= Void
						and then
						other_like_arg.position = position
		end;

	is_deep_equal (other: TYPE): BOOLEAN is
		local
			other_like_arg: LIKE_ARGUMENT;
		do
			other_like_arg ?= other;
			Result := other_like_arg /= Void and then
				other_like_arg.position = position and then
				other_like_arg.actual_type.is_deep_equal (actual_type)
		end;

	create_info: CREATE_ARG is
			-- Byte code information for entity type creation
		do
			!!Result;
			Result.set_position (position);
		end;

end
