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
			v.process_nested_as (Current)
		end

feature -- Attributes

	target: ACCESS_AS
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
			arg_name: ID_AS
		do
				-- Type check the target
			target.type_check

			t := context.item
			if t.is_separate then
				if not target.is_argument then
					create not_supported
					context.init_error (not_supported)
					not_supported.set_message ("Invalid separate call")
					not_supported.set_location (target.start_location)
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
		end

	byte_node: NESTED_B is
			-- Associated byte code
		local
			t: ACCESS_B
			m: CALL_B
		do
			create Result
			t := target.byte_node
			t.set_parent (Result)
			Result.set_target (t)
			m := message.byte_node
			m.set_parent (Result)
			Result.set_message (m)
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

invariant
	message_not_void: message /= Void
	target_not_void: target /= Void
						
end -- class NESTED_AS
