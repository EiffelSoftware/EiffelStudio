indexing
	description: "Object that represents a list of delayed actuals"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DELAYED_ACTUAL_LIST_AS

inherit
	PARAN_LIST_AS
		redefine
			first_token, last_token
		end

create
	make

feature{NONE} -- Initialization

	make (l: like operands; lp_as, rp_as: like lparan_symbol) is
			-- Initialize.
		do
			operands := l
			set_paran_symbols (lp_as, rp_as)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_delayed_actual_list_as (Current)
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if operands = Void then
				Result := other.operands = Void
			else
				Result := other.operands /= Void and then operands.is_equivalent (other.operands)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list = Void then
				if operands /= Void then
					Result := operands.first_token (a_list)
				end
			else
				Result := Precursor (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list = Void then
				if operands /= Void then
					Result := operands.last_token (a_list)
				end
			else
				Result := Precursor (a_list)
			end
		end

feature -- Content

	operands: EIFFEL_LIST [OPERAND_AS]
			-- Operands of current delayed actual list

end
