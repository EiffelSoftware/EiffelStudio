indexing
	description: "Actual type description."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPE_A

inherit
	TYPE_AS
		rename
			start_position as comment_position
		redefine
			is_solved, same_as, format, append_to
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
		export
			{NONE} all
		end

	SHARED_GENERIC_CONSTRAINT

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
		end

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
		
	is_natural: BOOLEAN is
			-- Is current actual type a natural type?
		do
			-- Do nothing
		end

	is_real_32: BOOLEAN is
			-- Is the current actual type a real 32 bits type ?
		do
			-- Do nothing
		end

	is_real_64: BOOLEAN is
			-- Is the current actual type a real 64 bits type ?
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
		
	is_reference: BOOLEAN is
			-- Is current actual type a reference one?
		do
			Result := not is_expanded
		end
		
	is_true_expanded: BOOLEAN is
			-- Is current actual type an expanded one which is not basic?
		do
			Result := is_expanded and not is_basic
		end

	is_basic: BOOLEAN is
			-- Is the current actual type a basic type ?
		do
			-- Do nothing
		end
		
	is_external: BOOLEAN is
			-- Is current type based on an external one?
		do
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
		
	is_typed_pointer: BOOLEAN is
			-- Is current type a typed pointer type ?
		do
			-- Do nothing
		end

	is_tuple: BOOLEAN is
			-- Is it a TUPLE type
		do
			-- Do nothing
		end
		
	is_named_type: BOOLEAN is
			-- Is it a named type?
		do
		end

	is_full_named_type: BOOLEAN is
			-- Is it a full named type?
		do
		ensure
			is_full_named_type_consistent: Result implies is_named_type
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

	associated_class: CLASS_C is
			-- Class associated to the current type
		deferred
		end

	actual_type: TYPE_A is
			-- Actual type of the interpreted type
			--| *** FIXME this will become obsolete
		do
			Result := Current
		end

	deep_actual_type: TYPE_A is
			-- Actual type; recursive on generic types
			-- NOTE by M.S: Needed for ROUTINEs - perhaps
			--              this is the intended meaning
			--              of 'actual_type' - but 'actual_type'
			--              does not recurs on generics(?)!
		do
			Result := actual_type
		end

	has_generics: BOOLEAN is
			-- Has the current type generics types ?
		do
			Result := generics /= Void
		end

	intrinsic_type: TYPE_A is
			-- Default type of a manifest constant.
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

