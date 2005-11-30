indexing
	description: "Byte code for manifest arrays"
	date: "$Date$"
	revision: "$Revision$"

class ARRAY_CONST_B

inherit
	EXPR_B
		redefine
			enlarged, enlarge_tree, is_unsafe,
			optimized_byte_node, calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			allocates_memory, has_call, is_constant_expression
		end

	PREDEFINED_NAMES
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialize

	make (e: like expressions; t: like type; i: like info) is
			-- New instance of ARRAY_CONST_B initialized with `e' and `t'.
		require
			e_not_void: e /= Void
			t_not_void: t /= Void
			i_not_void: i /= Void
		do
			expressions := e
			type := t
			info := i
		ensure
			expressions_set: expressions = e
			type_set: type = t
			info_set: info = i
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_array_const_b (Current)
		end

feature -- Access

	expressions: BYTE_LIST [BYTE_NODE];
			-- Expressions in the array

	type: GEN_TYPE_I;
			-- Generic array type

	info: CREATE_INFO
			-- Info to create manifest array instance

feature -- Status report

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local access ?
		local
			expr: EXPR_B
			i, nb: INTEGER
			l_area: SPECIAL [BYTE_NODE]
			l_expressions: BYTE_LIST [BYTE_NODE]
		do
			from
				l_expressions := expressions
				l_area := l_expressions.area
				nb := l_expressions.count
			until
				i = nb or Result
			loop
				expr ?= l_area.item (i)
				check
					expr_not_void: expr /= Void
				end
				Result := expr.used (r)
				i := i + 1
			end
		end

	allocates_memory: BOOLEAN is True;
			-- Current allocates memory.

	has_call: BOOLEAN is
			-- Does current contain a call?
		local
			expr: EXPR_B
			l_expressions: like expressions
		do
			from
				l_expressions := expressions
				l_expressions.start
			until
				l_expressions.after or Result
			loop
				expr ?= l_expressions.item
				check expr_not_void: expr /= Void end
				Result := expr.has_call
				l_expressions.forth
			end
		end

	is_constant_expression: BOOLEAN is
			-- Is current array only made of constant expressions?
		local
			expr: EXPR_B
			l_expressions: like expressions
		do
			from
				l_expressions := expressions
				Result := True
				l_expressions.start
			until
				l_expressions.after or not Result
			loop
				expr ?= l_expressions.item
				check expr_not_void: expr /= Void end
				Result := expr.is_constant_expression
				l_expressions.forth
			end
		end

feature -- Code generation

	enlarge_tree is
			-- Enlarge the expressions.
		do
			expressions.enlarge_tree
		end

	enlarged: ARRAY_CONST_BL is
			-- Enlarge node
		do
			create Result.make (expressions, type, info)
			Result.enlarge_tree;
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expressions.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := expressions.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			expressions := expressions.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expressions.size + 1
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			expressions := expressions.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expressions := expressions.inlined_byte_code
		end

invariant
	expressions_not_void: expressions /= Void
	type_not_void: type /= Void
	info_not_void: info /= Void

end
