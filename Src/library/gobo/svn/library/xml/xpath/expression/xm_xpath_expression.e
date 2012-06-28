indexing

	description:

		"XPath expression"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class XM_XPATH_EXPRESSION

inherit

	XM_XPATH_STATIC_PROPERTY

	XM_XPATH_EVALUATION_CONSTANTS

	XM_XPATH_TYPE
		export {NONE} all end

	XM_XPATH_STANDARD_NAMESPACES
		export {NONE} all end

	XM_XPATH_NAME_UTILITIES
		export {NONE} all end

	XM_XPATH_PROMOTION_ACTIONS
		export {NONE} all end
	
	XM_XPATH_SHARED_EXPRESSION_TESTER
		export {NONE} all end

	XM_XPATH_SHARED_EXPRESSION_FACTORY
		export {NONE} all end

	XM_XPATH_SHARED_TYPE_FACTORY
		export {NONE} all end

	XM_XPATH_SHARED_ANY_ITEM_TYPE

	XM_XPATH_SHARED_ANY_NODE_TEST
		export {NONE} all end
	
	XM_XPATH_SHARED_NO_NODE_TEST
		export {NONE} all end

	XM_XPATH_NODE_KIND_ROUTINES
		export {NONE} all end

	XM_XPATH_SHARED_NAME_POOL

	XM_XPATH_ERROR_TYPES

	XM_XPATH_DEBUGGING_ROUTINES
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	KL_IMPORTED_ANY_ROUTINES
		export {NONE} all end

	KL_IMPORTED_BOOLEAN_ROUTINES
		export {NONE} all end

	XM_XPATH_VARIABLE_DECLARATION_ROUTINES
		export {NONE} all end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, when known;
			-- All expression return sequences, in general;
			-- This routine determines the type of the items within the
			-- sequence, assuming that (a) this is known in advance,
			-- and (b) it is the same for all items in the sequence.
		require
			not_in_error: not is_error
		deferred
		ensure
			item_type_not_void: Result /= Void
		end

	atomized_item_type (always_untyped: BOOLEAN): XM_XPATH_ITEM_TYPE is
			-- Type of atomized items
		local
			a_base_type: XM_XPATH_ITEM_TYPE
			a_node_kind_mask: INTEGER
			finished: BOOLEAN
			a_content_type: XM_XPATH_SCHEMA_TYPE
		do
			a_base_type := item_type
			if a_base_type.is_atomic_type then
				Result := a_base_type
			elseif a_base_type.is_node_test then
				if a_base_type.is_no_node_test then
					Result := a_base_type
					finished := True
				else
					a_node_kind_mask := a_base_type.as_node_test.node_kind_mask
					if always_untyped then
						
						-- Some node-kinds always have a typed value that's a string
						
						if INTEGER_.bit_or (a_node_kind_mask, string_kinds) = string_kinds then
							Result := type_factory.string_type
							finished := True
							
							-- Some node-kinds are always untypedAtomic; some are conditionally so:
							
						elseif INTEGER_.bit_or (a_node_kind_mask, untyped_if_untyped_kinds) = untyped_if_untyped_kinds then
							Result := type_factory.untyped_atomic_type
							finished := True
						end
					else
						if INTEGER_.bit_or (a_node_kind_mask, untyped_kinds) = untyped_kinds then
							Result := type_factory.untyped_atomic_type
							finished := True
						end
					end
					if not finished then
						a_content_type := a_base_type.as_node_test.content_type
						if a_content_type.is_simple_type then
							Result := a_content_type.as_simple_type.common_atomic_type
						else

							-- TODO: Complex types for schema-aware processor

							Result := type_factory.untyped_atomic_type
						end
					end
				end
			else
				Result := type_factory.any_atomic_type
			end
		ensure
			result_not_void: Result /= Void
		end

	sub_expressions: DS_ARRAYED_LIST [XM_XPATH_EXPRESSION] is
			-- Immediate sub-expressions of `Current'
		require
			not_in_error: not is_error
		deferred
			-- TODO: consider changing this to return a sequence iterator, as now that
			--       XSLT compiles to expressions, there could be a lot of array
			--       copying going on
		ensure
			expression_tester: Result /= Void and then Result.equality_tester /= Void and then Result.equality_tester.is_equal (expression_tester)
		end

	container: XM_XPATH_EXPRESSION_CONTAINER is
			-- Containing parent;
			-- `Void' for top-level expressions and literal values.
			-- Within an XSLT stylesheet, returns the XSLT instruction.
		deferred
		end

	lazy_evaluation_mode: INTEGER is
			-- Method used for lazy evaluation of `Current'
		do
			if depends_upon_position or depends_upon_last or
				depends_upon_current_item or depends_upon_current_group or depends_upon_regexp_group then
				Result := eager_evaluation_mode
			elseif is_deferred_error then
				Result := Call_evaluate_item
			elseif is_lazy_expression then
				Result := Create_memo_closure
			elseif not cardinality_allows_many then
				Result := eager_evaluation_mode
			elseif is_tail_expression then
				if as_tail_expression.base_expression.is_variable_reference then
					Result := Evaluate_as_lazy_tail_expression
				else
					Result := Create_closure
				end
			else
				Result := Create_closure
			end
		ensure
			lazy_evaluation_mode_large_enough: Result >= Evaluation_method_undecided
			lazy_evaluation_mode_small_enough: Result <= Create_memo_closure
			none_needed_implies_value: Result = No_evaluation_needed implies is_value
			closure_over_computed_expression: Result = Create_closure implies is_computed_expression
			memo_closure_over_computed_expression: Result = Create_memo_closure implies is_computed_expression
		end

	eager_evaluation_mode: INTEGER is
			-- Method used for eager evaluation of `Current'
		do
			if is_evaluate_supported then
				Result := Call_evaluate_item
			elseif is_iterator_supported then
				Result := Iterate_and_materialize
			else
				Result := Call_generate_events
			end
		ensure
			eager_evaluation_mode_large_enough: Result >= Evaluation_method_undecided
			eager_evaluation_mode_small_enough: Result <= Call_generate_events
			none_needed_implies_value: Result = No_evaluation_needed implies is_value
		end

feature -- Comparison

	same_expression (other: XM_XPATH_EXPRESSION): BOOLEAN is
			-- Are `Current' and `other' the same expression?
		require
			other_not_void: other /= Void
		deferred
		end

