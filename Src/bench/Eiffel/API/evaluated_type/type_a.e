-- Actual type description

deferred class TYPE_A

inherit

	TYPE
		redefine
			is_solved, same_as
		end;
	SHARED_WORKBENCH;
	SHARED_CONSTRAINT_ERROR;
	SHARED_TYPE_I;

feature

	base_type: INTEGER;
			-- Base type of the actual type

	set_base_type (i: INTEGER) is
			-- Assign `i' tp `base_type'.
		do
			base_type := i;
		end;

	generics: ARRAY [TYPE_A] is
			-- Actual generic types
		do
			-- Void
		end;

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' ?
		do
			Result := internal_conform_to (other, False);
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
			-- [If `in_generics' is set, we are within generic parameters].
		require
			good_argument: other /= Void
		deferred
		end;

	redeclaration_conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' for a redeclaration ?
		do
			Result := internal_conform_to (other, True);
		end;

	has_generics: BOOLEAN is
			-- Has the current type generics types ?
		do
			Result := generics /= Void;
		end;

	has_formal_generic: BOOLEAN is
			-- Has the current type formal generic parameter in its type ?
		do
			-- Do nothing
		end;

	valid_generic (type: TYPE_A): BOOLEAN is
			-- Do the generic parameter of `type' conform to those of
			-- Current ?
		do
		end;

	associated_class: CLASS_C is
			-- Class associated to the current type
		deferred
		end;

	is_integer: BOOLEAN is
			--  Is the current actual type an integer type ?
		do
			-- Do nothing
		end;

	is_real: BOOLEAN is
			-- Is the current actual type a real type ?
		do
			-- Do nothing
		end;

	is_double: BOOLEAN is
			-- Is the current actual type a double type ?
		do
			-- Do nothing
		end;

	is_character: BOOLEAN is
			-- Is the current actual type a character type ?
		do
			-- Do nothing
		end;

	is_boolean: BOOLEAN is
			-- Is the current actual type a boolean type ?
		do
			-- Do nothing
		end;

	is_bits: BOOLEAN is
			-- Is the current actual type a bits type ?
		do
			-- Do nothing
		end;

	is_formal: BOOLEAN is
			-- Is the current actual type a formal generic ?
		do
			-- Do nothing
		end;

	is_expanded: BOOLEAN is
			-- Is the current actual type an expanded one ?
		do
			-- Do nothing
		end;

	is_none: BOOLEAN is
			-- Is the current actual type a none type ?
		do
			-- Do nothing
		end;

	is_basic: BOOLEAN is
			-- Is the current actual type a basic type ?
		do
			-- Do nothing
		end;

	is_numeric: BOOLEAN is
			-- Is the current actual type a numeric type ?
		do
			-- Do nothing
		end;

	is_like: BOOLEAN is
			-- Is the current type an anchored one ?
		do
			-- Do nothing
		end;

	is_pointer: BOOLEAN is
			-- Is the current type a pointer type ?
		do
			-- Do nothing
		end;

	is_hector: BOOLEAN is
			-- Is the current type an hector type ?
		do
			-- Do nothing
		end;

	has_expanded: BOOLEAN is
			-- Has the current type some expanded types in itself ?
		do
			-- Do nothing
		end;

	type_i: TYPE_I is
			-- C type
		deferred
		end;

	meta_type: TYPE_I is
			-- Meta type
		do
			Result := type_i;
		end;

	set is
		do
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			Result := Current
		end;

	actual_type: TYPE_A is
			-- Actual type of the interpreted type
		do
			Result := Current
		end;

	conformance_type: TYPE_A is
			-- Conformance type including like argument process
		do
			Result := Current
		end;

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the class of id `written_id'.
		require
			good_argument: type /= Void;
			positive_id: written_id > 0;
		do
			Result := Current
		end;

	instantiated_in (class_type: CL_TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		require
			good_argument: class_type /= Void;
		do
			Result := Current;
		end;

	is_solved: BOOLEAN is
		do
			Result := True;
		end;

	duplicate: like Current is
			-- Duplication
		do
			Result := twin;
		end;

	good_generics: BOOLEAN is
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		do
			Result := True;
		end;

	check_constraints (context_class: CLASS_C) is
			-- Check the constained genericity validity rule and leave
			-- error info in `Constraint_error_list'
		require
			good_argument: context_class /= Void;
			good_generic_count: good_generics;
		do
			Constraint_error_list.wipe_out;
			check_generics (context_class);
		end;

	check_generics (context_class: CLASS_C) is
			-- Check the constained genericity validity rule
		require
			good_argument: context_class /= Void;
			good_generic_count: good_generics;
		do
		end;

	good_expanded1: BOOLEAN is
			-- Is the expanded type a good one ?
		require
			has_expanded
		local
			act_type: TYPE_A;
		do
			act_type := actual_type;
			Result := not (	act_type.is_expanded
							and then
							act_type.associated_class.is_deferred);
		end;

	good_expanded2: BOOLEAN is
			-- Is the expaned type has an associated class with one
			-- creation routine with no arguments only ?
		require
			has_expanded
		local
			a_class: CLASS_C;
			creators: EXTEND_TABLE [EXPORT_I, STRING];
			creation_name: STRING;
			creation_feature: FEATURE_I;
		do
--			if is_expanded then
--				a_class := associated_class;
--				creators := a_class.creators;
--				if creators = Void then
--					Result := True;
--				elseif creators.count = 1 then
--					creators.start;
--					creation_name := creators.key_for_iteration;
--					creation_feature :=
--									a_class.feature_table.item (creation_name);
--					Result := creation_feature.argument_count = 0;
--				else 
--					Result := False;
--				end;
--			else
--				Result := True;
--			end;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			-- Do nothing
		end;

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		require
			good_argument: type /= Void;
		do	
			-- Do nothing
		end;

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		deferred
		end;

end
