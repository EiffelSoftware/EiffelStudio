indexing
	description: "Expression whose type is either conforming or convertible to a give type"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_ADAPTATION_AS

inherit
	EXPR_AS

create
	make
	
feature {NONE} -- Initialize

	make (t: like type; e: like expression) is
			-- New instance of TYPE_ADAPTATION_AS initialized with `t' and `e'.
		require
			t_not_void: t /= Void
		do
			type := t
			expression := e
		ensure
			type_set: type = t
			expression_set: expression = e
		end

feature -- Access

	type: TYPE_AS
			-- Type representing type expression

	expression: EXPR_AS
			-- Expression

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
	expression_not_void: expression /= Void

end
