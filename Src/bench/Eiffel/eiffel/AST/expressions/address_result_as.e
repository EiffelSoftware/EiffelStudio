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
		
	LEAF_AS

	SHARED_TYPES

create
	make_from_other

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
			if context.is_checking_invariant or else context.feature_type.conform_to (void_type) then
					-- It means that we are in a location where `Result' is not
					-- acceptable (e.g. an invariant, or within the body of a procedure).
				create vrle3
				context.init_error (vrle3)
				vrle3.set_location (start_location)
				Error_handler.insert_error (vrle3)
					-- Cannot go on here
				Error_handler.raise_error
			elseif context.is_checking_precondition then
					-- Result entity in precondition
				create veen2a
				context.init_error (veen2a)
				veen2a.set_location (start_location)
				Error_handler.insert_error (veen2a)
			end
			context.put (create {TYPED_POINTER_A}.make_typed (Context.feature_type))
		end

	byte_node: HECTOR_B is
			-- Byte code for current node
		do
			create Result.make (create {RESULT_B})
		end

end -- class ADDRESS_RESULT_AS
