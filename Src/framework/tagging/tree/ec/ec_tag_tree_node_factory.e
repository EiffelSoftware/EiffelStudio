note
	description: "[
		Node factory creating instances of {EC_TAG_TREE_NODE}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EC_TAG_TREE_NODE_FACTORY [G -> TAG_ITEM]

inherit
	TAG_TREE_NODE_FACTORY [G]
		redefine
			create_node
		end

feature -- Factory

	create_node (a_parent: TAG_TREE_NODE [G]; a_tag: READABLE_STRING_GENERAL; an_item: G): TAG_TREE_NODE [G]
			-- <Precursor>
		local
			l_formatter: TAG_FORMATTER
			l_token, l_code, l_name, l_uuid: STRING
			i: INTEGER
			l_node: detachable like create_node
		do
			l_formatter := a_parent.tree.formatter
			l_token := l_formatter.first_token (a_tag)

			if l_token.starts_with ({EC_TAG_TREE_CONSTANTS}.class_prefix) then
				l_name := l_token.substring ({EC_TAG_TREE_CONSTANTS}.class_prefix.count + 1, l_token.count)
				create {EC_TAG_TREE_CLASS_NODE [G]} l_node.make (a_parent, a_tag, l_name, an_item)

			elseif l_token.starts_with ({EC_TAG_TREE_CONSTANTS}.feature_prefix) then
				l_name := l_token.substring ({EC_TAG_TREE_CONSTANTS}.feature_prefix.count + 1, l_token.count)
				create {EC_TAG_TREE_FEATURE_NODE [G]} l_node.make (a_parent, a_tag, l_name, an_item)

			elseif l_token.starts_with ({EC_TAG_TREE_CONSTANTS}.target_prefix) then
				-- TODO: implement

			elseif l_token.starts_with ({EC_TAG_TREE_CONSTANTS}.library_prefix) then
				l_name := l_token.substring ({EC_TAG_TREE_CONSTANTS}.library_prefix.count + 1, l_token.count)
				if l_name.count > 37 then
					l_uuid := l_name.substring (l_name.count - 35, l_name.count)
					l_name := l_name.substring (1, l_name.count - 37)
					if (create {UUID}).is_valid_uuid (l_uuid) then
						create {EC_TAG_TREE_LIBRARY_NODE [G]} l_node.make (a_parent, a_tag, l_name, create {UUID}.make_from_string (l_uuid), an_item)
					end
				end

			elseif l_token.starts_with ({EC_TAG_TREE_CONSTANTS}.cluster_prefix) then
				l_name := l_token.substring ({EC_TAG_TREE_CONSTANTS}.cluster_prefix.count + 1, l_token.count)
				create {EC_TAG_TREE_CLUSTER_NODE [G]} l_node.make (a_parent, a_tag, l_name, an_item)

			elseif l_token.starts_with ({EC_TAG_TREE_CONSTANTS}.override_prefix) then
				l_name := l_token.substring ({EC_TAG_TREE_CONSTANTS}.override_prefix.count + 1, l_token.count)
				create {EC_TAG_TREE_OVERRIDE_NODE [G]} l_node.make (a_parent, a_tag, l_name, an_item)

			elseif l_token.starts_with ({EC_TAG_TREE_CONSTANTS}.directory_prefix) then
				l_name := l_token.substring ({EC_TAG_TREE_CONSTANTS}.directory_prefix.count + 1, l_token.count)
				create {EC_TAG_TREE_DIRECTORY_NODE [G]} l_node.make (a_parent, a_tag, l_name, an_item)

			end

			if l_node = Void then
				l_node := Precursor (a_parent, a_tag, an_item)
			end
			Result := l_node
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
