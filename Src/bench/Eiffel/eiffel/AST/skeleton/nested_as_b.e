indexing

	description:
			"Abstract description of a nested call `target.message' %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class NESTED_AS_B

inherit

	NESTED_AS
		redefine
			target, message
		end;

	CALL_AS_B
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	target: ACCESS_AS_B;
			-- Target of the call

	message: CALL_AS_B;
			-- Message send to the target

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check the call
		local
			curr_feat: FEATURE_I;
			vape_check: BOOLEAN
			t: TYPE_A
		do
			vape_check := context.check_for_vape;
				-- Type check the target
			target.type_check;
			if context.level4 then
				context.set_check_for_vape (False);	
			end;

			t := context.item
			if t.is_separate then
				if not target.is_argument then
					Error_handler.make_separate_syntax_error
				else
				end
			end

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
	
	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			target.format (ctxt);
			if ctxt.last_was_printed then
				ctxt.need_dot;
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
			Result := clone (Current);
			Result.set_target (target.replicate (ctxt));
			Result.set_message (message.replicate (ctxt));
		end;

end -- class NESTED_AS_B
