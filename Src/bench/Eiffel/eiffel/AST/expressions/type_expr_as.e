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
		
	SHARED_EVALUATOR
		export
			{NONE} all
		end
		
	SHARED_INSTANTIATOR
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
			l_type: TYPE_A
			l_vtug: VTUG
			l_vtcg3: VTCG3
			l_type_type: GEN_TYPE_A
		do
			l_type := type_expr_evaluator.evaluated_type (type, context.feature_table, context.current_feature)
			if not l_type.good_generics then
				l_vtug := l_type.error_generics
				l_vtug.set_class (context.current_class)
				l_vtug.set_feature (context.current_feature)
				error_handler.insert_error (l_vtug)
			else
				l_type.reset_constraint_error_list
				l_type.check_constraints (context.current_class)
				if not l_type.constraint_error_list.is_empty then
					create l_vtcg3
					l_vtcg3.set_class (context.current_class)
					l_vtcg3.set_feature (context.current_feature)
					l_vtcg3.set_error_list (l_type.constraint_error_list)
					error_handler.insert_error (l_vtcg3)
				else
					instantiator.dispatch (l_type, context.current_class)
				end
			end
			error_handler.checksum

			create l_type_type.make (system.type_class.compiled_class.class_id, << l_type >>)
			context.put (l_type_type)
			context.creation_types.insert (l_type_type.type_i)
		end
		
feature -- Code generation

	byte_node: EXPR_B is
			-- Associated byte node
		local
			l_type_type: GEN_TYPE_I
		do
			l_type_type ?= context.creation_types.item
			check
				is_generic_type: l_type_type /= Void
			end
			context.creation_types.forth
			create {TYPE_EXPR_B} Result.make (l_type_type)
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
