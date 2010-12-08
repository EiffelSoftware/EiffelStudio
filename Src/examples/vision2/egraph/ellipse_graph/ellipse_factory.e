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
			node_name, source_name, target_name: STRING
			a_source, a_target: detachable EG_LINKABLE
			l_attribute: detachable XML_ATTRIBUTE
		do
			node_name := node.name
			if node_name.is_equal ("ELLIPSE_NODE") then
				create {EG_NODE} Result
			elseif node_name.is_equal ("EG_SIMPLE_CLUSTER") then
				create {EG_CLUSTER} Result
			elseif node_name.is_equal ("EG_SIMPLE_LINK") then
				l_attribute := node.attribute_by_name ("SOURCE")
				check l_attribute /= Void end -- FIXME: Implied by ...?
				source_name := l_attribute.value

				l_attribute := node.attribute_by_name ("TARGET")
				check l_attribute /= Void end -- FIXME: Implied by ...?
				target_name := l_attribute.value

				if attached source_name as l_source_name and then attached target_name as l_target_name and then attached world as l_world then
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
