indexing

	description: 
		"Representation of an type anchored on a routine argument.";
	date: "$Date$";
	revision: "$Revision $"

class LIKE_ARGUMENT

inherit

	TYPE_A
		redefine
			actual_type, solved_type, has_like, instantiation_in, is_like,
			is_basic, instantiated_in, same_as, conformance_type, meta_type,
			is_like_argument, has_associated_class
		end;
	SHARED_LIKE_CONTROLER;
	SHARED_ARG_TYPES;

feature -- Properties

	actual_type: TYPE_A;
			-- Actual type of the argument

	is_like: BOOLEAN is
			-- Is the type an anchored one ?
		do
			Result := True;
		end;

	is_like_argument: BOOLEAN is
			-- Is Current a like argument? (True)
		do
			Result := True;
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then
				equivalent (actual_type, other.actual_type)
		end

feature -- Access

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := evaluated_type /= Void and then
				evaluated_type.has_associated_class
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

	associated_eclass: E_CLASS is
			-- Associated class
		do
			Result := evaluated_type.associated_eclass;
		end;

	position: INTEGER
			-- Position in the argument list

feature -- Setting

	set_position (p: like position) is
			-- Assign `p' to `position'.
		do
			position := p
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			actual_dump: STRING;
		do
			actual_dump := evaluated_type.dump;
			!!Result.make (16 + actual_dump.count);
			Result.append ("(like arg #");
			Result.append_integer (position);
			Result.append (")");
			Result.append (actual_dump);
		end;

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("(like arg #");
			st.add_int (position);
			st.add_char (')');
			actual_type.append_to (st);
		end;

feature {COMPILER_EXPORTER} -- Primitives

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
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
			argument_type: TYPE_B;
		do
			if Like_control.is_on then
				Like_control.raise_error
			else
				argument_type := f.arguments.i_th (position);
				Result := clone (Current);
					-- Recalculation of the anchor
				Result.set_actual_type 
					(argument_type.solved_type (feat_table, f).actual_type);
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end;
			end;
		end;

	instantiation_in (type: TYPE_A; written_id: CLASS_ID): LIKE_ARGUMENT is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			Result := clone (Current);
			Result.set_actual_type
					(actual_type.instantiation_in (type, written_id));
		end;

	instantiated_in (class_type: CL_TYPE_A): like Current is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := clone (Current);
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

	create_info: CREATE_ARG is
			-- Byte code information for entity type creation
		do
			!!Result;
			Result.set_position (position);
		end;

feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info (classc: CLASS_C): S_CLASS_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		do
			!! Result.make (Void, associated_class.id.id)
		end;

	storage_info_with_name (classc: CLASS_C): S_CLASS_TYPE_INFO is
			-- Storage info for Current type in class `classc'
			-- and store the name of the class for Current
		local
			ass_classc: CLASS_C
			class_name: STRING
		do
			ass_classc := associated_class;
			!! class_name.make (ass_classc.class_name.count);
			class_name.append (ass_classc.class_name);
			!! Result.make (class_name, ass_classc.id.id)
		end;

end -- class LIKE_ARGUMENT
