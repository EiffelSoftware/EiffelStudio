indexing
	description: "Root Window for the application"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit

	EC_EDITOR_WINDOW [CLUSTER_DATA]
		redefine
			make_top_level, 
			execute,
			update,
			set_entity
		end

	EV_COMMAND

creation
	make_top_level

feature -- Settings

	set_entity (g: like entity) is
		do
			entity := g
			update
		end
	

feature -- Initialization

	make_top_level is
			-- Initialize
		do
			precursor
			create_components

			set_size (resources.cluster_window_width,resources.cluster_window_height)

			set_title("EiffelCase 5")
			!! graph_page.make (notebook, entity, Current)

			fill_menu

			show
		end

feature -- Graphical 

	fill_menu is
		local
		
		
			tools_m,prefer_m,docu_m,graph_m: EV_MENU
			edit_m: EV_MENU
		
			-- File 
				-- Items
					open_i: EV_MENU_ITEM
					create_i: EV_MENU_ITEM
					recent_system_i: EV_MENU_ITEM
					save_i: EV_MENU_ITEM
					automatic_save_i: EV_CHECK_MENU_ITEM
					save_as_i: EV_MENU_ITEM
					import_cluster_i: EV_MENU_ITEM
					import_glossary_i: EV_MENU_ITEM
					generate_system_i: EV_MENU_ITEM
					generate_cluster_i: EV_MENU_ITEM
					exit_i: EV_MENU_ITEM
					report_i: EV_MENU_ITEM
		
				-- Commands
					create_command: CREATE_PROJECT
					open_command: OPEN_PROJECT
					recent_files_list: RECENT_FILES_LIST
					save_command: SAVE_PROJECT
					automatic_save_command: AUTO_SAVE
					save_as_command: SAVE_AS_PROJECT
					import_cluster_command: LOAD_PROJECT_AUX
					import_glossary_command: IMPORT_COM
					generate_system_command: DISPLAY_GENE_COM
					generate_cluster_command: DISPLAY_GENE_COM2
					exit_command: EXIT_PROJECT
	
			-- Edit Commands
				-- Items
					undo_i: EV_MENU_ITEM
					redo_i: EV_MENU_ITEM
					resizing_i: EV_MENU_ITEM
						modify_width_i: EV_MENU_ITEM
						modify_height_i: EV_MENU_ITEM
					automatic_resizing_i: EV_MENU_ITEM
				-- Commands
					undo_command: UNDO_HISTORY
					redo_command: REDO_HISTORY
					automatic_resizing_command: AUTOMATIC_RESIZE_COM

			-- View 
				view_m: EV_MENU
				-- Items
					retarget_parent_i: EV_MENU_ITEM
					hs_label_i: EV_MENU_ITEM
					hs_implementation_i: EV_MENU_ITEM
					hs_inheritance_i: EV_MENU_ITEM
					hs_client_links_i: EV_MENU_ITEM
					hs_aggregation_i: EV_MENU_ITEM
				-- Commands
					retarget_command: UNZOOM_CLUSTER
					hs_label_command: LAB_MENU_SELEC 				
					hs_implementation_command: IMP_MENU_SELEC
					hs_inheritance_command: INH_MENU_SELEC
					hs_client_links_command: CLI_MENU_SELEC
					hs_aggregation_command: AGG_MENU_SELEC			

			-- Tools
				-- Items
					class_i,system_i,feature_i,hidden_i,view_i: EV_MENU_ITEM
					relation_i: EV_MENU_ITEM
					preference_i: EV_MENU_ITEM
				-- Commands
					i: EV_ARGUMENT2 [ECASE_WINDOW, INTEGER]

			-- Options
				option_m: EV_MENU
				-- Items
					gather_i: EV_MENU_ITEM
						up_i: EV_MENU_ITEM
						left_i: EV_MENU_ITEM
						up_left_i: EV_MENU_ITEM

					advanced_color_i: EV_MENU_ITEM
					coloring_i: EV_MENU_ITEM

					right_angles_i: EV_MENU_ITEM
						client_i: EV_CHECK_MENU_ITEM
						inheritance_i: EV_CHECK_MENU_ITEM
						both_i: EV_CHECK_MENU_ITEM
				-- Commands
					gather_command: OPTIMIZE_CLUSTER_CONTENT
					client_command: STR_CLIENT_COM
					inheritance_command: STR_INH_COM
					both_command: STR_BOTH_COM
					coloring_command: COLORING_COMMAND
		do
			if menu /= Void then
				if graph_page /= Void then
					!! create_i.make_with_text (menu.file_m, widget_names.create_proj)
					!! create_command.make (Current)
					create_i.add_select_command (create_command, Void)
	
					!! open_i.make_with_text (menu.file_m, widget_names.open_project)
					!! open_command.make (Current)
					open_i.add_select_command (open_command, Void)
		
					!! recent_system_i.make_with_text (menu.file_m, widget_names.recent_systems)
					!! recent_files_list.make (Current, recent_system_i)
	
					!! save_i.make_with_text (menu.file_m, widget_names.save_proj)
					!! save_command.make (Current)
					save_i.add_select_command (save_command, Void)
	
					!! automatic_save_i.make_with_text (menu.file_m, widget_names.automatic_save)
					!! automatic_save_command.make (Current)
					automatic_save_i.add_select_command (automatic_save_command, Void)
		
					!! save_as_i.make_with_text (menu.file_m, widget_names.save_proj_as)
					!! save_as_command.make (Current)
					save_as_i.add_select_command (save_as_command, Void)
		
					!! import_cluster_i.make_with_text (menu.file_m, widget_names.import_cluster)
					!! import_cluster_command.make (Current)
					import_cluster_i.add_select_command (import_cluster_command, Void)
		
					!! import_glossary_i.make_with_text (menu.file_m, widget_names.import_glossary)
					!! import_glossary_command.make (Current, graph_page.drawing_area)
					import_glossary_i.add_select_command (import_glossary_command, Void)
		
					!! generate_system_i.make_with_text (menu.file_m, widget_names.generate_eiffel_whole_system)
					!! generate_system_command.make (Current)
					generate_system_i.add_select_command (generate_system_command, Void)
		
					!! generate_cluster_i.make_with_text (menu.file_m, widget_names.generate_eiffel_this_cluster)
					!! generate_cluster_command.make (Current)
					generate_cluster_i.add_select_command (generate_cluster_command, Void)
		
					!! exit_i.make_with_text (menu.file_m, widget_names.exit)
					!! exit_command.make (Current)
					exit_i.add_select_command (exit_command, Void)
	
					!! edit_m.make_with_text (menu.menu_bar, widget_names.edit)
						!! undo_i.make_with_text (edit_m, widget_names.undo)
						!! undo_command
						undo_i.add_select_command (undo_command, Void)
	
						!! redo_i.make_with_text (edit_m, widget_names.redo)
						!! redo_command
						redo_i.add_select_command (redo_command, Void)
	
						!! resizing_i.make_with_text (edit_m, widget_names.resizing)
							!! modify_height_i.make_with_text (resizing_i, widget_names.modify_height)
							make_submenu_for_resizing (modify_height_i, true)
	
							!! modify_width_i.make_with_text (resizing_i, widget_names.modify_width)
							make_submenu_for_resizing (modify_width_i, false)
	
						!! automatic_resizing_i.make_with_text (edit_m, widget_names.automatic_resizing)
						!! automatic_resizing_command
						automatic_resizing_i.add_select_command (automatic_resizing_command, Void)
	
					!! view_m.make_with_text (menu.menu_bar, widget_names.view)
						!! retarget_parent_i.make_with_text (view_m, widget_names.retarget_to_parent)
						!! retarget_command.make (Current)
						retarget_parent_i.add_select_command (retarget_command, Void)
						
					--	!! hs_label_i.make_with_text (view_m, widget_names.hs_labels)
					--	!! hs_label_command.make (toolbar)
					--	hs_label_i.add_select_command (hs_label_command, Void)
	
					--	!! hs_implementation_i.make_with_text (view_m, widget_names.hs_implementation)
					--	!! hs_implementation_command.make (toolbar)
					--	hs_implementation_i.add_select_command (hs_implementation_command, Void)
	
					--	!! hs_inheritance_i.make_with_text (view_m, widget_names.hs_inheritance)
					--	!! hs_inheritance_command.make (toolbar)
					--	hs_inheritance_i.add_select_command (hs_inheritance_command, Void)
	
					--	!! hs_client_links_i.make_with_text (view_m, widget_names.hs_client_links)
					--	!! hs_client_links_command.make (toolbar)
					--	hs_client_links_i.add_select_command (hs_client_links_command, Void)
	
					--	!! hs_aggregation_i.make_with_text (view_m, widget_names.hs_aggregation)
					--	!! hs_aggregation_command.make (toolbar)
					--	hs_aggregation_i.add_select_command (hs_aggregation_command, Void)
	
					!! tools_m.make_with_text(menu.menu_bar,"&Tools")
	
						!! class_i.make_with_text(tools_m,"Class Tool")
						!! i.make(Current, 1)
						class_i.add_select_command(Current,i)
	
						!! system_i.make_with_text(tools_m,"System Tool")	
						!! i.make(Current, 2)
						system_i.add_select_command(Current,i)
	
						!! feature_i.make_with_text(tools_m,"Feature Tool")
						!! i.make(Current,3)
						feature_i.add_select_command(Current,i)
	
					--	!! hidden_i.make_with_text(tools_m,"Hiding Tool")
	
						!! view_i.make_with_text(tools_m,"View Tool")			
						!! i.make(Current,6)
						view_i.add_select_command(Current,i)
	
						!! relation_i.make_with_text(tools_m,widget_names.relation_tool)					
						!! i.make(Current,7)
						relation_i.add_select_command(Current,i)
	
						!! preference_i.make_with_text(tools_m,widget_names.preference_tool)					
						!! i.make(Current,9)
						preference_i.add_select_command(Current,i)
			
					!! option_m.make_with_text (menu.menu_bar, widget_names.options)
						!! gather_i.make_with_text (option_m, widget_names.gather)
							!! gather_command.make (Current, 1, graph_page.drawing_area)
							!! up_i.make_with_text (gather_i, widget_names.up)
					
							!! gather_command.make (Current, 2, graph_page.drawing_area)
							!! left_i.make_with_text (gather_i, widget_names.left)
								!! gather_command.make (Current, 3, graph_page.drawing_area)
							!! up_left_i.make_with_text (gather_i, widget_names.up_left)
		
						!! advanced_color_i.make_with_text(option_m,widget_names.advanced_color_tool)					
						!! i.make(Current,8)
						!! coloring_command.make(Current)
						!! coloring_i.make_with_text(option_m,"Select Color...")
						coloring_i.add_select_command(coloring_command,i)
						!! i.make(Current, 50)
						coloring_i.add_select_command(Current,i)
							!! right_angles_i.make_with_text (option_m, widget_names.right_angles)
							!! client_i.make_with_text (right_angles_i, widget_names.client)
							!! client_command.make (client_i)
							client_i.add_select_command (client_command, Void)
								!! inheritance_i.make_with_text (right_angles_i, widget_names.inheritance)
							!! inheritance_command.make (inheritance_i)
							inheritance_i.add_select_command (inheritance_command, Void)
								!! both_i.make_with_text (right_angles_i, widget_names.both)
							!! both_command.make (both_i, client_i, inheritance_i)
							both_i.add_select_command (both_command, Void)
								client_command.set_str_both_com (both_command)
							inheritance_command.set_str_both_com (both_command)					
						end
					end

					!! docu_m.make_with_text(menu.menu_bar, "&Documentation")
					!! report_i.make_with_text(docu_m,"Report ...")
					!! i.make(Current,4)
					report_i.add_select_command(Current,i)	
						!! prefer_m.make_with_text(menu.menu_bar,"&Preferences")
					!! graph_m.make_with_text(menu.menu_bar,"&Modify graph")	
			
		end
	
	
		make_submenu_for_resizing ( resizing_menu : EV_MENU_ITEM; is_height : BOOLEAN  ) is
		local
			sub1,sub2,sub3,sub4: EV_MENU_ITEM
			a_commandd: SUB_MENU_RESIZE
		do
			if graph_page /= Void then
				!! a_commandd.make ( Current, graph_page.drawing_area, 200, is_height) 
				!! sub1.make_with_text (resizing_menu, "+ 100")
				sub1.add_select_command ( a_commandd, Void)
			
				!! a_commandd.make ( Current, graph_page.drawing_area, 150, is_height ) 
				!! sub2.make_with_text (resizing_menu, "+ 50")
				if is_height then 
					--set_action("Shift<Key>Down", a_commandd, Void )
				else
					--set_action("Shift<Key>Right", a_commandd, Void )
				end
				sub2.add_select_command ( a_commandd, Void)
	
				!! a_commandd.make ( Current, graph_page.drawing_area, 50, is_height )
				!! sub3.make_with_text (resizing_menu, "- 50")
				if  is_height then
					--set_action("Shift<Key>Up", a_commandd, Void )
				else
					--set_action("Shift<Key>Left", a_commandd, VOid )
				end
				sub3.add_select_command (a_commandd, Void)
	
				!! a_commandd.make ( Current, graph_page.drawing_area, 0 , is_height)
				!! sub4.make_with_text (resizing_menu, "- 100")
				sub4.add_select_command (a_commandd, Void)

			end
		end

