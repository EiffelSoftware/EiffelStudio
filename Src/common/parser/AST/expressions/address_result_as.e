indexing
	description: "AST representation of an Eiffel function pointer for Result types.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADDRESS_RESULT_AS

inherit
	EXPR_AS

	LOCATION_AS

create
	initialize

feature{NONE} -- Initialization

	initialize (r_as: like result_keyword; a_as: like address_symbol) is
			-- Create new ADDRESS_RESULT AST node.
		require
			r_as_not_void: r_as /= Void
		do
			result_keyword := r_as
			address_symbol := a_as
			make_from_other (result_keyword)
		ensure
			result_keyword_set: result_keyword = r_as
			address_symbol_set: address_symbol = a_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_address_result_as (Current)
		end

feature -- Roundtrip

	address_symbol: SYMBOL_AS
			-- Symbol "$" associated with this structure

	result_keyword: KEYWORD_AS
			-- Keyword "result" associated with this structure

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

end -- class ADDRESS_RESULT_AS
