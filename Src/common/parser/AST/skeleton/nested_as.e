indexing

	description: 
		"AST representation of a nested call `target.message'";
	date: "$Date$";
	revision: "$Revision$"

class NESTED_AS

inherit

	CALL_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like target; m: like message) is
			-- Create a new NESTED CALL AST node.
		require
			t_not_void: t /= Void
			m_not_void: m /= Void
		do
			target := t
			message := m
		ensure
			target_set: target = t
			message_set: message = m
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initilization
		do
			target ?= yacc_arg (0);
			message ?= yacc_arg (1);
		ensure then
			target_exists: target /= Void;
			message_exists: message /= Void;
		end;

feature -- Properties

	target: ACCESS_AS;
			-- Target of the call

	message: CALL_AS;
			-- Message send to the target

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (message, other.message) and
				equivalent (target, other.target)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			target.simple_format (ctxt);
			ctxt.need_dot;
			message.simple_format (ctxt);
		end;

feature {NESTED_AS} -- Replication

	set_target (t: like target) is
		require
			valid_arg: t /= Void 
		do
			target := t;
		end;

	set_message (m: like message) is
		require
			valid_arg: m /= Void 
		do
			message := m;
		end;
						
end -- class NESTED_AS