feature -- Status report

	is_error: BOOLEAN is
			-- Is `Current' in error?
		do
			Result := error_value /= Void
		end

	is_evaluate_supported: BOOLEAN is
			-- Is `evaluate' supported natively?
		do
			Result := INTEGER_.bit_and (native_implementations, Supports_evaluate) /= 0
		end

	is_iterator_supported: BOOLEAN is
			-- Is `iterator' supported natively?
		do
			Result := INTEGER_.bit_and (native_implementations, Supports_iterator) /= 0
		end

	is_process_supported: BOOLEAN is
			-- Is `generate_events' supported natively?
		do
			Result := INTEGER_.bit_and (native_implementations, Supports_process) /= 0
		end

	error_value: XM_XPATH_ERROR_VALUE
			-- Last error value

	last_evaluated_string: XM_XPATH_STRING_VALUE
			-- Value from last call to `evaluate_as_string'

	last_boolean_value: XM_XPATH_BOOLEAN_VALUE
			-- Value from last call to `calculate_effective_boolean_value'

	last_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
			-- Result from last call to `create_iterator'
	
	last_node_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
			-- Result from last call to `create_node_iterator'
	
	last_slot_number: INTEGER
			-- Last allocated variable slot number
	
	is_deferred_error: BOOLEAN is
			-- Is `Current' a deferred error?
		do
			Result := False
		end

	is_node_sequence: BOOLEAN is
			-- Is `Current' a sequence of zero or more nodes?
		do
			Result := is_node_item_type (item_type)
		end

	calls_function (a_name_code: INTEGER): BOOLEAN is
			-- Does `Current' include a call to function named by `a_name_code'?
		local
			l_fingerprint: INTEGER
			l_expression: XM_XPATH_EXPRESSION
			l_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
		do
			l_fingerprint := fingerprint_from_name_code (a_name_code)
			if is_function_call then
				Result := as_function_call.fingerprint = l_fingerprint
			end
			if not Result then
				from
					l_cursor := sub_expressions.new_cursor
					l_cursor.start
				until
					Result or l_cursor.after
				loop
					l_expression := l_cursor.item
					Result := l_expression.calls_function (a_name_code)
					l_cursor.forth
				end
			end
		end

	display (a_level: INTEGER) is
			-- Diagnostic print of expression structure to `std.error'
		require
			no_error: not is_error
		deferred
		end

	contains_recursive_tail_function_calls (a_name_code, a_arity: INTEGER): UT_TRISTATE is
			-- Does `Current' contains recursive tail calls of stylesheet functions?
			-- `Undecided' means it contains a tail call to another function.
		do
			create Result.make_false
		ensure
			contains_recursive_tail_function_calls_not_void: Result /= Void
		end

	is_trace_wrapper: BOOLEAN is
			-- Is `Current' an `XM_XSLT_TRACE_WRAPPER'?
		do
			Result := False
		end

	is_untyped_atomic_converter: BOOLEAN is
			-- Is `Current' an `XM_XPATH_UNTYPED_ATOMIC_CONVERTER'?
		do
			Result := False
		end

	is_value_of: BOOLEAN is
			-- Is `Current' an `XM_XSLT_COMPILED_VALUE_OF'?
		do
			Result := False
		end

	is_current_function: BOOLEAN is
			-- Is `Current' the XSLT "current()" function?
		do
			Result := False
		end

	is_current_group: BOOLEAN is
			-- Is `Current' the XSLT "current-group()" function?
		do
			Result := False
		end

	is_current_grouping_key: BOOLEAN is
			-- Is `Current' the XSLT "current-grouping-key()" function?
		do
			Result := False
		end

	is_pattern_bridge: BOOLEAN is
			-- Is `Current' a bridge to an XSLT pattern?
		do
			Result := False
		end

	is_function_package: BOOLEAN is
			-- Is `Current' an XSLT function call package?
		do
			Result := False
		end

	is_function_call: BOOLEAN is
			-- Is `Current' an XPath function call?
		do
			Result := False
		end

	is_mapped_path_expression: BOOLEAN is
			-- Is `Current' a mapped path expression?
		do
			Result := False
		end

	is_user_function_call: BOOLEAN is
			-- Is `Current' a user function call?
		do
			Result := False
		end

	is_tail_call: BOOLEAN is
			-- Is `Current' an XPath tail call?
		do
			Result := False
		end

	is_system_function: BOOLEAN is
			-- Is `Current' an XPath system function?
		do
			Result := False
		end

	is_unordered_function: BOOLEAN is
			-- Is `Current' an XPath unordered() function?
		do
			Result := False
		end

	is_not_function: BOOLEAN is
			-- Is `Current' an XPath not() function?
		do
			Result := False
		end

	is_count_function: BOOLEAN is
			-- Is `Current' an XPath count() function?
		do
			Result := False
		end

	is_empty_function: BOOLEAN is
			-- Is `Current' an XPath empty() function?
		do
			Result := False
		end

	is_exists_function: BOOLEAN is
			-- Is `Current' XPath an exists() function?
		do
			Result := False
		end
	
	is_string_length_function: BOOLEAN is
			-- Is `Current' XPath an string-length() function?
		do
			Result := False
		end

	is_string_function: BOOLEAN is
			-- Is `Current' XPath an string() function?
		do
			Result := False
		end

	is_number_function: BOOLEAN is
			-- Is `Current' XPath an number() function?
		do
			Result := False
		end
	
	is_generate_id_function: BOOLEAN is
			-- Is `Current' an XSLT generate-id() function?
		do
			Result := False
		end

	is_last_function: BOOLEAN is
			-- Is `Current' an XPath last() function?
		do
			Result := False
		end

	is_position_function: BOOLEAN is
			-- Is `Current' an XPath position() function?
		do
			Result := False
		end

	is_value: BOOLEAN is
			-- Is `Current' a value?
		do
			Result := False
		end

	is_atomic_value: BOOLEAN is
			-- Is `Current' an atomic value?
		do
			Result := False
		end
	
	is_hex_binary: BOOLEAN is
			-- Is `Current' a hexBinary value?
		do
			Result := False
		end
	
	is_base64_binary: BOOLEAN is
			-- Is `Current' a base64Binary value?
		do
			Result := False
		end

	is_numeric_value: BOOLEAN is
			-- Is `Current' a numeric value?
		do
			Result := False
		end
	
	is_integer_value: BOOLEAN is
			-- Is `Current' an integer value?
		do
			Result := False
		end

	is_machine_integer_value: BOOLEAN is
			-- Is `Current' a machine integer value?
		do
			Result := False
		end
	
	is_integer_range: BOOLEAN is
			-- Is `Current' an integer range?
		do
			Result := False
		end
	
	is_decimal_value: BOOLEAN is
			-- Is `Current' a decimal value?
		do
			Result := False
		end

	is_calendar_value: BOOLEAN is
			-- Is `Current' a calendar value?
		do
			Result := False
		end
	
	is_date_value: BOOLEAN is
			-- Is `Current' a date value?
		do
			Result := False
		end

	is_time_value: BOOLEAN is
			-- Is `Current' a time value?
		do
			Result := False
		end

	is_date_time_value: BOOLEAN is
			-- Is `Current' a date_time value?
		do
			Result := False
		end

	is_month_day_value: BOOLEAN is
			-- Is `Current' a gYearMonth value?
		do
			Result := False
		end

	is_year_month_value: BOOLEAN is
			-- Is `Current' a gYearMonth value?
		do
			Result := False
		end

	is_year_value: BOOLEAN is
			-- Is `Current' a gYear value?
		do
			Result := False
		end

	is_month_value: BOOLEAN is
			-- Is `Current' a gMonth value?
		do
			Result := False
		end

	is_day_value: BOOLEAN is
			-- Is `Current' a gDay value?
		do
			Result := False
		end

	is_duration_value: BOOLEAN is
			-- Is `Current' an xs:duration value?
		do
			Result := False
		end

	is_seconds_duration: BOOLEAN is
			-- Is `Current' an xdt:dayTimeDuration value?
		do
			Result := False
		end

	is_months_duration: BOOLEAN is
			-- Is `Current' an xdt:yearMonthDuration value?
		do
			Result := False
		end

	is_string_value: BOOLEAN is
			-- Is `Current' a string value?
		do
			Result := False
		end

	is_any_uri: BOOLEAN is
			-- Is `Current' an anyURI value?
		do
			Result := False
		end
	
	is_untyped_atomic: BOOLEAN is
			-- Is `Current' an untyped atomic value?
		do
			Result := False
		end

	is_qname_value: BOOLEAN is
			-- Is `Current' a QName value?
		do
			Result := False
		end

	is_invalid_value: BOOLEAN is
			-- Is `Current' an invalid value?
		do
			Result := False
		end

	is_boolean_value: BOOLEAN is
			-- Is `Current' a boolean value?
		do
			Result := False
		end

	is_closure: BOOLEAN is
			-- Is `Current' a closure?
		do
			Result := False
		end

	is_memo_closure: BOOLEAN is
			-- Is `Current' a memo-closure?
		do
			Result := False
		end

	is_empty_sequence: BOOLEAN is
			-- Is `Current' an empty sequence?
		do
			Result := False
		end
	
	is_singleton_node: BOOLEAN is
			-- Is `Current' a singleton node?
		do
			Result := False
		end

	is_sequence_extent: BOOLEAN is
			-- Is `Current' a sequence extent?
		do
			Result := False
		end

	is_sequence_expression: BOOLEAN is
			-- Is `Current' a sequence expression [e.g. (,,,)]?
		do
			Result := False
		end

	is_sequence_value: BOOLEAN is
			-- Is `Current' a sequence value?
		do
			Result := False
		end
	
	is_computed_expression: BOOLEAN is
			-- Is `Current' a computed expression?
		do
			Result := False
		end

	is_range_expression: BOOLEAN is
			-- Is `Current' a range expression?
		do
			Result := False
		end

	is_lazy_expression: BOOLEAN is
			-- Is `Current' a lazy expression?
		do
			Result := False
		end

	is_atomizer_expression: BOOLEAN is
			-- Is `Current' an atomizer expression?
		do
			Result := False
		end

	is_arithmetic_expression: BOOLEAN is
			-- Is `Current' a arithmetic expression?
		do
			Result := False
		end

	is_unary_expression: BOOLEAN is
			-- Is `Current' a unary expression?
		do
			Result := False
		end

	is_cast_expression: BOOLEAN is
			-- Is `Current' a cast expression?
		do
			Result := False
		end

	is_castable_expression: BOOLEAN is
			-- Is `Current' a castable expression?
		do
			Result := False
		end

	is_instance_of_expression: BOOLEAN is
			-- Is `Current' an instance-of expression?
		do
			Result := False
		end

	is_variable_reference: BOOLEAN is
			-- Is `Current' a variable reference?
		do
			Result := False
		end

	is_numeric_promoter: BOOLEAN is
			-- Is `Current' a numeric promoter?
		do
			Result := False
		end

	is_document_sorter: BOOLEAN is
			-- Is `Current' a document sorter?
		do
			Result := False
		end

	is_reverser: BOOLEAN is
			-- Is `Current' a reverser?
		do
			Result := False
		end

	is_assignation: BOOLEAN is
			-- Is `Current' a assignation?
		do
			Result := False
		end
	
	is_axis_expression: BOOLEAN is
			-- Is `Current' an axis expression?
		do
			Result := False
		end
	
	is_let_expression: BOOLEAN is
			-- Is `Current' a let expression?
		do
			Result := False
		end

	is_binary_expression: BOOLEAN is
			-- Is `Current' a binary expression?
		do
			Result := False
		end
	
	is_boolean_expression: BOOLEAN is
			-- Is `Current' a boolean expression?
		do
			Result := False
		end
	
	is_tail_expression: BOOLEAN is
			-- Is `Current' a tail expression?
		do
			Result := False
		end
	
	is_root_expression: BOOLEAN is
			-- Is `Current' a root expression?
		do
			Result := False
		end
	
	is_parent_node_expression: BOOLEAN is
			-- Is `Current' a parent node expression?
		do
			Result := False
		end
	
	is_path_expression: BOOLEAN is
			-- Is `Current' a path expression?
		do
			Result := False
		end

	is_filter_expression: BOOLEAN is
			-- Is `Current' a filter expression?
		do
			Result := False
		end

	is_first_item_expression: BOOLEAN is
			-- Is `Current' a first item expression?
		do
			Result := False
		end

	is_context_item: BOOLEAN is
			-- Is `Current' a context-item expression?
		do
			Result := False
		end

	is_last_expression: BOOLEAN is
			-- Is `Current' an is-last expression?
		do
			Result := False
		end

	is_item_checker: BOOLEAN is
			-- Is `Current' an item checker?
		do
			Result := False
		end

	is_position_range: BOOLEAN is
			-- Is `Current' a position range?
		do
			Result := False
		end

feature -- Status setting

	clear_error is
			-- Clear `error_value'.
		require
			in_error: is_error
		do
			error_value := Void
		ensure
			not_in_error: not is_error
		end

	set_last_error (an_error_value: XM_XPATH_ERROR_VALUE) is
			-- Set `error_value'.
		require
			not_in_error: not is_error		
			error_value_not_void: an_error_value /= Void
		do
			error_value := an_error_value
		ensure
			set: error_value = an_error_value
			in_error: is_error
		end
	
	set_last_error_from_string (a_message, a_namespace_uri, a_code: STRING; an_error_type: INTEGER) is
			-- Set `error_value'.
		require
			valid_error_type: an_error_type = Static_error or an_error_type = Type_error or an_error_type = Dynamic_error
			message_not_void: a_message /= Void and then a_message.count > 0
			namespace_uri_not_void: a_namespace_uri /= Void
			code_not_void: a_code /= Void
			not_in_error: not is_error			
		do
			create error_value.make_from_string (a_message, a_namespace_uri, a_code, an_error_type)
		ensure
			valid_error: error_value /= Void
				and then STRING_.same_string (error_value.code, a_code)
			in_error: is_error
		end

	set_replacement (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_expression: XM_XPATH_EXPRESSION) is
			-- Set replacement for `Current'.
		require
			not_in_error: not is_error
			a_replacement_not_void: a_replacement /= Void
			not_replaced: a_replacement.item = Void
			no_circularity: a_expression /= Current
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
		do
			if a_expression.is_computed_expression then
				a_expression.as_computed_expression.copy_location_identifier (Current)
				if not a_expression.is_error then
					from l_cursor := a_expression.sub_expressions.new_cursor
					l_cursor.start
					until
						l_cursor.after
					loop
						if l_cursor.item.is_computed_expression then
							l_cursor.item.as_computed_expression.set_parent (a_expression.as_computed_expression)
						end
						l_cursor.forth
					end
				end
			end
			a_replacement.put (a_expression)
		ensure
			replaced: a_replacement.item /= Void
			replacement_set: a_replacement.item = a_expression
		end

	resolve_calls_to_current_function (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]) is
			-- Resolve calls to "fn:current()".
		require
			a_replacement_not_void: a_replacement /= Void
			not_replaced: a_replacement.item = Void
		local
			l_let_expression: XM_XPATH_LET_EXPRESSION
			l_range_variable: XM_XPATH_RANGE_VARIABLE_DECLARATION
			l_sequence_expression: XM_XPATH_CONTEXT_ITEM_EXPRESSION
			l_name_code, l_counter: INTEGER
			l_required_type: XM_XPATH_SEQUENCE_TYPE
			l_name_code_created: BOOLEAN
			l_local_name, l_local_name_prefix: STRING
			l_offer: XM_XPATH_PROMOTION_OFFER
		do
			if calls_function (Current_function_type_code) then
				create l_required_type.make_single_item
				from
					l_local_name_prefix := "current_"; l_counter := 0
				until
					l_name_code_created
				loop
					l_local_name := STRING_.concat (l_local_name_prefix, l_counter.out)
					if not shared_name_pool.is_name_code_allocated ("gexslt_system_usage", Gexslt_examples_uri, l_local_name) then
						shared_name_pool.allocate_name ("gexslt_system_usage", Gexslt_examples_uri, l_local_name)
						l_name_code_created := True
						l_name_code := shared_name_pool.last_name_code
					else
						l_counter := l_counter + 1
					end
				end
				create l_range_variable.make ("gexslt_system_usage:current_function", l_name_code, l_required_type)
				create l_sequence_expression.make_current
				create l_let_expression.make (l_range_variable, l_sequence_expression, Current)
				create l_offer.make (Replace_current, Void, l_let_expression, False, False)
				promote (a_replacement, l_offer)
				l_let_expression.set_action (a_replacement.item)
				a_replacement.put (l_let_expression)
			else
				a_replacement.put (Current)
			end
		ensure
			may_be_replaced: a_replacement.item /= Void
		end

	mark_tail_function_calls is
  			-- Mark tail calls on stylesheet functions.
  		do
  			-- do_nothing by default.
  		end

feature -- Optimization

	simplify (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]) is
			-- Perform context-independent static optimizations
		require
			no_previous_error: not is_error
			static_properties_computed: are_static_properties_computed
			a_replacement_not_void: a_replacement /= Void
			not_replaced: a_replacement.item = Void
		deferred
		ensure
			simplified_expression_not_void: a_replacement.item /= Void
		end

	check_static_type (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE) is
			-- Perform static type-checking of `Current' and its subexpressions.
			-- This checks statically that the operands of the expression have the correct type.
			-- If necessary it generates code to do run-time type checking or type conversion.
			-- A static type error is reported only if execution cannot possibly succeed, that
			--  is, if a run-time type error is inevitable. The call may create a modified form of the expression.
			-- This routine is called after all references to functions and variables have been resolved
			--  to the declaration of the function or variable. However, the types of such functions and
			--  variables will only be accurately known if they have been explicitly declared.
		require
			a_context_not_void: a_context /= Void
			context_item_may_not_be_set: True
			no_previous_error: not is_error
			a_replacement_not_void: a_replacement /= Void
			not_replaced: a_replacement.item = Void
			static_properties_computed: are_static_properties_computed
		deferred
		ensure
			replaced: a_replacement.item /= Void
		end

	optimize (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE) is
			-- Perform optimization of `Current' and its subexpressions.
			-- This routine is called after all references to functions and variables have been resolved
			--  to the declaration of the function or variable, and after static type-checking.
		require
			context_not_void: a_context /= Void
			context_item_may_not_be_set: True
			no_previous_error: not is_error
			a_replacement_not_void: a_replacement /= Void
			not_replaced: a_replacement.item = Void
			static_properties_computed: are_static_properties_computed
		deferred
		ensure
			replaced: a_replacement.item /= Void
			may_be_in_error: True -- even if there was no replacement, early evaluation can cause this
		end

	promote (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_offer: XM_XPATH_PROMOTION_OFFER) is
			-- Promote this subexpression.
			-- The offer will be accepted if the subexpression is not dependent on
			--  the factors (e.g. the context item) identified in `a_offer'.
			-- By default the offer is not accepted - this is appropriate in the case of simple expressions
			-- such as constant values and variable references where promotion would give no performance
			-- advantage. This routine is always called at compile time.
		require
			offer_not_void: a_offer /= Void
			no_previous_error: not is_error
			a_replacement_not_void: a_replacement /= Void
			not_replaced: a_replacement.item = Void
			static_properties_computed: are_static_properties_computed
		deferred
		ensure
			replaced: a_replacement.item /= Void
			no_error: not a_replacement.item.is_error
		end

