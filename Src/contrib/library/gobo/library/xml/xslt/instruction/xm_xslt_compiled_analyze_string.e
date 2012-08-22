note

	description: "Objects that represent an xsl:analyze-string,"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_COMPILED_ANALYZE_STRING

inherit

	XM_XSLT_INSTRUCTION
		redefine
			sub_expressions, promote_instruction,
			item_type, compute_dependencies, create_iterator, create_node_iterator
		end

	XM_XPATH_REGEXP_CACHE_ROUTINES

	XM_XPATH_SHARED_REGEXP_CACHE

	KL_IMPORTED_ARRAY_ROUTINES
		export {NONE} all end

	UC_IMPORTED_UTF8_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (an_executable: XM_XSLT_EXECUTABLE; a_select_expression, a_regex_expression, a_flags_expression: XM_XPATH_EXPRESSION;
			a_regexp_cache_entry: XM_XPATH_REGEXP_CACHE_ENTRY; a_matching_block, a_non_matching_block: XM_XPATH_EXPRESSION)
			-- Establish invariant.
		require
			executable_not_void: an_executable /= Void
			select_expression_not_void: a_select_expression /= Void
			regex_expression_not_void: a_regex_expression /= Void
			flags_expression_not_void: a_flags_expression /= Void
			at_least_one_block: a_matching_block = Void implies a_non_matching_block /= Void
		local
			a_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
		do
			executable := an_executable
			select_expression := a_select_expression
			regex_expression := a_regex_expression
			flags_expression := a_flags_expression
			regexp_cache_entry := a_regexp_cache_entry
			matching_block := a_matching_block
			non_matching_block := a_non_matching_block
			from
				a_cursor := sub_expressions.new_cursor; a_cursor.start
			until a_cursor.after loop
				adopt_child_expression (a_cursor.item)
				a_cursor.forth
			end
			compute_static_properties
			initialized := True
			context_item_type := type_factory.string_type
		ensure
			executable_set: executable = an_executable
			select_expression_set: select_expression = a_select_expression
			regex_expression_set: regex_expression = a_regex_expression
			flags_expression_set: flags_expression = a_flags_expression
			regexp_cache_entry_set: regexp_cache_entry = a_regexp_cache_entry
			matching_block_set: matching_block = a_matching_block
			non_matching_block_set: non_matching_block = a_non_matching_block
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type of the expression, when known
		do
			if matching_block /= Void then
				if non_matching_block /= Void then
					Result := common_super_type (matching_block.item_type, non_matching_block.item_type)
				else
					Result := matching_block.item_type
				end
			else
				Result := non_matching_block.item_type
			end
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

	sub_expressions: DS_ARRAYED_LIST [XM_XPATH_EXPRESSION]
			-- Immediate sub-expressions of `Current'
		do
			create Result.make (5)
			Result.set_equality_tester (expression_tester)
			Result.put_last (select_expression)
			Result.put_last (regex_expression)
			Result.put_last (flags_expression)
			if matching_block /= Void then
				Result.put_last (matching_block)
			end
			if non_matching_block /= Void then
				Result.put_last (non_matching_block)
			end
		end

feature -- Status report

	display (a_level: INTEGER)
			-- Diagnostic print of expression structure to `std.error'
		do
			std.error.put_string (STRING_.concat (indentation (a_level), "xsl:analyze-string"))
			std.error.put_new_line
		end

feature -- Status setting

	compute_dependencies
			-- Compute dependencies on context.
		local
			l_dummy: XM_XPATH_STATIC_PROPERTY
		do
			if not are_intrinsic_dependencies_computed then
				compute_intrinsic_dependencies
			end
			if not select_expression.are_dependencies_computed then
				select_expression.as_computed_expression.compute_dependencies
			end
			set_dependencies (select_expression)
			if not regex_expression.are_dependencies_computed then
				regex_expression.as_computed_expression.compute_dependencies
			end
			merge_dependencies (regex_expression)
			if not flags_expression.are_dependencies_computed then
				flags_expression.as_computed_expression.compute_dependencies
			end
			merge_dependencies (flags_expression)
			if matching_block /= Void then
				if not matching_block.are_dependencies_computed then
					matching_block.as_computed_expression.compute_dependencies
				end
				create l_dummy
				l_dummy.set_dependencies (matching_block)
				if l_dummy.depends_upon_focus then
					l_dummy.set_focus_independent
				end
				if l_dummy.depends_upon_regexp_group then
					l_dummy.set_regexp_group_independent
				end
				merge_dependencies (l_dummy)
			end
			if non_matching_block /= Void then
				if not non_matching_block.are_dependencies_computed then
					non_matching_block.as_computed_expression.compute_dependencies
				end
				create l_dummy
				l_dummy.set_dependencies (non_matching_block)
				if l_dummy.depends_upon_focus then
					l_dummy.set_focus_independent
				end
				if l_dummy.depends_upon_regexp_group then
					l_dummy.set_regexp_group_independent
				end
				merge_dependencies (l_dummy)
			end
		end

