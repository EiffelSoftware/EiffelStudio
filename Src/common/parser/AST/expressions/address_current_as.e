indexing
	description: "AST representation of an Eiffel function pointer for Current.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADDRESS_CURRENT_AS

inherit
	EXPR_AS

	LOCATION_AS

create
	initialize

feature{NONE} -- Initialization

	initialize (c_as: like current_keyword; a_as: like address_symbol) is
			-- Create new ADDRESS_CURRENT AST node.
		require
			c_as_not_void: c_as /= Void
		do
			current_keyword := c_as
			address_symbol := a_as
			make_from_other (current_keyword)
		ensure
			current_keyword_set: current_keyword = c_as
			address_symbol_set: address_symbol = a_as
		end

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

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := Current
			else
				Result := address_symbol.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := Current
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

end -- class ADDRESS_CURRENT_AS