feature -- Output

	append_to (structured_text: STRUCTURED_TEXT) is
			-- Append `Current' to `text'.
		do
			ext_append_to (structured_text, Void)
		end

	ext_append_to (structured_text: STRUCTURED_TEXT; f: E_FEATURE) is
			-- Append `Current' to `text'.
			-- `f' is used to retreive the generic type or argument name as string.
			-- This replaces the old "Generic #2" or "arg #1" texts in feature signature views.
			-- Actually used in FORMAL_A and LIKE_ARGUMENT.
		require
			structured_text_not_void: structured_text /= Void
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

	is_numeric: BOOLEAN is
			-- Is the current actual type a numeric type ?
		do
			-- Do nothing
		end

	check_const_gen_conformance (a_gen_type: GEN_TYPE_A; a_target_type: TYPE_A; a_class: CLASS_C; i: INTEGER) is
			-- Is `Current' a valid generic parameter at position `i' of `gen_type'?
		require
			a_gen_type_not_void: a_gen_type /= Void
			a_target_type_not_void: a_target_type /= Void
			a_class_not_void: a_class /= Void
			i_non_negative: i > 0
		local
			l_vtcg7: VTCG7
		do
			if not conform_to (a_target_type) then
					-- FIXME: Manu 02/04/2004 We should be checking convertibility here,
					-- but for the moment it is not yet possible because this check is done
					-- before we do degree 4. What we need to implement is the ability
					-- to check converitibility without having to go through a full
					-- degree 4
				reset_constraint_error_list
				generate_constraint_error (a_gen_type, Current, a_target_type, i)
				create l_vtcg7
				l_vtcg7.set_in_constraint (True)
				l_vtcg7.set_class (a_class)
				l_vtcg7.set_error_list (constraint_error_list)
				l_vtcg7.set_parent_type (a_gen_type)
				Error_handler.insert_error (l_vtcg7)
			end
		end

	check_conformance (target_name: STRING; target_type: TYPE_A) is
			-- Check if Current conforms to `other'.
			-- If not, insert error into Error handler.
		require
			target_name_not_void: target_name /= Void
			target_type_not_void: target_type /= Void
		local
			vjar: VJAR
		do
			if not conform_to (target_type) then
				create vjar
				context.init_error (vjar)
				vjar.set_source_type (Current)
				vjar.set_target_type (target_type)
				vjar.set_target_name (target_name)
				Error_handler.insert_error (vjar)
			end
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' ?
		require
			other_not_void: other /= Void
		deferred
		end
		
	is_conformant_to (other: TYPE_A): BOOLEAN is
			-- Does Current inherit from other?
			-- Most of the time, it is equivalent to `conform_to' except
			-- when current is an expanded type.
		require
			other_not_void: other /= Void
		do
			Result := conform_to (other)
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		require
			a_context_class_not_void: a_context_class /= Void
			a_target_type_not_void: a_target_type /= Void
		do
			Result := False
			context.set_last_conversion_info (Void)
		ensure
			context_set: Result implies context.last_conversion_info /= Void
		end
		
	valid_generic (type: TYPE_A): BOOLEAN is
			-- Do the generic parameter of `type' conform to those of
			-- Current ?
		require
			type_not_void: type /= Void
			conforming_type: type.associated_class.conform_to (associated_class)
		do
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

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the class of id `written_id'.
		require
			good_argument: type /= Void
			positive_id: written_id > 0
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
			Result := twin
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

	check_constraints (context_class: CLASS_C) is
			-- Check the constained genericity validity rule and leave
			-- error info in `constraint_error_list'
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
			creators: HASH_TABLE [EXPORT_I, STRING]
			l_export: EXPORT_I
		do
			if is_expanded then
				a_class := associated_class
				if a_class.is_external then
					Result := True
				else
					creators := a_class.creators
					if creators = Void then
						Result := True
					else
						creators.search (a_class.default_create_feature.feature_name)
						if creators.found then
							l_export := creators.found_item
							Result := l_export.valid_for (class_c)
						end
					end
				end
			else
				Result := True
			end
		end

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		require
			has_current_class: system.current_class /= Void
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
					create warn
					warn.set_class (current_class)
					warn.set_obsolete_class (ass_class)
					Error_handler.insert_warning (warn)
				end
			end
		end

	update_dependance (feat_depend: FEATURE_DEPENDANCE) is
			-- Update dependency for Dead Code Removal
		local
			a_class: CLASS_C
			like_feat: LIKE_FEATURE
			depend_unit: DEPEND_UNIT
			feature_i: FEATURE_I
		do
			like_feat ?= Current
			if like_feat /= Void then
					-- we must had a dependance to the anchor feature
				a_class := System.class_of_id (like_feat.class_id)
				feature_i := a_class.feature_table.item_id (like_feat.feature_name_id)
				create depend_unit.make (like_feat.class_id, feature_i)
				feat_depend.extend (depend_unit)
			end
		end

feature {COMPILER_EXPORTER}

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_string (dump)
		end

feature {NONE} -- Implementation

	delayed_convert_constraint_check (
			context_class: CLASS_C;
			gen_type: GEN_TYPE_A
			to_check, constraint_type: TYPE_A;
			i: INTEGER;
			in_constraint: BOOLEAN)
		is
			-- Check that if we have class A [G -> ANY] and we found A [X] where
			-- X is expanded, then it exists a conversion routine from X to reference X
			-- and that `reference X' conforms to the constraint ANY.
			-- Delayed because could not be done during degree 4 since information
			-- about conversion routine is usually not yet computed.
		require
			context_class_not_void: context_class /= Void
			gen_type_not_void: gen_type /= Void
			to_check_not_void: to_check /= Void
			constraint_type_not_void: constraint_type /= Void
			to_check_is_expanded: to_check.is_expanded
			constraint_type_is_reference: not constraint_type.is_expanded
		local
			l_vtcg7: VTCG7
		do
			reset_constraint_error_list
			if context_class.is_valid and to_check.is_valid then
				if
					not (to_check.convert_to (context_class, constraint_type) and
					to_check.is_conformant_to (constraint_type))
				then
					generate_constraint_error (gen_type, to_check, constraint_type, i)
						-- The feature listed in the creation constraint have
						-- not been declared in the constraint class.
					create l_vtcg7
					l_vtcg7.set_in_constraint (in_constraint)
					l_vtcg7.set_class (context_class)
					l_vtcg7.set_error_list (constraint_error_list)
					l_vtcg7.set_parent_type (gen_type)
					Error_handler.insert_error (l_vtcg7)
				end
			end
		end

	generate_constraint_error (gen_type: GEN_TYPE_A; current_type, constraint_type: TYPE_A; position: INTEGER) is
			-- Build the error corresponding to the VTCG error
		local
			constraint_info: CONSTRAINT_INFO
		do
			create constraint_info
			constraint_info.set_type (gen_type)
			constraint_info.set_actual_type (current_type)
			constraint_info.set_formal_number (position)
			constraint_info.set_constraint_type (constraint_type)
			constraint_error_list.extend (constraint_info)
		end

end -- class TYPE_A
