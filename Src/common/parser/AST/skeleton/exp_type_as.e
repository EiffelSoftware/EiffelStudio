indexing
	description: 
		"AST representation of expanded class type."
	date: "$Date$"
	revision: "$Revision$"

class
	EXP_TYPE_AS

inherit
	CLASS_TYPE_AS
		redefine
			initialize,
			dump,
			process
		end

feature {AST_FACTORY} -- Initialization

	initialize (n: like class_name; g: like generics) is
			-- Create a new EXPANDED_CLASS_TYPE AST node.
		do
			Precursor (n, g)
			record_expanded
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_exp_type_as (Current)
		end

feature {NONE} -- Initialization

	record_expanded is
			-- This must be done before pass2
			-- `solved_type' and `actual type' are called in pass3 for
			-- local variables
		do
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (class_name.count + 9)
			Result.append ("expanded ")
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_text_item (ti_Expanded_keyword);
--			ctxt.put_space;
--			basic_simple_format (ctxt);
--		end

end -- class EXP_TYPE_AS
