indexing
	description: "translation of an element of list1 to list2";
	date: "$Date$";
	revision: "$Revision$"

class 
	ADD_CLUSTER_REVERSE
inherit
	CASE_COMMAND
creation
	make

feature	
	
	loop_for_clusters ( cl : ARRAYED_LIST [CLUSTER_I] ) is
		-- search the clusters to insert or to remove ...
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
					!! e.make ( cl.item )
					scroll2.extend(e)
			end
			if cl.item.sub_clusters /= Void and then 
				cl.item.sub_clusters.count >0 then
					loop_for_clusters ( cl.item.sub_clusters )
			end
			cl.forth
		end
	end

	test_if_belong_to_scroll2 ( s : STRING ) is
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
	execute ( a : ANY ) is
		-- role : pass an element from one list to the other
		-- also : if the cluster has some sub-clusters, 
		-- deals with it thanks to loop_for_clusters ...
	local
		ind : INTEGER
		cluster : CLUSTER_I
		e, el : SCROLLABLE_LIST_CLUSTERS
	do
		if scroll1.selected_item /= Void then
			e ?= scroll1.selected_item
			el := e		
			scroll2.extend(el)
			cluster := el.cluster 
			ind := scroll1.selected_position
			scroll1.go_i_th(ind)
			scroll1.remove
			if cluster.sub_clusters/= Void  and then
				cluster.sub_clusters.count >0 then
				loop_for_clusters ( cluster.sub_clusters )
			end
		end 
	end

end -- class ADD_CLUSTER_REVERSE
