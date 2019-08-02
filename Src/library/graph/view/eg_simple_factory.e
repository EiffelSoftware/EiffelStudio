note
	description: "Factory for the simple figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SIMPLE_FACTORY

inherit
	EG_FIGURE_FACTORY

feature -- Basic operations

	new_node_figure (a_node: EG_NODE): EG_LINKABLE_FIGURE
			-- Create a node figure for `a_node'.
		do
			Result := create {EG_SIMPLE_NODE}.make_with_model (a_node)
		end

	new_cluster_figure (a_cluster: EG_CLUSTER): EG_CLUSTER_FIGURE
			-- Create a cluster figure for `a_cluster'.
		do
			Result := create {EG_SIMPLE_CLUSTER}.make_with_model (a_cluster)
		end

	new_link_figure (a_link: EG_LINK): EG_LINK_FIGURE
			-- Create a link figure for `a_link'.
		do
			Result := create {EG_SIMPLE_LINK}.make_with_model (a_link)
		end

	model_from_xml (node: like xml_element_type): detachable EG_ITEM
			-- Create an EG_ITEM from `node' if possible.
		local
			node_name: READABLE_STRING_32
		do
			node_name := node.name
			if node_name = Void then
				check has_name: False end
			elseif node_name.same_string_general ("EG_SIMPLE_NODE") then
				create {EG_NODE} Result
			elseif node_name.same_string_general ("EG_SIMPLE_CLUSTER") then
				create {EG_CLUSTER} Result
			elseif node_name.same_string_general ("EG_SIMPLE_LINK") then
				if
					attached node.attribute_by_name ("SOURCE") as l_source_attrib and then
					attached node.attribute_by_name ("TARGET") as l_target_attrib and then
					world /= Void and then
					attached linkable_with_name (l_source_attrib.value) as l_source and then
					attached linkable_with_name (l_target_attrib.value) as l_target
				then
					create {EG_LINK} Result.make_with_source_and_target (l_source, l_target)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
