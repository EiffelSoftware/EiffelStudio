indexing
						
	description: 
		"Command that processes the stones dropped in the %
		%workarea, according to their type.";
	date: "$Date$";
	revision: "$Revision $"

class 
	PROCESS_WORKAREA_STONE

inherit
	WORKAREA_COMMAND
		rename
			make as wa_com_make
		undefine
			compatible, stone_type, process_new_class, process_new_cluster,
			process_class, process_cluster, process_color, process_relation,
			process_any
		end;

	WORKAREA_COMMAND
		redefine
			compatible, stone_type, process_new_class, process_new_cluster,
			process_class, process_cluster, process_color, process_relation, 
			process_any,make
		select
			make
		end;

creation

	make

feature {NONE} -- Initialization

	make (wa: like workarea) is
			-- Create Current command and associate it to workarea `wa'
		do
			wa_com_make (wa)
			analysis_window := wa.analysis_window
			!! add_inh_com
			!! add_cli_sup_com
			!! add_aggreg_com
			--!! main_panel_hole_com
		ensure then
			analysis_window_exists: analysis_window /= Void
		end

feature -- Status report    

	compatible (st: STONE): BOOLEAN is
			-- Is dropped stone compatible with Current command
			-- associated hole?	
		do
			Result := True
			--Result := (st.stone_type = Stone_types.new_cluster_type or else
			--	st.stone_type = Stone_types.new_class_type or else
			--	st.stone_type = Stone_types.class_type or else
			--	st.stone_type = Stone_types.color_type or else
			--	st.stone_type = Stone_types.relation_type or else
			--	st.stone_type = Stone_types.cluster_type)
		end;

	stone_type: INTEGER is 
			-- Stone type of hole associated to Current command.
		do 
			Result := Stone_types.void_type
			--Result := Stone_types.any_type
		end;

feature -- Status setting

	set_aggreg_link_command is
			-- Set the command to add a new link 
			-- to the command that adds an aggregation link
		do
			add_link_com := add_aggreg_com
		end

	set_cli_sup_link_command is
			-- Set the command to add a new link 
			-- to the command that adds a client-supplier link
		do
			add_link_com := add_cli_sup_com
		end

	set_inherit_link_command is
			-- Set the command to add a	new link 
			-- to the command that adds an inheritance link
		do
			add_link_com := add_inh_com
		end

feature -- Execution

	process_class (class_stone: CLASS_STONE) is
			-- Retarget the workarea to the cluster that contains the
			-- class corresponding to `class_stone', highlight this
			-- class and modify the scrollbars to have it visible.
		local
			graph_class,gc: GRAPH_CLASS;
				--| locals used to speed up accesses:
			activ_ent: GRAPH_FORM
			to_wa, from_wa: like workarea 
			fig : GRAPH_LINKABLE
			tmp : CLASS_DATA
			flo_menu_command : FLO_MENU_COMMAND

			arg: EV_ARGUMENT2 [WORKAREA, WORKAREA]
		do
			from_wa := system.workarea_picked
			to_wa := workarea;
			if from_wa /= Void and to_wa /= Void then
				if to_wa.data /= Void then
					if (to_wa.active_entity /= Void) then
						activ_ent := to_wa.active_entity
					else
						activ_ent := from_wa.active_entity;
					end
					if (activ_ent = Void) then
						if not class_stone.data.is_hidden then
							--Windows.set_watch_cursor;
							graph_class := to_wa.find_class (class_stone.data);
							if graph_class = Void then
								to_wa.set_cluster_without_update (class_stone.data.parent_cluster);
								graph_class := to_wa.find_class (class_stone.data);
							end;
							to_wa.highlight_linkable (graph_class);
							--Windows.restore_cursor;
						else
							windows_manager.popup_error ("E4", Void, analysis_window);
						end;
					else
							-- Stone comes from another workarea
					--	add_link_com.set_context_data (to_wa.button_data)
						add_link_com.set_special(class_stone, Current);
					--	add_link_com.execute (<< from_wa, to_wa >>); 
						!! arg.make (from_wa, to_wa)
						add_link_com.execute (arg, pnd_data); 
					end;
				else
					-- Stone comes from within the same workarea
					-- pascalf, for the flotting menus
					
					fig ?= to_wa.figure_at (pnd_data.absolute_x - pnd_data.x, pnd_data.absolute_y - pnd_data.y)
					if fig /= Void then 
						tmp ?= fig.data
					end
					if tmp /= Void and then class_stone.data /= Void and then tmp.name.is_equal(class_stone.data.name) then
						!! flo_menu_command.make
					--	Windows.menu_window.set_coord(to_wa.button_data.absolute_x,
					--				to_wa.button_data.absolute_y )
					--	Windows.menu_window.set_stone ( class_stone )
						flo_menu_command.execute(Void, Void)
					else
				--		add_link_com.set_context_data (to_wa.button_data);
						add_link_com.set_special( class_stone, Current )
						--add_link_com.execute (<< to_wa, to_wa >>);					
						!! arg.make (from_wa, to_wa)
						add_link_com.execute (arg, pnd_data)
					end
				end; 
			end;
		end

	process_cluster (cluster_st: CLUSTER_STONE) is
			-- Retarget the workarea to the cluster corresponding to 
			-- `cluster_stone', highlight this cluster and modify the 
			-- scrollbars to have it visible.
		local
				--| local to speed up access:
			to_wa, from_wa: like workarea
		do
			to_wa := workarea
			if (to_wa.active_entity /= Void) then
				-- Stone comes from within the same workarea
			--	add_link_com.set_context_data (to_wa.button_data);
			--	add_link_com.execute (<< to_wa, to_wa >>) 
				analysis_window.set_entity ( cluster_st.data )
			else
				-- Stone comes from another workarea
				if (to_wa.data /= cluster_st.data) then
					analysis_window.set_entity (cluster_st.data)
				end;
			end
			to_wa.update_lists
		end;

	process_color (color_stone: COLOR_STONE) is
			-- Change the color of the object on which `color_stone'
			-- was dropped to the color associatted to `color_stone'.
			-- No effect if stone dropped on the workarea's background
		local
			change_color: CHANGE_COLOR_U;
			figure: GRAPH_FORM;
			col_list: LINKED_LIST [COLORABLE];
			colorable: COLORABLE;
				--| locals to speed up access:
			wa: like workarea;
			sel_fig: GRAPH_LIST [GRAPH_FORM];
		do
			wa := workarea;
			if wa.data /= Void then
			--	figure := wa.figure_at (wa.button_data.absolute_x - wa.real_x, 
			--							wa.button_data.absolute_y - wa.real_y);
				if figure /= Void then
					!! col_list.make;
					sel_fig := wa.selected_figures;
					if sel_fig.has (figure) then
						from
							sel_fig.start;
						until
							sel_fig.after
						loop
							colorable ?= sel_fig.item.data;
							check
								is_colorable_1: colorable /= Void
							end;
							col_list.put_right (colorable);
							col_list.forth;
							sel_fig.forth;
						end
					else
						colorable ?= figure.data;
						check
							is_colorable_2: colorable /= Void
						end;
						col_list.put_front (colorable);
					end;
					!! change_color.make (col_list, color_stone.color_name);
				end;
			end;
		end;

	process_new_class is
			-- Create a new class where the stone was dropped
		local
				--| local to speed up access:
			wa: like workarea
		do
			wa := workarea
			if wa.data /= Void then 
				wa.workarea_make_class_com.execute (Void, pnd_data)
			end
		end

	process_new_cluster is
			-- Create a new cluster where the stone was dropped
		local
				--| local to speed up access:
			wa: like workarea
		do
			wa := workarea
			if wa.data /= Void then 
				wa.workarea_make_cluster_com.execute (Void, pnd_data)
			end
		end

	process_relation (relation_stone: RELATION_STONE) is
			-- Add the relation associated to `relation_stone'
			-- to the compressed link on which the stone was dropped.
			-- No effect (?) if not dropped on a compressed link.
		local
			dropped_rel_com: WORKAREA_DROPPED_REL_COM;
			graph_relation: GRAPH_RELATION;
			list: LINKED_LIST [DATA];
			rel_list: LINKED_LIST [RELATION_DATA];
			rel_data: RELATION_DATA;
				--| local to speed up access:
			wa: like workarea
		do
			wa := workarea;
			if wa.data /= Void then
				--graph_relation := wa.relation_figure_at (pnd_data.absolute_x - wa.real_x, pnd_data.absolute_y - wa.real_y);
				graph_relation := wa.relation_figure_at (pnd_data.x, pnd_data.y);
				if graph_relation /= Void then
					list := wa.selected_figures.datas;
					if list.has (relation_stone.data) then
						list.start;
						list.prune (relation_stone.data);
						list.put_front (relation_stone.data);
					else	
						!! list.make;
						list.put_front (relation_stone.data)
					end;
					!! rel_list.make;
					from
						list.start
					until
						list.after
					loop
						rel_data ?= list.item;
						if rel_data /= Void then
							rel_list.extend (rel_data);
						end;
						list.forth
					end;
					!! dropped_rel_com.set_relation (graph_relation);
					--dropped_rel_com.execute (rel_list, Void)
					dropped_rel_com.execute (Void, Void)
				else
					process_any(relation_stone)
				end;
			end	
		end

	process_any (s: STONE) is
			-- Process dropped stone `stone' and create an editor
			-- if it is editable.
		local
			create_win: CREATE_EDITOR_WINDOW_COM;
			group_stone: GROUP_STONE;
			stones: LINKED_LIST [STONE]
		do
			group_stone ?= s;
			if group_stone = Void then
				!! create_win.make (analysis_window)
				create_win.execute (s.data);
			else
				from
					stones := group_stone.stones;
					stones.start
				until
					stones.after
				loop
					!! create_win.make (analysis_window)
					create_win.execute (stones.item.data);
					stones.forth
				end
			end
		end;	


feature {NONE} -- Implementation

	add_aggreg_com: ADD_AGGREG_COM;
		-- Add aggregation command

	add_cli_sup_com: ADD_CLI_SUP_COM;
		-- Add client-supplier link command

	add_inh_com: ADD_INH_COM;
		-- Add inheritance link command

	add_link_com: ADD_LINK_COM;
		-- Current link command (ie which type of link 
		-- addition is currently performed).

	main_panel_hole_com: MAIN_PANEL_HOLE_COM

	analysis_window: MAIN_WINDOW
		-- Window attached to `workarea'

	pnd_data: EV_PND_EVENT_DATA
		-- Context information on where stone was dropped
		-- relatively to the main panel

