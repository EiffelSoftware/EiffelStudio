indexing
	description:
			"Abstract description of a nested call `target.message' where %
			%the target is a parenthesized expression. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class NESTED_EXPR_AS

inherit
	CALL_AS
		redefine
			type_check, byte_node, format, 
			fill_calls_list, replicate,
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

feature -- Attributes

	target: EXPR_AS
			-- Target of the call

	message: CALL_AS
			-- Message send to the target

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (message, other.message) and
				equivalent (target, other.target)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check the call
		local
			t: TYPE_A
			not_supported: NOT_SUPPORTED
		do
				-- Type check the target
			target.type_check

			t := context.item
			context.pop (1)
			context.replace (t)

			if t.is_separate then
					-- The target of a separate call must be an argument
					-- FIXME: the expression can be an argument access only

				!! not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Invalid separate call")
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

				-- Type check the message
			message.type_check
		end

	byte_node: NESTED_B is
			-- Associated byte code
		local
			access_expr: ACCESS_EXPR_B
			c: CALL_B
		do
			!! access_expr
			access_expr.set_expr (target.byte_node)
			!! Result
			Result.set_target (access_expr)
			c := message.byte_node
			Result.set_message (c)
			c.set_parent (Result)
		end

	format (ctxt: FORMAT_CONTEXT) is
		-- Reconstitute text.
		do
			ctxt.begin
			ctxt.put_text_item (ti_L_parenthesis)
			target.format (ctxt)
			if ctxt.last_was_printed then
				ctxt.put_text_item_without_tabs (ti_R_parenthesis)
				ctxt.need_dot
				message.format (ctxt)
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			else
				ctxt.rollback
			end
		end

    fill_calls_list (l: CALLS_LIST) is
            -- find calls to Current
        do
            target.fill_calls_list (l)
            l.stop_filling
            message.fill_calls_list (l)
        end

    Replicate (ctxt: REP_CONTEXT): like Current is
            -- Adapt to replication
        do
            Result := clone (Current)
            Result.set_target (target.replicate (ctxt))
            Result.set_message (message.replicate (ctxt))
        end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		-- Reconstitute text.
		local
			paran_as: PARAN_AS
		do
			paran_as ?= target
			if paran_as = Void then
				ctxt.put_text_item (ti_L_parenthesis)
			end
			target.simple_format (ctxt)
			if paran_as = Void then
				ctxt.put_text_item_without_tabs (ti_R_parenthesis)
			end
			ctxt.need_dot
			message.simple_format (ctxt)
		end

feature {NESTED_EXPR_AS} -- Replication

	set_target (t: like target) is
		require
			valid_arg: t /= Void 
		do
			target := t
		end

	set_message (m: like message) is
		require
			valid_arg: m /= Void 
		do
			message := m
		end
						
end -- class NESTED_EXPR_AS
