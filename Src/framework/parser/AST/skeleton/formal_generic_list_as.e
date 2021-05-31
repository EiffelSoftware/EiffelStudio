note
	description: "Object that represents a list of formal generic declaraction"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_GENERIC_LIST_AS

inherit
	EIFFEL_LIST [FORMAL_DEC_AS]
		redefine
			process, first_token, last_token
		end

create
	make,
	make_filled_with

feature -- Visitor

	process (v: AST_VISITOR)
		do
			v.process_formal_generic_list_as (Current)
		end

feature -- Transformation

	transform_class_types_to_formals_and_record_suppliers (a_ast_factory: AST_FACTORY; a_suppliers: SUPPLIERS_AS; a_formal_parameters: ARRAYED_LIST [FORMAL_AS])
			-- Record all suppliers and transform possibly some class types into formals.
			--| If a formal is used before it is defined, we cannot possibly now that. That's why we need this second pass.			
		require
			a_ast_factory_not_void: a_ast_factory /= Void
			a_suppliers_not_void: a_suppliers /= Void
			a_formal_parameters_not_void: a_formal_parameters /= Void
		local
			l_constraints: EIFFEL_LIST[CONSTRAINING_TYPE_AS]
			l_formal_generics_pass2: AST_FORMAL_GENERICS_PASS2
		do
			create l_formal_generics_pass2.make (a_ast_factory, a_suppliers, a_formal_parameters)
			from
				start
			until
				after
			loop
				l_constraints := item.constraints
				from
					l_constraints.start
				until
					l_constraints.after
				loop
					l_constraints.item.type.process (l_formal_generics_pass2)
					if l_formal_generics_pass2.has_node_changed then
						l_formal_generics_pass2.consume_node
						if attached l_formal_generics_pass2.last_consumed_node as l_node then
							l_constraints.item.set_type (l_node)
						end
					end
					l_constraints.forth
				end
				forth
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				Result := Precursor (a_list)
			elseif lsqure_symbol_index /= 0 then
				Result := lsqure_symbol (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				Result := Precursor (a_list)
			elseif rsqure_symbol_index /= 0 then
				Result := rsqure_symbol (a_list)
			end
		end

feature -- Roundtrip

	lsqure_symbol_index, rsqure_symbol_index: INTEGER
			-- Symbol "[" and "]" associated with Current AST node

	lsqure_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "[" associated with Current AST node
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, lsqure_symbol_index)
		end

	rsqure_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "]" associated with Current AST node
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, rsqure_symbol_index)
		end

feature -- Settings

	set_lsqure_symbol (s_as: like lsqure_symbol)
			-- Set `lsqure_symbol' with `s_as'.
		do
			if s_as /= Void then
				lsqure_symbol_index := s_as.index
			end
		ensure
			lsqure_symbol_index_set: s_as /= Void implies lsqure_symbol_index = s_as.index
		end

	set_rsqure_symbol (s_as: like rsqure_symbol)
			-- Set `rsqure_symbol' with `s_as'.
		do
			if s_as /= Void then
				rsqure_symbol_index := s_as.index
			end
		ensure
			rsqure_symbol_index_set: s_as /= Void implies rsqure_symbol_index = s_as.index
		end

	set_squre_symbols (l_as, r_as: detachable SYMBOL_AS)
			-- Set `lsqure_symbol' with `l_as' and `rsqure_symbol' with `r_as'.
		do
			set_lsqure_symbol (l_as)
			set_rsqure_symbol (r_as)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
