indexing
	description: "Node for Void expression."
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_AS
	
inherit
	EXPR_AS
		redefine
			type_check
		end
		
	SHARED_TYPES
		export
			{NONE} all
		end
	
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to Current?
		do
			Result := True
		end

feature -- Type checking

	type_check is
			-- Type check `Void'.
		do
			context.put (none_type)
		end

feature -- Byte node

	byte_node: EXPR_B is
			-- Associated byte node
		do
			create {VOID_B} Result
		end
		
feature -- Visitor

	process (v: AST_VISITOR) is
			-- Process Void element.
		do
			v.process_void_as (Current)
		end

feature {AST_EIFFEL, COMPILER_EXPORTER} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text according to context.
		do
			ctxt.put_text_item (ti_void)
		end

end -- class VOID_AS
