indexing
	description: 
		"AST representation of a check clause"
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_AS

inherit
	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (c: like check_list; l: like location) is
			-- Create a new CHECK AST node.
		require
			non_void_c: c /= Void
			non_void_l: l /= Void
		do
			check_list := c
			location := l
		ensure
			check_list_set: check_list = c
			location_set: location = l
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_check_as (Current)
		end

feature -- Attributes

	check_list: EIFFEL_LIST [TAGGED_AS];
			-- List of tagged boolean expression

feature -- Comparison 

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (check_list, other.check_list)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_breakable;
--			ctxt.put_text_item (ti_check_keyword);
--			if check_list /= void then
--				ctxt.indent;
--				ctxt.new_line;
--				ctxt.format_ast (check_list);
--				ctxt.exdent;
--				ctxt.new_line;
--			end
--			ctxt.put_text_item (ti_End_keyword);
--		end
			
feature {CHECK_AS} -- Replication
	
	set_check_list (c: like check_list) is
		do
			check_list := c
		end

end -- class CHECK_AS
