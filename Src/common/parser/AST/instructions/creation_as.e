indexing
	description: "Node for a creation instruction."
	date: "$Date$"
	revision: "$Revision$"

class CREATION_AS

inherit
	INSTRUCTION_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (tp: like type; tg: like target; c: like call) is
			-- Create a new CREATION AST node.
		require
			tg_not_void: tg /= Void
		do
			type := tp
			target := tg
			call := c
		ensure
			type_set: type = tp
			target_set: target = tg
			call_set: call = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_creation_as (Current)
		end

feature -- Attributes

	type: TYPE_AS
			-- Creation type

	target: ACCESS_AS
			-- Target to create

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if type /= Void then
				Result := type.start_location
			else
				Result := target.start_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if call /= Void then
				Result := call.end_location
			else
				Result := target.end_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (target, other.target) and then
				equivalent (type, other.type)
		end

invariant
	target_not_void: target /= Void

end -- class CREATION_AS
