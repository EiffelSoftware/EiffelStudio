indexing
	description: "Object that represents a list of parameters"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETER_LIST_AS

inherit
	PARAN_LIST_AS
		redefine
			first_token, last_token
		end

create
	initialize

feature{NONE} -- Initialization

	initialize (l: EIFFEL_LIST [EXPR_AS]; lp_as, rp_as: SYMBOL_AS) is
			-- Initialize.
		do
			parameters := l
			set_paran_symbols (lp_as, rp_as)
		ensure
			parameters_set: parameters = l
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_parameter_list_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if parameters = Void then
				Result := other.parameters = Void
			else
				Result := other.parameters /= Void and then parameters.is_equivalent (other.parameters)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list = Void then
				if parameters /= Void then
					Result := parameters.first_token (a_list)
				end
			else
				Result := Precursor (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list = Void then
				if parameters /= Void then
					Result := parameters.last_token (a_list)
				end
			else
				Result := Precursor (a_list)
			end
		end

feature -- Access

	parameters: EIFFEL_LIST [EXPR_AS]
			-- Parameters

end
