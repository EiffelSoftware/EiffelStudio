indexing
	description:"Abstract description to access to `Result'. %
				%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	RESULT_AS

inherit
	ACCESS_AS
		redefine
			type_check, byte_node, replicate,
			is_equivalent, format
		end

	SHARED_TYPES

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new RESULT AST node.
		do
			-- Do nothing.
		end

feature -- Properties

	access_name: STRING is "Result"

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an access to Result
		local
			feat_type: TYPE_A
			access_result: RESULT_B
			vrle3: VRLE3
			error_found: BOOLEAN
			veen2a: VEEN2A
		do
				-- Error if in procedure or invariant
			error_found := context.level2
			if not error_found then
				feat_type := context.feature_type
				error_found := feat_type.conform_to (Void_type)
			end
					
			if error_found then
				!! vrle3
				context.init_error (vrle3)
				Error_handler.insert_error (vrle3)
					-- Cannot go on here
				Error_handler.raise_error
			else
				if context.level4 then
						-- Result entity in precondition
					!! veen2a
					context.init_error (veen2a)
					Error_handler.insert_error (veen2a)
				end

					-- Update the type stack
				context.replace (feat_type)

					-- Update the access line
				!! access_result
				context.access_line.insert (access_result)
			end
		end

	byte_node: RESULT_B is
			-- Associated byte node
		local
			access_line: ACCESS_LINE
		do
			access_line := context.access_line
			Result ?= access_line.access
			access_line.forth
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_result
			ctxt.put_text_item (ti_Result)
		end

feature -- Replication

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			ctxt.adapt_Result
			Result := clone (Current)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_result
			ctxt.put_text_item (ti_Result)
		end

end -- class RESULT_AS
