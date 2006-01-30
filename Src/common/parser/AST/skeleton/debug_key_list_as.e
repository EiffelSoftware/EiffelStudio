indexing
	description: "Object that represents a list of debug keys"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_KEY_LIST_AS

inherit
	PARAN_LIST_AS
		redefine
			first_token, last_token
		end

create
	make

feature{NONE} -- Implementation

	make (s_as: EIFFEL_LIST [STRING_AS]; lp_as, rp_as: like lparan_symbol) is
			--
		do
			keys := s_as
			set_paran_symbols (lp_as, rp_as)
		ensure
			keys_set: keys = s_as
		end

feature -- Access

	keys: EIFFEL_LIST [STRING_AS]
			-- Debug keys

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_debug_key_list_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if keys = Void then
				Result := other.keys = Void
			else
				Result := other.keys /= Void and then keys.is_equivalent (other.keys)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list = Void then
				if keys /= Void then
					Result := keys.first_token (a_list)
				end
			else
				Result := Precursor (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list = Void then
				if keys /= Void then
					Result := keys.last_token (a_list)
				end
			else
				Result := Precursor (a_list)
			end
		end

end

