note
	description: "Objects that creates simple links, simple clusters and ellipse nodes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_FIGURE_FACTORY

inherit
	EG_FIGURE_FACTORY

	REFACTORING_HELPER

feature -- Basic operations

	new_node_figure (a_node: EG_NODE): EG_LINKABLE_FIGURE
			-- Create a node figure for `a_node'.
		do
			Result := create {MA_OBJECT_NODE}.make_with_model (a_node)
		end

	new_cluster_figure (a_cluster: EG_CLUSTER): EG_CLUSTER_FIGURE
			-- Create a cluster figure for `a_cluster'.
		do
			Result := create {EG_SIMPLE_CLUSTER}.make_with_model (a_cluster)
		end

	new_link_figure (a_link: EG_LINK): EG_LINK_FIGURE
			-- Create a link figure for `a_link'.
		do
			Result := create {MA_REFERENCE_LINK}.make_with_model (a_link)
		end

	model_from_xml (node: attached like xml_element_type): EG_ITEM
			-- Create an EG_ITEM from `node' if possible.
		do
-- TODO: implement the xml conversion.
--			node_name := node.name
--			if node_name.is_equal ("ELLIPSE_NODE") then
--				create {EG_NODE} Result
--			elseif node_name.is_equal ("EG_SIMPLE_CLUSTER") then
--				create {EG_CLUSTER} Result
--			elseif node_name.is_equal ("EG_SIMPLE_LINK") then
--				source_name := node.attribute_by_name ("SOURCE").value
--				target_name := node.attribute_by_name ("TARGET").value
--				
--				if source_name /= Void and then target_name /= Void and then world /= Void then
--					a_source := linkable_with_name (source_name)
--					if a_source /= Void then
--						a_target := linkable_with_name (target_name)
--						if a_target /= Void then
--							create {EG_LINK} Result.make_with_source_and_target (a_source, a_target)
--						end
--					end
--				end
--			end
			check implemented: False then
				to_implement (generator + ".model_from_xml: Not yet implemented!")
			end
		ensure then
			implemented: False
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