feature -- Update

	update is
		do
			precursor

		--	if toolbar /= Void then
		--		toolbar.update
		--	end
		end



feature -- Implementation

	graph_page: GRAPH_PAGE

	--toolbar: MAIN_WINDOW_TOOLBAR

feature -- Callbacks

	execute ( arg: EV_ARGUMENT2[ECASE_WINDOW,INTEGER]; data: EV_EVENT_DATA) is
		local
			ed: EC_EDITOR_WINDOW [ANY]
			tool: EC_TOOL
			ec_w: ECASE_WINDOW
			view_t: VIEW_TOOL
			advanced_color: ADVANCED_COLOR_WINDOW
			preference_tool: PREFERENCE_WINDOW
			coloring_tool: EC_COLOR_TOOL
			i : INTEGER
		do
			i := arg.second
			if i>=0 and i < 51 then
				-- popup an editor
				if i=1 then
				--	!EC_CLASS_WINDOW! ed.make ( Current )
				--elseif i=2 then
				--	!EC_SYSTEM_WINDOW! ed.make (Current)
				--elseif i=3 then
				--	!EC_FEATURE_WINDOW! ed.make (Current)
				--elseif i=4 then
					!REPORT_WINDOW! tool.make (Current)
				--elseif i=5 then
					--!HTML_WINDOW! tool.make (Current)
				elseif i=6 then
					!! view_t.make_viewer ( Current)
				elseif i=7 then
					!EC_RELATION_WINDOW! ed.make (Current)
				elseif i=8 then
					!! advanced_color.make (Current)
				elseif i=9 then
					!! preference_tool.make (Current)
				elseif i=50 then
					!! coloring_tool.make(Current)
				end
				if ed /= Void then
					ed.show
				end 
				if ec_w /= Void then
					ec_w.show
				end
			end
		end

	update_title is
		local
			title_string: STRING
		do
			title_string := clone (widget_names.eiffelcase)
			title_string.append (" : ")
			title_string.append (environment.project_directory)
			title_string.append (" View : ")
			title_string.append (system.view_name)

			set_title (title)
		end

feature -- Size

	get_width_name	: STRING	is
		do
		end

	get_height_name	: STRING	is
		do
		end



end -- class MAIN_WINDOW
