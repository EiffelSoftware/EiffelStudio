indexing

	description: "Objects that represent an xsl:number,"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_COMPILED_NUMBER

inherit

	XM_XSLT_INSTRUCTION
		redefine
			sub_expressions, compute_intrinsic_dependencies, item_type,
			compute_cardinality, promote
		end

	HASHABLE

	XM_XPATH_TYPE

	XM_XPATH_AXIS

	XM_XPATH_NUMERIC_ROUTINES

	ST_XSLT_NUMBER_ROUTINES

	XM_XPATH_SHARED_NODE_KIND_TESTS

create

	make

feature {NONE} -- Initialization

	make (an_executable: XM_XSLT_EXECUTABLE; a_select_expression: XM_XPATH_EXPRESSION; a_level, a_hash_code: INTEGER; a_count_pattern, a_from_pattern: XM_XSLT_PATTERN;
		a_value_expression, a_format, a_grouping_size, a_grouping_separator, a_letter_value, an_ordinal, a_language: XM_XPATH_EXPRESSION;
		a_formatter: XM_XSLT_NUMBER_FORMATTER;	a_numberer: ST_XSLT_NUMBERER; a_variables_in_patterns, a_backwards: BOOLEAN) is
			-- Establish invariant.
		require
			executable_not_void: an_executable /= Void
			language: a_language = Void implies a_numberer /= Void
			formatter: a_formatter = Void implies a_format /= Void
			strictly_positive_hash_code: a_hash_code > 0
		do
			executable := an_executable
			select_expression := a_select_expression;	if select_expression /= Void then adopt_child_expression (select_expression) end
			level := a_level
			count_pattern := a_count_pattern
			from_pattern := a_from_pattern
			value_expression := a_value_expression; if value_expression /= Void then adopt_child_expression (value_expression) end
			format := a_format; if format /= Void then adopt_child_expression (format) end
			grouping_size := a_grouping_size; if grouping_size /= Void then adopt_child_expression (grouping_size) end
			grouping_separator := a_grouping_separator; if grouping_separator /= Void then adopt_child_expression (grouping_separator) end
			letter_value := a_letter_value; if letter_value /= Void then adopt_child_expression (letter_value) end
			ordinal := an_ordinal; if ordinal /= Void then adopt_child_expression (ordinal) end
			language := a_language; if language /= Void then adopt_child_expression (language) end
			formatter := a_formatter
			numberer := a_numberer
			has_variables_in_patterns := a_variables_in_patterns
			is_backwards_compatible := a_backwards
			if value_expression /= Void and then not is_sub_type (value_expression.item_type, type_factory.any_atomic_type) then
				create {XM_XPATH_ATOMIZER_EXPRESSION} value_expression.make (value_expression, False)
			end
			hash_code := a_hash_code
			compute_static_properties
			initialized := True
		ensure
			executable_set: executable = an_executable
			select_expression_set: select_expression = a_select_expression
			level_set: level = a_level
			count_pattern_set: count_pattern = a_count_pattern
			from_pattern_set: from_pattern = a_from_pattern
			value_expression_set: a_value_expression /= Void implies value_expression /= Void
			format_set: format = a_format
			grouping_size_set: grouping_size = a_grouping_size
			grouping_separator_set: grouping_separator = a_grouping_separator
			letter_value_set: letter_value = a_letter_value
			ordinal_set: ordinal = an_ordinal
			language_set: language = a_language
			formatter_set: formatter = a_formatter
			numberer_set: numberer = a_numberer
			has_variables_in_patterns_set: has_variables_in_patterns = a_variables_in_patterns
			backwards_compatible: is_backwards_compatible = a_backwards
			hash_code_set: hash_code = a_hash_code
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, when known
		do
			Result := type_factory.string_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

	sub_expressions: DS_ARRAYED_LIST [XM_XPATH_EXPRESSION] is
			-- Immediate sub-expressions of `Current'
		local
			l_bridge: XM_XSLT_PATTERN_BRIDGE
		do
			create Result.make (10)
			Result.set_equality_tester (expression_tester)
			if select_expression /= Void then Result.put_last (select_expression) end
			if value_expression /= Void then Result.put_last (value_expression) end
			if format /= Void then Result.put_last (format) end
			if grouping_size /= Void then Result.put_last (grouping_size) end
			if grouping_separator /= Void then Result.put_last (grouping_separator) end
			if letter_value /= Void then Result.put_last (letter_value) end
			if ordinal /= Void then Result.put_last (ordinal) end
			if language /= Void then Result.put_last (language) end
			if count_pattern /= Void then
				create l_bridge.make (count_pattern, Current)
				Result.put_last (l_bridge)
			end
			if from_pattern /= Void then
				create l_bridge.make (from_pattern, Current)
				Result.put_last (l_bridge)
			end			
		end

feature -- Status report

	is_backwards_compatible: BOOLEAN
			-- Is in backwards compatible mode?

	display (a_level: INTEGER) is
			-- Diagnostic print of expression structure to `std.error'
		do
			std.error.put_string (STRING_.appended_string (indentation (a_level), "xsl:number"))
			std.error.put_new_line
			if select_expression /= Void then select_expression.display (a_level + 1) end
		end

