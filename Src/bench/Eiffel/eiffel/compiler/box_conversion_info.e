indexing
	description: "Boxing conversion for IL code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	BOX_CONVERSION_INFO

inherit
	CONVERSION_INFO
	
	COMPILER_EXPORTER

create
	make
		
feature -- Byte code generation

	byte_node (an_expr: EXPR_B): EXPR_B is
			-- Generate byte node needed to convert `an_expr' to `target_type'
		do
			create {BOX_B} Result.make (an_expr, target_type.type_i)
		end
		
end -- class BOX_CONVERSION_INFO
