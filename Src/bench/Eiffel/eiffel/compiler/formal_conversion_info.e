indexing
	description: "Information about converting a formal to its constraint type."
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_CONVERSION_INFO

inherit
	CONVERSION_INFO
		rename
			make as old_make
		end

	COMPILER_EXPORTER

create
	make
	
feature {NONE} -- Implementation

	make (a_formal: like formal_type; a_target_type: like target_type) is
		require
			a_formal_not_void: a_formal /= Void
			a_target_type_not_void: a_target_type /= Void
		do
			formal_type := a_formal
			target_type := a_target_type
		ensure
			formal_type_set: formal_type = a_formal
			target_type_set: target_type = a_target_type
		end

feature -- Access

	formal_type: FORMAL_A
			-- Source of conversion which is formal

feature -- Byte code generation

	byte_node (an_expr: EXPR_B): EXPR_B is
			-- Generate byte node needed to convert `an_expr' to `target_type'
		do
			create {FORMAL_CONVERSION_B} Result.make (an_expr, target_type.type_i, False)
		end

invariant
	formal_type_not_void: formal_type /= Void

end -- class FORMAL_CONVERSION_INFO