feature -- Status setting

		compute_intrinsic_dependencies is
			-- Determine the intrinsic dependencies of an expression.
		do
			initialize_intrinsic_dependencies
			if select_expression = Void then
				set_intrinsically_depends_upon_context_item
			end
		end

feature -- Optimization

	simplify (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]) is
			-- Perform context-independent static optimizations.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]		
		do
			create l_replacement.make (Void)
			if select_expression /= Void then
				select_expression.simplify (l_replacement)
				set_select_expression (l_replacement.item)
				if select_expression.is_error then
					set_replacement (a_replacement, select_expression)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and value_expression /= Void then
				value_expression.simplify (l_replacement)
				set_value_expression (l_replacement.item)
				if value_expression.is_error then
					set_replacement (a_replacement, value_expression)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and format /= Void then
				format.simplify (l_replacement)
				set_format (l_replacement.item)
				if format.is_error then
					set_replacement (a_replacement, format)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and grouping_size /= Void then
				grouping_size.simplify (l_replacement)
				set_grouping_size (l_replacement.item)
				if grouping_size.is_error then
					set_replacement (a_replacement, grouping_size)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and grouping_separator /= Void then
				grouping_separator.simplify (l_replacement)
				set_grouping_separator (l_replacement.item)
				if grouping_separator.is_error then
					set_replacement (a_replacement, grouping_separator)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and letter_value /= Void then
				letter_value.simplify (l_replacement)
				set_letter_value (l_replacement.item)
				if letter_value.is_error then
					set_replacement (a_replacement, letter_value)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and ordinal /= Void then
				ordinal.simplify (l_replacement)
				set_ordinal (l_replacement.item)
				if ordinal.is_error then
					set_replacement (a_replacement, ordinal)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and language /= Void then
				language.simplify (l_replacement)
				set_language (l_replacement.item)
				if language.is_error then
					set_replacement (a_replacement, language)
					-- TODO: simplify count_pattern and from_pattern,
					--  in which case uncomment: l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end
		end

	check_static_type (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE) is
			-- Perform static type-checking of `Current' and its subexpressions.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			if select_expression /= Void then
				select_expression.check_static_type (l_replacement, a_context, a_context_item_type)
				set_select_expression (l_replacement.item)
				if select_expression.is_error then
					set_replacement (a_replacement, select_expression)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and value_expression /= Void then
				value_expression.check_static_type (l_replacement, a_context, a_context_item_type)
				set_value_expression (l_replacement.item)
				if value_expression.is_error then
					set_replacement (a_replacement, value_expression)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and format /= Void then
				format.check_static_type (l_replacement, a_context, a_context_item_type)
				set_format (l_replacement.item)
				if format.is_error then
					set_replacement (a_replacement, format)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and grouping_size /= Void then
				grouping_size.check_static_type (l_replacement, a_context, a_context_item_type)
				set_grouping_size (l_replacement.item)
				if grouping_size.is_error then
					set_replacement (a_replacement, grouping_size)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and grouping_separator /= Void then
				grouping_separator.check_static_type (l_replacement, a_context, a_context_item_type)
				set_grouping_separator (l_replacement.item)
				if grouping_separator.is_error then
					set_replacement (a_replacement, grouping_separator)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and letter_value /= Void then
				letter_value.check_static_type (l_replacement, a_context, a_context_item_type)
				set_letter_value (l_replacement.item)
				if letter_value.is_error then
					set_replacement (a_replacement, letter_value)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and ordinal /= Void then
				ordinal.check_static_type (l_replacement, a_context, a_context_item_type)
				set_ordinal (l_replacement.item)
				if ordinal.is_error then
					set_replacement (a_replacement, ordinal)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and language /= Void then
				language.check_static_type (l_replacement, a_context, a_context_item_type)
				set_language (l_replacement.item)
				if language.is_error then
					set_replacement (a_replacement, language)
					-- TODO: check count_pattern and from_pattern,
					--  in which case uncomment: l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end			
		end

	optimize (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE) is
			-- Perform optimization of `Current' and its subexpressions.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			if select_expression /= Void then
				select_expression.optimize (l_replacement, a_context, a_context_item_type)
				set_select_expression (l_replacement.item)
				if select_expression.is_error then
					set_replacement (a_replacement, select_expression)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and value_expression /= Void then
				value_expression.optimize (l_replacement, a_context, a_context_item_type)
				set_value_expression (l_replacement.item)
				if value_expression.is_error then
					set_replacement (a_replacement, value_expression)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and format /= Void then
				format.optimize (l_replacement, a_context, a_context_item_type)
				set_format (l_replacement.item)
				if format.is_error then
					set_replacement (a_replacement, format)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and grouping_size /= Void then
				grouping_size.optimize (l_replacement, a_context, a_context_item_type)
				set_grouping_size (l_replacement.item)
				if grouping_size.is_error then
					set_replacement (a_replacement, grouping_size)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and grouping_separator /= Void then
				grouping_separator.optimize (l_replacement, a_context, a_context_item_type)
				set_grouping_separator (l_replacement.item)
				if grouping_separator.is_error then
					set_replacement (a_replacement, grouping_separator)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and letter_value /= Void then
				letter_value.optimize (l_replacement, a_context, a_context_item_type)
				set_letter_value (l_replacement.item)
				if letter_value.is_error then
					set_replacement (a_replacement, letter_value)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and ordinal /= Void then
				ordinal.optimize (l_replacement, a_context, a_context_item_type)
				set_ordinal (l_replacement.item)
				if ordinal.is_error then
					set_replacement (a_replacement, ordinal)
				else
					l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void and language /= Void then
				language.optimize (l_replacement, a_context, a_context_item_type)
				set_language (l_replacement.item)
				if language.is_error then
					set_replacement (a_replacement, language)
					-- TODO: optimize count_pattern and from_pattern,
					--  in which case uncomment: l_replacement.put (Void)
				end
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end			
		end

	promote (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_offer: XM_XPATH_PROMOTION_OFFER) is
			-- Promote this subexpression.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
			l_promotion: XM_XPATH_EXPRESSION
		do
			a_offer.accept (Current)
			l_promotion := a_offer.accepted_expression
			if l_promotion /= Void then
				set_replacement (a_replacement, l_promotion)
			else
				create l_replacement.make (Void)
				if select_expression /= Void then
					select_expression.promote (l_replacement, a_offer)
					set_select_expression (l_replacement.item)
					if select_expression.is_error then
						set_replacement (a_replacement, select_expression)
					else
						l_replacement.put (Void)
					end
				end
				if a_replacement.item = Void and value_expression /= Void then
					value_expression.promote (l_replacement, a_offer)
					set_value_expression (l_replacement.item)
					if value_expression.is_error then
						set_replacement (a_replacement, value_expression)
					else
						l_replacement.put (Void)
					end
				end
				if a_replacement.item = Void and format /= Void then
					format.promote (l_replacement, a_offer)
					set_format (l_replacement.item)
					if format.is_error then
						set_replacement (a_replacement, format)
					else
						l_replacement.put (Void)
					end
				end
				if a_replacement.item = Void and grouping_size /= Void then
					grouping_size.promote (l_replacement, a_offer)
					set_grouping_size (l_replacement.item)
					if grouping_size.is_error then
						set_replacement (a_replacement, grouping_size)
					else
						l_replacement.put (Void)
					end
				end
				if a_replacement.item = Void and grouping_separator /= Void then
					grouping_separator.promote (l_replacement, a_offer)
					set_grouping_separator (l_replacement.item)
					if grouping_separator.is_error then
						set_replacement (a_replacement, grouping_separator)
					else
						l_replacement.put (Void)
					end
				end
				if a_replacement.item = Void and letter_value /= Void then
					letter_value.promote (l_replacement, a_offer)
					set_letter_value (l_replacement.item)
					if letter_value.is_error then
						set_replacement (a_replacement, letter_value)
					else
						l_replacement.put (Void)
					end
				end
				if a_replacement.item = Void and ordinal /= Void then
					ordinal.promote (l_replacement, a_offer)
					set_ordinal (l_replacement.item)
					if ordinal.is_error then
						set_replacement (a_replacement, ordinal)
					else
						l_replacement.put (Void)
					end
				end
				if a_replacement.item = Void and language /= Void then
					language.promote (l_replacement, a_offer)
					set_language (l_replacement.item)
					if language.is_error then
						set_replacement (a_replacement, language)
						-- TODO: promote count_pattern and from_pattern,
						--  in which case uncomment: l_replacement.put (Void)
					end
				end
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end
		end

