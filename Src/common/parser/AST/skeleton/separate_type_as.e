indexing
	description: 
		"AST representation of separate class type."
	date: "$Date$"
	revision: "$Revision$"

class
	SEPARATE_TYPE_AS

inherit
	CLASS_TYPE_AS
		redefine
			initialize,
			dump,
			process
		end

feature {AST_FACTORY} -- Initialization

	initialize (n: like class_name; g: like generics) is
			-- Create a new SEPARATE_CLASS_TYPE AST node.
		do
			Precursor (n, g)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_separate_type_as (Current)
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (class_name.count + 9)
			Result.append ("separate ")
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_text_item (ti_Separate_keyword);
--			ctxt.put_space;
--			basic_simple_format (ctxt);
--		end

end -- class SEPARATE_TYPE_AS
