indexing
	description: "AST representation of an Eiffel function pointer for Current.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADDRESS_CURRENT_AS

inherit
	EXPR_AS

	LEAF_AS

create
	make_from_other

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_address_current_as (Current)
		end

feature -- Roundtrip

	address_symbol: SYMBOL_AS
			-- Symbol "$" associated with this structure

	current_keyword: KEYWORD_AS
			-- Keyword "current" associated with this structure

	set_address_symbol (s_as: SYMBOL_AS) is
			-- Set `address_symbol' with `s_as'.
		do
			address_symbol := s_as
		ensure
			address_symbol_set: address_symbol = s_as
		end

	set_current_keyword (k_as: KEYWORD_AS) is
			-- Set `current_keyword' with `k_as'.
		do
			current_keyword := k_as
		ensure
			current_keyword_set: current_keyword = k_as
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

end -- class ADDRESS_CURRENT_AS
