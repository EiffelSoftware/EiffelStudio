indexing
	description: "This class optimize the positioning of linkables"
	date: "$Date$"
	author : pascalf
	revision: "$Revision$"

class
	OPTIMIZE_CLUSTER_CONTENT

inherit
	
	EV_COMMAND

	ONCES

	CONSTANTS

creation
	make

feature -- Initialization

	make ( cl : MAIN_WINDOW; b : integer ; dw : like drawing_a) is
			-- Creation routine
		do
			clusterw := cl
			type_opti := b
			drawing_a := dw
		end

feature {NONE} -- Implementation

	type_opti : INTEGER
			-- 1 => only with y 
			-- 2 => only with x
			-- 3 => both x and y algorithm

	drawing_a : DRAWING_COMPONENT

	list_linkables : LINKED_LIST [GRAPH_LINKABLE]

	new_list : LINKED_LIST [ GRAPH_LINKABLE ]

	cluster : CLUSTER_DATA

	clusterw : MAIN_WINDOW

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
		ind : INTEGER
		err : BOOLEAN
	do
--		cluster := clusterw.entity
--		error := FALSE
--		if not err then
--			if type_opti=1 or type_opti=3 then
--				initiate_calcul
--				processing_y
--			end
--			if type_opti>1 then
--				initiate_calcul
--				processing_x
--			end
--			drawing_a.refresh_all
--		else
--	--		Windows.message (Windows.main_graph_window, "Mk", Void )
--			Windows.add_message ("Problem in the loop of execute of OPTIMIZE CLUSTER CONTENT ", 1)
--		end
--		rescue
--			err := TRUE
--			retry
	 end

	error : BOOLEAN

	This_is_the_end : BOOLEAN

feature -- calculation

	initiate_calcul is
	local
		li : LINKED_LIST [ LINKABLE_DATA ]
		cl : GRAPH_LINKABLE
	do
