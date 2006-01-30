indexing
	description: "Object that represents a list of class name as clients"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_LIST_AS

inherit
	EIFFEL_LIST [ID_AS]
		redefine
			process, first_token, last_token
		end

create
	make,
	make_filled

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_class_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				check
					lcurly_symbol /= Void
				end
				Result := lcurly_symbol.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				check
					rcurly_symbol /= Void
				end
				Result := rcurly_symbol.last_token (a_list)
			end
		end

feature -- Roundtrip

	lcurly_symbol, rcurly_symbol: SYMBOL_AS
			-- Symbol "{" and "}" associated with current AST node

	set_lcurly_symbol (a_symbol: SYMBOL_AS) is
			-- Set `lcurly_symbol' with `a_symbol'.
		do
			lcurly_symbol := a_symbol
		ensure
			lcurly_symbol_set: lcurly_symbol = a_symbol
		end

	set_rcurly_symbol (a_symbol: SYMBOL_AS) is
			-- Set `rcurly_symbol' with `a_symbol'.
		do
			rcurly_symbol := a_symbol
		ensure
			rcurly_symbol_set: rcurly_symbol = a_symbol
		end

end
