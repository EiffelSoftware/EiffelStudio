indexing
	description: "Actual type description."
	date: "$Date$"
	revision: "$Revision $"

deferred class TYPE_A

inherit
	TYPE_B
		rename
			position as comment_position
		undefine
			append_to
		redefine
			is_solved, same_as, format
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_TYPE_I

feature -- Properties

	generics: ARRAY [TYPE_A] is
			-- Actual generic types
		do
			-- Void
		end

	is_valid: BOOLEAN is
			-- The associated class is still in the system
		do
			Result := True
		end

	is_integer: BOOLEAN is
			--  Is the current actual type an integer type ?
		do
			-- Do nothing
		end

	is_real: BOOLEAN is
			-- Is the current actual type a real type ?
		do
			-- Do nothing
		end

	is_double: BOOLEAN is
			-- Is the current actual type a double type ?
		do
			-- Do nothing
		end

	is_character: BOOLEAN is
			-- Is the current actual type a character type ?
		do
			-- Do nothing
		end

	is_boolean: BOOLEAN is
			-- Is the current actual type a boolean type ?
		do
			-- Do nothing
		end

	is_bits: BOOLEAN is
			-- Is the current actual type a bits type ?
		do
			-- Do nothing
		end

	is_formal: BOOLEAN is
			-- Is the current actual type a formal generic ?
		do
			-- Do nothing
		end

	is_expanded: BOOLEAN is
			-- Is the current actual type an expanded one ?
		do
			-- Do nothing
		end

	is_separate: BOOLEAN is
			-- Is the current actual type a separate one ?
		do
			-- Do nothing
		end

	is_none: BOOLEAN is
			-- Is the current actual type a none type ?
		do
			-- Do nothing
		end

	is_basic: BOOLEAN is
			-- Is the current actual type a basic type ?
		do
			-- Do nothing
		end

	is_like: BOOLEAN is
			-- Is the current type an anchored one ?
		do
			-- Do nothing
		end

	is_like_argument: BOOLEAN is
			-- Is the current type a like argument?
		do
			-- Do nothing
		end

	is_multi_type: BOOLEAN is
			-- Is the current type a manifest array
		do
			-- Do nothing
		end

	is_pointer: BOOLEAN is
			-- Is the current type a pointer type ?
		do
			-- Do nothing
		end

	is_hector: BOOLEAN is
			-- Is the current type an hector type ?
		do
			-- Do nothing
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			-- Do nothing
		end

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := not (is_void or else is_formal or else is_none)
		ensure
			Yes_if_is: Result implies not (is_void or else 
								is_formal or else is_none)
		end

	evaluated_type: TYPE_A is
			-- Evaluated type (for like types)	
		do
			Result := actual_type
		end

	actual_type: TYPE_A is
			-- Actual type of the interpreted type
			--| *** FIXME this will become obsolete
		do
			Result := Current
		end

	has_generics: BOOLEAN is
			-- Has the current type generics types ?
		do
			Result := generics /= Void
		end

	associated_eclass: CLASS_C is
			-- Eiffel class associated to the current type
		deferred
		ensure
			non_void_if_has_associated_class: 
				has_associated_class implies Result /= Void
		end

feature -- Output

	append_to (structured_text: STRUCTURED_TEXT) is
		deferred
		end

