indexing
	description: "Actual type description."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPE_A

inherit
	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH

	SHARED_TYPE_I
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_GENERIC_CONSTRAINT

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		require
			v_not_void: v /= Void
			v_is_valid: v.is_valid
		deferred
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
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
	is_named_tuple: BOOLEAN is
			-- Is the current type a tuple with labels?
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

	is_solved: BOOLEAN is
		do
			Result := True
		end

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end

	has_formal_generic: BOOLEAN is
			-- Has type a formal generic parameter?
		do
			-- Do nothing
		end

	is_loose: BOOLEAN is
			-- Does type depend on formal generic parameters and/or anchors?
		do
			-- Do nothing
		ensure
			definition: Result = (has_like or has_formal_generic)
		end

	is_void: BOOLEAN is
			-- Is the type void (procedure type) ?
		do
		end

	is_like_current: BOOLEAN is
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end

feature -- Comparison

	frozen is_deep_equal (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			Result := other /= Void and then other.same_type (Current)
				and then is_equivalent (other)
		end;

	frozen equivalent (o1, o2: TYPE_A): BOOLEAN is
			-- Are `o1' and `o2' equivalent ?
			-- this feature is similar to `deep_equal'
			-- but ARRAYs and STRINGs are processed correctly
			-- (`deep_equal' will compare the size of the `area')
		do
			if o1 = Void then
				Result := o2 = Void
			else
				Result := o2 /= Void and then o2.same_type (o1) and then
					o1.is_equivalent (o2)
			end
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		require
			arg_non_void: other /= Void
			same_type: same_type (other)
		deferred
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			-- Do nothing
		end

feature -- Access

	has_associated_class: BOOLEAN is
			-- Does Current have an associated class?
		do
			Result := not (is_void or else is_formal or else is_none)
		ensure
			Yes_if_is: Result implies not (is_void or else
								is_formal or else is_none)
		end

	associated_class: CLASS_C is
			-- Class associated to the current type.
		require
			has_associated_class: has_associated_class
		deferred
		end

	actual_type: TYPE_A is
			-- Actual type of the interpreted type
			--| *** FIXME this will become obsolete
		do
			Result := Current
		end

	conformance_type: TYPE_A is
			-- Type which is used to check conformance
		do
			Result := actual_type
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

	frozen append_to (a_text_formatter: TEXT_FORMATTER) is
			-- Append `Current' to `text'.
		do
			ext_append_to (a_text_formatter, Void)
		end

	dump: STRING is
			-- Dumped trace
		deferred
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; f: E_FEATURE) is
			-- Append `Current' to `text'.
			-- `f' is used to retreive the generic type or argument name as string.
			-- This replaces the old "G#2" or "arg#1" texts in feature signature views.
			-- Actually used in FORMAL_A and LIKE_ARGUMENT.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
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
		require
			is_valid: is_valid
		deferred
		end

	meta_type: TYPE_I is
			-- Meta type
		require
			is_valid: is_valid
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

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' ?
		require
			is_valid: is_valid
			other_not_void: other /= Void
			other_is_valid: other.is_valid
		deferred
		end

	is_conformant_to (other: TYPE_A): BOOLEAN is
			-- Does Current inherit from other?
			-- Most of the time, it is equivalent to `conform_to' except
			-- when current is an expanded type.
		require
			is_valid: is_valid
			other_not_void: other /= Void
			other_is_valid: other.is_valid
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

	actual_argument_type (a_arg_types: ARRAY [TYPE_A]): TYPE_A is
			-- Type including like argument process based on `a_arg_types'.
		require
			a_arg_types_not_void: a_arg_types /= Void
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

	instantiated_in (class_type: TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		require
			good_argument: class_type /= Void
		do
			Result := Current
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

	check_labels (a_context_class: CLASS_C; a_node: TYPE_AS) is
			-- Check validity of `labels' of current in `a_context_class'.
		require
			a_context_class_not_void: a_context_class /= Void
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

	is_ancestor_valid: BOOLEAN is
			-- Is type ancestor valid?
			-- (This is currently checked only for expanded types that have
			-- an external ancestor, that is not supported by CIL code generation.)
		require
			il_generation: system.il_generation
		do
			Result := True
			if is_expanded and then not is_external and then associated_class.has_external_ancestor_class then
				Result := False
			end
		end

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		require
			has_current_class: system.current_class /= Void
			is_valid: is_valid
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
		   		if actual_type.has_associated_class then
					ass_class := actual_type.associated_class
					if ass_class.is_obsolete and then ass_class.lace_class.options.warnings.is_enabled ("obsolete_class") then
						create warn
						warn.set_class (current_class)
						warn.set_obsolete_class (ass_class)
						Error_handler.insert_warning (warn)
					end
				end
			end
		end

	update_dependance (feat_depend: FEATURE_DEPENDANCE) is
			-- Update dependency for Dead Code Removal
		do
		end

feature {COMPILER_EXPORTER}

	format (ctxt: TEXT_FORMATTER_DECORATOR) is
			-- Reconstitute text
		do
			ctxt.process_string_text (dump, Void)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class TYPE_A
