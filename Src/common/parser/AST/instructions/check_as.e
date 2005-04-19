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

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like check_list; e: like end_keyword) is
			-- Create a new CHECK AST node.
		require
			e_not_void: e /= Void
		do
			check_list := c
			end_keyword := e
		ensure
			check_list_set: check_list = c
			end_keyword_set: end_keyword = e
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

	end_keyword: LOCATION_AS
			-- Line number where `end' keyword is located
			
feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if check_list /= Void then
				Result := check_list.start_location
			else
				Result := end_keyword
			end
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
