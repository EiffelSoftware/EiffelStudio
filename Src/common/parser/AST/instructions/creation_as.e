indexing

	description: 
		"AST representation of a clause clause";
	date: "$Date$";
	revision: "$Revision$"

class CREATION_AS

inherit

	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (tp: like type; tg: like target; c: like call; s, l: INTEGER) is
			-- Create a new CREATION AST node.
		require
			tg_not_void: tg /= Void
		do
			type := tp
			target := tg
			call := c
			start_position := s
			line_number := l
		ensure
			type_set: type = tp
			target_set: target = tg
			call_set: call = c
			start_position_set: start_position = s
			line_number_set: line_number = l
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			type ?= yacc_arg (0);
			target ?= yacc_arg (1);
			call ?= yacc_arg (2);
			start_position := yacc_position;
			line_number    := yacc_line_number
		ensure then
			target_exists: target /= Void;
		end;

feature -- Properties

	type: TYPE;
			-- Creation type

	target: ACCESS_AS;
			-- Target to create

	call: ACCESS_INV_AS;
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (target, other.target) and then
				equivalent (type, other.type)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			if type /= Void then
				ctxt.set_type_creation (type);
				ctxt.put_text_item (ti_Exclamation);
				ctxt.format_ast (type);
				ctxt.put_text_item_without_tabs (ti_Exclamation);
				ctxt.put_space
			else
				ctxt.put_text_item (ti_Creation_mark);
				ctxt.put_space
			end;
			ctxt.format_ast (target)
			if type /= Void then
				ctxt.set_type_creation (Void);
			end;
			if call /= void then
				ctxt.need_dot;
				ctxt.format_ast (call);
			end;
		end;

feature {CREATION_AS} -- Replication

	set_call (c: like call) is
		do
			call := c
		end;

	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t;
		end;

end -- class CREATION_AS
