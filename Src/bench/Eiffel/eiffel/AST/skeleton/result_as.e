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
			type_check, byte_node,
			is_equivalent
		end
		
	LEAF_AS

	SHARED_TYPES

create
	make_with_location

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_result_as (Current)
		end

feature -- Properties

	access_name: STRING is "Result"

	parameters: EIFFEL_LIST [EXPR_AS] is
			-- No parameters for Result
		do
		end

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
			vrle3: VRLE3
			error_found: BOOLEAN
			veen2a: VEEN2A
		do
				-- Error if in procedure or invariant
			error_found := context.is_checking_invariant
			if not error_found then
				feat_type := context.feature_type
				error_found := feat_type.conform_to (Void_type)
			end
					
			if error_found then
				create vrle3
				context.init_error (vrle3)
				vrle3.set_location (start_location)
				Error_handler.insert_error (vrle3)
					-- Cannot go on here
				Error_handler.raise_error
			else
				if context.is_checking_precondition then
						-- Result entity in precondition
					create veen2a
					context.init_error (veen2a)
					veen2a.set_location (start_location)
					Error_handler.insert_error (veen2a)
				end

					-- Update the type stack
				context.replace (feat_type)

					-- Update the access line
				context.access_line.insert (create {RESULT_B})
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

end -- class RESULT_AS
