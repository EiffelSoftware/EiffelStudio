indexing
	description: "Abstraction for a conversion."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONVERSION_INFO

feature -- Access

	target_type: TYPE_A
			-- Target type of a conversion
		
feature -- Properties

	depend_unit: DEPEND_UNIT is
			-- Associated depend unit used for incrementality
		require
			has_depend_unit: has_depend_unit
		do
		ensure
			depend_unit_not_void: Result /= Void
		end

feature -- Status report

	has_depend_unit: BOOLEAN is
			-- Can `depend_unit' be accessed?
		do
		end
		
feature -- Byte code generation

	byte_node (an_expr: EXPR_B): EXPR_B is
			-- Generate byte node needed to convert `an_expr' to `target_type'
		require
			an_expr_not_void: an_expr /= Void
		deferred
		ensure
			byte_node_not_void: Result /= Void
		end

invariant
	target_type_not_void: target_type /= Void

end -- class CONVERSION_INFO