feature {COMPILER_EXPORTER} -- Access

	has_expanded: BOOLEAN is
			-- Has the current type some expanded types in itself ?
		do
			-- Do nothing
		end

	type_i: TYPE_I is
			-- C type
		deferred
		end

	meta_type: TYPE_I is
			-- Meta type
		do
			Result := type_i
		end

	set is
		do
		end

	is_numeric: BOOLEAN is
			-- Is the current actual type a numeric type ?
		do
			-- Do nothing
		end

	check_const_gen_conformance (target_type: TYPE_A; a_class: CLASS_C) is
		local
			vtcg5: VTCG5
		do
			if not conform_to (target_type) then
				!!vtcg5
				vtcg5.set_class (a_class)
				vtcg5.set_actual_type (Current)
				vtcg5.set_constraint_type (target_type)
				Error_handler.insert_error (vtcg5)
			end
		end

	check_conformance (target_name: STRING; target_type: TYPE_A) is
			-- Check if Current conforms to `other'.
			-- If not, insert error into Error handler.
		local
			vjar: VJAR
		do
			if not conform_to (target_type) then
				!!vjar
				context.init_error (vjar)
				vjar.set_source_type (Current)
				vjar.set_target_type (target_type)
				vjar.set_target_name (target_name)
				Error_handler.insert_error (vjar)
			end
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' ?
		do
			Result := internal_conform_to (other, False)
		end

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
			-- [If `in_generics' is set, we are within generic parameters].
		require
			good_argument: other /= Void
		deferred
		end

	redeclaration_conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' for a redeclaration ?
		do
			Result := internal_conform_to (other, True)
		end

	has_formal_generic: BOOLEAN is
			-- Has the current type formal generic parameter in its type ?
		do
			-- Do nothing
		end

	valid_generic (type: TYPE_A): BOOLEAN is
			-- Do the generic parameter of `type' conform to those of
			-- Current ?
		do
		end

	associated_class: CLASS_C is
			-- Class associated to the current type
		deferred
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			Result := Current
		end

	conformance_type: TYPE_A is
			-- Conformance type including like argument process
		do
			Result := Current
		end

	instantiation_in (type: TYPE_A; written_id: CLASS_ID): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the class of id `written_id'.
		require
			good_argument: type /= Void
			positive_id: written_id /= Void
		do
			Result := Current
		end

	instantiated_in (class_type: CL_TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		require
			good_argument: class_type /= Void
		do
			Result := Current
		end

	is_solved: BOOLEAN is
		do
			Result := True
		end

	duplicate: like Current is
			-- Duplication
		do
			Result := clone (Current)
		end

	good_generics: BOOLEAN is
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		do
			Result := True
		end

	error_generics: VTUG is
			-- Build the error if `good_generics' returns False
		do
		end

	check_constraints (context_class: CLASS_C): LINKED_LIST [CONSTRAINT_INFO] is
			-- Check the constained genericity validity rule and leave
			-- error info in `Constraint_error_list'
		require
			good_argument: context_class /= Void
			good_generic_count: good_generics
		do
		end

	expanded_deferred: BOOLEAN is
			-- Is the expanded type deferred ?
		require
			has_expanded
		local
			act_type: TYPE_A
		do
			act_type := actual_type
			Result := act_type.is_expanded and then
						act_type.associated_class.is_deferred
		end

	valid_expanded_creation (class_c: CLASS_C): BOOLEAN is
			-- Is the expanded type has an associated class with one
			-- creation routine with no arguments only, exported to
			-- `a_class'
		require
			has_expanded
		local
			a_class: CLASS_C
			creators: EXTEND_TABLE [EXPORT_I, STRING]
			creation_name: STRING
			creation_feature: FEATURE_I
		do
			if is_expanded then
				a_class := associated_class
				creators := a_class.creators
				if creators = Void then
					Result := True
				elseif creators.count = 1 then
					creators.start
					creation_name := creators.key_for_iteration
					creation_feature :=
									a_class.feature_table.item (creation_name)
					Result := creation_feature.argument_count = 0 and then
						creators.item_for_iteration.valid_for (class_c)
				else 
					Result := False
				end
			else
				Result := True
			end
		end

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		require
			good_argument: type /= Void
		do	
			-- Do nothing
		end

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		deferred
		end

	check_for_obsolete_class (current_class: CLASS_C) is
			-- Check for obsolete class from Current. If
			-- obsolete then display warning message.
		require
			good_arg: current_class /= Void
		local
			ass_class: CLASS_C
			warn: OBS_CLASS_WARN
		do
			if not current_class.is_obsolete then
				ass_class := actual_type.associated_class
		   		if 	(ass_class /= Void) and then ass_class.is_obsolete then
					!!warn
					warn.set_class (current_class)
					warn.set_obsolete_class (ass_class)
					Error_handler.insert_warning (warn)
				end
			end
		end

feature {COMPILER_EXPORTER}

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text
		do
			ctxt.put_string (dump)
		end

	storage_info (classc: CLASS_C): S_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		deferred
		ensure
			valid_result: result /= Void
		end

	storage_info_with_name (classc: CLASS_C): S_TYPE_INFO is
			-- Storage info for Current type in class `classc'
			-- and store the name of the class for Current
		deferred
		ensure
			valid_result: result /= Void
		end

end -- class TYPE_A
