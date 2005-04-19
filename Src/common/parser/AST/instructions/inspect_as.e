indexing
	description	: "Abstract description of a multi_branch instruction, %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class INSPECT_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots
		end

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

invariant
	switch_not_void: switch /= Void
	end_keyword_not_void: end_keyword /= Void	

end -- class INSPECT_AS
