indexing

	description:

		"Eiffel types"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_TYPE

inherit

	ET_TYPE_ITEM

	ET_ACTUAL_PARAMETER
		undefine
			resolved_syntactical_constraint_with_type
		end

	ET_CONSTRAINT_TYPE
		undefine
			actual_parameter
		redefine
			type
		end

	ET_DECLARED_TYPE

	ET_TARGET_TYPE

	DEBUG_OUTPUT

	KL_IMPORTED_STRING_ROUTINES

feature -- Initialization

	reset is
			-- Reset type as it was just after it was last parsed.
		do
		end

	reset_qualified_anchored_types is
			-- Reset qualified anchored types contained in current type
			-- as they were just after it were last parsed.
		do
		end

feature -- Access

	base_class (a_context: ET_TYPE_CONTEXT): ET_CLASS is
			-- Base class of current type when it appears in `a_context'
			-- (Definition of base class in ETL2 page 198).
			-- Return "*UNKNOWN*" class if unresolved identifier type,
			-- or unmatched formal generic parameter.
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		ensure
			base_class_not_void: Result /= Void
		end

	base_type (a_context: ET_TYPE_CONTEXT): ET_BASE_TYPE is
			-- Base type of current type, when it appears in `a_context',
			-- only made up of class names and generic formal parameters
			-- when the root type of `a_context' is a generic type not
			-- fully derived (Definition of base type in ETL2 p.198).
			-- Replace by "*UNKNOWN*" any unresolved identifier type, or
			-- unmatched formal generic parameter if this parameter
			-- is current type.
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		ensure
			base_type_not_void: Result /= Void
			deep_base_type: Result.is_named_type
		end

	shallow_base_type (a_context: ET_BASE_TYPE): ET_BASE_TYPE is
			-- Base type of current type, when it appears in `a_context',
			-- but where the actual generic parameters are not replaced
			-- by their named version and should still be considered as
			-- viewed from `a_context'
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		ensure
			shallow_base_type_not_void: Result /= Void
		end

	base_type_actual (i: INTEGER; a_context: ET_TYPE_CONTEXT): ET_NAMED_TYPE is
			-- `i'-th actual generic parameter's type of the base type of current
			-- type when it appears in `a_context'
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
			i_large_enough: i >= 1
			i_small_enough: i <= base_type_actual_count (a_context)
		deferred
		ensure
			base_type_actual_not_void: Result /= Void
			definition: Result.same_named_type (base_type (a_context).actual_parameters.type (i), a_context.root_context, a_context.root_context)
			actual_parameter_type: Result.same_named_type (base_type_actual_parameter (i, a_context).type, a_context.root_context, a_context.root_context)
			named_type_named: Result.is_named_type
		end

	base_type_actual_parameter (i: INTEGER; a_context: ET_TYPE_CONTEXT): ET_ACTUAL_PARAMETER is
			-- `i'-th actual generic parameter of the base type of current
			-- type when it appears in `a_context'
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
			i_large_enough: i >= 1
			i_small_enough: i <= base_type_actual_count (a_context)
		deferred
		ensure
			base_type_actual_parameter_not_void: Result /= Void
			--definition: Result.same_actual_parameter (base_type (a_context).actual_parameters.actual_parameter (i), a_context.root_context, a_context.root_context)
			named_type_named: Result.type.is_named_type
		end

	base_type_index_of_label (a_label: ET_IDENTIFIER; a_context: ET_TYPE_CONTEXT): INTEGER is
			-- Index of actual generic parameter with label `a_label' in
			-- the base type of current type when it appears in `a_context';
			-- 0 if it does not exist
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
			a_label_not_void: a_label /= Void
		deferred
		ensure
			definition: Result = base_type (a_context).index_of_label (a_label)
			index_large_enough: Result >= 0
			index_small_enough: Result <= base_type_actual_count (a_context)
		end

	named_type (a_context: ET_TYPE_CONTEXT): ET_NAMED_TYPE is
			-- Same as `base_type' except when current type is still
			-- a formal generic parameter after having been replaced
			-- by its actual counterpart in `a_context'. Return this
			-- new formal type in that case instead of the base
			-- type of its constraint.
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			Result := base_type (a_context)
		ensure
			named_type_not_void: Result /= Void
			named_type_named: Result.is_named_type
		end

	shallow_named_type (a_context: ET_BASE_TYPE): ET_NAMED_TYPE is
			-- Same as `shallow_base_type' except when current type is still
			-- a formal generic parameter after having been replaced
			-- by its actual counterpart in `a_context'. Return this
			-- new formal type in that case instead of the base
			-- type of its constraint.
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			Result := shallow_base_type (a_context)
		ensure
			shallow_named_type_not_void: Result /= Void
		end

	named_parameter (a_context: ET_TYPE_CONTEXT): ET_ACTUAL_PARAMETER is
			-- Same as current actual parameter but its type
			-- replaced by its named type
		do
			Result := named_type (a_context)
		end

	type: ET_TYPE is
			-- Type
		do
			Result := Current
		ensure then
			definition: Result = Current
		end

	label: ET_IDENTIFIER is
			-- Label of `actual_parameter';
			-- Useful when part of a labeled tuple, Void if no label
		do
			-- No label.
		end

