indexing
	description: "Type expression"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_EXPR_AS
	
inherit
	EXPR_AS
		redefine
			type_check
		end
		
	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialize

	make (t: like type) is
			-- New instance of TYPE_EXPR_AS initialized with `t'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Access

	type: TYPE_AS
			-- Type representing type expression

feature -- Visitor

	process (v: AST_VISITOR) is
			-- 
		do
			
		end
		
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'?
		do
			Result := type.is_equivalent (other.type)
		end

feature -- Type checking

	type_check is
			-- Check validity of current node. 
		local
			l_error: NOT_SUPPORTED
		do
			fixme ("Implement this.")
			create l_error
			context.init_error (l_error)
			l_error.set_message ("Creation of manifest type is not yet supported")
			Error_handler.insert_error (l_error)
			Error_handler.raise_error
		end
		
feature -- Code generation

	byte_node: EXPR_B is
			-- Associated byte node
		do
		end

feature {AST_EIFFEL, COMPILER_EXPORTER} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text according to context.
		do
			ctxt.put_text_item (ti_l_curly)
			type.format (ctxt)
			ctxt.put_text_item (ti_r_curly)
		end
		
invariant
	type_not_void: type /= Void

end
