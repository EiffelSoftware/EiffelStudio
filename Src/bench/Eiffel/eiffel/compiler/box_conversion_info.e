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
	
feature {NONE} -- Initialization

	make (a_target_type: TYPE_A) is
			-- New instance of BOX_CONVERSION_INFO which will box to `a_target_type' instance
		require
			a_target_type_not_void: a_target_type /= Void
		do
			target_type := a_target_type
		ensure
			target_type_set: target_type = a_target_type
		end
		
feature -- Byte code generation

	byte_node (an_expr: EXPR_B): EXPR_B is
			-- Generate byte node needed to convert `an_expr' to `target_type'
		do
			create {BOX_B} Result.make (an_expr, target_type.type_i)
		end
		
end -- class BOX_CONVERSION_INFO
