indexing

	description: 
		"AST representation of a clause clause"
	date: "$Date$"
	revision: "$Revision$"

class CREATION_AS

inherit
	INSTRUCTION_AS
--		redefine
--			location
--		end

feature {AST_FACTORY} -- Initialization

	initialize (tp: like type; tg: like target; c: like call; l: like location) is
			-- Create a new CREATION AST node.
		require
			tg_not_void: tg /= Void
			l_not_void: l /= Void
		local
			dcr_id: ID_AS
		do
			type := tp
			target := tg
			call := c
			location := clone (l)

				-- If there is no call we create `default_call'
			if call = Void then
					-- Create id. True name set later.
				create dcr_id.make (0)
				!ACCESS_ID_AS! default_call
				default_call.set_feature_name (dcr_id)
			end
		ensure
			type_set: type = tp
			target_set: target = tg
			call_set: call = c
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_creation_as (Current)
		end

feature -- Attributes

	type: EIFFEL_TYPE
			-- Creation type

	target: ACCESS_AS
			-- Target to create

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

	default_call: ACCESS_INV_AS
			-- Default creation call

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (target, other.target) and then
				equivalent (type, other.type)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_breakable;
--			if type /= Void then
--				ctxt.set_type_creation (type);
--				ctxt.put_text_item (ti_Exclamation);
--				ctxt.format_ast (type);
--				ctxt.put_text_item_without_tabs (ti_Exclamation);
--				ctxt.put_space
--			else
--				ctxt.put_text_item (ti_Create_keyword);
--				ctxt.put_space
--			end
--			ctxt.format_ast (target)
--			if type /= Void then
--				ctxt.set_type_creation (Void);
--			end
--			if call /= void then
--				ctxt.need_dot;
--				ctxt.format_ast (call);
--			end
--		end

feature {CREATION_AS} -- Replication

	set_call (c: like call) is
		do
			call := c
		end

	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t;
		end

end -- class CREATION_AS
