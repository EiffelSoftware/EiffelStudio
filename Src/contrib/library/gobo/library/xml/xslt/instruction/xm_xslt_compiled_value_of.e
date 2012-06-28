indexing

	description:

		"Compiled xsl:value-of elements"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_COMPILED_VALUE_OF

inherit

	XM_XSLT_TEXT_CONSTRUCTOR
		redefine
			display, evaluate_item, item_type,
			compute_cardinality, is_value_of
		end

	XM_XPATH_RECEIVER_OPTIONS
		export {NONE} all end

	XM_XPATH_SHARED_NODE_KIND_TESTS
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (an_executable: XM_XSLT_EXECUTABLE; a_select_expression: XM_XPATH_EXPRESSION; disabled: BOOLEAN; a_module_number, a_line_number: INTEGER) is
			-- Establish invariant.
		require
			executable_not_void: an_executable /= Void
		local
			a_string_value: XM_XPATH_STRING_VALUE
			is_special: BOOLEAN
			a_string: STRING
			an_index, a_count, a_code: INTEGER
		do
			set_source_location (a_module_number, a_line_number)
			executable := an_executable
			select_expression := a_select_expression
			if select_expression /= Void then adopt_child_expression (select_expression) end
			is_special := True
			a_string_value ?= select_expression
			if a_string_value /= Void then
				instruction_name := "xsl:text"
				from
					is_special := False
					a_string := a_string_value.string_value
					an_index := 1; a_count := a_string.count
				until
					is_special or else an_index > a_count
				loop
					a_code := a_string.item_code (an_index)
					if a_code < 33 or else a_code > 126
						or else a_code = 60 or else a_code = 62 or else a_code = 38 then
						-- <, > or &
						is_special := True
					end
					an_index := an_index + 1
				end
				if not is_special then
					receiver_options := No_special_characters
				end
			else
				instruction_name := "xsl:value-of"
			end
			if disabled then
				if	not is_special then
					receiver_options := Disable_escaping + No_special_characters
				else
					receiver_options := Disable_escaping
				end
			end
			compute_static_properties
			initialized := True
		ensure
			executable_set: executable = an_executable
			select_set: select_expression = a_select_expression
		end

feature -- Access

	instruction_name: STRING
			-- Name of instruction, for diagnostics
	
	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, when known
		do
			Result := text_node_kind_test
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	is_value_of: BOOLEAN is
			-- Is `Current' an `XM_XSLT_COMPILED_VALUE_OF'?
		do
			Result := True
		end

	display (a_level: INTEGER) is
			-- Diagnostic print of expression structure to `std.error'
		local
			a_string: STRING
		do
			a_string := STRING_.appended_string (indentation (a_level), instruction_name)
			std.error.put_string (a_string)
			std.error.put_new_line
			check
				select_expression_not_void: select_expression /= Void
				-- Compiling ensures this
			end
			select_expression.display (a_level + 1)
		end

feature -- Optimization

	type_check (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE) is
			-- Perform static type checking
		do
			-- do nothing
		end

feature -- Evaluation

	evaluate_item (a_result: DS_CELL [XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a single item to `a_result'.
		local
			l_orphan: XM_XPATH_ORPHAN
			l_evaluation_context: XM_XSLT_EVALUATION_CONTEXT
		do
			l_evaluation_context ?= a_context
			check
				evaluation_context: l_evaluation_context /= Void
				-- This is XSLT
			end
			expand_children (l_evaluation_context)
			if not is_error then
				create l_orphan.make (Text_node, last_string_value)
				a_result.put (l_orphan)
			else
				conditionally_set_error_location
				a_result.put (create {XM_XPATH_INVALID_ITEM}.make (error_value))
			end
		end

	generate_tail_call (a_tail: DS_CELL [XM_XPATH_TAIL_CALL]; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Execute `Current', writing results to the current `XM_XPATH_RECEIVER'.
		do
			expand_children (a_context)
			if is_error then
				conditionally_set_error_location
				a_context.transformer.report_recoverable_error (error_value)
				a_context.current_receiver.on_error (error_value.error_message)
			else
				a_context.current_receiver.notify_characters (STRING_.cloned_string (last_string_value), receiver_options)
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality is
			-- Compute cardinality.
		do
			set_cardinality_exactly_one
		end

feature {NONE} -- Implementation

	receiver_options: INTEGER
			-- Receiver options

end
	
