indexing

	description: 
		"Command executed to initiallly select an entity.";
	date: "$Date$";
	revision: "$Revision $"


class WORKAREA_SELECT_COM

inherit

	WORKAREA_COM
		rename
			make as old_make
		end
	ONCES

	CONSTANTS

creation

	make

feature {NONE} -- Initialization

	make (wk: like workarea; dis: DRAWING_AREA_COMMAND_DISPATCHER) is
			-- Make Current with workarea `wk'.
		require
			has_wk: wk /= void
			dispatcher_exists: dis /= Void
		do
			old_make (wk)
			create workarea_move_set_com.make (wk)
			create workarea_move_class_com.make (wk)
			create workarea_move_cluster_com.make (wk)
			create workarea_move_icon_com.make (wk)
			create workarea_resize_cluster_com.make (wk)
			create workarea_move_tag_com.make (wk)
			create workarea_add_handle_com.make (wk)
			create workarea_move_handle_com.make (wk)
			create workarea_set_angle_com.make (wk)	
			create workarea_resize_coin_com.make (wk)
			create workarea_move_label_com.make (wk)
			dispatcher := dis
		end

feature -- Implementation

	dispatcher: DRAWING_AREA_COMMAND_DISPATCHER
		-- Workarea command dispatcher.

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Initial selection of graphical objects processing.
		local
			btpress_data: EV_BUTTON_EVENT_DATA
			cluster: GRAPH_CLUSTER;
			relation: GRAPH_RELATION;
			clientele_relation: GRAPH_CLIENTELE;
			is_on_tag, command_set, relation_selected : BOOLEAN;
			handle, coin: INTEGER;
			rel_x, rel_y, abs_x, abs_y: INTEGER;
			ctr_pressed: BOOLEAN;
			label_data: LABEL_DATA
		do
			btpress_data ?= data
			check
				btpress_data /= void
			end
			rel_x := btpress_data.x
			rel_y := btpress_data.y
			abs_x := btpress_data.absolute_x
			abs_y := btpress_data.absolute_y
		
			if (rel_x >= workarea.width-20) and (rel_y >= workarea.height-20) then
				workarea_resize_coin_com.init (btpress_data);
				add_action (workarea_resize_coin_com)
			else
				if workarea.active_entity /= void then
					relation ?= workarea.active_entity;
					if relation = void then
						cluster ?= workarea.active_entity;
						if cluster /= Void then
							coin := cluster.handle_at (rel_x, rel_y);
							if coin = 0 then
								is_on_tag := cluster.is_on_tag (rel_x, rel_y)
							end
						end;
						if cluster = void or (coin = 0 and (not is_on_tag)) then
							move_figures (btpress_data)
						else
							if is_on_tag then
								workarea_move_tag_com.init (btpress_data);
								workarea_move_tag_com.set_cluster (cluster);
								add_action (workarea_move_tag_com)
							else
								workarea_resize_cluster_com.init (btpress_data);
								workarea_resize_cluster_com.set_cluster (cluster, coin);
								add_action (workarea_resize_cluster_com)
							end
						end
					else
						clientele_relation ?= relation;
						if relation.are_active_triangles_shown then
							if relation.active_triangles.item 
								(1).contains_xy (rel_x, rel_y)
							then
								command_set := True;
								workarea_set_angle_com.set_arrow (1);
								relation.active_triangles.item (1).select_it
							elseif relation.active_triangles.item 
								(2).contains_xy (rel_x, rel_y)
							then
								command_set := True;
								workarea_set_angle_com.set_arrow (2);
								relation.active_triangles.item (2).select_it
							end;
							if command_set then
								workarea_set_angle_com.set_relation (relation);
								add_action (workarea_set_angle_com)
							end
						elseif clientele_relation /= Void then
							if not clientele_relation.data.is_reflexive then
								label_data := clientele_relation.label_at (rel_x, rel_y)	
								if label_data /= Void then
									command_set := True;
									workarea_move_label_com.init (btpress_data);
									workarea_move_label_com.set_relation
										(clientele_relation, 
										label_data =
											clientele_relation.data.reverse_label);
									add_action (workarea_move_label_com)
								end
							end;
						end;
						command_set := command_set or else 
										(clientele_relation /= Void and then
										clientele_relation.data.is_reflexive);
						if not command_set then
							handle := relation.handle_at (rel_x, rel_y);
							if handle = 0 then
								handle := relation.segment_at (rel_x, rel_y);
								if handle /= 0 then
								
									workarea_add_handle_com.init (btpress_data);
									workarea_add_handle_com.set_relation
										(relation, handle);
									add_action (workarea_add_handle_com)
								end
							else
								workarea_move_handle_com.init (btpress_data);
								workarea_move_handle_com.set_handle 
									(relation.data.break_points.i_th (handle));
								add_action (workarea_move_handle_com)
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	move_figures (btpress_data: EV_BUTTON_EVENT_DATA) is
			-- Move figures.
		require
			has_button_press_data: btpress_data /= void;
		local
			graph_class: GRAPH_CLASS;
			graph_cluster: GRAPH_CLUSTER;
			graph_icon: GRAPH_ICON;
			entity: GRAPH_FORM
		do
			entity := workarea.active_entity;
			if (entity /= Void and then not entity.selected) or else
				workarea.selected_figures.count = 1 
			then
				graph_class ?= entity;
				graph_cluster ?= entity;
				graph_icon ?= entity;
				if graph_class /= Void then
					workarea_move_class_com.init (btpress_data);
					workarea_move_class_com.set_data (graph_class);
					add_action (workarea_move_class_com)
				elseif graph_cluster /= Void then
					workarea_move_cluster_com.init (btpress_data);
					workarea_move_cluster_com.set_data (graph_cluster);
					add_action (workarea_move_cluster_com)
				elseif graph_icon /= Void then
					workarea_move_icon_com.init (btpress_data);
					workarea_move_icon_com.set_data (graph_icon);
					add_action (workarea_move_icon_com)
			end
			else
				workarea_move_set_com.init (btpress_data);
				workarea_move_set_com.set_data
					(workarea.selected_figures.duplicate);
				add_action (workarea_move_set_com)
			end
		end;

	add_action (command: MOVE_COM) is
			-- graphically commit the action.
		require
			command_exists: command /= Void
			dispatcher_exists: dispatcher /= Void
		local
			drawing_area: EC_DRAWING_AREA
		do
			if workarea /= Void then
				drawing_area := workarea.drawing_area

				if drawing_area /= Void then
					-- When button_motion event available
					dispatcher.initialize_motion(command)
				end
			end
		end

feature {NONE} -- Command properties

	workarea_move_set_com: WORKAREA_MOVE_SET_COM

	workarea_move_class_com: WORKAREA_MOVE_DATUM_COM

	workarea_move_cluster_com: WORKAREA_MOVE_CLUSTER_COM

	workarea_move_icon_com: WORKAREA_MOVE_DATUM_COM

	workarea_resize_cluster_com: WORKAREA_RESIZE_CLUSTER_COM

	workarea_move_tag_com: WORKAREA_MOVE_TAG_COM

	workarea_add_handle_com: WORKAREA_ADD_HANDLE_COM

	workarea_move_handle_com: WORKAREA_MOVE_HANDLE_COM

	workarea_set_angle_com: WORKAREA_SET_ANGLE_COM

	workarea_resize_coin_com: WORKAREA_RESIZE_COIN_COM

	workarea_move_label_com: WORKAREA_MOVE_LABEL_COM

invariant

	has_move_set_command:		workarea_move_set_com /= void;
	has_move_class_command:		workarea_move_class_com /= void;
	has_move_cluster_command:		workarea_move_cluster_com /= void;
	has_move_icon_command:		workarea_move_icon_com /= void;
	has_resize_cluster_command:	workarea_resize_cluster_com /= void;
	has_move_tag_command:		workarea_move_tag_com /= void;
	has_add_handle_command:		workarea_add_handle_com /= void;
	has_move_handle_command:		workarea_move_handle_com /= void;
	has_set_angle_command:		workarea_set_angle_com /= void

end -- class WORKAREA_SELECT_COM
