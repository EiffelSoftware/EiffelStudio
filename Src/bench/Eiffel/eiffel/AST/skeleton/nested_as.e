indexing
	description:
			"Abstract description of a nested call `target.message' %
			%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class NESTED_AS

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

	target: ACCESS_AS
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
			vape_check: BOOLEAN
			t: TYPE_A
			not_supported: NOT_SUPPORTED
			arg_name: ID_AS
		do
			vape_check := context.check_for_vape
				-- Type check the target
			target.type_check
			if context.level4 then
				context.set_check_for_vape (False);	
			end

			t := context.item
			if t.is_separate then
				if not target.is_argument then
					!! not_supported
					context.init_error (not_supported)
					not_supported.set_message ("Invalid separate call")
					Error_handler.insert_error (not_supported)
					Error_handler.raise_error
				else
						-- Record that argument is used in a separate call

						-- Assignment attempt cannot fail
					arg_name ?= target.access_name
					context.set_separate_call_on_argument (arg_name)
				end
			end

				-- Type check the message
			message.type_check
			if vape_check then
				context.set_check_for_vape (true)
			end
		end

	byte_node: NESTED_B is
			-- Associated byte code
		local
			t: ACCESS_B
			m: CALL_B
		do
			!! Result
			t := target.byte_node
			t.set_parent (Result)
			Result.set_target (t)
			m := message.byte_node
			m.set_parent (Result)
			Result.set_message (m)
		end
	
	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin
			target.format (ctxt)
			if ctxt.last_was_printed then
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
	
feature -- Replication

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
		do
			target.simple_format (ctxt)
			ctxt.need_dot
			message.simple_format (ctxt)
		end

feature {NESTED_AS} -- Replication

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
						
end -- class NESTED_AS
