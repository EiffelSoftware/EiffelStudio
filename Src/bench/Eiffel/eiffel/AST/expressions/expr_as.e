indexing
	description: "Abstract class for expression nodes."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXPR_AS

inherit
	AST_EIFFEL
		undefine
			byte_node
		end

--feature -- Visitor
--
--	process (v: AST_VISITOR) is
--			-- process current element.
--		do
--			v.process_expr_as (Current)
--		end

feature -- Byte code generation

	byte_node: EXPR_B is
			-- Byte code type
		deferred
		end
		
end -- class EXPR_AS