feature -- Optimization

	simplify (a_replacement: DS_CELL [XM_XPATH_EXPRESSION])
			-- Preform context-independent static optimizations
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			select_expression.simplify (l_replacement)
			set_select_expression (l_replacement.item)
			if select_expression.is_error then
				set_replacement (a_replacement, select_expression)
			else
				l_replacement.put (Void)
				regex_expression.simplify (l_replacement)
				set_regex_expression (l_replacement.item)
				if regex_expression.is_error then
					set_replacement (a_replacement, regex_expression)
				else
					l_replacement.put (Void)
					flags_expression.simplify (l_replacement)
					set_flags_expression (l_replacement.item)
					if flags_expression.is_error then
						set_replacement (a_replacement, flags_expression)
					else
						if matching_block /= Void then
							l_replacement.put (Void)
							matching_block.simplify (l_replacement)
							set_matching_block (l_replacement.item)
							if matching_block.is_error then
								set_replacement (a_replacement, matching_block)
							elseif non_matching_block /= Void then
								l_replacement.put (Void)
								non_matching_block.simplify (l_replacement)
								set_non_matching_block (l_replacement.item)
								if non_matching_block.is_error then
									set_replacement (a_replacement, non_matching_block)
								end
							end
						end
					end
				end
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end
		end

	check_static_type (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE)
			-- Perform static type-checking of `Current' and its subexpressions.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			select_expression.check_static_type (l_replacement, a_context, a_context_item_type)
			set_select_expression (l_replacement.item)
			if select_expression.is_error then
				set_replacement (a_replacement, select_expression)
			else
				l_replacement.put (Void)
				regex_expression.check_static_type (l_replacement, a_context, a_context_item_type)
				set_regex_expression (l_replacement.item)
				if regex_expression.is_error then
					set_replacement (a_replacement, regex_expression)
				else
					l_replacement.put (Void)
					flags_expression.check_static_type (l_replacement, a_context, a_context_item_type)
					set_flags_expression (l_replacement.item)
					if flags_expression.is_error then
						set_replacement (a_replacement, flags_expression)
					else
						if matching_block /= Void then
							l_replacement.put (Void)
							matching_block.check_static_type (l_replacement, a_context, context_item_type)
							set_matching_block (l_replacement.item)
							if matching_block.is_error then
								set_replacement (a_replacement, matching_block)
							end
						end
						if non_matching_block /= Void then
							l_replacement.put (Void)
							non_matching_block.check_static_type (l_replacement, a_context, context_item_type)
							set_non_matching_block (l_replacement.item)
							if non_matching_block.is_error then
								set_replacement (a_replacement, non_matching_block)
							end
						end
					end
				end
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end
		end

	optimize (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE)
			-- Perform optimization of `Current' and its subexpressions.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			select_expression.optimize (l_replacement, a_context, a_context_item_type)
			if select_expression.is_error then
				set_replacement (a_replacement, select_expression)
			else
				l_replacement.put (Void)
				regex_expression.optimize (l_replacement, a_context, a_context_item_type)
				if regex_expression.is_error then
					set_replacement (a_replacement, regex_expression)
				else
					l_replacement.put (Void)
					flags_expression.optimize (l_replacement, a_context, a_context_item_type)
					set_flags_expression (l_replacement.item)
					if flags_expression.is_error then
						set_replacement (a_replacement, flags_expression)
					else
						l_replacement.put (Void)
						if matching_block /= Void then
							matching_block.optimize (l_replacement, a_context, context_item_type)
							set_matching_block (l_replacement.item)
							if matching_block.is_error then
								set_replacement (a_replacement, matching_block)
							end
						end
						if non_matching_block /= Void then
							l_replacement.put (Void)
							non_matching_block.optimize (l_replacement, a_context, context_item_type)
							set_non_matching_block (l_replacement.item)
							if non_matching_block.is_error then
								set_replacement (a_replacement, non_matching_block)
							end
						end
					end
				end
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end
		end

	promote_instruction (a_offer: XM_XPATH_PROMOTION_OFFER)
			-- Promote this instruction.
		local
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			create l_replacement.make (Void)
			select_expression.promote (l_replacement, a_offer)
			set_select_expression (l_replacement.item)
			l_replacement.put (Void)
			regex_expression.promote (l_replacement, a_offer)
			set_regex_expression (l_replacement.item)
			l_replacement.put (Void)
			flags_expression.promote (l_replacement, a_offer)
			set_flags_expression (l_replacement.item)
			l_replacement.put (Void)
			if matching_block /= Void then
				l_replacement.put (Void)
				matching_block.promote (l_replacement, a_offer)
				set_matching_block (l_replacement.item)
			end
			if non_matching_block /= Void then
				l_replacement.put (Void)
				non_matching_block.promote (l_replacement, a_offer)
				set_non_matching_block (l_replacement.item)
			end
		end