feature -- Measurement

	base_type_actual_count (a_context: ET_TYPE_CONTEXT): INTEGER is
			-- Number of actual generic parameters of the base type of current type
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		ensure
			definition: Result = base_type (a_context).actual_parameter_count
		end

feature -- Status report

	is_like_current: BOOLEAN is
			-- Is current type of the form 'like Current'?
		do
			-- Result := False
		end

	is_named_type: BOOLEAN is
			-- Is current type only made up of named types?
		do
			-- Result := False
		end

	is_base_type: BOOLEAN is
			-- Is current type only made up of base types?
		do
			-- Result := False
		ensure
			named_type: Result implies is_named_type
		end

	is_type_expanded (a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Is current type expanded when viewed from `a_context'?
			-- (Note that the feature name `is_expanded_type' is
			-- already the name of a feature in SmartEiffel's GENERAL.)
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		end

	is_type_reference (a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Is current type reference when viewed from `a_context'?
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			Result := not is_type_expanded (a_context)
		end

	has_anchored_type: BOOLEAN is
			-- Does current type contain an anchored type?
		do
			-- Result := False
		end

	has_identifier_anchored_type: BOOLEAN is
			-- Does current type contain an identifier anchored type
			-- (i.e. an anchored type other than 'like Current')?
		do
			-- Result := False
		end

	named_type_has_formal_type (i: INTEGER; a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does the named type of current type contain the formal generic parameter
			-- with index `i' when viewed from `a_context'?
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
			i_large_enough: i >= 1
		do
			-- Result := False
		end

	has_formal_types (a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does current type contain a formal generic parameter
			-- when viewed from `a_context'?
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	named_type_has_formal_types (a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does the named type of current type contain a formal generic parameter
			-- when viewed from `a_context'?
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	named_type_is_formal_type (a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Is named type of current type, or if it is a qualified type
			-- is the named type of its  target type (recursively),
			-- a formal parameter when viewed from `a_context'?
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	base_type_has_class (a_class: ET_CLASS; a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does the base type of current type contain `a_class'
			-- when it appears in `a_context'?
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
			a_class_not_void: a_class /= Void
		deferred
		end

	named_type_has_class (a_class: ET_CLASS; a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does the named type of current type contain `a_class'
			-- when it appears in `a_context'?
		require
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
			a_class_not_void: a_class /= Void
		do
			Result := base_type_has_class (a_class, a_context)
		end

	named_parameter_has_class (a_class: ET_CLASS; a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does the named parameter of current type contain `a_class'
			-- when it appears in `a_context'?
		do
			Result := named_type_has_class (a_class, a_context)
		end

feature -- Comparison

	same_syntactical_type (other: ET_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the basic types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		ensure
			symmetric: Result = other.same_syntactical_type (Current, a_context, other_context)
		end

	same_named_type (other: ET_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same named type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		ensure
			definition: Result = named_type (a_context).same_syntactical_type (other.named_type (other_context), other_context, a_context)
			symmetric: Result = other.same_named_type (Current, a_context, other_context)
		end

	same_base_type (other: ET_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same base type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		ensure
			definition: Result = base_type (a_context).same_syntactical_type (other.base_type (other_context), other_context, a_context)
			symmetric: Result = other.same_base_type (Current, a_context, other_context)
		end

feature {ET_TYPE, ET_TYPE_CONTEXT} -- Comparison

	same_syntactical_bit_type (other: ET_BIT_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the basic types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_syntactical_class_type (other: ET_CLASS_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the basic types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_syntactical_formal_parameter_type (other: ET_FORMAL_PARAMETER_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the basic types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_syntactical_like_current (other: ET_LIKE_CURRENT; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the basic types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_syntactical_like_feature (other: ET_LIKE_FEATURE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the basic types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_syntactical_qualified_like_identifier (other: ET_QUALIFIED_LIKE_IDENTIFIER; other_context: ET_TYPE_CONTEXT; a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the basic types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_syntactical_tuple_type (other: ET_TUPLE_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the basic types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_named_bit_type (other: ET_BIT_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same named type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_named_class_type (other: ET_CLASS_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same named type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_named_formal_parameter_type (other: ET_FORMAL_PARAMETER_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same named type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_named_tuple_type (other: ET_TUPLE_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same named type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_base_bit_type (other: ET_BIT_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same base type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_base_class_type (other: ET_CLASS_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same base type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_base_formal_parameter_type (other: ET_FORMAL_PARAMETER_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same base type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	same_base_tuple_type (other: ET_TUPLE_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same base type?
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

feature -- Conformance

	conforms_to_type (other: ET_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does current type appearing in `a_context' conform
			-- to `other' type appearing in `other_context'?
			-- (Note: 'current_system.ancestor_builder' is used on the classes
			-- whose ancestors need to be built in order to check for conformance.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		deferred
		end

feature {ET_TYPE, ET_TYPE_CONTEXT} -- Conformance

	conforms_from_bit_type (other: ET_BIT_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does `other' type appearing in `other_context' conform
			-- to current type appearing in `a_context'?
			-- (Note: 'current_system.ancestor_builder' is used on the classes
			-- whose ancestors need to be built in order to check for conformance.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	conforms_from_class_type (other: ET_CLASS_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does `other' type appearing in `other_context' conform
			-- to current type appearing in `a_context'?
			-- (Note: 'current_system.ancestor_builder' is used on the classes
			-- whose ancestors need to be built in order to check for conformance.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	conforms_from_formal_parameter_type (other: ET_FORMAL_PARAMETER_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does `other' type appearing in `other_context' conform
			-- to current type appearing in `a_context'?
			-- (Note: 'current_system.ancestor_builder' is used on the classes
			-- whose ancestors need to be built in order to check for conformance.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			other_context_is_root: other_context.is_root_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

	conforms_from_tuple_type (other: ET_TUPLE_TYPE; other_context, a_context: ET_TYPE_CONTEXT): BOOLEAN is
			-- Does `other' type appearing in `other_context' conform
			-- to current type appearing in `a_context'?
			-- (Note: 'current_system.ancestor_builder' is used on the classes
			-- whose ancestors need to be built in order to check for conformance.)
		require
			other_not_void: other /= Void
			other_context_not_void: other_context /= Void
			other_context_valid: other_context.is_valid_context
			a_context_not_void: a_context /= Void
			a_context_valid: a_context.is_valid_context
			-- no_cycle: no cycle in anchored types involved.
		do
			-- Result := False
		end

feature -- Type processing

	resolved_formal_parameters (a_parameters: ET_ACTUAL_PARAMETER_LIST): ET_TYPE is
			-- Version of current type where the formal generic
			-- parameter types have been replaced by their actual
			-- counterparts in `a_parameters'
		do
			Result := Current
		end

	resolved_formal_parameters_with_type (a_type: ET_TYPE): ET_TYPE is
			-- Version of current actual parameter where its type
			-- is replaced by `a_type'
		do
			Result := a_type
		end

	resolved_syntactical_constraint (a_formals: ET_FORMAL_PARAMETER_LIST;
		a_parser: ET_EIFFEL_PARSER_SKELETON): ET_TYPE is
			-- Version of current type, appearing in the constraint of
			-- one of the formal generic parameters in `a_formals', where
			-- class names and formal generic parameter names have been
			-- resolved (i.e. replaced by the corresponding Class_type,
			-- Tuple_type and Formal_parameter_type)
		do
			Result := Current
		end

feature -- Type context

	is_valid_context_type (a_root_context: ET_BASE_TYPE): BOOLEAN is
			-- Is current type only made up of class names and
			-- formal generic parameter names, and are the actual
			-- parameters of these formal parameters themselves
			-- in `a_root_context'?
		require
			a_root_context_not_void: a_root_context /= Void
		do
			-- Result := False
		end

feature -- Output

	to_text: STRING is
			-- Textual representation of current type
			-- (Create a new string at each call.)
		do
			create Result.make (15)
			append_to_string (Result)
		ensure
			to_text_not_void: Result /= Void
		end

	append_to_string (a_string: STRING) is
			-- Append textual representation of
			-- current type to `a_string'.
		require
			a_string_not_void: a_string /= Void
		deferred
		end

	unaliased_to_text: STRING is
			-- Textual representation of unaliased version of current type
			-- (Create a new string at each call.)
			-- An unaliased version if when aliased types such as INTEGER
			-- are replaced by the associated types such as INTEGER_32.
		do
			create Result.make (15)
			append_unaliased_to_string (Result)
		ensure
			unaliased_to_text_not_void: Result /= Void
		end

	append_unaliased_to_string (a_string: STRING) is
			-- Append textual representation of unaliased
			-- version of current type to `a_string'.
			-- An unaliased version if when aliased types such as INTEGER
			-- are replaced by the associated types such as INTEGER_32.
		require
			a_string_not_void: a_string /= Void
		do
			append_to_string (a_string)
		end

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'
		do
			Result := unaliased_to_text
		end

end
