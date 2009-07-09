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
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_TREE [G -> TAG_ITEM]

inherit
	TAG_SERVER [G]
		rename
			connection as server_connection,
			connection_cache as server_connection_cache
		export
			{TAG_SPARSE_TREE} lock, unlock
		redefine
			make_with_formatter,
			formatter,
			add_tag,
			remove_tag,
			is_valid_tag_for_item
		select
			server_connection
		end

	EVENT_CONNECTION_POINT_I [TAG_TREE_OBSERVER [G], TAG_TREE [G]]

create
	make_with_formatter

feature {NONE} -- Initialization

	make_with_formatter (a_formatter: like formatter)
			-- <Precursor>
		do
			Precursor (a_formatter)

			create node_added_event
			create node_remove_event
		end

feature -- Access

	formatter: TAG_HIERARCHICAL_FORMATTER
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
			-- Node factory for creating new nodes.
		local
			l_cache: like node_factory_cache
		do
			l_cache := node_factory_cache
			if l_cache = Void then
				create l_cache
				node_factory_cache := l_cache
			end
			Result := l_cache
		end

feature {NONE} -- Access

	root_node_cache: detachable like root_node
			-- Cache for `root_node'
			--
			-- Note: do not access directly, use `root_node' instead.

	node_factory_cache: detachable like node_factory
			-- Cache for `node_factory'
			--
			-- Note: do not access directly, use `node_factory' instead.

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
				Result := not a_tag.has_code (('~').natural_32_code) and
				          formatter.is_valid_token (an_item.name)
			end
		ensure then
			result_implies_valid_token: Result implies formatter.is_valid_token (an_item.name)
		end

feature -- Status setting

	set_node_factory (a_factory: like node_factory)
			-- Set `node_factory' to given factory.
			--
			-- TODO: move this into creation procedure...
			--
			-- `a_factory': Node factory to be used for creating future nodes.
		require
			a_factory_attached: a_factory /= Void
		do
			node_factory_cache := a_factory
		ensure
			node_factory_set: node_factory = a_factory
		end

feature -- Element change

	add_tag (an_item: G; a_tag: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_found: like find_node
			l_new: detachable TAG_TREE_NODE [G]
			l_tree_tag: READABLE_STRING_GENERAL
			l_token: STRING
			l_formatter: like formatter
		do
			Precursor (an_item, a_tag)

			lock
			l_found := find_node (a_tag)
			l_formatter := formatter
			l_token := l_formatter.string_copy (an_item.name)
			l_token.append_character ('~')
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
			l_tree_tag: READABLE_STRING_GENERAL
			l_found: like find_node
			l_node, l_remove: detachable TAG_TREE_NODE [G]
		do
			lock
			l_tree_tag := formatter.join_tags (a_tag, an_item.name)
			l_found := find_node (l_tree_tag)

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

feature -- Events

	node_added_event: EVENT_TYPE [TUPLE [tree: TAG_TREE [G]; node: TAG_TREE_NODE [G]]]
			-- Events called after a node has been added to `Current'

	node_remove_event: EVENT_TYPE [TUPLE [tree: TAG_TREE [G]; node: TAG_TREE_NODE [G]]]
			-- Events called before a node is removed from `Current'

	connection: EVENT_CHAINED_CONNECTION [TAG_TREE_OBSERVER [G], TAG_TREE [G], TAG_SERVER_OBSERVER [G], TAG_SERVER [G]]
			-- <Precursor>
		local
			l_cache: like connection_cache
		do
			l_cache := connection_cache
			if l_cache = Void then
				create l_cache.make (agent (a_observer: TAG_TREE_OBSERVER [G]): attached ARRAY [TUPLE [event: attached EVENT_TYPE [TUPLE]; action: attached PROCEDURE [ANY, TUPLE]]]
					do
						Result := <<
								[node_added_event, agent a_observer.on_node_added],
								[node_remove_event, agent a_observer.on_node_remove]
							>>
					end, server_connection)
				connection_cache := l_cache
			end
			Result := l_cache
		end

feature {NONE} -- Implementation

	find_node (a_tag: READABLE_STRING_GENERAL): TUPLE [node: TAG_TREE_NODE [G]; suffix: READABLE_STRING_GENERAL]
			-- Find node in `Current' which best approximates given tag.
			--
			-- `a_tag': Tag specifying path to where `find_node' will look for a node.
			-- `Result': Tuple containing found node, together with remaining suffix.
		require
			a_tag_attached: a_tag /= Void
			a_tag_valid: formatter.is_valid_tag (a_tag)
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
			result_suffix_valid: Result.suffix.is_empty or else formatter.is_valid_tag (Result.suffix)
			result_valid: a_tag.same_string (formatter.join_tags (Result.node.tag, Result.suffix))
			result_matches_best: not Result.suffix.is_empty implies (Result.node.is_leaf or not
				Result.node.has_child_with_token (formatter.first_token (Result.suffix)))
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
end -- class TAG_TREE


