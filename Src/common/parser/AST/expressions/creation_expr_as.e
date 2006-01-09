indexing
	description: "Abstract description of an Eiffel creation expression call."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CREATION_EXPR_AS

inherit
	CALL_AS
		redefine
			is_equivalent
		end

feature {NONE} -- Initialization

	initialize (t: like type; c: like call) is
			-- Create a new CREATION_EXPR AST node.
		require
			t_not_void: t /= Void
		do
			type := t
			call := c
		ensure
			type_set: type = t
			call_set: call = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_creation_expr_as (Current)
		end

feature -- Access

	type: TYPE_AS
			-- Creation Type.

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (type, other.type)
		end

invariant
		-- A creation expression contains its type
	type_exists: type /= Void

end -- class CREATION_EXPR_AS
