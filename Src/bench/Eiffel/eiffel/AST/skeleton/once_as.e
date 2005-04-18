indexing
	description: "AST representation of a once routines."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_AS

inherit
	INTERNAL_AS
		redefine
			byte_node, is_once, process, type_check
		end

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_once_as (Current)
		end

feature -- Properties

	is_once: BOOLEAN is True
			-- Is the current routine body a once one ?

feature -- Type check

	type_check is
			-- Type check compound
		do
			Precursor
			if context.current_class.is_generic then
				error_handler.insert_warning (create {ONCE_IN_GENERIC_WARNING}.make (context.current_class, context.current_feature))
			end
		end

feature -- Access

	byte_node: ONCE_BYTE_CODE is
			-- Byte code for once body
		local
			body: FEATURE_AS
		do
			create Result
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			
			body := Context.current_feature.body
			check
				body_not_void: body /= Void
			end

			if body.indexes /= Void then
				Result.set_is_global_once (body.indexes.has_global_once)
			end
		end

end -- class ONCE_AS
