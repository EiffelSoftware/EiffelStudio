indexing
	description	: "Abstract description of a multi_branch instruction, %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class INSPECT_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots, byte_node
		end

	SHARED_INSPECT

create
	initialize

feature {NONE} -- Initialization

	initialize (s: like switch; c: like case_list; e: like else_part; el: like end_keyword) is
			-- Create a new INSPECT AST node.
		require
			s_not_void: s /= Void
			el_not_void: el /= Void
		do
			switch := s
			case_list := c
			else_part := e
			end_keyword := el
		ensure
			switch_set: switch = s
			case_list_set: case_list = c
			else_part_set: else_part = e
			end_keyword_set: end_keyword = el
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_inspect_as (Current)
		end

feature -- Attributes

	switch: EXPR_AS
			-- Expression to inspect

	case_list: EIFFEL_LIST [CASE_AS]
			-- Alternatives

	else_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- Else part

	end_keyword: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := switch.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := end_keyword
		end

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
			controler.set_feature_table (context.current_class.feature_table)

				-- Type check if it is an expression conform either to
				-- and integer or to a character
			current_item := context.item
			if current_item.is_integer or else current_item.is_character or else current_item.is_natural then
				controler.set_type (current_item)
			else
					-- Error
				create vomb1
				context.init_error (vomb1)
				vomb1.set_type (current_item)
				vomb1.set_location (switch.end_location)
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
			Result.set_line_number (switch.start_location.line)
			Result.set_end_location (end_keyword)
		end

invariant
	switch_not_void: switch /= Void
	end_keyword_not_void: end_keyword /= Void	

end -- class INSPECT_AS
