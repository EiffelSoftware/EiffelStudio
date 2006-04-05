indexing
	description: "translation of an element of list1 to list2"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	ADD_CLUSTER_REVERSE

inherit
	CASE_COMMAND

create
	make

feature	-- Execution

	execute (a : ANY) is
			-- role : pass an element from one list to the other
			-- also : if the cluster has some sub-clusters, 
			-- deals with it thanks to loop_for_clusters ...
		local
			list: LINKED_LIST [SCROLLABLE_LIST_ELEMENT]
			item: SCROLLABLE_LIST_CLUSTERS
		do
			list ?= scroll1.selected_items
			if list /= Void then
				from
					list.start
				until
					list.after
				loop
					item ?= list.item
					check
						valid_item: item /= Void
					end
					scroll1.start
					scroll1.search (item)
					if not scroll1.exhausted then
							-- Item selected has been removed,
							-- because it was a subcluster of one of the
							-- last selected items.
						move (item)
					end
					list.forth
				end
			end 
		end

feature {NONE} -- Implementation

	loop_for_clusters (cl : ARRAYED_LIST [CLUSTER_I]) is
			-- Search the clusters to insert or to remove ...
		local
			e : SCROLLABLE_LIST_CLUSTERS
		do
			from 
				cl.start
			until
				cl.after
			loop
				if way then
					if scroll1.count > 0 then
						from 
							scroll1.start
						until
							scroll1.after or
							scroll1.count =0
							or scroll1.index > scroll1.count -- necessary : bug of vision ...
						loop
							--from list1 to list2
							if scroll1.item.value.is_equal(cl.item.cluster_name) then
								scroll1.remove
							end
							test_if_belong_to_scroll2(cl.item.cluster_name)
							scroll1.forth
						end
					end
				else 
						-- form list2 to list1
						create e.make (cl.item)
						scroll2.extend(e)
				end
				if cl.item.sub_clusters /= Void and then 
					cl.item.sub_clusters.count >0 then
						loop_for_clusters (cl.item.sub_clusters)
				end
				cl.forth
			end
		end
	
	test_if_belong_to_scroll2 (s : STRING) is
		local
			Resul : BOOLEAN
		do
			from 
				scroll2.start
			until
				scroll2.after
				or Resul= TRUE
			loop
				if scroll2.item.value.is_equal(s) then
					scroll2.remove 
					Resul := TRUE
				end	
				scroll2.forth
			end
		end

	move (item: SCROLLABLE_LIST_CLUSTERS) is
			-- role : pass an element from one list to the other
			-- also : if the cluster has some sub-clusters, 
			-- deals with it thanks to loop_for_clusters ...
		local
			cluster : CLUSTER_I
		do
			scroll2.extend(item)
			cluster := item.cluster 
			scroll1.start
			scroll1.search (item)
			scroll1.remove
			if cluster.sub_clusters /= Void  and then
				cluster.sub_clusters.count >0 then
				loop_for_clusters (cluster.sub_clusters)
			end
		end

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

end -- class ADD_CLUSTER_REVERSE