feature -- Evaluation

		-- TODO: make a_context be non-Void in all these

	evaluate (a_result: DS_CELL [XM_XPATH_VALUE]; a_mode, a_reference_count: INTEGER; a_context: XM_XPATH_CONTEXT) is
			-- Evaluate `Current' according to `a_mode'.
		require
			context_may_be_void: True
			not_in_error: not is_error
			a_mode_large_enough: a_mode >= Evaluation_method_undecided
			a_mode_small_enough: a_mode <= Create_memo_closure
			a_result_not_void: a_result /= Void
			a_result_empty: a_result.item = Void
		local
			l_reference_count: INTEGER
			l_value: XM_XPATH_VALUE
			l_result: DS_CELL [XM_XPATH_ITEM]
		do
			inspect
				a_mode
			when No_evaluation_needed then
				check
					value: is_value
					-- Overall library design
				end
				a_result.put (as_value)
			when Call_evaluate_variable then
				check
					variable_reference: is_variable_reference
					-- Overall library design
				end
				as_variable_reference.evaluate_variable (a_context)
				a_result.put (as_variable_reference.last_evaluated_binding)
			when Create_closure then
				expression_factory.create_closure (as_computed_expression, a_context, a_reference_count)
				a_result.put (expression_factory.last_created_closure)
			when Create_memo_closure then
				if a_reference_count = 1 then
					l_reference_count := Many_references
				else
					l_reference_count := a_reference_count
				end
				expression_factory.create_closure (as_computed_expression, a_context, l_reference_count)
				a_result.put (expression_factory.last_created_closure)
			when Create_empty_sequence then
				a_result.put (create {XM_XPATH_EMPTY_SEQUENCE}.make)
			when Evaluate_and_materialize_variable then
				as_variable_reference.evaluate_variable (a_context)
				l_value := as_variable_reference.last_evaluated_binding
				if l_value.is_closure and not l_value.is_error then
					l_value.create_iterator (a_context)
					expression_factory.create_sequence_extent (l_value.last_iterator)
					a_result.put (expression_factory.last_created_closure)
				else
					a_result.put (l_value)
				end
			when Call_evaluate_item then
				create l_result.make (Void)
				evaluate_item (l_result, a_context)
				if l_result.item = Void then
					a_result.put (create {XM_XPATH_EMPTY_SEQUENCE}.make)
				elseif l_result.item.is_error then
					a_result.put (create {XM_XPATH_INVALID_VALUE}.make (l_result.item.error_value))
				elseif l_result.item.is_node then
					a_result.put (create {XM_XPATH_SINGLETON_NODE} .make (l_result.item.as_node))
				else
					a_result.put (l_result.item.as_atomic_value)
				end
			when Evaluation_method_undecided, Iterate_and_materialize then
				create_iterator (a_context)
				expression_factory.create_sequence_extent (last_iterator)
				a_result.put (expression_factory.last_created_closure)
			when Call_generate_events then
				evaluate_by_generating_events (a_result, a_context)
			when Evaluate_as_lazy_tail_expression then
				evaluate_lazy_tail_expression (a_result, a_context, a_reference_count)
			end
			if a_result.item = Void then
				a_result.put (create {XM_XPATH_EMPTY_SEQUENCE}.make)
			end
		ensure
			evaluation_not_void: a_result.item /= Void
		end

	calculate_effective_boolean_value (a_context: XM_XPATH_CONTEXT) is
			-- Effective boolean value;
			-- The result has value `False' if the value is the empty sequence,
			--  a zero-length string, a number equal to zero, or the boolean `False'.
			-- Otherwise it has value  `True'.
		require
			context_may_be_void: True
			not_in_error: not is_error
		local
			l_item: XM_XPATH_ITEM
		do
			last_boolean_value := Void
			create_iterator (a_context)
			if not last_iterator.is_error then
				last_iterator.start
				if last_iterator.is_error then
					create last_boolean_value.make (False)
					last_boolean_value.set_last_error (last_iterator.error_value)
					set_last_error (last_iterator.error_value)
				elseif not last_iterator.after then
					l_item := last_iterator.item
					if l_item.is_node then
						create last_boolean_value.make (True)
					else
						if l_item.is_boolean_value then
							last_iterator.forth
							if last_iterator.is_error then
								create last_boolean_value.make (False)
								last_boolean_value.set_last_error (last_iterator.error_value)
								set_last_error (last_iterator.error_value)
							elseif last_iterator.after then
								create last_boolean_value.make (l_item.as_boolean_value.value)
							else
								last_boolean_value := effective_boolean_value_in_error ("sequence of two or more items starting with an atomic value")
							end
						else
							if l_item.is_string_value or l_item.is_untyped_atomic then -- includes URI
								last_iterator.forth
								if last_iterator.is_error then
									create last_boolean_value.make (False)
									last_boolean_value.set_last_error (last_iterator.error_value)
									set_last_error (last_boolean_value.error_value)
								elseif last_iterator.after then
									create last_boolean_value.make (l_item.string_value.count /= 0)
								else
									last_boolean_value := effective_boolean_value_in_error ("sequence of two or more items starting with an atomic value")
								end
							else
								if l_item.is_numeric_value then
									last_iterator.forth
									if last_iterator.is_error then
										create last_boolean_value.make (False)
										last_boolean_value.set_last_error (last_iterator.error_value)
										set_last_error (last_boolean_value.error_value)
									elseif last_iterator.after then
										l_item.as_numeric_value.calculate_effective_boolean_value (a_context)
										last_boolean_value := l_item.as_numeric_value.last_boolean_value
									else
										last_boolean_value := effective_boolean_value_in_error ("sequence of two or more items starting with an atomic value")
									end
								else
									last_boolean_value := effective_boolean_value_in_error ("sequence starting with a typed atomic value other than a boolean, number, URI or string")
								end
							end
						end
					end
				end
				if last_boolean_value = Void then create last_boolean_value.make (False) end			
			else
				create last_boolean_value.make (False)
				last_boolean_value.set_last_error (last_iterator.error_value)
				set_last_error (last_boolean_value.error_value)
			end
		ensure
			value_not_void_but_may_be_in_error: last_boolean_value /= Void
		end

	evaluate_item (a_result: DS_CELL [XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a single item to `a_result'.
			-- This always sets `a_result.item' to either a single Item or Void (denoting the empty sequence). No conversion is done.
			-- This routine should not be used unless the static type of the expression is a subtype of "item" or "item?":
			--  that is, it should not be called if the expression may return a sequence.
			-- If an error condition is detected, this routine MUST set `a_result.item' to an item marked in error.
		require
			a_result_not_void: a_result /= Void
			a_result_empty: a_result.item = Void
			context_may_be_void: True
			expression_not_in_error: not is_error
		deferred
		ensure
			item_evaluated_but_may_be_void: True
		end

	evaluate_as_string (a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a String.
			-- This procedure must only be called in contexts where it is known
			--  that the expression will evaluate to a single string (or where an empty sequence
			--  is to be treated as a zero-length string). Implementations should not attempt to convert
			--  the result to a string, other than converting () to "". This routine is used mainly to
			--  evaluate expressions produced by compiling an attribute value template in XSLT.
		require
			-- TODO - check the above and turn it into pre-conditions.if possible
			context_may_be_void: True
			expression_not_in_error: not is_error
		deferred
		ensure
			string_not_void_but_may_be_in_error: last_evaluated_string /= Void
		end

	create_iterator (a_context: XM_XPATH_CONTEXT) is
			-- Create an iterator over the values of a sequence
		require
			not_in_error: not is_error
			context_may_be_void: True
		deferred
		ensure
			iterator_not_void_but_may_be_error: last_iterator /= Void
			iterator_before: not last_iterator.is_error implies last_iterator.before
		end

	create_node_iterator (a_context: XM_XPATH_CONTEXT) is
			-- Create an iterator over a node sequence
		require
			not_in_error: not is_error
			context_may_be_void: True
			node_sequence: is_node_sequence
		deferred
		ensure
			iterator_not_void_but_may_be_error: last_node_iterator /= Void
			iterator_before: not last_node_iterator.is_error implies last_node_iterator.before
		end

	generate_events (a_context: XM_XPATH_CONTEXT) is
			-- Execute `Current' completely, writing results to the current `XM_XPATH_RECEIVER'.
		require
			evaluation_context_not_void: a_context /= Void
			push_processing: a_context.has_push_processing
			no_error: not a_context.is_process_error
		deferred
		ensure
			no_tail_calls: True -- this will be refined within XSLT
		end

	processed_eager_evaluation (a_context: XM_XPATH_CONTEXT): XM_XPATH_VALUE is
			-- Eager evaluation via `generate_events'
		require
			expression_not_in_error: not is_error
			context_may_be_void: True
			process_supported: is_process_supported
		deferred
		ensure
			processed_eager_evaluation_not_void: Result /= Void
		end

feature -- Element change
	
	allocate_slots (a_next_free_slot: INTEGER; a_slot_manager: XM_XPATH_SLOT_MANAGER) is
			-- Allocate slot numbers for all range variable in `Current' and it's sub-expresions.
		require
			strictly_positive_slot_number: a_next_free_slot > 0
			a_next_free_slot_large_enough: a_next_free_slot >= last_slot_number
			slot_manager_may_be_void: True
			not_in_error: not is_error -- should really be all sub-expressions not in error - think about this
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
			l_last_slot: INTEGER
		do

			-- This version only allocates slots to the children.
			-- Redefined in `XM_XPATH_ASSIGNATION'.

			last_slot_number := a_next_free_slot

			from
				l_cursor := sub_expressions.new_cursor
				l_cursor.start
			variant
				sub_expressions.count + 1 - l_cursor.index
			until
				l_cursor.after
			loop
				if not l_cursor.item.is_error then
					l_last_slot := l_cursor.item.last_slot_number
					if l_last_slot > last_slot_number then
						last_slot_number := l_last_slot
					end
					l_cursor.item.allocate_slots (last_slot_number, a_slot_manager)
					last_slot_number := l_cursor.item.last_slot_number
				end
				l_cursor.forth
			end
		ensure
			last_slot_number_not_less: last_slot_number >= old last_slot_number
		end

feature -- Conversion

	as_position_range: XM_XPATH_POSITION_RANGE is
			-- `Current' seen as a position range
		require
			position_range: is_position_range
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_binary_expression: XM_XPATH_BINARY_EXPRESSION is
			-- `Current' seen as a binary expression
		require
			binary_expression: is_binary_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_boolean_expression: XM_XPATH_BOOLEAN_EXPRESSION is
			-- `Current' seen as a boolean expression
		require
			boolean_expression: is_boolean_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_tail_expression: XM_XPATH_TAIL_EXPRESSION is
			-- `Current' seen as a tail expression
		require
			tail_expression: is_tail_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_root_expression: XM_XPATH_ROOT_EXPRESSION is
			-- `Current' seen as a root expression
		require
			root_expression: is_root_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_parent_node_expression: XM_XPATH_PARENT_NODE_EXPRESSION is
			-- `Current' seen as a parent node expression
		require
			parent_node_expression: is_parent_node_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_path_expression: XM_XPATH_PATH_EXPRESSION is
			-- `Current' seen as a path expression
		require
			path_expression: is_path_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_filter_expression: XM_XPATH_FILTER_EXPRESSION is
			-- `Current' seen as a filter expression
		require
			filter_expression: is_filter_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_context_item: XM_XPATH_CONTEXT_ITEM_EXPRESSION is
			-- `Current' seen as a context-item expression
		require
			context_item: is_context_item
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_last_expression: XM_XPATH_IS_LAST_EXPRESSION is
			-- `Current' seen as an is-last expression
		require
			last_expression: is_last_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_item_checker: XM_XPATH_ITEM_CHECKER is
			-- `Current' seen as an item checker
		require
			item_checker: is_item_checker
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_variable_reference: XM_XPATH_VARIABLE_REFERENCE is
			-- `Current' seen as a variable reference
		require
			variable_reference: is_variable_reference
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_numeric_promoter: XM_XPATH_NUMERIC_PROMOTER is
			-- `Current' seen as a numeric promoter
		require
			numeric_promoter: is_numeric_promoter
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_document_sorter: XM_XPATH_DOCUMENT_SORTER is
			-- `Current' seen as a document sorter
		require
			document_sorter: is_document_sorter
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_reverser: XM_XPATH_REVERSER is
			-- `Current' seen as a reverser
		require
			reverser: is_reverser
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end	

	as_assignation: XM_XPATH_ASSIGNATION is
			-- `Current' seen as a assignation
		require
			assignation: is_assignation
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_axis_expression: XM_XPATH_AXIS_EXPRESSION is
			-- `Current' seen as an axis expression
		require
			axis_expression: is_axis_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_let_expression: XM_XPATH_LET_EXPRESSION is
			-- `Current' seen as a let expression
		require
			let_expression: is_let_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end
	
	as_lazy_expression: XM_XPATH_LAZY_EXPRESSION is
			-- `Current' seen as a lazy expression
		require
			lazy_expression: is_lazy_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_atomizer_expression: XM_XPATH_ATOMIZER_EXPRESSION is
			-- `Current' seen as an atomizer expression
		require
			atomizer_expression: is_atomizer_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_arithmetic_expression: XM_XPATH_ARITHMETIC_EXPRESSION is
			-- `Current' seen as a arithmetic expression
		require
			arithmetic_expression: is_arithmetic_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_unary_expression: XM_XPATH_UNARY_EXPRESSION is
			-- `Current' seen as a unary expression
		require
			unary_expression: is_unary_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_cast_expression: XM_XPATH_CAST_EXPRESSION is
			-- `Current' seen as a cast expression
		require
			cast_expression: is_cast_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_castable_expression: XM_XPATH_CASTABLE_EXPRESSION is
			-- `Current' seen as a castable expression
		require
			castable_expression: is_castable_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_instance_of_expression: XM_XPATH_INSTANCE_OF_EXPRESSION is
			-- `Current' seen as an instance-of expression
		require
			instance_of_expression: is_instance_of_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_invalid_value: XM_XPATH_INVALID_VALUE is
			-- `Current' seen as an invalid value
		require
			invalid_value: is_invalid_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_boolean_value: XM_XPATH_BOOLEAN_VALUE is
			-- `Current' seen as a boolean value
		require
			boolean_value: is_boolean_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end	

	as_closure: XM_XPATH_CLOSURE is
			-- `Current' seen as a closure
		require
			closure: is_closure
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_memo_closure: XM_XPATH_MEMO_CLOSURE is
			-- `Current' seen as a closure
		require
			memo_closure: is_memo_closure
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_empty_sequence: XM_XPATH_EMPTY_SEQUENCE is
			-- `Current' seen as an empty_sequence
		require
			empty_sequence: is_empty_sequence
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_singleton_node: XM_XPATH_SINGLETON_NODE is
			-- `Current' seen as a singleton node
		require
			singleton_node: is_singleton_node
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_sequence_extent: XM_XPATH_SEQUENCE_EXTENT is
			-- `Current' seen as a sequence extent
		require
			sequence_extent: is_sequence_extent
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_sequence_expression: XM_XPATH_SEQUENCE_EXPRESSION is
			-- `Current' seen as a sequence expression
		require
			sequence_expression: is_sequence_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_sequence_value: XM_XPATH_SEQUENCE_VALUE is
			-- `Current' seen as a sequence value
		require
			sequence_value: is_sequence_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_computed_expression: XM_XPATH_COMPUTED_EXPRESSION is
			-- `Current' seen as a computed expression
		require
			computed_expression: is_computed_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_range_expression: XM_XPATH_RANGE_EXPRESSION is
			-- `Current' seen as a range expression
		require
			range_expression: is_range_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end
	
	as_duration_value: XM_XPATH_DURATION_VALUE is
			-- `Current' seen as an xs:duration value
		require
			duration_value: is_duration_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_seconds_duration: XM_XPATH_SECONDS_DURATION_VALUE is
			-- `Current' seen as an xdt:dayTimeDuration value
		require
			seconds_duration_value: is_seconds_duration
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_months_duration: XM_XPATH_MONTHS_DURATION_VALUE is
			-- `Current' seen as an xdt:dayTimeDuration value
		require
			months_duration_value: is_months_duration
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_string_value: XM_XPATH_STRING_VALUE is
			-- `Current' seen as a string value
		require
			string_value: is_string_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
			string: Result.is_string_value
		end

	as_any_uri: XM_XPATH_ANY_URI_VALUE is
			-- `Current' seen as an anyURI value
		require
			any_uri_value: is_any_uri
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_untyped_atomic: XM_XPATH_STRING_VALUE is
			-- `Current' seen as an untyped atomic
		require
			untyped_atomic_value: is_untyped_atomic
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
			untyped_atomic: Result.is_untyped_atomic
		end

	as_qname_value: XM_XPATH_QNAME_VALUE is
			-- `Current' seen as a QName value
		require
			qname_value: is_qname_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_integer_range: XM_XPATH_INTEGER_RANGE is
			-- `Current' seen as an integer value
		require
			integer_range: is_integer_range
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_decimal_value: XM_XPATH_DECIMAL_VALUE is
			-- `Current' seen as a decimal value
		require
			decimal_value: is_decimal_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_calendar_value: XM_XPATH_CALENDAR_VALUE is
			-- `Current' seen as a calendar value
		require
			calendar_value: is_calendar_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
			atomic_value: Result.is_atomic_value
		end

	as_date_value: XM_XPATH_DATE_VALUE is
			-- `Current' seen as a date value
		require
			date_value: is_date_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
			calendar_value: Result.is_calendar_value
		end

	as_time_value: XM_XPATH_TIME_VALUE is
			-- `Current' seen as a time value
		require
			time_value: is_time_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
			calendar_value: Result.is_calendar_value
		end

	as_date_time_value: XM_XPATH_DATE_TIME_VALUE is
			-- `Current' seen as a dateTime value
		require
			date_time_value: is_date_time_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
			calendar_value: Result.is_calendar_value
		end

	as_month_day_value: XM_XPATH_MONTH_DAY_VALUE is
			-- `Current' seen as a gMonthDay value
		require
			month_day_value: is_month_day_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_year_month_value: XM_XPATH_YEAR_MONTH_VALUE is
			-- `Current' seen as a gYearMonth value
		require
			year_month_value: is_year_month_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_year_value: XM_XPATH_YEAR_VALUE is
			-- `Current' seen as a gYear value
		require
			year_value: is_year_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_month_value: XM_XPATH_MONTH_VALUE is
			-- `Current' seen as a gMonth value
		require
			month_value: is_month_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_day_value: XM_XPATH_DAY_VALUE is
			-- `Current' seen as a gDay value
		require
			day_value: is_day_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_function_call: XM_XPATH_FUNCTION_CALL is
			-- `Current' seen as an XPath function call
		require
			function_call: is_function_call
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_mapped_path_expression: XM_XPATH_MAPPED_PATH_EXPRESSION is
			-- `Current' seen as a mapped path expression
		require
			mapped_path_expression: is_mapped_path_expression
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_tail_call: XM_XPATH_TAIL_CALL is
			-- `Current' seen as an XPath tail call
		require
			tail_call: is_tail_call
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_system_function: XM_XPATH_SYSTEM_FUNCTION is
			-- `Current' seen as an XPath system function
		require
			system_function: is_system_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_unordered_function: XM_XPATH_UNORDERED is
			-- `Current' seen as an XPath unordered() function
		require
			unordered_function: is_unordered_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_not_function: XM_XPATH_NOT is
			-- `Current' seen as an XPath not() function
		require
			not_function: is_not_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_count_function: XM_XPATH_COUNT is
			-- `Current' seen as an XPath count() function
		require
			count_function: is_count_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_empty_function: XM_XPATH_EMPTY is
			-- `Current' seen as an XPath empty() function
		require
			empty_function: is_empty_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_exists_function: XM_XPATH_EXISTS is
			-- `Current' seen as an XPath exists() function
		require
			exists_function: is_exists_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_string_length_function: XM_XPATH_STRING_LENGTH is
			-- `Current' seen as an XPath string-length() function
		require
			string_length_function: is_string_length_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_string_function: XM_XPATH_STRING is
			-- `Current' seen as an XPath string() function
		require
			string_function: is_string_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_number_function: XM_XPATH_NUMBER is
			-- `Current' seen as an XPath number() function
		require
			number_function: is_number_function
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_value: XM_XPATH_VALUE is
			-- `Current' seen as a value
		require
			value: is_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_atomic_value: XM_XPATH_ATOMIC_VALUE is
			-- `Current' seen as an atomic value
		require
			atomic_value: is_atomic_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_hex_binary: XM_XPATH_HEX_BINARY_VALUE is
			-- `Current' seen as a hexBinary value
		require
			hex_binary_value: is_hex_binary
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_base64_binary: XM_XPATH_BASE64_BINARY_VALUE is
			-- `Current' seen as a base64Binary value
		require
			base64_binary_value: is_base64_binary
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_numeric_value: XM_XPATH_NUMERIC_VALUE is
			-- `Current' seen as a numeric value
		require
			numeric_value: is_numeric_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_integer_value: XM_XPATH_INTEGER_VALUE is
			-- `Current' seen as an integer value
		require
			integer_value: is_integer_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

	as_machine_integer_value: XM_XPATH_MACHINE_INTEGER_VALUE is
			-- `Current' seen as a machine integer value
		require
			machine_integer_value: is_machine_integer_value
		do
		ensure
			same_object: ANY_.same_objects (Result, Current)
		end

feature {XM_XPATH_EXPRESSION} -- Local

	Supports_evaluate: INTEGER is 1
			-- `Current' natively supports `evaluate'
	
	Supports_iterator: INTEGER is 2
			-- `Current' natively supports `create_iterator'

	Supports_process: INTEGER is 4
			-- `Current' natively supports `generate_events'

	native_implementations: INTEGER is
			-- Natively-supported evaluation routines
		deferred
		ensure
			bit_set: Result < 8 and then Result > 0 and then INTEGER_.bit_and (Result, INTEGER_.bit_or (INTEGER_.bit_or (Supports_evaluate, Supports_iterator), Supports_process)) /= 0
		end

	set_unsorted (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_eliminate_duplicates: BOOLEAN) is
			-- Remove unwanted sorting from an expression, at compile time.
		require
			not_in_error: not is_error
			a_replacement_not_void: a_replacement /= Void
			not_replaced: a_replacement.item = Void			
		local
			l_offer: XM_XPATH_PROMOTION_OFFER
		do
			create l_offer.make (Unordered, Void, Void, a_eliminate_duplicates, False)
			promote (a_replacement, l_offer)
		ensure
			replaced: a_replacement.item /= Void
			not_in_error: not a_replacement.item.is_error
		end

	set_unsorted_if_homogeneous  (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_eliminate_duplicates: BOOLEAN) is
			-- Remove unwanted sorting from an expression, at compile time,
			--  but only if all nodes or all atomic values.
		require
			not_in_error: not is_error
			a_replacement_not_void: a_replacement /= Void
			not_replaced: a_replacement.item = Void
		local
			l_offer: XM_XPATH_PROMOTION_OFFER
		do
			if not is_value and then not item_type.is_any_item_type then
				create l_offer.make (Unordered, Void, Void, a_eliminate_duplicates, False)
				promote (a_replacement, l_offer)
			else
				a_replacement.put (Current)
			end
		ensure
			replaced: a_replacement.item /= Void
			not_in_error: not a_replacement.item.is_error			
		end

	indentation (a_level: INTEGER): STRING is
			-- Indentation string prefix, for diagnostic output
		require
			strictly_positive_level: a_level > 0
		local
			counter: INTEGER
		do
			Result := ""
			from
				counter := 1
			variant
				a_level + 1 - counter
			until
				counter > a_level
			loop
				Result := STRING_.appended_string (Result, " ")
				counter := counter + 1
			end
		end

	effective_boolean_value_in_error (a_reason: STRING): XM_XPATH_BOOLEAN_VALUE is
			-- Type error for `calculate_effective_boolean_value'
		require
			reason_not_empty: a_reason /= Void and then a_reason.count > 0
		do
			create Result.make (False)
			Result.set_last_error_from_string ("Effective boolean value is not defined for a " + a_reason, Xpath_errors_uri, "FORG0006", Type_error)
			set_last_error (Result.error_value)
		end

feature {XM_XPATH_EXPRESSION_FACTORY} -- Implementation

	evaluate_lazy_tail_expression (a_result: DS_CELL [XM_XPATH_VALUE]; a_context: XM_XPATH_CONTEXT; a_reference_count: INTEGER) is
			-- Evaluate `Current' as a lazy tail expression.
		require
			context_may_be_void: True
			not_in_error: not is_error
			a_result_not_void: a_result /= Void
			a_result_empty: a_result.item = Void
			lazy_tail_expression: is_tail_expression and then as_tail_expression.base_expression.is_variable_reference
		local
			l_tail: XM_XPATH_TAIL_EXPRESSION
			l_var: XM_XPATH_VARIABLE_REFERENCE
			l_value: XM_XPATH_VALUE
			l_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
			l_finished: BOOLEAN
			l_start, l_end, l_length: INTEGER
			l_extent: XM_XPATH_SEQUENCE_EXTENT
		do
			l_tail := as_tail_expression
			l_var := l_tail.base_expression.as_variable_reference
			l_var.evaluate (a_result, Call_evaluate_variable, a_reference_count, a_context)
			l_value := a_result.item
			if l_value  /= Void then
				if l_value.is_memo_closure then
					from
						l_value.create_iterator (a_context)
						l_iterator := l_value.last_iterator
						l_iterator.start
					until
						l_iterator.is_error or else l_iterator.after
					loop
						l_iterator.forth
					end
					if l_iterator.is_error then
						l_finished := True
						a_result.put (create {XM_XPATH_INVALID_VALUE}.make (l_iterator.error_value))
					else
						if l_value.as_memo_closure.state = l_value.as_memo_closure.Maybe_more_state then
							l_value.as_memo_closure.mark_as_all_read
						end
						l_value := l_value.as_memo_closure.materialized
					end
				end
				if not l_finished then
					if l_value.is_integer_range then
						l_start := l_value.as_integer_range.minimum + 1
						l_end := l_value.as_integer_range.maximum
						if l_start = l_end then
							a_result.put (create {XM_XPATH_MACHINE_INTEGER_VALUE}.make (l_start))
						else
							a_result.put (create {XM_XPATH_INTEGER_RANGE}.make (l_start, l_end))
						end
					elseif l_value.is_sequence_extent then
						l_start := l_tail.start
						l_length := l_value.as_sequence_extent.count - l_tail.start + 1
						l_extent := l_value.as_sequence_extent
						if l_start > 0 and (l_start - 1) <= l_extent.count then
							a_result.put (create {XM_XPATH_SEQUENCE_EXTENT}.make_as_view (l_extent, l_start, l_length))
						else
							a_result.put (create {XM_XPATH_EMPTY_SEQUENCE}.make)
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	evaluate_by_generating_events (a_result: DS_CELL [XM_XPATH_VALUE]; a_context: XM_XPATH_CONTEXT) is
			-- Evaluate via `generate_events'.
		require
			context_may_be_void: True
			not_in_error: not is_error
			a_result_not_void: a_result /= Void
			a_result_empty: a_result.item = Void
		do
			-- TODO: probably we can inline this, and drop `processed_eager_evaluation'.
			-- (assuming we drop `eagerly_evaluate')
			a_result.put (processed_eager_evaluation (a_context))
		end

invariant

	value_or_computed_expression: BOOLEAN_.nxor (<<is_value, is_computed_expression, is_pattern_bridge>>)

end
	
