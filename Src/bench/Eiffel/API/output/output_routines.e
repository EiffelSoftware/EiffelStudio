indexing
	description:
		"Common routines shared by documentation generation and%N%
		%$EiffelGraphicalCompiler$ viewer/editor tools."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_ROUTINES

inherit
	SHARED_TEXT_ITEMS

	SHARED_EIFFEL_PROJECT

feature -- Miscellaneous

	append_system_info (text: STRUCTURED_TEXT) is
			-- Append to `text' information about `e_system'.
		local
			creation_name: STRING
			root_cluster: CLUSTER_I
			root_class: CLASS_I
			cr_f: E_FEATURE
		do
			text.add (create {KEYWORD_TEXT}.make ("System"))
			text.add_new_line
			text.add_indent
			text.add (create {INDEXING_TAG_TEXT}.make ("name:     "))
			text.add (create {BASIC_TEXT}.make (Eiffel_system.name))
			text.add_new_line

			text.add_indent
			text.add (create {INDEXING_TAG_TEXT}.make ("location: "))
			text.add (create {BASIC_TEXT}.make (Eiffel_project.name))
			text.add_new_line

			text.add_indent
			text.add (create {INDEXING_TAG_TEXT}.make ("ace file: "))
			text.add (create {BASIC_TEXT}.make (Eiffel_ace.file_name))
			text.add_new_line

			text.add_new_line

			root_class := Eiffel_system.root_class
			if root_class /= Void then
				text.add (create {KEYWORD_TEXT}.make ("Root class"))
				text.add_new_line
				text.add_indent
				text.add_class (root_class)

				root_cluster := Eiffel_system.root_cluster
				if root_cluster /= Void then
					text.add_space
					text.add (ti_L_parenthesis)
					text.add_cluster (root_cluster, root_cluster.cluster_name)
					text.add (ti_R_parenthesis)
				end

				creation_name := Eiffel_system.system.creation_name
				if root_class.compiled_class /= Void and creation_name /= Void then
					if root_class.compiled_class.has_feature_table then
						cr_f := root_class.compiled_class.feature_with_name (creation_name)
					end
					if cr_f /= Void then
						text.add (ti_Colon)
						text.add_space
						text.add_feature (cr_f, creation_name)
					else
						text.add (ti_Colon)
						text.add_space
						text.add_string (creation_name)
					end
				elseif creation_name /= Void then
					text.add (ti_Colon)
					text.add_space
					text.add_string (creation_name)
				end
				text.add_new_line
				text.add_new_line
			end
		end

	append_class_ancestors (text: STRUCTURED_TEXT; class_c: CLASS_C) is
			-- Append class ancestors for `class_c' to `text'.
		local
			parents: FIXED_LIST [CL_TYPE_A]
			class_list: SORTED_TWO_WAY_LIST [CLASS_I]
		do
			parents := class_c.parents
			if parents /= Void and then not parents.is_empty then
				create class_list.make
				from parents.start until parents.after loop
					class_list.extend (parents.item.associated_class.lace_class)
					parents.forth
				end
				text.add (create {KEYWORD_TEXT}.make ("Ancestors"))
				text.add_new_line
				append_simple_class_list (text, class_list)
				text.add_new_line
			end
		end

	append_class_descendants (text: STRUCTURED_TEXT; class_c: CLASS_C) is
			-- Append class descendants for `class_c' to `text'.
		local
			c_classes: LINEAR [CLASS_C]
		do
			c_classes := class_c.descendants
			if c_classes /= Void and then not c_classes.is_empty then
				text.add (create {KEYWORD_TEXT}.make ("Descendants"))
				text.add_new_line
				append_simple_class_list (text, lace_classes (c_classes))
				text.add_new_line
			end
		end

	append_class_clients (text: STRUCTURED_TEXT; class_c: CLASS_C) is
			-- Append class clients for `class_c' to `text'.
		local
			c_classes: LINEAR [CLASS_C]
		do
			c_classes := class_c.clients
			if c_classes /= Void and then not c_classes.is_empty then
				text.add (create {KEYWORD_TEXT}.make ("Clients"))
				text.add_new_line
				append_simple_class_list (text, lace_classes (c_classes))
				text.add_new_line
			end
		end

	append_class_suppliers (text: STRUCTURED_TEXT; class_c: CLASS_C) is
			-- Append class suppliers for `class_c' to `text'.
		local
			suppliers: SUPPLIER_LIST
			class_list: SORTED_TWO_WAY_LIST [CLASS_I]
		do
			suppliers := class_c.suppliers
			if suppliers /= Void and then not suppliers.is_empty then
				create class_list.make
				from suppliers.start until suppliers.after loop
					class_list.extend (suppliers.item.supplier.lace_class)
					suppliers.forth
				end
				text.add (create {KEYWORD_TEXT}.make ("Suppliers"))
				text.add_new_line
				append_simple_class_list (text, class_list)
				text.add_new_line
			end
		end

	append_simple_class_list (text: STRUCTURED_TEXT; class_list: LINKED_LIST [CLASS_I]) is
			-- Append to `ctxt.text', formatted `class_list'.
			-- Depending on `desc', include descriptions.
		local
			ci: CLASS_I
		do
			from
				class_list.start
			until
				class_list.after
			loop
				ci := class_list.item
				text.add_indent
				ci.compiled_class.append_signature (text, True)
				text.add_new_line
				class_list.forth
			end
		end

feature {NONE} -- Implementation

	lace_classes (l: LINEAR [CLASS_C]): SORTED_TWO_WAY_LIST [CLASS_I] is
			-- Similar list of lace classes.
		do
			create Result.make
			from l.start until l.after loop
				Result.extend (l.item.lace_class)
				l.forth
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class OUTPUT_ROUTINES
