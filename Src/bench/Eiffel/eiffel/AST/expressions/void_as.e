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
		
	LEAF_AS
		
	SHARED_TYPES
		export
			{NONE} all
		end

create
	make_with_location

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

end -- class VOID_AS
