indexing

	description: "Abstract description of a check clause. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CHECK_AS

inherit
	INSTRUCTION_AS
		redefine
			byte_node, number_of_breakpoint_slots
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like check_list; l, e: like location) is
			-- Create a new CHECK AST node.
		require
			l_not_void: l /= Void
			e_not_void: e /= Void
		do
			check_list := c
			location := l.twin
			end_location := e.twin
		ensure
			check_list_set: check_list = c
			location_set: location.is_equal (l)
			end_location_set: end_location.is_equal (e)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_check_as (Current)
		end

feature -- Attributes

	check_list: EIFFEL_LIST [TAGGED_AS]
			-- List of tagged boolean expression

	end_location: like location
			-- Line number where `end' keyword is located
			
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
				context.set_is_checking_check (True)
				check_list.type_check
				context.set_is_checking_check (False)
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
			Result.set_end_location (end_location)
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
			ctxt.put_text_item (ti_end_keyword)
		end
			
feature {CHECK_AS} -- Replication
	
	set_check_list (c: like check_list) is
		do
			check_list := c
		end

end -- class CHECK_AS
