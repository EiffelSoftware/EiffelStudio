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

	SHARED_TYPES

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new ADDRESS_CURRENT AST node.
		do
			-- Do nothing.
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
			context.put (pointer_type)
		end

	byte_node: HECTOR_B is
			-- Byte code for current node.
		local
			current_access: CURRENT_B
		do
			!! current_access
			!! Result.make (current_access)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Dollar)
			ctxt.put_text_item_without_tabs (ti_Current)
		end

end -- class ADDRESS_CURRENT_AS
