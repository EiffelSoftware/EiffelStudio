note
	description: "A checker for conflicts of local names against names of features of the given class."
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	AST_LOCAL_IDENTIFIER_CHECKER

inherit

	AST_ITERATOR
		redefine
			process_body_as,
			process_iteration_as,
			process_local_dec_list_as,
			process_named_expression_as,
			process_object_test_as
		end

	COMPILER_EXPORTER
		export {NONE} all end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	SHARED_SERVER
		export {NONE} all end

create
	make

feature {NONE} -- Creation

	make (f: FEATURE_AS; t: FEATURE_TABLE)
			-- Check names in feature `f` for conflicts against feature names in `t`
			-- and report errors accordingly.
		do
			feature_declaration := f
			feature_table := t
			f.process (Current)
		end

feature {NONE} -- State

	feature_declaration: FEATURE_AS
			-- Feature declaration being checked.

	feature_table: FEATURE_TABLE
			-- A table to look up for used feature names.

feature {NONE} -- Access: source code

	match_list: detachable LEAF_AS_LIST
			-- Leaf list of current class if exists, `Void` otherwise.
		do
			Result := match_list_server.item (feature_table.feat_tbl_id)
		end

feature {NONE} -- Visitor

	process_body_as (a: BODY_AS)
			-- <Precursor>
			-- Check conflicts for arguments and proceed with the feature content.
		local
			c: CLASS_C
			error: VRFA
			id_list: IDENTIFIER_LIST
			name_id: INTEGER
		do
			if attached a.arguments as arguments then
				across
					arguments as declaration_list
				loop
					id_list := declaration_list.item.id_list
					across
						id_list as local_name
					loop
						name_id := local_name.item
						if feature_table.has_id (name_id) then
								-- The name conflicts with a feature name of the current class.
							create error
							c := feature_table.associated_class
							error.set_class (c)
							error.set_written_class (c)
							error.set_feature (feature_table.item_id (feature_declaration.feature_name.name_id))
							error.set_other_feature (feature_table.item_id (name_id))
							if attached match_list as m then
								error.set_location (m [id_list.id_list [local_name.target_index]])
							end
							error_handler.insert_error (error)
						end
					end
				end
			end
			Precursor (a)
		end

	process_iteration_as (a: ITERATION_AS)
			-- <Precursor>
			-- Check conflicts for an iteration cursor name.
		do
			if
				attached a.identifier as n and then
				feature_table.has_id (n.name_id)
			then
					-- The name conflicts with a feature name of the current class.
				error_handler.insert_error (create {VOIT2}.make
					(n, feature_table.item_id (feature_declaration.feature_name.name_id), feature_table.associated_class))
			end
		end

	process_local_dec_list_as (a: LOCAL_DEC_LIST_AS)
			-- <Precursor>
			-- Check conflicts for local variable names.
		local
			c: CLASS_C
			error: VRLE1
			id_list: IDENTIFIER_LIST
			name_id: INTEGER
		do
			across
				a.locals as declaration_list
			loop
				id_list := declaration_list.item.id_list
				across
					id_list as local_name
				loop
					name_id := local_name.item
					if feature_table.has_id (name_id) then
							-- The name conflicts with a feature name of the current class.
						create error
						c := feature_table.associated_class
						error.set_class (c)
						error.set_written_class (c)
						error.set_feature (feature_table.item_id (feature_declaration.feature_name.name_id))
						error.set_local_name (name_id)
						if attached match_list as m then
							error.set_location (m [id_list.id_list [local_name.target_index]])
						end
						error_handler.insert_error (error)
					end
				end
			end
		end

	process_named_expression_as (a: NAMED_EXPRESSION_AS)
			-- <Precursor>
			-- Check conflicts for object test local.
		do
			if
				attached a.name as n and then
				feature_table.has_id (n.name_id)
			then
					-- The name conflicts with a feature name of the current class.
				error_handler.insert_error (create {FRESH_IDENTIFIER_ERROR}.make
					(n, feature_table.item_id (feature_declaration.feature_name.name_id), feature_table.associated_class))
			end
		end

	process_object_test_as (a: OBJECT_TEST_AS)
			-- <Precursor>
			-- Check conflicts for an object test local.
		do
			if
				attached a.name as n and then
				feature_table.has_id (n.name_id)
			then
					-- The name conflicts with a feature name of the current class.
				error_handler.insert_error (create {VUOT1}.make
					(n, feature_table.item_id (feature_declaration.feature_name.name_id), feature_table.associated_class))
			end
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
