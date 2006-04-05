indexing
	description: "Objects that is a graph model for a given cluster_i"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLUSTER

inherit
	EM_CLUSTER
	
	ES_ITEM
		undefine
			default_create
		end
		
	SHARED_WORKBENCH
		undefine
			default_create
		end

create
	make
	
feature {NONE} -- Implementation

	make (a_cluster_i: like cluster_i) is
			-- Create an ES_CLUSTER from `cluster_i'.
		require
			a_cluster_i_not_void: a_cluster_i /= Void
		do
			cluster_i := a_cluster_i
			make_with_name (cluster_i.cluster_name)
			is_needed_on_diagram := True
		end
		
feature -- Access

	cluster_i: CLUSTER_I
			-- cluster_i `Current' is model for.
	
	needed_links: LIST [ES_ITEM] is
			-- `links' that are EIFFEL_ITEMS and are needed_on_diagram.
		local
			l_links: like internal_links
			l_item: ES_ITEM
		do
			l_links := internal_links
			create {ARRAYED_LIST [ES_ITEM]} Result.make (l_links.count)
			from
				l_links.start
			until
				l_links.after
			loop
				l_item ?= l_links.item
				if l_item /= Void and then l_item.is_needed_on_diagram then
					Result.extend (l_item)
				end
				l_links.forth
			end
		end
		
	needed_linkables: LIST [ES_ITEM] is
			-- `linkables' that are EIFFEL_ITEMS and are needed_on_diagram.
		local
			l_linkables: like linkables
			l_item: ES_ITEM
		do
			l_linkables := linkables
			create {ARRAYED_LIST [ES_ITEM]} Result.make (l_linkables.count)
			from
				l_linkables.start
			until
				l_linkables.after
			loop
				l_item ?= l_linkables.item
				if l_item /= Void and then l_item.is_needed_on_diagram then
					Result.extend (l_item)
				end
				l_linkables.forth
			end
		end
		
feature -- Element change
		
	synchronize is
			-- Some properties may have changed due to recompilation.
			-- | retrive new cluster_i.
		do
			cluster_i := universe.cluster_of_name (cluster_i.cluster_name)
			if cluster_i = Void then
				graph.remove_all (Current)
			end
		end

invariant
	cluster_i_not_void: cluster_i /= Void
	
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

end -- class ES_CLUSTER
