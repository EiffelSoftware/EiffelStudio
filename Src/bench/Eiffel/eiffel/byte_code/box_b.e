indexing
	description: "Boxing instruction for IL code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	BOX_B

inherit
	EXPR_B
		redefine
			generate_il
		end

create
	make
	
feature {NONE} -- Initialization

	make (an_expr: EXPR_B; a_target_type: like type) is
			-- New BOX_B instance which converts value of `an_expr' into
			-- a box version of `a_target_type'.
		require
			an_expr_not_void: an_expr /= Void
			a_target_type_not_void: a_target_type /= Void
		do
			expr := an_expr
			type := a_target_type
		ensure
			expr_set: expr = an_expr
			type_set: type = a_target_type
		end
		
feature -- Access

	expr: EXPR_B
			-- Associated expression whose result is boxed

	type: TYPE_I
			-- Box type

feature -- Status report

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			-- False
		ensure then
			not_used: not Result
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for Void value.
		do
			expr.generate_il
			il_generator.generate_metamorphose (type)
		end

invariant
	expr_not_void: expr /= Void
	type_not_void: type /= Void

end -- class BOX_B
