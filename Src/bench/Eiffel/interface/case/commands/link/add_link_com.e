indexing

	description: "Abstract notion of link's creation action.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ADD_LINK_COM 

inherit

	ONCES

	EC_COMMAND
	
feature {NONE} -- Implementation

	is_clientelism : BOOLEAN is deferred end

	new_client_u : ADD_CLIENT_U

feature
	-- building

	build_link (workarea: WORKAREA; 
			first_entity, second_entity: LINKABLE_DATA) is
			-- Build a link in `workarea' with source
			-- `first_entity' and destination `second_entity'.
		require
			workarea_exists: not (workarea = Void);
			first_entity_exists: not (first_entity = Void);
			second_entity_exists: not (second_entity = Void)
		deferred
		end; -- build_link

straight_link ( l1 : LINKABLE_DATA ; l2 : LINKABLE_DATA; 
				new_link : RELATION_DATA) is
		local
			remove_handles: REMOVE_HANDLES_U
			handx,handy : INTEGER -- coordinate of the new handle ...
			err : BOOLEAN
			hand : HANDLE_DATA
			move_handle_undoable: MOVE_HANDLE_U;
			n1,n2 : BOOLEAN
			xmin,xmax,ymin,ymax : INTEGER
			add_hand :ADD_HANDLE_U
			gr : GRAPH_CLASS
		do
--			if not err then 
--				if l1.parent_cluster=l2.parent_cluster then
--					-- we start by removing all the handles ...
--				--	!! remove_handles.make (new_link)
--					n1 := ( l1.x> l2.x )
--					n2 := ( l1.y> l2.y )
--					if n1 then 
--							xmax := l1.x
--							xmin := l2.x
--					else 
--							xmin := l1.x
--							xmax := l2.x
--					end
--					if n2 then 
--							ymax := l1.y
--							ymin := l2.y
--					else
--							ymin := l1.y
--							ymax := l2.y
--					end
--					if (n1 and not is_clientelism) or
--						( not n1 and is_clientelism) then
--					-- right algo
--						handx := xmin
--						if (n1 and not n2) or (not n1 and n2) then
--							handy := ymin
--						else
--							handy := ymax
--						end
--					else
					-- left algo
--						handx := xmax
--						if (n2 and not n1) or (not n2 and n1 ) then
--							handy := ymax
--						else
--							handy := ymin
--						end
--					end
--					if (l2.x/=l1.x) or (l2.y/=l1.y)  then
--						-- x1/=x2 or y1/=y2
--					if proc/= Void then
--						gr?=proc.workarea.figure_at (handx,handy )
--						-- proc.workarea.figure_at (handx,handy )= Void then
--						-- it avoids to have an handles within a graph figure
--						if gr=Void then
--							!! hand
--							hand.set_x ( handx )
--							hand.set_y ( handy )
--							hand.put_in_cluster (l1.parent_cluster )
--							!! add_hand.make_str ( new_link ,hand)
--							end
--						end
--					end
--					workareas.refresh
--				end
--			else
--				-- link cross different clusters
--				Windows.message(Windows.main_graph_window, "Mn", Void )
--			end
--			rescue
--				err := TRUE
----				Windows.add_message ("straight of add_link_com failed...",1)
--				retry
		end


feature -- Execution

	execute (args: EV_ARGUMENT2 [WORKAREA, WORKAREA]; data: EV_EVENT_DATA) is
			-- Execution creation of link.
		local
			first_fig, second_fig: GRAPH_LINKABLE;
			first_entity, second_entity: LINKABLE_DATA;
			x_coord, y_coord: INTEGER
			cluster_data: CLUSTER_DATA
			temp,temp2 : CLASS_DATA	
--			nw:new_window;
			inter:inter_new_window;
			temp3: ADD_CLI_SUP_COM

			to_wa: WORKAREA
			from_wa: WORKAREA
				
			context_data: EV_BUTTON_EVENT_DATA
		do

			--Windows.popdown_error_window;
			from_wa := args.first
			to_wa := args.second
			first_entity ?= from_wa.active_entity_data;
			if first_entity /= void then
				context_data ?= data
				if context_data /= Void then
					--x_coord := context_data.absolute_x - context_data.x
					--y_coord := context_data.absolute_y - context_data.y
					x_coord := context_data.x
					y_coord := context_data.y
					second_fig ?= to_wa.figure_at (x_coord,y_coord);
					if (second_fig /= void) then
						second_entity := second_fig.data;
						temp ?= first_entity;
       	         			temp2 ?= second_entity;
						if (temp /= Void)  
						        and (temp.parent_cluster.name.is_equal( second_entity.name)) 
						then	
							proc.process_any(stone_tmp)
						else	
							build_link (to_wa, first_entity, second_entity)		
						end
					else
						cluster_data ?= first_entity;
						if cluster_data /= Void then
							to_wa.analysis_window.set_entity (cluster_data)
						else
							-- case of drag and drop in nothing
							proc.process_any(stone_tmp)
						end
					end;
				end
			end
			context_data := void
		end 

stone_tmp : STONE

proc : PROCESS_WORKAREA_STONE

set_special ( s: STONE; p : PROCESS_WORKAREA_STONE ) is
do
	stone_tmp := s
	proc := p
end

end -- class ADD_LINK_COM
