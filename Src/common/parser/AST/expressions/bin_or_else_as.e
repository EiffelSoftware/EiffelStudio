indexing
	description: "AST representation of binary `or else' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_OR_ELSE_AS

inherit
	BINARY_AS

	PREFIX_INFIX_NAMES

create
	initialize,
	make

feature -- Initialization

	make (l: like left; r: like right; k_as, s_as: KEYWORD_AS) is
			--
		local
			l_op: EIFFEL_LIST [KEYWORD_AS]
		do
			create l_op.make (2)
			l_op.extend (k_as)
			l_op.extend (s_as)
			initialize (l, r, l_op)
		end

feature -- Properties

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "or else"
			-- Name without the infix keyword.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_or_else_as (Current)
		end

end -- class BIN_OR_ELSE_AS
