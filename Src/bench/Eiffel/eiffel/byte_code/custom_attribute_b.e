indexing
	description: "Hold byte code information of a custom attribute creation%
		%with or without named argument."
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_ATTRIBUTE_B

inherit
	EXPR_B

create
	make

feature {NONE} -- Initialization

	make (a_creation: CREATION_EXPR_B; a_tuple: TUPLE_CONST_B) is
			-- Create new instance of Current.
		require
			a_creation_not_void: a_creation /= Void
		do
			creation_expr := a_creation
			tuple := a_tuple
		ensure
			creation_expr_set: creation_expr = a_creation
			tuple_set: tuple = a_tuple
		end
		
feature -- Access

	creation_expr: CREATION_EXPR_B
			-- Associated creation expression.
			
	tuple: TUPLE_CONST_B
			-- Associated tuple for named arguments.

feature {NONE} -- Not applicable

	type: TYPE_I is
			-- Expression type.
		do
			Result := creation_expr.type
		end
		
	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			check
				not_callable: False
			end
		end
		
invariant
	creation_expr_not_void: creation_expr /= Void

end -- class CUSTOM_ATTRIBUTE_B
