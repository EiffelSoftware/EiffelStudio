-- Abstract description of a nested call `target.message'

class NESTED_AS

inherit

	CALL_AS
		redefine
			type_check, byte_node
		end

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

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check the call
		do
				-- Type check the target
			target.type_check;

				-- Type check the message
			message.type_check;
		end;

	byte_node: NESTED_B is
			-- Associated byte code
		local
			t: ACCESS_B;
			m: CALL_B;
		do
			!!Result;
			t := target.byte_node;
			t.set_parent (Result);
			Result.set_target (t);
			m := message.byte_node;
			m.set_parent (Result);
			Result.set_message (m);
		end;

end
