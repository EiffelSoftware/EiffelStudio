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

	initialize (k: like keys; c: like compound; d_as, e: like end_keyword) is
			-- Create a new DEBUG AST node.
		require
			e_not_void: e /= Void
		do
			internal_keys := k
			compound := c
			end_keyword := e
			debug_keyword := d_as
		ensure
			internal_keys_set: internal_keys = k
			compound_set: compound = c
			end_keyword_set: end_keyword = e
			ddebug_keyword_set: debug_keyword = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_debug_as (Current)
		end

feature -- Roundtrip

	debug_keyword: KEYWORD_AS
			-- Keyword "debug" associated with this structure

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound to debug

	keys: EIFFEL_LIST [STRING_AS] is
			-- Debug keys
		do
			if internal_keys = Void or else internal_keys.is_empty then
				Result := Void
			else
				Result := internal_keys
			end
		end

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip

	internal_keys: EIFFEL_LIST [STRING_AS]
			-- Internal debug keys			

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if keys /= Void then
					Result := keys.complete_start_location (a_list)
				elseif compound /= Void then
					Result := compound.complete_start_location (a_list)
				else
					Result := end_keyword.complete_start_location (a_list)
				end
			else
				Result := debug_keyword.complete_start_location (a_list)
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
