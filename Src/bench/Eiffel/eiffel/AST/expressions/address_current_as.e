indexing
	description: "AST representation of an Eiffel function pointer for Current.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADDRESS_CURRENT_AS

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
			v.process_address_current_as (Current)
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
		do
			context.put (create {TYPED_POINTER_A}.make_typed (context.actual_class_type))
		end

	byte_node: HECTOR_B is
			-- Byte code for current node.
		do
			create Result.make (create {CURRENT_B})
		end

end -- class ADDRESS_CURRENT_AS
