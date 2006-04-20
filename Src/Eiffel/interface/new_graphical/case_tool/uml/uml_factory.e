indexing
	description: "Objects that creates uml figures for models."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UML_FACTORY

inherit
	EIFFEL_FACTORY

feature -- Basic operations

	new_class_figure (a_node: EG_NODE): EG_LINKABLE_FIGURE is
			-- Create a node figure for `a_node'.
		local
			ec: ES_CLASS
		do
			ec ?= a_node
			if ec /= Void then
				Result := create {UML_CLASS_FIGURE}.make_with_model (ec)
				if not ec.is_needed_on_diagram then
					Result.hide
					Result.disable_sensitive
				end
			else
				Result := create {EG_SIMPLE_NODE}.make_with_model (a_node)
			end
		end
		
	new_cluster_figure (a_cluster: EG_CLUSTER): EG_CLUSTER_FIGURE is
			-- Create a cluster figure for `a_cluster'.
		local
			ec: ES_CLUSTER
		do
			ec ?= a_cluster
			if ec /= Void then
				Result := create {UML_CLUSTER_FIGURE}.make_with_model (ec)
				if not ec.is_needed_on_diagram then
					Result.hide
					Result.disable_sensitive
				end
			else
				Result := create {EG_SIMPLE_CLUSTER}.make_with_model (a_cluster)
			end
		end
		
	new_link_figure (a_link: EG_LINK): EG_LINK_FIGURE is
			-- Create a link figure for `a_link'.
		local
			eih: ES_INHERITANCE_LINK
			ecs: ES_CLIENT_SUPPLIER_LINK
		do
			eih ?= a_link
			if eih /= Void then
				Result := new_inheritance_figure (eih)
				if not eih.is_needed_on_diagram then
					Result.hide
					Result.disable_sensitive
				end
			else
				ecs ?= a_link
				if ecs /= Void then
					Result := new_client_supplier_figure (ecs)
					if not ecs.is_needed_on_diagram then
						Result.hide
						Result.disable_sensitive
					end
				else
					Result := create {EG_SIMPLE_LINK}.make_with_model (a_link)
				end
			end
		end

feature {NONE} -- Implementation
		
	new_inheritance_figure (eih: ES_INHERITANCE_LINK): UML_INHERITANCE_FIGURE is
			-- Create an inheritance figure.
		require
			eih_not_void: eih /= Void
		do
			create Result.make_with_model (eih)
		ensure
			result_not_void: Result /= Void
		end
		
	new_client_supplier_figure (ecs: ES_CLIENT_SUPPLIER_LINK): UML_CLIENT_SUPPLIER_FIGURE is
			-- Create a client supplier figure.
		require
			ecs_not_void: ecs /= Void
		do
			create Result.make_with_model (ecs)
		ensure
			result_not_void: Result /= Void
		end
		
	xml_class_figure_node_name: STRING is "UML_CLASS_FIGURE"
			-- Name of xml nodes describing class figures.
		
	xml_cluster_figure_node_name: STRING is "UML_CLUSTER_FIGURE"
			-- Name of xml nodes describing cluster figures.
			
	xml_client_supplier_figure_node_name: STRING is "UML_CLIENT_SUPPLIER_FIGURE"
			-- Name of xml nodes describing client supplier links.
		
	xml_inheritance_figure_node_name: STRING is "UML_INHERITANCE_FIGURE";
			-- Name of xml nodes describing inheritance links.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class UML_FACTORY
