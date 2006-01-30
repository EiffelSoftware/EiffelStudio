indexing
	description: "Object that represents a list of formal arguments"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_ARGU_DEC_LIST_AS

inherit
	PARAN_LIST_AS
		redefine
			first_token, last_token
		end

create
	make

feature{NONE} -- Initialization

	make (l_as: like arguments; lp_as, rp_as: like lparan_symbol) is
			-- Initialize instance.
		do
			arguments := l_as
			set_paran_symbols (lp_as, rp_as)
		ensure
			arguments_set: arguments = l_as
		end

feature -- Access

	arguments: EIFFEL_LIST [TYPE_DEC_AS]
			-- Local declarations

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_formal_argu_dec_list_as (Current)
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if arguments = Void then
				Result := other.arguments = Void
			else

				Result := other.arguments /= Void and then arguments.is_equivalent (other.arguments)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list = Void then
				if arguments /= Void then
					Result := arguments.first_token (a_list)
				end
			else
				Result := Precursor (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list = Void then
				if arguments /= Void then
					Result := arguments.last_token (a_list)
				end
			else
				Result := Precursor (a_list)
			end
		end

end
