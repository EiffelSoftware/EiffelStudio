indexing

	description: "Resizing When an Entity is added";
	date: "$Date$";
	revision: "$Revision$"

class AUTOMATIC_RESIZE_COM 

inherit
	EV_COMMAND
	--MENU_SELEC
	ONCES

feature -- 
	
	right_max,bottom_max: INTEGER 

feature

	process_workarea ( w: WORKAREA) is
	require
		workarea_not_void : w/= Void
	local
		gc: GRAPH_LIST[GRAPH_CLASS]
		gcl: GRAPH_LIST[GRAPH_CLUSTER]
		gi: GRAPH_LIST[GRAPH_ICON]
	do
		if w.data/= Void then 
			-- protection
		gc := w.class_list
		gcl := w.cluster_list
		gi := w.icon_list
		

		-- deals with the icons
		if gi/=Void then
		from
			gi.start
		until
			gi.after
		loop
			if gi.item.local_x > (right_max -100) 
				then right_max := gi.item.local_x + 100 
			end 		
		    	if gi.item.local_y > (bottom_max - 100 )	
				then bottom_max := gi.item.local_y + 100
			end
			gi.forth
		end
		end
		
		-- deals with the classes
		if gc/= Void then
		from
			gc.start
		until
			gc.after
		loop
			if gc.item.local_x > (right_max -100) 
				then right_max := gc.item.local_x + 100 
			end 		
		    	if gc.item.local_y > (bottom_max - 100 )	
				then bottom_max := gc.item.local_y + 100
			end
			gc.forth
		end
		end

		-- deals with the clusters
		if gcl/= Void then
		from
			gcl.start	
		until
			gcl.after
		loop
			if (gcl.item.local_x + gcl.item.data.width) > right_max
				then right_max := (gcl.item.local_x + gcl.item.data.width)+ 100
			end
			if (gcl.item.local_y + gcl.item.data.height ) > bottom_max
				then bottom_max := (gcl.item.local_y + gcl.item.data.height) + 100
			end
			gcl.forth		
		end
		end
		if w.data.is_root then
			-- we do not want to deal with the other clusters than the root one.
			-- reason : we may overlap other clusters by doing the following.
			-- we may imagine in the future searching the limit of enlargement 
			-- without overlapping the other clusters with a process similar to
			-- "Gather Entities".
			if w.analysis_window.width>right_max then
				right_max := w.analysis_window.width
			end
			if w.analysis_window.height>bottom_max then
				bottom_max := w.analysis_window.height
			end
		end
		w.data.set_height (bottom_max )
		w.data.set_width ( right_max ) 
	--	w.set_size (right_max, bottom_max)
		w.refresh_all
		end
		
	end
	
	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local	
			w: WORKAREAS_L
		do
			w := workareas
			right_max :=0
			bottom_max := 0
			from 
				w.start	
		    until
				w.after
			loop	
				process_workarea(w.item)
				w.forth
			end
	end

end
