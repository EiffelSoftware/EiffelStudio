indexing

	description:

		"Objects that represent a hypothetical xsl:block instruction%
	    %which simply evaluates it's contents.%
	    %Used for top-level templates, xsl:otherwise, etc."

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_BLOCK

inherit

	XM_XSLT_INSTRUCTION
		undefine
			sub_expressions, item_type, compute_cardinality,
			contains_recursive_tail_function_calls,
			create_iterator, creates_new_nodes,
			mark_tail_function_calls, same_expression,
			is_sequence_expression, create_node_iterator,
			as_sequence_expression, promote
		redefine
			promote_instruction, native_implementations, compute_special_properties
		end

	XM_XPATH_SEQUENCE_EXPRESSION
		rename
			make as make_sequence
		undefine
			is_tail_call, evaluate_item, native_implementations,
			as_tail_call, generate_events, system_id_from_module_number,
			processed_eager_evaluation
		redefine
			compute_special_properties
		end

create

	make

feature {NONE} -- Initialization

	make (a_executable: XM_XSLT_EXECUTABLE; a_head, a_tail: XM_XPATH_EXPRESSION; a_module_number, a_line_number: INTEGER) is
			-- Create a general-purpose block.
		require
			a_executable_not_void: a_executable /= Void
			a_head_not_void: a_head /= Void
			a_tail_not_void: a_tail /= Void
			strictly_positive_module_number: a_module_number > 0
			positive_line_number: a_line_number >= 0
		do
			make_sequence (a_head, a_tail)
			set_source_location (a_module_number, a_line_number)
			executable := a_executable			
		ensure
			executable_set: executable = a_executable
		end

feature -- Status report

	creates_new_nodes: BOOLEAN is
			-- Can `Current' create new nodes?
		local
			a_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
		do
			if children.count > 0 then
				from
					a_cursor := children.new_cursor; a_cursor.start
				variant
					children.count + 1 - a_cursor.index
				until
					a_cursor.after
				loop
					if not a_cursor.item.non_creating then
						Result := True
						a_cursor.go_after
					else
						a_cursor.forth
					end
				end
			end
		end

feature -- Optimization

	promote_instruction (a_offer: XM_XPATH_PROMOTION_OFFER) is
			-- Promote this instruction.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
			l_child: XM_XPATH_EXPRESSION
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			from
				create l_replacement.make (Void)
				l_cursor := children.new_cursor
				l_cursor.start
			variant
				children.count + 1 - l_cursor.index
			until
				l_cursor.after
			loop
				l_child := l_cursor.item
				l_child.promote (l_replacement, a_offer)
				if l_replacement.item /= l_child then
					l_cursor.replace (l_replacement.item)
					reset_static_properties
				end
				l_replacement.put (Void)
				l_cursor.forth
			end	
		end

feature -- Evaluation

	generate_tail_call (a_tail: DS_CELL [XM_XPATH_TAIL_CALL]; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Execute `Current', writing results to the current `XM_XPATH_RECEIVER'.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
			l_child: XM_XPATH_EXPRESSION
			l_instruction: XM_XSLT_INSTRUCTION
			l_user_call: XM_XSLT_USER_FUNCTION_CALL
			l_function, l_previous_function: XM_XSLT_COMPILED_USER_FUNCTION
			l_value: DS_CELL [XM_XPATH_VALUE]
			l_finished: BOOLEAN
		do
			from
				l_cursor := children.new_cursor; l_cursor.start
			variant
				children.count + 1 - l_cursor.index
			until
				a_context.transformer.is_error or else l_cursor.after
			loop
				l_child := l_cursor.item
				a_tail.put (Void)
				l_instruction ?= l_child
				if l_instruction /= Void then
					l_instruction.generate_tail_call (a_tail, a_context)
				else
					l_child.generate_events (a_context)
					if a_context.tail_call_function /= Void then
						from
							l_finished := False
						until l_finished loop
							l_function := a_context.tail_call_function
							a_context.clear_tail_call_function
							if l_previous_function = Void and l_child.is_user_function_call then
								l_user_call ?= l_child
								l_previous_function := l_user_call.function
							end
							if l_function /= Void then
								if l_function /= l_previous_function then
									a_context.reset_stack_frame_map (l_function.slot_manager, l_function.parameter_definitions.count)
								end
								l_previous_function := l_function
								create l_value.make (Void)
								l_function.body.evaluate (l_value, l_function.evaluation_mode, 1, a_context)
								l_value.item.generate_events (a_context)
							else
								l_finished := True
							end
						end
					end
				end
				l_cursor.forth
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_special_properties is
			-- Compute special properties.
		do
			Precursor {XM_XPATH_SEQUENCE_EXPRESSION}
			if not creates_new_nodes then
				set_non_creating
			end
		end

feature {NONE} -- Implementation
	
	native_implementations: INTEGER is
			-- Natively-supported evaluation routines
		do
				Result := Supports_process + Supports_iterator
		end

end
	
