indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_COMPONENT_PAGE
inherit
	EDITOR_WINDOW_PAGE
		rename 
			make as make_editor
		end

	ONCES

creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY; s: like system_window) is
			-- Initialize
		do
			make_editor ( noteb, ent)
			notebook.append_page(page, "Components")
			--!! area.make(page)
			--update_from(system.root_cluster,1,10000)
			--area.set_text(text.image)

			system_window := s

			!! tree.make (page, system_window)
			tree.update_from (system.root_cluster)
		end

feature {NONE} -- Implementation 

	system_window: EC_SYSTEM_WINDOW

	area: EV_TEXT

	last_displayed_data: LINKABLE_DATA
			-- last class or cluster displayed
			--| Used to optimize `display_current_page'.
	
	total_number_of_elements: INTEGER;
			-- Number of components

	index: INTEGER

	tree: TREE_COMPONENT

feature -- Access

	update is 
		-- Update Current list
		do 
			update_from(System.root_cluster,1,10000)
		end

	reset, do_page is do end

	update_from(cluster: CLUSTER_DATA;first,last: INTEGER) is
			-- Update page
		local
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_DATA]
			sorted_cluster_list: SORTED_TWO_WAY_LIST [CLUSTER_DATA];
			classes: CLASS_LIST
			clusters: CLUSTER_LIST
		do
			-- Iteratively process the cluster's classes:	
			-- build the sorted list of this cluster's modified classes:
			from
				!! sorted_classes.make;
				classes := cluster.classes;
				classes.start
			until
				classes.after
			loop
				sorted_classes.put_front (classes.item) 
				classes.forth
			end
			sorted_classes.sort
			index := index + 1 
	
			if (sorted_classes.count + index) < first then
					-- not yet reached the first element to display
				index := index + sorted_classes.count
			else
					-- we display these elements
				text.new_line
				if (index <= 1) then
							-- we just begun displaying in the page
					if index = first then
						sorted_classes.start
					else
						sorted_classes.go_i_th (first - index)
						index := first
					end
							-- display the cluster
					text.append_stone(cluster.name,cluster)
				else
					text.append_stone(cluster.name,cluster)
					last_displayed_data := cluster 
					sorted_classes.start
				end

					-- display the classes' names themselves:	
				if not sorted_classes.empty then
					from
						text.indent
					until
						sorted_classes.after or else index > last
					loop
						text.new_line
						text.append_stone(sorted_classes.item.name,sorted_classes.item)
						last_displayed_data := sorted_classes.item 
						index := index + 1 --| may be improved
						sorted_classes.forth		
					end -- loop
					if sorted_classes.after then	
						text.exdent; 
					end
				end
			end 

					-- Recursively process the cluster's sub-clusters:
	
			if index <= last then
					-- Still displaying 	
				clusters := cluster.clusters
	
					--| Loop that's cheaper than using SORTED_TWO_WAY_LIST 
					--| features (!)...
				from
					!! sorted_cluster_list.make;
					clusters.start
				until
					clusters.after
				loop
						--| Cheap (unsorted) insertion
					sorted_cluster_list.put_front (clusters.item) 
					clusters.forth
				end
					--| Relatively cheap sort:
				sorted_cluster_list.sort

				text.indent; 
				from
					sorted_cluster_list.start
				until
					sorted_cluster_list.after or else index > last
				loop
					update_from (sorted_cluster_list.item, first, last)
					sorted_cluster_list.forth
				end;
				text.exdent
			end; -- if index
		end  

end -- class SYSTEM_COMPONENT_PAGE
