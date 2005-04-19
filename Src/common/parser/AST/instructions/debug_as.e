indexing
	description	: "Abstract description of a debug clause. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (k: like keys; c: like compound; e: like end_keyword) is
			-- Create a new DEBUG AST node.
		require
			e_not_void: e /= Void
		do
			keys := k
			compound := c
			end_keyword := e
		ensure
			keys_set: keys = k
			compound_set: compound = c
			end_keyword_set: end_keyword = e
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_debug_as (Current)
		end

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound to debug

	keys: EIFFEL_LIST [STRING_AS]
			-- Debug keys

	end_keyword: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if keys /= Void then
				Result := keys.start_location
			elseif compound /= Void then
				Result := compound.start_location
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
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (keys, other.keys)
		end

invariant
	end_keyword_not_void: end_keyword /= Void

end -- class DEBUG_AS
