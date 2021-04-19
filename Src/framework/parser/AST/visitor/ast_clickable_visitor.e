note
	description: "Visitor to compute CLICK_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_CLICKABLE_VISITOR

inherit
	AST_ITERATOR
		redefine
			process_address_as,
			process_feature_as,
			process_feat_name_id_as,
			process_feature_name_alias_as,
			process_class_as,
			process_class_type_as,
			process_generic_class_type_as,
			process_named_tuple_type_as,
			process_predecessor_as,
			process_rename_as,
			process_client_as,
			process_convert_feat_as,
			default_create
		end

	REFACTORING_HELPER
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			create internal_click_list.make (1)
		end

feature -- Clickable

	click_list (a_class: CLASS_AS): CLICK_LIST
			-- Associated `click_list' of `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			internal_click_list.make (100)
			process_class_as (a_class)
			Result := internal_click_list
		end

feature {NONE} -- Access

	internal_click_list: CLICK_LIST
			-- Storage while visiting nodes for new click_list element.

feature {NONE} -- Implementation

	process_address_as (l_as: ADDRESS_AS)
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as.feature_name, l_as.feature_name)
			internal_click_list.extend (l_click_ast)
		end

	process_feature_as (l_as: FEATURE_AS)
		local
			l_fnames: EIFFEL_LIST [FEATURE_NAME]
			l_click_ast: CLICK_AST
			l_first: BOOLEAN
		do
			from
				l_fnames := l_as.feature_names
				l_fnames.start
				l_first := True
			until
				l_fnames.after
			loop
				if l_first then
					create l_click_ast.initialize (l_fnames.item, l_as)
					l_first := False
				else
					create l_click_ast.initialize (l_fnames.item, l_fnames.item)
				end
				internal_click_list.extend (l_click_ast)
				l_fnames.forth
			end
			l_as.body.process (Current)
			safe_process (l_as.indexes)
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS)
		do
			internal_click_list.extend (create {CLICK_AST}.initialize (l_as, l_as))
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS)
		do
			internal_click_list.extend (create {CLICK_AST}.initialize (l_as, l_as))
		end

	process_class_as (l_as: CLASS_AS)
		local
			l_click_ast: CLICK_AST
		do
			safe_process (l_as.top_indexes)

			create l_click_ast.initialize (l_as.class_name, l_as)
			internal_click_list.extend (l_click_ast)
			safe_process (l_as.generics)

			safe_process (l_as.conforming_parents)
			safe_process (l_as.non_conforming_parents)
			safe_process (l_as.creators)
			safe_process (l_as.convertors)
			safe_process (l_as.features)
			safe_process (l_as.invariant_part)
			safe_process (l_as.bottom_indexes)
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as.class_name, l_as)
			internal_click_list.extend (l_click_ast)
			safe_process (l_as.generics)
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
		do
			process_class_type_as (l_as)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as.class_name, l_as)
			internal_click_list.extend (l_click_ast)
			safe_process (l_as.generics)
		end

	process_predecessor_as (a: PREDECESSOR_AS)
			-- <Precursor>
		do
			internal_click_list.extend (create {CLICK_AST}.initialize (a.feature_name, a.feature_name))
		end

	process_rename_as (l_as: RENAME_AS)
		local
			l_click_ast: CLICK_AST
		do
				-- For `old_name' we use `new_name' as node to follow what
				-- we were doing before even though it does not make much sense
				-- to do that.
			create l_click_ast.initialize (l_as.old_name, l_as.new_name)
			internal_click_list.extend (l_click_ast)

			create l_click_ast.initialize (l_as.new_name, l_as.new_name)
			internal_click_list.extend (l_click_ast)
		end

	process_client_as (l_as: CLIENT_AS)
		local
			l_clients: EIFFEL_LIST [ID_AS]
			l_click_ast: CLICK_AST
		do
			from
				l_clients := l_as.clients
				l_clients.start
			until
				l_clients.after
			loop
				create l_click_ast.initialize (l_clients.item,
					create {CLASS_TYPE_AS}.initialize (l_clients.item))
				internal_click_list.extend (l_click_ast)
				l_clients.forth
			end
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS)
		local
			l_click_ast: CLICK_AST
		do
			create l_click_ast.initialize (l_as.feature_name, l_as.feature_name)
			internal_click_list.extend (l_click_ast)
			l_as.conversion_types.process (Current)
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