feature -- Evaluation

	create_iterator (a_context: XM_XPATH_CONTEXT)
			-- Iterate over the values of a sequence.
		local
			l_regexp_iterator: XM_XSLT_REGEXP_ITERATOR
			l_context, l_new_context: XM_XSLT_EVALUATION_CONTEXT
		do
			l_context ?= a_context
			check
				l_context_not_void: l_context /= Void
				-- this is XSLT
			end
			l_regexp_iterator := regexp_iterator (l_context)
			if l_context.transformer.is_error then
				create {XM_XPATH_INVALID_ITERATOR} last_iterator.make (l_context.transformer.last_error)
			else
				l_new_context := l_context.new_context
				l_new_context.set_current_iterator (l_regexp_iterator)
				l_new_context.set_current_regexp_iterator (l_regexp_iterator)
				create {XM_XPATH_CONTEXT_MAPPING_ITERATOR} last_iterator.make (create {XM_XSLT_ANALYZE_MAPPING_FUNCTION}.make (l_regexp_iterator, l_new_context, matching_block, non_matching_block), l_new_context)
			end
		end

	create_node_iterator (a_context: XM_XPATH_CONTEXT)
			-- Iterate over the nodes of a sequence.
		local
			l_regexp_iterator: XM_XSLT_REGEXP_ITERATOR
			l_context, l_new_context: XM_XSLT_EVALUATION_CONTEXT
		do
			l_context ?= a_context
			check
				l_context_not_void: l_context /= Void
				-- this is XSLT
			end
			l_regexp_iterator := regexp_iterator (l_context)
			if l_context.transformer.is_error then
				create {XM_XPATH_INVALID_NODE_ITERATOR} last_node_iterator.make (l_context.transformer.last_error)
			else
				l_new_context := l_context.new_context
				l_new_context.set_current_iterator (l_regexp_iterator)
				l_new_context.set_current_regexp_iterator (l_regexp_iterator)
				create {XM_XPATH_NODE_MAPPING_ITERATOR} last_node_iterator.make (l_regexp_iterator, create {XM_XSLT_ANALYZE_NODE_MAPPING_FUNCTION}.make (l_regexp_iterator, l_new_context, matching_block, non_matching_block), l_new_context)
			end
		end

	generate_tail_call (a_tail: DS_CELL [XM_XPATH_TAIL_CALL]; a_context: XM_XSLT_EVALUATION_CONTEXT)
			-- Execute `Current', writing results to the current `XM_XPATH_RECEIVER'.
		local
			l_regexp_iterator: XM_XSLT_REGEXP_ITERATOR
			l_new_context: XM_XSLT_EVALUATION_CONTEXT
		do
			l_regexp_iterator := regexp_iterator (a_context)
			if not a_context.transformer.is_error then
				l_new_context := a_context.new_context
				l_new_context.set_current_iterator (l_regexp_iterator)
				l_new_context.set_current_regexp_iterator (l_regexp_iterator)
				from l_regexp_iterator.start until is_error or else l_regexp_iterator.after loop
					if l_regexp_iterator.is_error then
						a_context.transformer.report_fatal_error (l_regexp_iterator.error_value)
					elseif l_regexp_iterator.is_matching then
						if matching_block /= Void then
							matching_block.generate_events (l_new_context)
						end
						l_regexp_iterator.forth
					else
						if non_matching_block /= Void then
							non_matching_block.generate_events (l_new_context)
						end
						l_regexp_iterator.forth
					end
				end
			end
		end

