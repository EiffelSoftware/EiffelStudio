indexing
	description: 
		"AST representation of an assignment"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSIGN_AS

inherit
	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (t: like target; s: like source; loc: like location) is
			-- Create a new ASSIGN AST node.
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
			non_void_loc: loc /= Void
		do
			target := t
			source := s
			location := loc
		ensure
			target_set: target = t
			source_set: source = s
			location_set: location = loc
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_assign_as (Current)
		end

feature -- Attributes

	target: ACCESS_AS;
			-- Target of the assignment

	source: EXPR_AS;
			-- Source of the assignment

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (source, other.source) and then
				equivalent (target, other.target)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_breakable;
--			ctxt.new_expression;
--			ctxt.format_ast (target);
--			ctxt.put_space;
--			ctxt.put_text_item_without_tabs (assign_symbol);
--			ctxt.put_space;
--			ctxt.new_expression;
--			ctxt.format_ast (source);
--		end
	
feature {ASSIGN_AS}	-- Replication
		
	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t
		end

	set_source (s: like source) is
		require
			valid_arg: s /= Void
		do
			source := s
		end

end -- class ASSIGN_AS
