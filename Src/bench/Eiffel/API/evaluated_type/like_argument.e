-- Representation of an type anchored on a routine argument

class LIKE_ARGUMENT

inherit

	TYPE_A
		rename
			base_type as position,
			set_base_type as set_position
		redefine
			actual_type, solved_type, has_like, instantiation_in, is_like,
			is_basic, instantiated_in, same_as, conformance_type, meta_type
		end;
	SHARED_LIKE_CONTROLER;
	SHARED_ARG_TYPES;

feature -- Attributes

	argument_position: INTEGER;
			-- Argument position

	actual_type: TYPE_A;
			-- Actual type of the argument

feature -- Primitives

	set_argument_position (i: INTEGER) is
			-- Assign `i' to `argument_position'.
		do
			argument_position := i;
		end;

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
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
				Error_handler.raise ("Like cycle");
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
			Result := Argument_types.i_th (argument_position).actual_type;
		end;

	associated_class: CLASS_C is
			-- Associated class
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
			Result.append_integer (argument_position);
			Result.append (")");
			Result.append (actual_dump);
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
						other_like_arg.argument_position = argument_position
		end;

	create_info: CREATE_ARG is
			-- Byte code information for entity type creation
		do
			!!Result;
			Result.set_position (position);
		end;

end
