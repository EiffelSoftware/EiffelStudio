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
		local
			dcr_id : ID_AS
		do
			type := t
			call := c
			location := clone (l)

				-- If there's no call create 'default_call'
			if call = Void then
					-- Create id. True name set later.
				create dcr_id.make (0)
				create default_call
				default_call.set_feature_name (dcr_id)
			end
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

	type: EIFFEL_TYPE
			-- Creation Type.

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

	default_call : ACCESS_INV_AS
			-- Call to default create.

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
