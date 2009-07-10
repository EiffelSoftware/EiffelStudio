note
	description: "Summary description for {EC_TAG_TREE_NODE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EC_TAG_TREE_NODE_VISITOR [G -> TAG_ITEM]

inherit
	TAG_TREE_NODE_VISITOR [G]

feature {EC_TAG_TREE_NODE} -- Basic operations

	process_class_node (a_node: EC_TAG_TREE_CLASS_NODE [G])
			-- Process class node.
			--
			-- `a_node': Node to be processed.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		deferred
		end

	process_feature_node (a_node: EC_TAG_TREE_FEATURE_NODE [G])
			-- Process class node.
			--
			-- `a_node': Node to be processed.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		deferred
		end

	process_library_node (a_node: EC_TAG_TREE_LIBRARY_NODE [G])
			-- Process library node.
			--
			-- `a_node': Node to be processed.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		deferred
		end

	process_cluster_node (a_node: EC_TAG_TREE_CLUSTER_NODE [G])
			-- Process class node.
			--
			-- `a_node': Node to be processed.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		deferred
		end

	process_override_node (a_node: EC_TAG_TREE_OVERRIDE_NODE [G])
			-- Process class node.
			--
			-- `a_node': Node to be processed.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		deferred
		end

	process_directory_node (a_node: EC_TAG_TREE_DIRECTORY_NODE [G])
			-- Process class node.
			--
			-- `a_node': Node to be processed.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		deferred
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
