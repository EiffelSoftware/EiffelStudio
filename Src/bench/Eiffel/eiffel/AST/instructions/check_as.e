indexing

	description: "Abstract description of a check clause. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CHECK_AS

inherit
	INSTRUCTION_AS
		redefine
			byte_node, fill_calls_list, replicate,
			number_of_breakpoint_slots
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like check_list; s, l: INTEGER) is
			-- Create a new CHECK AST node.
		do
			check_list := c
			start_position := s
			line_number := l
		ensure
			check_list_set: check_list = c
			start_postion_set: start_position = s
			line_number_set: line_number = l
		end

feature -- Attributes

	check_list: EIFFEL_LIST [TAGGED_AS]
			-- List of tagged boolean expression

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			if check_list /= Void then
				Result := check_list.number_of_breakpoint_slots
			end
		end

feature -- Comparison 

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (check_list, other.check_list)
		end

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check on check clause
		do
			if check_list /= Void then
				check_list.type_check
			end
		end

	byte_node: CHECK_B is
			-- Associated byte code
		do
			create Result
			if check_list /= Void then
				Result.set_check_list (check_list.byte_node)
			end
			Result.set_line_number (line_number)
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current
		do
			if check_list /= Void then
				check_list.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current)
			if check_list /= Void then
				Result.set_check_list(
					check_list.replicate (ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute Text
		do
			ctxt.put_text_item (ti_check_keyword)
			if check_list /= Void then
				ctxt.indent
				ctxt.new_line
				ctxt.set_new_line_between_tokens
				ctxt.format_ast (check_list)
				ctxt.exdent
			end
			ctxt.new_line
			ctxt.put_text_item (ti_End_keyword)
		end
			
feature {CHECK_AS} -- Replication
	
	set_check_list (c: like check_list) is
		do
			check_list := c
		end

end -- class CHECK_AS
