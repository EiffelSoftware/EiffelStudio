-- Abstract description of a nested call `target.message'

class NESTED_AS

inherit

	CALL_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
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
		local
			curr_feat: FEATURE_I;
			vape_check: BOOLEAN
			
		do
			vape_check := context.check_for_vape;
				-- Type check the target
			target.type_check;
			if context.level4 then
				context.set_check_for_vape (False);	
			end;

				-- Type check the message
			message.type_check;
			if vape_check then
				context.set_check_for_vape (true)
			end;
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


	
	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			target.format (ctxt);
			if ctxt.last_was_printed then
				ctxt.need_dot;
				ctxt.keep_types;
				message.format (ctxt);
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback;
				end
			else
				ctxt.rollback
			end
		end;
	
feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			target.fill_calls_list (l);
			l.stop_filling;
			message.fill_calls_list (l);
		end;

	Replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := twin;
			Result.set_target (target.replicate (ctxt));
			Result.set_message (message.replicate (ctxt));
		end;

feature {NESTED_AS} -- Replication

	set_target (t: like target) is
		do
			target := t;
		end;


	set_message (m: like message) is
		do
			message := m;
		end;
						
end