feature -- Evaluation

	generate_tail_call (a_tail: DS_CELL [XM_XPATH_TAIL_CALL]; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Execute `Current', writing results to the current `XM_XPATH_RECEIVER'.	
		local
			l_receiver: XM_XPATH_SEQUENCE_RECEIVER
			l_letter: STRING
			l_integer_value: XM_XPATH_MACHINE_INTEGER_VALUE
			l_number_formatter: XM_XSLT_NUMBER_FORMATTER
			l_error: XM_XPATH_ERROR_VALUE
		do
			transformer := a_context.transformer
			l_receiver := a_context.current_receiver
			atomic_vector := Void
			calculate_vector (a_context)
			if not transformer.is_error then calculate_group_size (a_context)	end
			if not transformer.is_error then calculate_group_separator (a_context) end
			if not transformer.is_error then
				calculate_ordinal (a_context)
				if atomic_vector = Void and then format = Void and then group_size = 0 and then language = Void then
					
					-- fast path for the simple case
					
					l_receiver.notify_characters (value.out, 0)
				else
					if numberer = Void then
						language.evaluate_as_string (a_context)
						numberer := selected_numberer (language.last_evaluated_string.string_value)
					end
					if letter_value = Void then
						l_letter := ""
					else
						letter_value.evaluate_as_string (a_context)
						if letter_value.last_evaluated_string.is_error or else
							not (STRING_.same_string (letter_value.last_evaluated_string.string_value, "alphabetic") or else
								  STRING_.same_string (letter_value.last_evaluated_string.string_value, "traditional")) then
							create l_error.make_from_string ("Letter-value must be %"traditional%" or %"alphabetic%"", Xpath_errors_uri, "XTDE0030", Dynamic_error)
							l_error.set_location (system_id, line_number)
							transformer.report_fatal_error (l_error)
						else
							l_letter := letter_value.last_evaluated_string.string_value
						end
					end
					if not transformer.is_error then
						if atomic_vector = Void then
							create atomic_vector.make (1)
							create l_integer_value.make (value)
							atomic_vector.put_last (l_integer_value)
						end
						if formatter = Void then
							format.evaluate_as_string (a_context)
							if format.last_evaluated_string.is_error then
								create l_error.make_from_string ("Format must evaluate to a string", Xpath_errors_uri, "XTDE0030", Dynamic_error)
								l_error.set_location (system_id, line_number)
								transformer.report_fatal_error (l_error)
							else
								create l_number_formatter.make (format.last_evaluated_string.string_value)
							end
						else
							l_number_formatter := formatter
						end
					end
					if not transformer.is_error then
						l_receiver.notify_characters (l_number_formatter.formatted_string (atomic_vector, group_size, group_separator, l_letter, ordinal_value, numberer), 0)
					end
				end
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality is
			-- Compute cardinality.
		do
			set_cardinality_exactly_one
		end

feature {NONE} -- Implementation

	select_expression: XM_XPATH_EXPRESSION
			-- Selected node

	level: INTEGER
			-- Level

	count_pattern: XM_XSLT_PATTERN
			-- Nodes which are to be counted

	from_pattern: XM_XSLT_PATTERN
			-- Node from which counting is to be started

	value_expression: XM_XPATH_EXPRESSION
			-- Supplied value

	format: XM_XPATH_EXPRESSION
			-- Format for formatted number

	grouping_size, grouping_separator: XM_XPATH_EXPRESSION
			-- Grouping parameters

	letter_value: XM_XPATH_EXPRESSION
		-- Letter value

	ordinal: XM_XPATH_EXPRESSION
			-- Ordinal marker

	language: XM_XPATH_EXPRESSION
			-- Language

	formatter: XM_XSLT_NUMBER_FORMATTER
			-- Formatter

	numberer: ST_XSLT_NUMBERER
			-- Numberer

	has_variables_in_patterns: BOOLEAN
			-- Do any supplied patterns include variable references?


	-- The following are used to communicate between `generate_tail_call' and it's sub-routines

	value: INTEGER_64
			-- Value of number

	atomic_vector: DS_ARRAYED_LIST [XM_XPATH_ATOMIC_VALUE]
			-- Sequence of atoms to be used as place marker to be formatted

	transformer: XM_XSLT_TRANSFORMER
			-- Transformer

	group_size: INTEGER
			-- Group size set by `calculate_group_size'

	group_separator: STRING
			-- Group separator

	ordinal_value: STRING
			-- Ordinal

	set_select_expression (a_select_expression: XM_XPATH_EXPRESSION) is
			-- Ensure `select_expression' = `a_select_expression'.
		do
			if select_expression /= a_select_expression then
				select_expression := a_select_expression
				if select_expression /= Void then
					adopt_child_expression (select_expression)
					reset_static_properties
				end
			end
		ensure
			set: select_expression = a_select_expression
		end

	set_value_expression (a_value_expression: XM_XPATH_EXPRESSION) is
			-- Ensure `value_expression' = `a_value_expression'.
		do
			if value_expression /= a_value_expression then
				value_expression := a_value_expression
				if value_expression /= Void then
					adopt_child_expression (value_expression)
					reset_static_properties
				end
			end
		ensure
			set: value_expression = a_value_expression
		end

	set_format (a_format: XM_XPATH_EXPRESSION) is
			-- Ensure `format' = `a_format'.
		do
			if format /= a_format then
				format := a_format
				if format /= Void then
					adopt_child_expression (format)
					reset_static_properties
				end
			end
		ensure
			set: format = a_format
		end

	set_grouping_size (a_grouping_size: XM_XPATH_EXPRESSION) is
			-- Ensure `grouping_size' = `a_grouping_size'.
		do
			if grouping_size /= a_grouping_size then
				grouping_size := a_grouping_size
				if grouping_size /= Void then
					adopt_child_expression (grouping_size)
					reset_static_properties
				end
			end
		ensure
			set: grouping_size = a_grouping_size
		end

	set_grouping_separator (a_grouping_separator: XM_XPATH_EXPRESSION) is
			-- Ensure `grouping_separator' = `a_grouping_separator'.
		do
			if grouping_separator /= a_grouping_separator then
				grouping_separator := a_grouping_separator
				if grouping_separator /= Void then
					adopt_child_expression (grouping_separator)
					reset_static_properties
				end
			end
		ensure
			set: grouping_separator = a_grouping_separator
		end

	set_language (a_language: XM_XPATH_EXPRESSION) is
			-- Ensure `language' = `a_language'.
		do
			if language /= a_language then
				language := a_language
				if language /= Void then
					adopt_child_expression (language)
					reset_static_properties
				end
			end
		ensure
			set: language = a_language
		end

	set_ordinal (a_ordinal: XM_XPATH_EXPRESSION) is
			-- Ensure `ordinal' = `a_ordinal'.
		do
			if ordinal /= a_ordinal then
				ordinal := a_ordinal
				if ordinal /= Void then
					adopt_child_expression (ordinal)
					reset_static_properties
				end
			end
		ensure
			set: ordinal = a_ordinal
		end

	set_letter_value (a_letter_value: XM_XPATH_EXPRESSION) is
			-- Ensure `letter_value' = `a_letter_value'.
		do
			if letter_value /= a_letter_value then
				letter_value := a_letter_value
				if letter_value /= Void then
					adopt_child_expression (letter_value)
					reset_static_properties
				end
			end
		ensure
			set: letter_value = a_letter_value
		end

	
	calculate_ordinal (a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Calculate `ordinal_value'
		require
			context_not_void: a_context /= Void
			transformer_not_void: transformer /= Void
		do
			if ordinal /= Void then
				ordinal.evaluate_as_string (a_context)
				check
					ordinal: not ordinal.last_evaluated_string.is_error
				end
				ordinal_value := ordinal.last_evaluated_string.string_value
			else
				ordinal_value := ""
			end
		end

	calculate_group_separator (a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Calculate `group_separator'
		require
			context_not_void: a_context /= Void
			transformer_not_void: transformer /= Void
		local
			an_error: XM_XPATH_ERROR_VALUE
		do
			group_separator := ""
			if grouping_separator /= Void then
				grouping_separator.evaluate_as_string (a_context)
				check
					grouping_separator: not grouping_separator.last_evaluated_string.is_error
				end
				group_separator := grouping_separator.last_evaluated_string.string_value
				if group_separator.count > 1 then
					create an_error.make_from_string ("Grouping-separator must evaluate to a single character", Xpath_errors_uri, "XTDE0030", Dynamic_error)
					an_error.set_location (system_id, line_number)
					transformer.report_fatal_error (an_error)
				end
			end
		end

	calculate_group_size (a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Calculate `group_size'
		require
			context_not_void: a_context /= Void
			transformer_not_void: transformer /= Void
		local
			a_string: STRING
			an_error: XM_XPATH_ERROR_VALUE
		do
			if grouping_size = Void then
				group_size := 0
			else
				grouping_size.evaluate_as_string (a_context)
				if grouping_size.last_evaluated_string.is_error then
					create an_error.make_from_string ("grouping-size must be numeric", Xpath_errors_uri, "XTDE0030", Dynamic_error)
					an_error.set_location (system_id, line_number)
					transformer.report_fatal_error (an_error)
				else
					a_string := grouping_size.last_evaluated_string.string_value
					if not a_string.is_integer then
						create an_error.make_from_string ("grouping-size must be an integer", Xpath_errors_uri, "XTDE0030", Dynamic_error)
						an_error.set_location (system_id, line_number)
						transformer.report_fatal_error (an_error)
					else
						group_size := a_string.to_integer
						if group_size < 0 then
							create an_error.make_from_string ("grouping-size must be positive", Xpath_errors_uri, "XTDE0030", Dynamic_error)
							an_error.set_location (system_id, line_number)
							transformer.report_fatal_error (an_error)
						end
					end
				end
			end
		end

	calculate_vector (a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Calculate `atomic_vector' or `value'.
		require
			context_not_void: a_context /= Void
			transformer_not_void: transformer /= Void
		local
			l_source: XM_XPATH_NODE
			l_error: XM_XPATH_ERROR_VALUE
			l_item: DS_CELL [XM_XPATH_ITEM]
		do
			value := -1
			atomic_vector := Void
			if value_expression /= Void then
				calculate_value (a_context)
			else
				if select_expression /= Void then
					create l_item.make (Void)
					select_expression.evaluate_item (l_item, a_context)
					if l_item.item.is_node then
						l_source := l_item.item.as_node
					else
						create l_error.make_from_string ("Context item for xsl:number must be a node",
																	 Xpath_errors_uri, "XTTE0990", Type_error)
						l_error.set_location (system_id, line_number)
						transformer.report_fatal_error (l_error)
					end
				else
					if not a_context.context_item.is_node then
						create l_error.make_from_string ("Context item for xsl:number must be a node",
																	 Xpath_errors_uri, "XTTE0990", Type_error)
						l_error.set_location (system_id, line_number)
						transformer.report_fatal_error (l_error)
					else
						l_source := a_context.context_item.as_node
					end
				end
				if not transformer.is_error then
					if level = Simple_numbering then
						value := simple_number (l_source)
					elseif level = Single_level then
						calculate_single_number (l_source, count_pattern, from_pattern, a_context)
						if not transformer.is_error then
							value := last_single_number
							if value = 0 then
								create atomic_vector.make (0)
							end
						end
					elseif level = Any_level then
						calculate_any_number (l_source, count_pattern, a_context)
						if not transformer.is_error then
							value := last_single_number
							if value = 0 then
								create atomic_vector.make (0)
							end
						end
					elseif level = Multiple_levels then
						calculate_multi_level_number (l_source, a_context)
						if not transformer.is_error then
							atomic_vector := multi_level_number
						end
					end
				end
			end
		ensure
			error_or_value_or_atomic_vector: not transformer.is_error implies (value > 0 or atomic_vector /= Void)
		end

	calculate_value (a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Calculate `value'.
		require
			context_not_void: a_context /= Void
			transformer_not_void: transformer /= Void
		local
			l_sequence_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
			l_finished: BOOLEAN
			l_double_value: XM_XPATH_DOUBLE_VALUE
			l_atomic_value: XM_XPATH_ATOMIC_VALUE
			l_string_value: XM_XPATH_STRING_VALUE
			l_numeric_value: XM_XPATH_NUMERIC_VALUE
			l_error: XM_XPATH_ERROR_VALUE
		do
			from
				value_expression.create_iterator (a_context)
				l_sequence_iterator := value_expression.last_iterator
				if l_sequence_iterator.is_error then
					l_sequence_iterator.error_value.set_location (system_id, line_number)
					a_context.transformer.report_fatal_error (l_sequence_iterator.error_value)
				else
					l_sequence_iterator.start
				end
				create atomic_vector.make_default
			until
				l_finished or else l_sequence_iterator.is_error or else l_sequence_iterator.after
			loop
				l_atomic_value ?= l_sequence_iterator.item
				if l_atomic_value = Void then
					l_finished := True
				else
					if not l_atomic_value.is_numeric_value then
						l_double_value := item_to_double (l_atomic_value)
						if l_double_value.is_error then
							create l_double_value.make_nan
						end
						l_numeric_value := l_double_value
					else
						l_numeric_value := l_atomic_value.as_numeric_value
					end
					if l_numeric_value.is_nan then
						if is_backwards_compatible then
							l_finished := True
							create l_string_value.make ("NaN")
							atomic_vector.force_last (l_string_value)
						else
							create l_error.make_from_string ("Numbers to be formatted must be positive integers",
								Xpath_errors_uri, "XTDE0980", Dynamic_error)
							l_error.set_location (system_id, line_number)
							transformer.report_fatal_error (l_error)
							l_finished := True
						end
					else
						if not l_finished then
							l_numeric_value := l_numeric_value.rounded_value
							l_numeric_value.convert_to_type (type_factory.integer_type)
							l_atomic_value := l_numeric_value.converted_value
						end
					end
					if not l_finished and then l_atomic_value.as_numeric_value.is_negative then
						if is_backwards_compatible then
							l_finished := True
							create l_string_value.make ("NaN")
							atomic_vector.force_last (l_string_value)
						else
							create l_error.make_from_string ("Numbers to be formatted must be positive integers",
							Xpath_errors_uri, "XTDE0980", Dynamic_error)
							l_error.set_location (system_id, line_number)
							transformer.report_fatal_error (l_error)
						end
					end
					if not l_finished then
						atomic_vector.force_last (l_atomic_value)
					end
				end
				l_sequence_iterator.forth
				if is_backwards_compatible then
					l_finished := True
				end
			end
			if l_sequence_iterator.is_error then
				l_sequence_iterator.error_value.set_location (system_id, line_number)
				a_context.transformer.report_fatal_error (l_sequence_iterator.error_value)
			end
			if atomic_vector.is_empty and is_backwards_compatible then
				atomic_vector.put_last (create {XM_XPATH_STRING_VALUE}.make ("NaN"))
			end
		end

	simple_number (a_node: XM_XPATH_NODE): INTEGER_64 is
			-- Simple number of `a_node';
			-- This is defined as one plus the number of previous siblings
			--  of the same node type and name.
		require
			source_node_not_void: a_node /= Void
			transformer_not_void: transformer /= Void
		local
			a_fingerprint: INTEGER
			a_node_test: XM_XPATH_NODE_TEST
			an_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
			finished: BOOLEAN
			a_previous_node: XM_XPATH_NODE
			a_memo: DS_CELL [INTEGER_64]
		do
			a_fingerprint := a_node.fingerprint
			if a_fingerprint = -1 then
				create {XM_XPATH_NODE_KIND_TEST} a_node_test.make (a_node.node_type)
			else
				create {XM_XPATH_NAME_TEST} a_node_test.make_same_type (a_node)
			end
			from
				an_iterator := a_node.new_axis_iterator_with_node_test (Preceding_sibling_axis, a_node_test)
				an_iterator.start
				Result := 1
			until
				finished or else an_iterator.after
			loop
				a_previous_node := an_iterator.item
				a_memo := transformer.remembered_number (a_previous_node, Current)
				if a_memo /= Void then
					Result := Result + a_memo.item
					transformer.set_remembered_number (Result, a_node, Current)
					finished := True
				else
					an_iterator.forth
					Result := Result + 1
				end
				if not finished then
					transformer.set_remembered_number (Result, a_node, Current)
				end
			end
		ensure
			strictly_positive_integer: Result > 0
		end

	last_single_number: INTEGER_64
			-- Result from `calculate_single_number' or `calculate_any_number'

	calculate_single_number (a_node: XM_XPATH_NODE; a_count_pattern, a_from_pattern: XM_XSLT_PATTERN; a_context: XM_XSLT_EVALUATION_CONTEXT) is 
			-- One plus the number of previous siblings
			--  of the nearest ancestor-or-self, that match `count_pattern'.
		require
			source_node_not_void: a_node /= Void
			transformer_not_void: transformer /= Void
		local
			known_to_match, finished, already_checked: BOOLEAN
			a_target: XM_XPATH_NODE
			an_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
			a_count: XM_XSLT_PATTERN
			i: INTEGER
		do
			last_single_number := -1
			if a_count_pattern = Void and then a_from_pattern = Void then
				last_single_number := simple_number (a_node)
			else
				if a_count_pattern = Void then
					if a_node.fingerprint = -1 then
						create {XM_XSLT_NODE_KIND_TEST} a_count.make_without_location (a_node.node_type)
					else
						create {XM_XSLT_NAME_TEST} a_count.make_without_location (a_node)
					end
					known_to_match := True
				else
					a_count := a_count_pattern
				end
				from
					a_target := a_node
				until known_to_match or else finished loop
					a_count.match (a_target, a_context.new_pattern_context)
					if transformer.is_error then
						finished := True
					elseif a_count.last_match_result then
						known_to_match := True
					else
						a_target := a_target.parent
						if a_target = Void then
							last_single_number := 0
							finished := True
						end
					end
				end
				if not finished then
					if a_from_pattern /= Void then
						a_from_pattern.match (a_target, a_context.new_pattern_context)
						if not transformer.is_error and a_from_pattern.last_match_result then
							last_single_number := 0
						end
					end
					if last_single_number = -1 then
						
						-- We've found the ancestor to count from

						already_checked := a_count.is_node_test
						from
							an_iterator := a_target.new_axis_iterator_with_node_test (Preceding_sibling_axis, a_count.node_test)
							an_iterator.start; i := 1
						until transformer.is_error or an_iterator.after loop
							if already_checked then
								i := i + 1
							else
								a_count.match (an_iterator.item, a_context.new_pattern_context)
								if not transformer.is_error and a_count.last_match_result then
									i := i + 1
								end
							end
							an_iterator.forth
						end
						last_single_number := i
					end
				end
			end
		ensure
			positive_integer: not transformer.is_error implies last_single_number >= 0
		end

	calculate_any_number (a_node: XM_XPATH_NODE; a_count: XM_XSLT_PATTERN; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- One plus number of previous nodes that match `count_pattern'
		require
			source_node_not_void: a_node /= Void
			transformer_not_void: transformer /= Void
		local
			l_memo: DS_CELL [INTEGER_64]
			l_memoize, l_finished: BOOLEAN
			l_count: INTEGER_64
			l_filter: XM_XPATH_NODE_TEST
			l_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
			l_count_pattern: XM_XSLT_PATTERN
			l_node: XM_XPATH_NODE
		do
			last_single_number := -1
			l_memoize := not has_variables_in_patterns
			if a_count = Void then
				if a_node.fingerprint = -1 then
						create {XM_XSLT_NODE_KIND_TEST} l_count_pattern.make_without_location (a_node.node_type)
					else
						create {XM_XSLT_NAME_TEST} l_count_pattern.make_without_location (a_node)
				end
				l_count := 1
			else
				l_count_pattern := a_count
				l_count_pattern.match (a_node, a_context.new_pattern_context)
				if not transformer.is_error and l_count_pattern.last_match_result then
					l_count := 1
				end
			end

			-- Pass part of the filtering down to the axis iterator if possible

			if from_pattern = Void then
				l_filter := l_count_pattern.node_test
			elseif from_pattern.node_kind = Element_node and then l_count_pattern.node_kind = Element_node then
				l_filter := element_node_kind_test
			else
				l_filter := any_node_test
			end
			from
				l_iterator := a_node.new_axis_iterator_with_node_test (Preceding_or_ancestor_axis, l_filter)
				l_iterator.start
			until l_finished or l_iterator.after or transformer.is_error loop
				l_node := l_iterator.item
				l_count_pattern.match (l_node, a_context.new_pattern_context)
				if not transformer.is_error and l_count_pattern.last_match_result then
					if l_memoize and l_count = 1 then
						l_memo := transformer.remembered_number (l_node, Current)
						if l_memo /= Void then
							last_single_number := l_memo.item + 1
							l_finished := True
						end
					end
					if not l_finished then
						l_count := l_count + 1
					end
				end
				if not l_finished then
					if from_pattern /= Void then
						from_pattern.match (l_iterator.item, a_context.new_pattern_context)
						if not transformer.is_error and from_pattern.last_match_result then
							last_single_number := l_count
							l_finished := True
						end
					end
				end
				l_iterator.forth
			end
			if not l_finished then
				if from_pattern /= Void and then last_single_number = -1 then
					last_single_number := 0
				else
					last_single_number := l_count
				end
			end
			if l_memoize and last_single_number /= 0 then
				transformer.set_remembered_number (last_single_number, a_node, Current)
			end
		ensure
			positive_integer: not transformer.is_error implies last_single_number >= 0
		end

	multi_level_number: DS_ARRAYED_LIST [XM_XPATH_ATOMIC_VALUE]
			-- Result from `calculate_multi_level_number'
	
	calculate_multi_level_number (a_node: XM_XPATH_NODE; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Hirerarchic position of `a_node'
		require
			source_node_not_void: a_node /= Void
			transformer_not_void: transformer /= Void
		local
			a_current_node: XM_XPATH_NODE
			finished: BOOLEAN
			an_integer_value: XM_XPATH_MACHINE_INTEGER_VALUE
		do
			create multi_level_number.make_default
			if count_pattern = Void then
				if a_node.fingerprint = -1 then
					create {XM_XSLT_NODE_KIND_TEST} count_pattern.make_without_location (a_node.node_type)
				else
					create {XM_XSLT_NAME_TEST} count_pattern.make_without_location (a_node)
				end
			end
			from a_current_node := a_node	until finished loop
				count_pattern.match (a_current_node, a_context.new_pattern_context)
				if transformer.is_error then
					finished := True
				elseif count_pattern.last_match_result then
					calculate_single_number (a_current_node, count_pattern, Void, a_context)
					if transformer.is_error then
						finished := True
					else
						create an_integer_value.make (last_single_number)
						multi_level_number.force_first (an_integer_value)
					end
				end
				a_current_node := a_current_node.parent
				if a_current_node = Void then
					finished := True
				elseif from_pattern /= Void then
					from_pattern.match (a_current_node, a_context.new_pattern_context)
					if transformer.is_error or from_pattern.last_match_result then
						finished := True
					end
				end
			end
		ensure
			multi_level_number_not_void: multi_level_number /= Void
		end

invariant

	language: initialized and then language = Void implies numberer /= Void
	formatter: initialized and then formatter = Void implies format /= Void

end

