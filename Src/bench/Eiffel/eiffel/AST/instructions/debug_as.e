indexing
	description	: "Abstract description of a debug clause. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots, byte_node
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (k: like keys; c: like compound; e: like end_keyword) is
			-- Create a new DEBUG AST node.
		require
			e_not_void: e /= Void
		local
			str: STRING
		do
			keys := k
				-- Debug keys are not case sensitive
			if keys /= Void then
				from
					keys.start
				until
					keys.after
				loop
					str := keys.item.value
					str.to_lower
					System.add_new_debug_clause (str)
					keys.forth
				end
			end

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

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check on debug clause
		do
			if compound /= Void then
				compound.type_check
			end
		end

	byte_node: DEBUG_B is
			-- Associated byte code
		local
			node_keys: ARRAYED_LIST [STRING]
		do
			create Result
			if compound /= Void then
				Result.set_compound (compound.byte_node)
				if keys /= Void then
					from
						create node_keys.make (0)
						node_keys.start
						keys.start
					until
						keys.after
					loop
						node_keys.extend (keys.item.value)
						keys.forth
					end
					Result.set_keys (node_keys)
				end
				Result.set_line_number (compound.start_location.line)
			end
			Result.set_end_location (end_keyword)
		end

invariant
	end_keyword_not_void: end_keyword /= Void

end -- class DEBUG_AS