feature {NONE} -- Implementation

	select_expression: XM_XPATH_EXPRESSION
			-- Select expression

	regex_expression: XM_XPATH_EXPRESSION
			-- Regex expression

	flags_expression: XM_XPATH_EXPRESSION
			-- Falgs expression

	regexp_cache_entry: XM_XPATH_REGEXP_CACHE_ENTRY
		-- Cached regular expression

	matching_block: XM_XPATH_EXPRESSION
			-- Expression called for matching substrings

	non_matching_block: XM_XPATH_EXPRESSION
			-- Expression called for non-matching substrings

	context_item_type: XM_XPATH_ITEM_TYPE
			-- Known context item type for xsl:(non-)matching-substring

	set_select_expression (a_expression: XM_XPATH_EXPRESSION)
			-- Ensure `select_expression' is `a_expression'.
		require
			a_expression_not_void: a_expression /= Void
		do
			if select_expression /= a_expression then
				select_expression := a_expression
				adopt_child_expression (select_expression)
				reset_static_properties
			end
		ensure
			select_expression_set: select_expression = a_expression
		end

	set_regex_expression (a_expression: XM_XPATH_EXPRESSION)
			-- Ensure `regex_expression' is `a_expression'.
		require
			a_expression_not_void: a_expression /= Void
		do
			if regex_expression /= a_expression then
				regex_expression := a_expression
				adopt_child_expression (regex_expression)
				reset_static_properties
			end
		ensure
			regex_expression_set: regex_expression = a_expression
		end

	set_flags_expression (a_expression: XM_XPATH_EXPRESSION)
			-- Ensure `flags_expression' is `a_expression'.
		require
			a_expression_not_void: a_expression /= Void
		do
			if flags_expression /= a_expression then
				flags_expression := a_expression
				adopt_child_expression (flags_expression)
				reset_static_properties
			end
		ensure
			flags_expression_set: flags_expression = a_expression
		end


	set_matching_block (a_expression: XM_XPATH_EXPRESSION)
			-- Ensure `matching_block' is `a_expression'.
		require
			a_expression_not_void: a_expression /= Void
		do
			if matching_block /= a_expression then
				matching_block := a_expression
				adopt_child_expression (matching_block)
				reset_static_properties
			end
		ensure
			matching_block_set: matching_block = a_expression
		end


	set_non_matching_block (a_expression: XM_XPATH_EXPRESSION)
			-- Ensure `non_matching_block' is `a_expression'.
		require
			a_expression_not_void: a_expression /= Void
		do
			if non_matching_block /= a_expression then
				non_matching_block := a_expression
				adopt_child_expression (non_matching_block)
				reset_static_properties
			end
		ensure
			non_matching_block_set: non_matching_block = a_expression
		end


	regexp_iterator (a_context: XM_XSLT_EVALUATION_CONTEXT): XM_XSLT_REGEXP_ITERATOR
			-- Iterator over substrings in regular expression;
		require
			context_not_void: a_context /= Void
		local
			an_input, some_flags, a_key: STRING
			an_error: XM_XPATH_ERROR_VALUE
		do
			select_expression.evaluate_as_string (a_context)
			if select_expression.last_evaluated_string.is_error then
				a_context.transformer.report_fatal_error (select_expression.last_evaluated_string.error_value)
			else
				an_input := utf8.to_utf8 (select_expression.last_evaluated_string.string_value)
				if regexp_cache_entry = Void then
					flags_expression.evaluate_as_string (a_context)
					if flags_expression.last_evaluated_string.is_error then
						a_context.transformer.report_fatal_error (flags_expression.last_evaluated_string.error_value)
					else
						some_flags := normalized_flags_string (flags_expression.last_evaluated_string.string_value)
						regex_expression.evaluate_as_string (a_context)
						if regex_expression.last_evaluated_string.is_error then
							a_context.transformer.report_fatal_error (regex_expression.last_evaluated_string.error_value)
						else
							a_key := composed_key (utf8.to_utf8 (regex_expression.last_evaluated_string.string_value), some_flags)
							regexp_cache_entry :=  shared_regexp_cache.item (a_key)
							if regexp_cache_entry = Void then
								create regexp_cache_entry.make (utf8.to_utf8 (regex_expression.last_evaluated_string.string_value), some_flags)
								if regexp_cache_entry.is_error then
									create an_error.make_from_string (STRING_.concat ("Invalid regular expression: ", regex_expression.last_evaluated_string.string_value),
																				 Xpath_errors_uri, "XTDE1140", Dynamic_error)
									a_context.transformer.report_fatal_error (an_error)
								else
									shared_regexp_cache.put (regexp_cache_entry, a_key)
								end
							end
							if not a_context.transformer.is_error then
								if regexp_cache_entry.regexp.matches ("") then
									create an_error.make_from_string ("Regular expression matches zero-length string", Xpath_errors_uri, "XTDE1150", Dynamic_error)
								end
							end
						end
					end
				end
				if not a_context.transformer.is_error then

					-- we don't examine the cache for xsl:analyze-string - TODO: possible improvement

					create Result.make (an_input, regexp_cache_entry.regexp)
				end
			end
		ensure
			error_or_result_not_void: not a_context.transformer.is_error implies Result /= Void
		end

invariant

	select_expression_not_void: select_expression /= Void
	regex_expression_not_void: regex_expression /= Void
	flags_expression_not_void: flags_expression /= Void
	at_least_one_block: matching_block = Void implies non_matching_block /= Void

end

