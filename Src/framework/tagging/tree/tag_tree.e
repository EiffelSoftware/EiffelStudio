note
	description: "[

		Objects that manage a tree structure based on the hierarchical tags stored in a {TAG_SERVER}.

		Example: two items in a collection are tagged each with one tag

			item1: platform/os/unix/x86_64
			item2: platform/os/unix/sparc
			item3: platform/proc/ia32

		The resulting tree for prefix `platform/os' would have the following structure:

			platform
				+ os
					+ unix
						+ x86_64
							-> item1
						+ sparc
							-> item2
				+ proc
					+ ia32
						-> item3

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_TREE [G -> TAG_ITEM]

inherit
	TAG_SERVER [G]
		rename
			make as make_server,
			connection as server_connection,
			connection_cache as server_connection_cache
		export
			{TAG_SPARSE_TREE} lock, unlock
		redefine
			add_tag,
			remove_tag,
			is_valid_tag_for_item
		end

create
	make

feature {NONE} -- Initialization

	make (a_formatter: like formatter; a_factory: like node_factory)
			-- Initialize `Current'.
			--
			-- `a_formatter': Tag formatter.
		do
			formatter := a_formatter
			make_server (formatter.validator)

			node_factory := a_factory

			create node_added_event
			create node_remove_event
		end

feature -- Access

	formatter: TAG_FORMATTER
			-- Formatter used to extract tokens from tags

	root_node: TAG_TREE_NODE [G]
			-- Root node of `Current'
		local
			l_cache: like root_node_cache
		do
			l_cache := root_node_cache
			if l_cache = Void then
				l_cache := node_factory.create_root_node (Current)
				root_node_cache := l_cache
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
		end

feature {TAG_TREE_NODE} -- Access

	node_factory: TAG_TREE_NODE_FACTORY [G]
			-- Node factory for creating new nodes

feature {NONE} -- Access

	root_node_cache: detachable like root_node
			-- Cache for `root_node'
			--
			-- Note: do not access directly, use `root_node' instead.

	connection_cache: detachable like connection
			-- Cache for `connection'
			--
			-- Note: do not access directly, use `connection' instead.

