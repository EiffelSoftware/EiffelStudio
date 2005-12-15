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
			is_equivalent, start_location, end_location
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; m: like message; d_as: like dot_symbol) is
			-- Create a new NESTED CALL AST node.
		require
			t_not_void: t /= Void
			m_not_void: m /= Void
		do
			target := t
			message := m
			dot_symbol := d_as
		ensure
			target_set: target = t
			message_set: message = m
			dot_symbol_set: dot_symbol = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_nested_as (Current)
		end

feature -- Roundtrip

	dot_symbol: SYMBOL_AS
			-- Symbol "." associated with this structure

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
