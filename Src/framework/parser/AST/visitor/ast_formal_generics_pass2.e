indexing
	description: "[
					Do a second pass over the generic declaration of a class.
					If its not a formal record it in the supplier list of the current class.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_FORMAL_GENERICS_PASS2

inherit
	AST_NULL_VISITOR
		redefine
			process_like_id_as, process_like_cur_as,
			process_formal_as, process_class_type_as,
			process_generic_class_type_as, process_none_type_as,
			process_bits_as, process_bits_symbol_as,
			process_named_tuple_type_as, process_type_dec_as
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make (a_ast_factory: AST_FACTORY; a_suppliers: SUPPLIERS_AS; a_formal_parameters: ARRAYED_LIST [FORMAL_AS])
			-- Initialise
			--
			-- `a_ast_factory' is needed to instatiate AST nodes.
			-- `a_suppliers' every identifier which is not a formal is recorded here.
			-- `a_formal_parameters' list of formals of the current class.
		require
			a_ast_factory_not_void: a_ast_factory /= Void
			a_suppliers_not_void: a_suppliers /= Void
			a_formal_parameters_not_void: a_formal_parameters /= Void
		do
			ast_factory := a_ast_factory
			suppliers := a_suppliers
			formal_parameters := a_formal_parameters
		ensure
			ast_factory_set: ast_factory = a_ast_factory
			suppliers_set: suppliers = a_suppliers
			formal_parameters_set: formal_parameters = a_formal_parameters
		end

feature -- Access

	has_node_changed: BOOLEAN
			-- Has the current call to the visitor created a new node object?
			--| So far we replace CL_TYPE_AS with FORMAL_AS wherever needed.
		do
			Result := new_node /= Void
		end

	consume_node
			-- Consumes a node, resets `has_node_changed' and sets `last_consumed_node'			
		require
			has_node_changed: has_node_changed
		do
			last_consumed_node := new_node
			new_node := Void
		ensure
			not_has_node_changed: not has_node_changed
			last_consumed_node_set: last_consumed_node /= Void and then last_consumed_node = old new_node
		end

	last_consumed_node: TYPE_AS
			-- Last consumed node.

feature {NONE} -- Implementation: Access

	new_node: TYPE_AS
			-- This is the new node which was produced to replace the node which was last visited.
			--| Usually we found the need to change the object type.

	ast_factory: AST_FACTORY
			-- AST Factory
			--| Needed to create instances of type FORMAL_AS.

	suppliers: SUPPLIERS_AS
			-- Suppliers of current class.
			--| Here we insert all supplier dependencies found

	formal_parameters: ARRAYED_LIST [FORMAL_AS]
			-- A list of all formal generic type parameters of the class.

feature {NONE} -- Visitor implementation

	process_formal_as (l_as: FORMAL_AS)
		do
			check not_has_node_changed: not has_node_changed end
			-- Do nothing.
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		local
			l_class_name: ID_AS
			l_formal_type, l_new_formal: FORMAL_AS
			l_generics: TYPE_LIST_AS
		do
			check not_has_node_changed: not has_node_changed end
			l_class_name := l_as.class_name
			if l_as.generics = Void then
					-- Check whether this class type should actually be a formal.
					-- If so, create a new formal instance and signal that the object has changed.				
				from
					formal_parameters.start
				until
					formal_parameters.after
				loop
					l_formal_type := formal_parameters.item
					if l_class_name.is_equal (l_formal_type.name) then
						l_new_formal := ast_factory.new_formal_as (l_class_name, l_formal_type.is_reference,
							l_formal_type.is_expanded, Void)
						l_new_formal.set_position (l_formal_type.position)
							-- Jump out of the loop.
						formal_parameters.finish
					end
					formal_parameters.forth
				end

				if l_new_formal /= Void then
						-- We changed, update `new_node'
						-- After we set `new_node' the query `has_node_changed' will yield true.
					new_node := l_new_formal
				else
						-- We have not found a formal. So it is indeed a class type.
						-- Add the class type to the suppliers!
					suppliers.insert_supplier_id (l_class_name)
				end
			else
					-- A formal can never be a base class of a generic class.
					-- Something like H -> G[INTEGER] is illegal.
					-- The error will be caught later.
				suppliers.insert_supplier_id (l_class_name)
				from
					l_generics := l_as.generics
					l_generics.start
				until
					l_generics.after
				loop
					l_generics.item.process (Current)
						-- If we changed the object, we need to replace the references.
					if has_node_changed then
						consume_node
						l_generics.replace (last_consumed_node)
						check is_replaced: l_generics.item = last_consumed_node end
					end
					l_generics.forth
				end
			end
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS) is
		do
			process_class_type_as (l_as)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
		local
			l_generics: EIFFEL_LIST [TYPE_DEC_AS]
		do
			check not_has_node_changed: not has_node_changed end
			from
				l_generics := l_as.generics
				l_generics.start
			until
				l_generics.after
			loop
				l_generics.item.type.process (Current)
					-- If we changed the object, we need to replace the references.
				if has_node_changed then
					consume_node
					l_generics.item.set_type (last_consumed_node)
				end
				l_generics.forth
			end
		end

feature -- Types which should not occur

	process_like_id_as (l_as: LIKE_ID_AS)
		do
				-- This type is not a formal and has no generics.
				-- Do nothing.
				-- An error will be thrown later.
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		do
				-- This type is not a formal and has no generics.
				-- Do nothing.
				-- An error will be thrown later.
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		do
			l_as.type.process (Current)
			if has_node_changed then
				l_as.set_type (new_node)
			end
		end

	process_none_type_as (l_as: NONE_TYPE_AS)
		do
			-- This type is not a formal and has no generics.
			-- Do nothing.
		end

	process_bits_as (l_as: BITS_AS)
		do
			-- This type is not a formal and has no generics.
			-- Do nothing.
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS)
		do
			-- This type is not a formal and has no generics.
			-- Do nothing.
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
