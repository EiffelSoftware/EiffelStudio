indexing
	description	: "Abstract description of a multi_branch instruction, %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class INSPECT_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots,
			byte_node, 
			fill_calls_list, 
			replicate
		end

	SHARED_INSPECT

feature {AST_FACTORY} -- Initialization

	initialize (s: like switch; c: like case_list; e: like else_part; p, l: INTEGER) is
			-- Create a new INSPECT AST node.
		require
			s_not_void: s /= Void
		do
			switch := s
			case_list := c
			else_part := e
			start_position := p
			line_number := l
		ensure
			switch_set: switch = s
			case_list_set: case_list = c
			else_part_set: else_part = e
			start_position_set: start_position = p
			line_number_set: line_number = l
		end

feature -- Attributes

	switch: EXPR_AS
			-- Expression to inspect

	case_list: EIFFEL_LIST [CASE_AS]
			-- Alternatives

	else_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- Else part

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1 -- "inspect cond" line
			if case_list /= Void then
				Result := Result + case_list.number_of_breakpoint_slots
			end
			if else_part /= Void then
				Result := Result + else_part.number_of_breakpoint_slots
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (case_list, other.case_list) and then
				equivalent (else_part, other.else_part) and then
				equivalent (switch, other.switch)
		end

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check a multi-branch instruction
		local
			current_item: TYPE_A
			vomb1: VOMB1
			controler: INSPECT_CONTROL
		do
			switch.type_check

				-- Initialization of the multi-branch controler
			create controler.make
			Inspect_controlers.put_front (controler)
			controler.set_node (Current)
			controler.set_feature_table (context.a_class.feature_table)

				-- Type check if it is an expression conform either to
				-- and integer or to a character
			current_item := context.item
			if current_item.is_integer then		
				controler.set_integer_type
			elseif	current_item.is_character then
				controler.set_character_type
			else
					-- Error
				create vomb1
				context.init_error (vomb1)
				vomb1.set_type (current_item)
				Error_handler.insert_error (vomb1)
					-- Cannot go on here
				Error_handler.raise_error
			end

				-- Update type stack
			context.pop (1)

			if case_list /= Void then
				case_list.type_check
			end

			if else_part /= Void then
				else_part.type_check
			end
			Inspect_controlers.start
			Inspect_controlers.remove
		end

	byte_node: INSPECT_B is
			-- Associated byte code
		local
			tmp: BYTE_LIST [BYTE_NODE]
			loc_case_list: like case_list
		do
			create Result
			Result.set_switch (switch.byte_node)
			loc_case_list := case_list
			if loc_case_list /= Void then
					-- The AST stores the inspect cases in reverse order
					-- compared to the way the user wrote them. So we
					-- put them back in the correct order in the generated
					-- byte code so that it will match the displayed text
					-- when debugging.
				tmp := loc_case_list.byte_node.remove_voids
				if tmp /= Void then
					Result.set_case_list (tmp)
				end
			end
			if else_part /= Void then
				Result.set_else_part (else_part.byte_node)
			end
			Result.set_line_number (line_number)
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l
		do
			create new_list.make
			switch.fill_calls_list (new_list)
			l.merge (new_list)
			if case_list /= Void then
				case_list.fill_calls_list (l)
			end
			if else_part /= Void then
				else_part.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current)
			Result.set_switch (switch.replicate (ctxt))
			if case_list /= Void then
				Result.set_case_list (
					case_list.replicate (ctxt))
			end
			if else_part /= Void then
				Result.set_else_part (
					else_part.replicate (ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_Inspect_keyword)
			ctxt.put_space
			ctxt.indent
			ctxt.format_ast (switch)
			ctxt.exdent
			ctxt.new_line
			if case_list /= Void then
				ctxt.set_separator (ti_Empty)
				ctxt.set_no_new_line_between_tokens
				case_list.format (ctxt)
			end
			if else_part /= Void then
				ctxt.put_text_item (ti_Else_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.set_separator (Void)
				ctxt.set_new_line_between_tokens
				ctxt.format_ast (else_part)
				ctxt.new_line
				ctxt.exdent
			end
			ctxt.put_text_item (ti_End_keyword)
		end

feature {INSPECT_AS} -- Replication

	set_switch (s: like switch) is
			-- Set `switch' to `s'.
		require
			valid_arg: s /= Void
		do
			switch := s
		end

	set_case_list (c: like case_list) is
			-- Set `case_list' to `c'.
		do
			case_list := c
		end

	set_else_part (e: like else_part) is
			-- Set `else_part' to `e'.
		do
			else_part := e
		end

end -- class INSPECT_AS
