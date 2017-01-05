note
	description: "Objects that creates simple links, simple clusters and ellipse nodes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ELLIPSE_FACTORY

inherit
	EG_FIGURE_FACTORY

feature -- Basic operations

	new_node_figure (a_node: EG_NODE): EG_LINKABLE_FIGURE
			-- Create a node figure for `a_node'.
		do
			Result := create {ELLIPSE_NODE}.make_with_model (a_node)
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

	model_from_xml (node: XML_ELEMENT): detachable EG_ITEM
			-- Create an EG_ITEM from `node' if possible.
		local
			l_node_name, l_source_name, l_target_name: STRING
			a_source, a_target: detachable EG_LINKABLE
		do
			l_node_name := node.name
			if l_node_name.is_equal ("ELLIPSE_NODE") then
				create {EG_NODE} Result
			elseif l_node_name.is_equal ("EG_SIMPLE_CLUSTER") then
				create {EG_CLUSTER} Result
			elseif l_node_name.is_equal ("EG_SIMPLE_LINK") then
				if attached node.attribute_by_name ("SOURCE") as l_attribute then
					l_source_name := l_attribute.value
				end
				if attached node.attribute_by_name ("TARGET") as l_attribute then
					l_target_name := l_attribute.value
				end
				if
					l_source_name /= Void and then l_target_name /= Void and then
					attached world as l_world
				then
					a_source := linkable_with_name (l_source_name)
					if attached a_source as l_source then
						a_target := linkable_with_name (l_target_name)
						if attached a_target as l_target then
							create {EG_LINK} Result.make_with_source_and_target (l_source, l_target)
						end
					end
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ELLIPSE_FACTORY
