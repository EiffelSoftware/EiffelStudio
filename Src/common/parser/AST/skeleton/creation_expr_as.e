indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXPR_AS

inherit
	CALL_AS
		redefine
			is_equivalent, location
		end
		
create
	initialize

feature {AST_FACTORY} -- Initialization

	initialize (t: like type; c: like call; l: like location) is
			-- Create a new CREATION_EXPR AST node.
		require
			t_not_void: t /= Void
		do
			type := t
			call := c
			location := clone (l)
		ensure
			type_set: type = t
			call_set: call = c
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_creation_expr_as (Current)
		end

feature -- Attributes

	location: TOKEN_LOCATION
			-- Location of current.

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

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--		end

invariant
		-- A creation expression contains its type
	type_exists: type /= Void

end -- class CREATION_EXPR_AS