feature {NONE} -- Inapplicable

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Callback for associated button:
			-- No associated button.
		local
			class_stone: CLASS_STONE
			cluster_stone: CLUSTER_STONE
			color_stone: COLOR_STONE
			new_cluster_stone: NEW_CLUSTER_STONE
			new_class_stone: NEW_CLASS_STONE
			relation_stone: RELATION_STONE
			st: STONE
		do
			pnd_data ?= data

			if pnd_data /= Void then
				class_stone ?= pnd_data.data
				if class_stone /= Void then
					process_class (class_stone)
				else
					cluster_stone ?= pnd_data.data
					if cluster_stone /= Void then
						process_cluster (cluster_stone)
					else
						relation_stone ?= pnd_data.data

						if relation_stone /= Void then
							process_relation (relation_stone)
						else
			
							color_stone ?= pnd_data.data
	
							if color_stone /= Void then
								process_color (color_stone)
							else
								new_cluster_stone ?= pnd_data.data
	
								if new_cluster_stone /= Void then
									process_new_cluster
								else
									new_class_stone ?= pnd_data.data
	
									if new_class_stone /= Void then
										process_new_class
									else
										st ?= pnd_data.data
										if st /= Void then
											process_any (st)
										end
									end
								end
							end
						end
					end		
				end
			end
		end

invariant
	analysis_window_exists: analysis_window /= Void 

end -- class PROCESS_WORKAREA_STONE
