indexing
	description: "Implicit conversion of an Eiffel type instance to an instance of System.Object"
	date: "$Date$"
	revision: "$Revision$"

class
	ANY_OBJECT_CONVERSION_INFO
	
inherit
	CONVERSION_INFO
	
create
	make

feature -- Byte code generation

	byte_node (an_expr: EXPR_B): EXPR_B is
			-- Byte node conversion. Nothing to be done here,
			-- since in generated code ANY inherits from SYSTEM_OBJECT.
		do
			Result := an_expr
		end

end -- class ANY_OBJECT_CONVERSION_INFO
