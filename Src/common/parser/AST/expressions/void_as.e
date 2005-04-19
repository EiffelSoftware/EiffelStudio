indexing
	description: "Node for Void expression."
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_AS
	
inherit
	EXPR_AS
		
	LEAF_AS
		
create
	make_with_location

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to Current?
		do
			Result := True
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Process Void element.
		do
			v.process_void_as (Current)
		end

end -- class VOID_AS
