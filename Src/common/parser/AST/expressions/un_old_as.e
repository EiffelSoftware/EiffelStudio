indexing
	description: "AST represenation of a unary `old' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	UN_OLD_AS

inherit
	UNARY_AS
		redefine
			--simple_format, 
			operator_is_keyword
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_old_as (Current)
		end

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		do
		end

	operator_name: STRING is "old"
	
	operator_is_keyword: BOOLEAN is True

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_text_item (ti_Old_keyword)
--			ctxt.put_space
--			ctxt.format_ast (expr)
--		end

end -- class UN_OLD_AS
