indexing
	description: "Type expression"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_EXPR_AS
	
inherit
	EXPR_AS

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

invariant
	type_not_void: type /= Void

end
