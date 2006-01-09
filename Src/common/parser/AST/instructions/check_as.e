indexing

	description: "Abstract description of a check clause. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CHECK_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots
		end

	ASSERTION_FILTER

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like check_list; c_as, e: like end_keyword) is
			-- Create a new CHECK AST node.
		require
			e_not_void: e /= Void
		do
			full_assertion_list := c
			check_list := filter_tagged_list (full_assertion_list)
			end_keyword := e
			check_keyword := c_as
		ensure
			full_assertion_list_set: full_assertion_list = c
			end_keyword_set: end_keyword = e
			check_keyword_set: check_keyword = c_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_check_as (Current)
		end

feature -- Roundtrip

	check_keyword: KEYWORD_AS
			-- Keyword "check" associated with this structure

feature -- Attributes

	check_list: EIFFEL_LIST [TAGGED_AS]
			-- List of tagged boolean expression
			-- (only complete assertions are included)
			-- e.g. "tag:expr", "expr"

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located


feature -- Roundtrip

	full_assertion_list: like check_list
			-- Assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if check_list /= Void then
					Result := check_list.complete_start_location (a_list)
				else
					Result := end_keyword.complete_start_location (a_list)
				end
			else
				Result := check_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := end_keyword.complete_end_location (a_list)
		end

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

invariant
	end_keyword_not_void: end_keyword /= Void

end -- class CHECK_AS
