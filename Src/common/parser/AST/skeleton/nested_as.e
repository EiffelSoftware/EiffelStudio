indexing

	description: "Abstract description of a nested call `target.message'";
	date: "$Date$";
	revision: "$Revision$"

class NESTED_AS

inherit

	CALL_AS
		redefine
			simple_format
		end;

feature -- Attributes

	target: ACCESS_AS;
			-- Target of the call

	message: CALL_AS;
			-- Message send to the target

feature -- Initialization

	set is
			-- Yacc initilization
		do
			target ?= yacc_arg (0);
			message ?= yacc_arg (1);
		ensure then
			target_exists: target /= Void;
			message_exists: message /= Void;
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			target.simple_format (ctxt);
			ctxt.need_dot;
			message.simple_format (ctxt);
			ctxt.commit
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
