indexing

	description: 
		"AST representation of an assignment";
	date: "$Date$";
	revision: "$Revision$"

class ASSIGN_AS

inherit

	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (t: like target; s: like source; p, l: INTEGER) is
			-- Create a new ASSIGN AST node.
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
		do
			target := t
			source := s
			start_position := p
			line_number := l
		ensure
			target_set: target = t
			source_set: source = s
			start_position_set: start_position = p
			line_number_set: line_number = l
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			target ?= yacc_arg (0);
			source ?= yacc_arg (1);
			start_position := yacc_position;
			line_number    := yacc_line_number
		ensure then
			target_exists: target /= Void;
			source_exists: source /= Void;
		end;

feature -- Properties

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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text.
		do
			ctxt.put_breakable;
			ctxt.new_expression;
			ctxt.format_ast (target);
			ctxt.put_space;
			ctxt.put_text_item_without_tabs (assign_symbol);
			ctxt.put_space;
			ctxt.new_expression;
			ctxt.format_ast (source);
		end;

feature {ASSIGN_AS} -- Formatter

	assign_symbol: TEXT_ITEM is
		once
			Result := ti_Assign
		end
		
feature {ASSIGN_AS}	-- Replication
		
	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t
		end;

	set_source (s: like source) is
		require
			valid_arg: s /= Void
		do
			source := s
		end;

end -- class ASSIGN_AS
