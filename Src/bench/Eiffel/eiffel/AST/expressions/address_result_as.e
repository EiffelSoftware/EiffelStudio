indexing
	description: "AST representation of an Eiffel function pointer for Result types.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADDRESS_RESULT_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node
		end

	SHARED_TYPES

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new ADDRESS_RESULT AST node.
		do
			-- Do nothing.
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_address_result_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an adress access on Current
		local
			vrle3: VRLE3
			veen2a: VEEN2A
		do
			if context.level2 then
					-- It means that we are in a location where `Result' is not
					-- acceptable (e.g. an invariant).
				create vrle3
				context.init_error (vrle3)
				Error_handler.insert_error (vrle3)
					-- Cannot go on here
				Error_handler.raise_error
			elseif context.level4 then
					-- Result entity in precondition
				create veen2a
				context.init_error (veen2a)
				Error_handler.insert_error (veen2a)
			end
			context.put (create {TYPED_POINTER_A}.make_typed (Context.feature_type))
		end

	byte_node: HECTOR_B is
			-- Byte code for current node
		do
			create Result.make (create {RESULT_B})
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Dollar)
			ctxt.put_text_item_without_tabs (ti_Result)
		end

end -- class ADDRESS_RESULT_AS