feature -- Query

	is_valid_tag_for_item (an_item: G; a_tag: READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
			--
			-- Note: the fact that `an_item' has a unique name which is a valid token is crucial for
			--       building the tree. Before adding a new tag to the tree, the name of the item is
			--       appended to the end of the tag, guaranteeing a new unique tag which is not masked by
			--       an existing tag. This again allows us to have pure leafs only containing the item.
		do
			if Precursor (an_item, a_tag) then
				Result := not a_tag.has_substring (formatter.item_prefix) and
				          formatter.is_valid_token (an_item.name)
			end
		ensure then
			result_implies_no_item_prefix: Result implies not a_tag.has_substring (formatter.item_prefix)
			result_implies_valid_token: Result implies formatter.is_valid_token (an_item.name)
		end

feature -- Element change

	add_tag (an_item: G; a_tag: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_found: like find_node
			l_new: detachable TAG_TREE_NODE [G]
			l_tree_tag: READABLE_STRING_GENERAL
			l_token: STRING_32
			l_formatter: like formatter
		do
			Precursor (an_item, a_tag)

			lock
			l_found := find_node (a_tag)
			l_formatter := formatter
			create l_token.make (an_item.name.count + l_formatter.item_prefix.count)
			l_token.append (l_formatter.item_prefix)
			l_token.append_string_general (an_item.name)
			l_tree_tag := l_formatter.join_tags (l_found.suffix, l_token)
			l_found.node.add_tag_with_item (l_tree_tag, an_item)
			l_new := l_found.node.last_added_child
			check l_new /= Void end
			node_added_event.publish ([Current, l_new])
			unlock
		end

	remove_tag (an_item: G; a_tag: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_found: like find_node
			l_node, l_remove: detachable TAG_TREE_NODE [G]
			l_token: STRING_32
			l_formatter: like formatter
		do
			lock

			l_formatter := formatter
			create l_token.make (an_item.name.count + l_formatter.item_prefix.count)
			l_token.append (l_formatter.item_prefix)
			l_token.append_string_general (an_item.name)

			l_found := find_node (formatter.join_tags (a_tag, l_token))

			check
					-- Check making sure there was a node representing `a_tag'
				exact_match: l_found.suffix.is_empty
					-- Also, the node must contain `an_item'
				match_contains_item: l_found.node.is_leaf and then l_found.node.item = an_item
			end

			from
				l_node := l_found.node
			until
				l_node.count > 1 or l_node.is_root
			loop
				l_remove := l_node
				l_node := l_node.parent
			end

			check l_remove_attached: l_remove /= Void end

			node_remove_event.publish ([Current, l_remove])
			l_node.remove_child_with_token (l_remove.token)
			unlock

			Precursor (an_item, a_tag)
		end

feature -- Basic operations

	item_suffixes (a_prefix: READABLE_STRING_GENERAL; an_item: G): like tags_of_item
			-- Set containing all suffixes of tags for which given item contained a tag with given prefixed
			--
			-- `a_prefix': A prefix.
			-- `an_item': Item for which all tags should be returned starting with `a_prefix'.
		require
			a_prefix_attached: a_prefix /= Void
			an_item_attached: an_item /= Void
			a_prefix_valid: validator.is_valid_tag (a_prefix) or else a_prefix.is_empty
			an_item_tagged: has_item (an_item)
		local
			l_tag: READABLE_STRING_GENERAL
			l_formatter: like formatter
		do
			Result := new_tag_set
			across
				item_to_tags_table.item (an_item) as ts
			from
				l_formatter := formatter
			loop
				l_tag := ts
				if l_formatter.is_prefix (a_prefix, l_tag) then
					Result.force (l_formatter.suffix (a_prefix, l_tag))
				end
			end
		end

feature -- Events

	node_added_event: EVENT_TYPE [TUPLE [tree: TAG_TREE [G]; node: TAG_TREE_NODE [G]]]
			-- Events called after a node has been added to `Current'

	node_remove_event: EVENT_TYPE [TUPLE [tree: TAG_TREE [G]; node: TAG_TREE_NODE [G]]]
			-- Events called before a node is removed from `Current'

	connection: EVENT_CHAINED_CONNECTION [TAG_TREE_OBSERVER [G], TAG_TREE [G], TAG_SERVER_OBSERVER [G], TAG_SERVER [G]]
			-- <Precursor>
			-- Connection point.
		require
			is_interface_usable: is_interface_usable
		do
			Result := connection_cache
			if not attached Result then
				create Result.make (agent (a_observer: TAG_TREE_OBSERVER [G]): ARRAY [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE]]
					do
						Result := <<
								[node_added_event, agent a_observer.on_node_added],
								[node_remove_event, agent a_observer.on_node_remove]
							>>
					end, server_connection)
				connection_cache := Result
			end
		ensure
			result_attached: attached Result
			result_is_interface_usable: Result.is_interface_usable
		end

feature {NONE} -- Implementation

	find_node (a_tag: READABLE_STRING_GENERAL): TUPLE [node: TAG_TREE_NODE [G]; suffix: READABLE_STRING_GENERAL]
			-- Find node in `Current' which best approximates given tag.
			--
			-- `a_tag': Tag specifying path to where `find_node' will look for a node.
			-- `Result': Tuple containing found node, together with remaining suffix.
		require
			a_tag_attached: a_tag /= Void
			a_tag_valid: validator.is_valid_tag (a_tag)
		local
			l_result: TAG_TREE_NODE [G]
			l_suffix, l_token: detachable READABLE_STRING_GENERAL
			l_formatter: like formatter
		do
			from
				l_result := root_node
				l_suffix := a_tag
				l_formatter := formatter
			until
				l_suffix.is_empty or else (l_token /= Void and then (l_result.is_leaf or else not l_result.has_child_with_token (l_token)))
			loop
				if l_token /= Void then
					l_result := l_result.child_with_token (l_token)
					l_suffix := l_formatter.suffix (l_token, l_suffix)
				end
				if not l_suffix.is_empty then
					l_token := l_formatter.first_token (l_suffix)
				end
			end
			Result := [l_result, l_suffix]
		ensure
			result_attached: Result /= Void and then Result.node /= Void and then Result.suffix /= Void
			result_node_valid: Result.node.is_active and then Result.node.tree = Current
			result_suffix_valid: Result.suffix.is_empty or else validator.is_valid_tag (Result.suffix)
			result_valid: a_tag.same_string (formatter.join_tags (Result.node.tag, Result.suffix))
			result_matches_best: not Result.suffix.is_empty implies (Result.node.is_leaf or not
				Result.node.has_child_with_token (formatter.first_token (Result.suffix)))
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
