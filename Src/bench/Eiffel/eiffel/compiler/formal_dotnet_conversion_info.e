indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_DOTNET_CONVERSION_INFO
	
inherit
	FORMAL_CONVERSION_INFO
		redefine
			byte_node
		end
	
create
	make

feature -- Byte code generation

	byte_node (an_expr: EXPR_B): EXPR_B is
			-- Generate byte node needed to convert `an_expr' to `target_type'
		do
			create {FORMAL_CONVERSION_B} Result.make (an_expr, target_type.type_i, True)
		end

end -- class FORMAL_DOTNET_CONVERSION_INFO
