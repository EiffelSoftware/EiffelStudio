-- Abstract description of a nested call `target.message' where the target
-- is a parenthesized expression

class NESTED_EXPR_AS

inherit

	CALL_AS
		redefine
			simple_format
		end

feature -- Attributes

	target: EXPR_AS;
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

	simple_format (ctxt: FORMAT_CONTEXT) is
		-- Reconstitute text.
		local
			paran_as: PARAN_AS
		do
			ctxt.begin;
			paran_as ?= target
			if paran_as = Void then
				ctxt.put_text_item (ti_L_parenthesis);
			end
			target.simple_format (ctxt);
			if ctxt.last_was_printed then
				if paran_as = Void then
					ctxt.put_text_item (ti_R_parenthesis);
				end
				ctxt.need_dot;
				ctxt.keep_types;
				message.simple_format (ctxt);
				if ctxt.last_was_printed then
					ctxt.commit
				end
			end
		end;

feature {NESTED_EXPR_AS} -- Replication

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

end
