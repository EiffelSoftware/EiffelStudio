indexing
	description: "Description of a custom attribute."
	date: "$Date$"
	revision: "$Revision$"

class CUSTOM_ATTRIBUTE_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent, type_check, byte_node
		end

create
	initialize
	
feature {AST_FACTORY} -- Initialization

	initialize (c: like creation_expr; t: like tuple) is
			-- Create a new UNIQUE AST node.
		require
			c_not_void: c /= Void
		do
			creation_expr := c
			tuple := t
		ensure
			creation_expr_set: creation_expr = c
			tuple_set: tuple = t
		end

feature -- Access

	creation_expr: CREATION_EXPR_AS
			-- Creation of Custom attribute.
			
	tuple: TUPLE_AS
			-- Tuple for addition custom attribute settings.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := creation_expr.is_equivalent (other.creation_expr)
		end

feature -- Type checking

	type_check is
			-- Type check a unique type
		do
				-- Type checking and byte code generation
				-- Since the first statement in `type_check' of CREATION_EXPR_AS
				-- is `context.pop (1)' we insert a dummy Void element.
			context.put (Void)
			creation_expr.type_check
			if tuple /= Void then
					-- Check validity of tuple in general.
				tuple.type_check

					-- Check validity of tuple in context of custom attribute.
				check_tuple_validity
			end
		end

feature -- Byte code generation

	byte_node: CUSTOM_ATTRIBUTE_B is
			-- Associated byte node.
		local
			l_creation_b: CREATION_EXPR_B
		do
			l_creation_b := creation_expr.byte_node
			if tuple /= Void then
				create Result.make (l_creation_b, tuple.byte_node)
			else
				create Result.make (l_creation_b, Void)
			end
		end
		
feature -- Output

	string_value: STRING is ""

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			creation_expr.simple_format (ctxt)
		end

feature {NONE} -- Type checking

	check_tuple_validity is
			-- Check validity of `tuple' in context of Current.
			-- i.e. it should be a tuple of tuple whose elements are
			-- a name and a value. For each name, a feature `f'
			-- should be available in context of class being created in `creation_expr'.
			-- To be more precise, tuple should look like:
			--  [["first_name", val1],["last_name", val2]]
		require
			tuple_not_void: tuple /= Void
		local
			vica: VICA
			l_sub: TUPLE_AS
			l_val: VALUE_AS
			l_name: STRING_AS
			l_value: EXPR_AS
			l_has_syntax_error, l_has_semantic_error: BOOLEAN
			l_creation_type: CL_TYPE_A
			l_feat: FEATURE_I
			l_cursor, i: INTEGER
			vjar: VJAR
		do
				-- Let's first check that TUPLE elements are indeed of the form
				-- ["my_attribute", my_value]
			l_cursor := Context.tuple_line.cursor
			l_creation_type ?= creation_expr.type.actual_type
			check
				has_type: l_creation_type /= Void
			end
			from
				tuple.expressions.start
			until
				tuple.expressions.after
			loop
				l_val ?= tuple.expressions.item
				l_has_syntax_error := l_val = Void
				if not l_has_syntax_error then
					l_sub ?= l_val.terminal
					l_has_syntax_error := l_sub = Void or else l_sub.expressions.count /= 2
					if not l_has_syntax_error then
						l_val ?= l_sub.expressions.i_th (1)
						l_has_syntax_error := l_val = Void
						if not l_has_syntax_error then
							l_name ?= l_val.terminal
							l_value := l_sub.expressions.i_th (2)
							l_has_syntax_error := l_name = Void
						end
					end
				end
				tuple.expressions.forth
			end
			
			if l_has_syntax_error then
				create vica.make (Context.current_class, l_creation_type)
				Error_handler.insert_error (vica)
			else
					-- Let's do the semantic analyzis of ["my_attribute", my_value]
					-- It consists to make sure that `my_attribute' is a feature of `type' created
					-- by Current and type of this feature matches type of `my_value'.
				from
					tuple.expressions.start
					i := l_cursor - tuple.expressions.count
				until
					tuple.expressions.after
				loop
					l_val ?= tuple.expressions.item
					l_sub ?= l_val.terminal
					l_val ?= l_sub.expressions.i_th (1)
					l_name ?= l_val.terminal
					l_value := l_sub.expressions.i_th (2)
					l_feat := l_creation_type.associated_class.feature_table.item
						(l_name.value.as_lower)
					l_has_semantic_error := l_feat = Void
					if not l_has_semantic_error then
						if not valid_feature (l_feat) then
							create vica.make (Context.current_class, l_creation_type)
							vica.set_feature (l_feat)
							Error_handler.insert_error (vica)
						else
							Context.tuple_line.go_i_th (i)
							l_has_semantic_error := not Context.tuple_line.item.generics.item (2).
								conform_to (l_feat.type.actual_type)
							if l_has_semantic_error then
								create vjar
								context.init_error (vjar)
								vjar.set_source_type (Context.tuple_line.item.generics.item (2))
								vjar.set_target_type (l_feat.type.actual_type)
								vjar.set_target_name (l_name.value)
								Error_handler.insert_error (vjar)
								create vica.make (Context.current_class, l_creation_type)
								vica.set_feature (l_feat)
								Error_handler.insert_error (vica)
							end
						end
					else
						create vica.make (Context.current_class, l_creation_type)
						vica.set_feature_name (l_name.value)
						Error_handler.insert_error (vica)
					end
					tuple.expressions.forth
					i := i + 1
				end

				if l_has_semantic_error and vica = Void then
					create vica.make (Context.current_class, l_creation_type)
					Error_handler.insert_error (vica)
				end
			end
			Context.tuple_line.go_i_th (l_cursor)
		end

	valid_feature (a_feat: FEATURE_I): BOOLEAN is
			-- Is `a_feat' valid to be used as a named argument in custom attribute?
		require
			a_feat_not_void: a_feat /= Void
		local
			vuex: VUEX
			l_ext_class: EXTERNAL_CLASS_C
		do
			if a_feat.is_exported_for (System.any_class.compiled_class) then
				Result := a_feat.is_attribute
				if not Result and a_feat.is_function then
						-- Let's find out if we have an associated property setter to function
						-- `a_feat'.
					l_ext_class ?= a_feat.written_class
					if l_ext_class /= Void then
							-- It has to have a setter
						Result := l_ext_class.has_associated_property_setter (a_feat)
					end
				end
			else
				create vuex
				context.init_error (vuex)
				vuex.set_static_class (System.any_class.compiled_class)
				vuex.set_exported_feature (a_feat)
				Error_handler.insert_error (vuex)
			end
		end
		
invariant
	creation_expr_not_void: creation_expr /= Void

end -- class CUSTOM_ATTRIBUTE_AS
