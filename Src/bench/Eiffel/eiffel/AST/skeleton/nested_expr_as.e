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
			type_check, byte_node, is_equivalent, start_location, end_location
		end

create
	initialize

feature {NONE} -- Initialization

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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_nested_expr_as (Current)
		end

feature -- Attributes

	target: EXPR_AS
			-- Target of the call

	message: CALL_AS
			-- Message send to the target

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := target.start_location
		end

	end_location: LOCATION_AS is
			-- End location of Current
		do
			Result := message.end_location
		end

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

				create not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Invalid separate call")
				not_supported.set_location (target.start_location)
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
			create access_expr
			access_expr.set_expr (target.byte_node)
			create Result
			Result.set_target (access_expr)
			c := message.byte_node
			Result.set_message (c)
			c.set_parent (Result)
		end

invariant
	message_not_void: message /= Void
	target_not_void: target /= Void

end -- class NESTED_EXPR_AS