--		if cluster /= Void then
--			if not error then
--				!! list_linkables.make
--				!! new_list.make
--				-- initialization of the working list
--				if cluster.content/= Void then	
--				li := cluster.content.clusters	
--				from
--					li.start
--				until
--					li.after
--				loop
--					cl := drawing_a.find_linkable (li.item )
--					if cl /= Void then 
--						list_linkables.extend ( cl )
--					end
--					li.forth
--				end	
--				li := cluster.content.classes
--					from
--					li.start
--				until
--					li.after
--				loop
--					cl := drawing_a.find_linkable ( li.item )
--					if cl /= Void then
--						list_linkables.extend ( cl)
--					end
--					li.forth
--				end
--				else
--			--		Windows.message(Windows.main_graph_window,"Mk", Void )
--				end				
--			else
--			--	Windows.message(Windows.main_graph_window, "Mj", Void )
--				Windows.add_message ("initiate calcul of optimize cluster content", 1)
--			end
--		else
--		--	Windows.message(Windows.main_graph_window, "Mg", Void )
--		end
--		rescue
--			error := TRUE
--			retry
		end

	processing_y  is
	local
		tmpx,tmpy: GRAPH_LINKABLE
		yy : INTEGER
	do
		-- let's sort the clusters with their y coord.
		-- strategy "Y"
		from
			new_list.start
		until
			list_linkables.count <1
		loop	
			from
				list_linkables.start
				tmpy := list_linkables.first
			until
				list_linkables.after 
			loop
				if list_linkables.item.upper_left.y <= tmpy.upper_left.y then
					tmpy := list_linkables.item
				end
				list_linkables.forth
			end
			new_list.extend(tmpy)
			list_linkables.start
			list_linkables.prune (tmpy)
		end
		-- now, new_list has a sorted set of cluster, depending on 	
		-- their y coord.
		-- let's move them ...
		from
			new_list.start
		until
			new_list.after
		loop
			yy := look_for_maxy( new_list.item )
			draw_linkable_y ( new_list.item, yy )
			new_list.forth
		end
	end

	processing_x is
	local
		tmpx: GRAPH_LINKABLE
		xx : INTEGER
	do
		-- let's sort the clusters with their x coord.
		-- strategy "X"
		from
			new_list.wipe_out
			new_list.start
		until
			list_linkables.count <1
		loop	
			from
				list_linkables.start
				tmpx := list_linkables.first
			until
				list_linkables.after 
			loop
				if list_linkables.item.upper_left.x <= tmpx.upper_left.x then
					tmpx := list_linkables.item
				end
				list_linkables.forth
			end
			new_list.extend(tmpx)
			list_linkables.start
			list_linkables.prune (tmpx)
		end
		-- now, new_list has a sorted set of cluster, depending on 	
		-- their x coord.
		-- let's move them ...
		from
			new_list.start
		until
			new_list.after
		loop
			xx := look_for_maxx( new_list.item )
			draw_linkable_x ( new_list.item, xx )
			new_list.forth
		end
	end
		
	draw_linkable_y ( l : GRAPH_LINKABLE ; ym : INTEGER ) is
	local
		cl : GRAPH_CLUSTER
		cla : GRAPH_CLASS
		ic : GRAPH_ICON
		enlarge_cluster : ENLARGE_CLUSTER
	do
		cl ?= l
		if cl/=Void then
			--	cl.data.set_y ( ym +(cl.bottom_right.y-cl.upper_left.y)//2 + 10)
				cl.data.set_y (ym + 30)
				workareas.change_data ( cl.data )
		else
			cla ?= l
			if cla /= Void then
				cla.data.set_y ( ym +30 )
			--	cla.data.set_y (ym + ( cla.bottom_right.y - cla.upper_left.y )//2 +10)
				workareas.change_data ( cla.data)
			else
				ic ?= l
				if ic /= Void then
					ic.data.set_y ( ym + Resources.cluster_icon_y_margin )
					workareas.change_data ( ic.data )
				end
			end
		end		
	end

	draw_linkable_x ( l : GRAPH_LINKABLE ; xm : INTEGER ) is
	local
		cl : GRAPH_CLUSTER
		cla : GRAPH_CLASS
		ic : GRAPH_ICON
		enlarge_cluster : ENLARGE_CLUSTER
	do
		cl ?= l
		if cl/=Void then
			--	 cl.data.set_x ( xm +(cl.bottom_right.x - cl.upper_left.x)//2 + 10 )
				cl.data.set_x (xm + 10)
				workareas.change_data ( cl.data )
		else
			cla ?= l
			if cla /= Void then
			--	cla.data.set_x (xm + (cla.bottom_right.x-cla.upper_left.x)//2 + 10 )
				cla.data.set_x ( xm + 10) 
				workareas.change_data ( cla.data)
			else
				ic ?= l
				if ic /= Void then
					ic.data.set_y ( xm + Resources.cluster_icon_x_margin +10)
					workareas.change_data ( ic.data )
				end
			end
		end		
	end

	look_for_maxy ( g: GRAPH_LINKABLE ): INTEGER is
	local
		xmin,xmax : INTEGER  -- xmax-xmin= height of the surface
		yyy : INTEGER -- temporary y coord
		we_stop : BOOLEAN
		xiter : INTEGER

		workarea: WORKAREA
	do
		workarea := drawing_a.drawing_area

		if workarea /= Void then
			from
				xmin := g.upper_left.x-5
				xmax := g.bottom_right.x+5
				yyy := g.upper_left.y
				we_stop := FALSE
			until
				we_stop or yyy <10
			loop
				yyy := yyy -2
				from
					xiter := xmin
				until
					 ( workarea.figure_at (xiter, yyy ) /= Void and 
						g/= workarea.figure_at ( xiter,yyy) ) 
					 or xiter>xmax
				loop
					xiter := xiter + 3
				end
				if workarea.figure_at ( xiter, yyy )/= Void  then
					we_stop := TRUE
				end
			end
			Result := yyy
		end
	end

	look_for_maxx ( g: GRAPH_LINKABLE ): INTEGER is
	local
		ymin,ymax : INTEGER  -- xmax-xmin= width of the surface
		xxx : INTEGER -- temporary y coord
		we_stop : BOOLEAN
		yiter : INTEGER

		workarea: WORKAREA
	do
		workarea := drawing_a.drawing_area

		if workarea /= Void then
			from
				ymin := g.upper_left.y-5
				ymax := g.bottom_right.y+5
				xxx := g.upper_left.x
				we_stop := FALSE
			until
				we_stop or xxx <10
			loop
				xxx := xxx -2
				from
					yiter := ymin
				until
					workarea.figure_at (xxx,yiter)/= Void
						 or yiter>ymax
				loop
					yiter := yiter + 3
				end
				if workarea.figure_at ( xxx, yiter )/= Void   then
					we_stop := TRUE
				end
			end
		Result := xxx+20
		end
	end

end -- class OPTIMIZE_CLUSTER_CONTENT
