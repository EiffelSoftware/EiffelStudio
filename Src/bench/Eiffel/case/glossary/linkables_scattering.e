indexing
	description: "Class that allows scattering classes inside clusters"
	date: "$Date$"
	revision: "$Revision$"
	author: "Pascalf"

class
	LINKABLES_SCATTERING

inherit
	ONCES

	CONSTANTS



feature -- Execute & Processes

	execute ( classes : LINKED_LIST [ CLASS_DATA ];
				clusters : LINKED_LIST [ CLUSTER_DATA ] ) is
			-- execute 
		require
			not_void : (classes/=Void and clusters/=Void ) 
		local
			is_new_cluster : BOOLEAN  -- is a cluster a new cluster added during the import process ?
			graph : GRAPH_CLUSTER -- we use this intermediar variable for being able to refresh ...
		do
--			default_width := Resources.width_for_scattering
--			if default_width<200 then
--				Windows.message(Windows.main_graph_window, "Mag", Void )
--				default_width := 200
--			end
--			if clusters.count>0 then
--					from
--						clusters.start
--					until
--						clusters.after
--					loop
--						is_new_cluster := detect_new_cluster ( clusters.item, classes )
--						if is_new_cluster then
--							process_new_cluster( clusters.item, classes )
--						else
--							process_existing_cluster ( clusters.item, classes )
--						end
--						graph := Windows.main_graph_window.draw_window.find_cluster ( clusters.item )
--						if graph/= Void then
--							-- refreshing ...
--							graph.update
--						end
--						clusters.forth
--					end
--			end
		end

	detect_new_cluster ( cl : CLUSTER_DATA ; clas : LINKED_LIST [ CLASS_DATA ] ): BOOLEAN is
		require
			glutton_cluster_consistent : cl /= Void and then cl.content/= Void and then cl.content.classes/=Void
			classes_not_nul : clas /= Void and then clas.count>0
		local
			i : INTEGER
		do
			from
				clas.start
				i:= 0
			until
				clas.after
			loop
				if clas.item.parent_cluster.name.is_equal ( cl.name ) then
					i := i+1
				end
				clas.forth
			end
			if i=cl.content.classes.count then
				Result := TRUE
			else
				Result := FALSE
			end
		end

	process_new_cluster( cl : CLUSTER_DATA; cla : LINKED_LIST [ CLASS_DATA ] )is 
	local
		index_x : INTEGER
		index_y : INTEGER
		limit_x : INTEGER
	do
		if init_y = 0 then
			-- case where process_new_cluster is not called by process_existing_cluster...
				init_y := 40
		else
				init_y := init_y + 40
		end
		limit_x := (default_width//100 ) -1
		cl.set_width ( default_width )
		from
			cla.start
			index_x := 0
			index_y := init_y
		until
			cla.after
		loop
			if cla.item.parent_cluster.name.is_equal ( cl.name ) then
				if index_x=limit_x then
					index_x := 1
					index_y := index_y + 40
				else
					index_x := index_x+1
				end
				cla.item.set_x ( (index_x*100))
				cla.item.set_y ( index_y )
			end
			cla.forth
		end
		cl.set_height ( index_y+30 )
		init_y := 0
	end

	process_existing_cluster ( cl : CLUSTER_DATA; cla : LINKED_LIST [ CLASS_DATA ] ) is
	do
		if cl.width < default_width then
			cl.set_width ( default_width )
		end 
		init_y := 0
		if cl.content/= Void then
			if cl.content.clusters/= Void and then cl.content.clusters.count>0 then
				-- this cluster contains other cluster ... humhum
				from
					cl.content.clusters.start
				until
					cl.content.clusters.after
				loop
					if (cl.content.clusters.item.y+cl.content.clusters.item.height) > init_y then
						init_y := (cl.content.clusters.item.y + cl.content.clusters.item.height)
					end
					cl.content.clusters.forth
				end		
			end
			if cl.content.classes/= Void and then cl.content.classes.count>0 then
				-- this cluster contains other classes ... that normal, this is just a banal check
				-- the added classes do not interfer with the following, since their x and y =0 ...
				from
					cl.content.classes.start
				until
					cl.content.classes.after
				loop
					if cl.content.classes.item.y > init_y then
						init_y := cl.content.classes.item.y
					end
					cl.content.classes.forth
				end
			end	
			process_new_cluster ( cl, cla )
			init_y := 0
		end
	end

feature -- Re-dispose the workareas with the different clusters ...

	process_clusters ( cl : LINKED_LIST [ CLUSTER_DATA ] ) is
		-- all the clusters of cl are new in the system, so that they need to 
		-- be judiciously located ...
		-- Note : none is root. That is important for the following ...
		-- but all are dirct child of root_cluster ...
		-- Note also that all these clusters are iconified 	
	require 
		clusters_not_void : cl/= VOid
	local
			graph : GRAPH_CLUSTER
			i,j,y : INTEGER
	do
		if cl.count>0 then
			-- we search first the y from where we start to fill
			from
				System.root_cluster.content.clusters.start
				y := 40
			until
				System.root_cluster.content.clusters.after
			loop
				if y < (System.root_cluster.content.clusters.item.y+System.root_cluster.content.clusters.item.height) then
					y := (System.root_cluster.content.clusters.item.y+System.root_cluster.content.clusters.item.height + 30)
				end
				System.root_cluster.content.clusters.forth
			end
			if System.root_cluster.content.classes/= Void and then
				System.root_cluster.content.classes.count>0 then
					from
						System.root_cluster.content.classes.start	
					until
						System.root_cluster.content.classes.after
					loop
						if y < System.root_cluster.content.classes.item.y then
							y := System.root_cluster.content.classes.item.y + 50
						end
						System.root_cluster.content.classes.forth
					end
			end	
			-- we look at the width
			if System.root_cluster.width < 400 then
				-- arbitrary, but consciouly hehehe
				System.root_cluster.set_width ( 400 )
			end
			-- now, we start to place them ...
			i := ( System.root_cluster.width//100 )	
			from
				cl.start
				j := 1
			until
				cl.after
			loop
				cl.item.set_x ( j * 100  )
				cl.item.set_y ( y  )	
				if j>i-1 then
					-- we jump one line
					j:= 1
					y := y+ 70	
				else
					j := j+1
				end	
				cl.forth
			end
			-- refreshing the area	
			System.root_cluster.set_height ( y +80 )
			--	
		end
	end	

feature -- Attributes
	
	default_width : INTEGER
			-- width by default of the clusters ...

	init_y : INTEGER
		-- height from where we start to fill the current cluster

end -- class LINKABLES_SCATTERING
