indexing
	description: "Object that represents a list which is surrounded by some kind of brackets (e.g. '(' and ')')."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PARAN_LIST_AS [G -> AST_EIFFEL]

inherit
	AST_EIFFEL

feature{NONE} -- Implementation

	make (s_as: G; lp_as, rp_as: like lparan_symbol) is
			-- Initialize Current with `G' and its brackets.
		do
			content := s_as
			lparan_symbol := lp_as
			rparan_symbol := rp_as
		ensure
			content_set: content = s_as
			lparan_symbol_set: lparan_symbol = lp_as
			rparan_symbol_set: rparan_symbol = rp_as
		end

feature -- Access

	content: G
			-- Content surrounded by brackets

feature -- Access: roundtrip

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Left and right brackets associated with `content' AST node

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if content = Void then
				Result := other.content = Void
			else
				Result := other.content /= Void and then content.is_equivalent (other.content)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list = Void then
				if content /= Void then
					Result := content.first_token (a_list)
				end
			else
				if lparan_symbol /= Void then
					Result := lparan_symbol.first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list = Void then
				if content /= Void then
					Result := content.last_token (a_list)
				end
			else
				if rparan_symbol /= Void then
					Result := rparan_symbol.last_token (a_list)
				end
			end
		end

end
