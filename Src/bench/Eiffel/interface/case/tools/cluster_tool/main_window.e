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
			view_m,option_m,edit_menu: EV_MENU
			menu_item,sub_menu1,sub_menu2: EV_MENU_ITEM
			menu_item2,menu_item3,menu_item4: EV_CHECK_MENU_ITEM
			i: EV_ARGUMENT2 [ECASE_WINDOW, INTEGER]
		--	sep: EV_MENU_SEPARATOR

			create_command: CREATE_PROJECT
			open_command: OPEN_PROJECT
			recent_files_list: RECENT_FILES_LIST
			save_command: SAVE_PROJECT
			automatic_save_command: AUTO_SAVE
			save_as_command: SAVE_AS_PROJECT
			generate_system_command: DISPLAY_GENE_COM
			generate_cluster_command: DISPLAY_GENE_COM2
			exit_command: EXIT_PROJECT
			undo_command: UNDO_HISTORY
			redo_command: REDO_HISTORY
			automatic_resizing_command: AUTOMATIC_RESIZE_COM
			retarget_command: UNZOOM_CLUSTER
			hs_label_command: LAB_MENU_SELEC 				
			hs_implementation_command: IMP_MENU_SELEC
			hs_inheritance_command: INH_MENU_SELEC
			hs_client_links_command: CLI_MENU_SELEC
			hs_aggregation_command: AGG_MENU_SELEC			
			gather_command: OPTIMIZE_CLUSTER_CONTENT
			client_command: STR_CLIENT_COM
			inheritance_command: STR_INH_COM
			both_command: STR_BOTH_COM
			coloring_command: COLORING_COMMAND
		do
				!! menu_item.make_with_text (menu.file_m, widget_names.create_proj)
				!! create_command.make (Current)
				menu_item.add_select_command (create_command, Void)
				!! menu_item.make_with_text (menu.file_m, widget_names.open_project)
				!! open_command.make (Current)
				menu_item.add_select_command (open_command, Void)
				!! menu_item.make_with_text (menu.file_m, widget_names.recent_systems)
				!! recent_files_list.make (Current, menu_item)
				!! menu_item.make_with_text (menu.file_m, widget_names.save_proj)
				!! save_command.make (Current)
				menu_item.add_select_command (save_command, Void)
				!! menu_item.make_with_text (menu.file_m, widget_names.automatic_save)
				!! automatic_save_command.make (Current)
				menu_item.add_select_command (automatic_save_command, Void)
				!! menu_item.make_with_text (menu.file_m, widget_names.save_proj_as)
				!! save_as_command.make (Current)
				menu_item.add_select_command (save_as_command, Void)
				!! menu_item.make_with_text (menu.file_m, widget_names.exit)
				!! exit_command.make (Current)
				menu_item.add_select_command (exit_command, Void)
	
				!! edit_menu.make_with_text (menu.menu_bar, widget_names.edit)
				!! menu_item.make_with_text (edit_menu, widget_names.undo)
				!! undo_command
				menu_item.add_select_command (undo_command, Void)
				!! menu_item.make_with_text (edit_menu, widget_names.redo)
				!! redo_command
				menu_item.add_select_command (redo_command, Void)
				!! sub_menu1.make_with_text (edit_menu, widget_names.resizing)
					!! sub_menu2.make_with_text (sub_menu1, widget_names.modify_height)
					make_submenu_for_resizing (sub_menu2, true)	
					!! sub_menu2.make_with_text (sub_menu1, widget_names.modify_width)
					make_submenu_for_resizing (sub_menu2, false)
				!! menu_item.make_with_text (edit_menu, widget_names.automatic_resizing)
				!! automatic_resizing_command
				menu_item.add_select_command (automatic_resizing_command, Void)
			
				!! view_m.make_with_text (menu.menu_bar, widget_names.view)
				!! menu_item.make_with_text (view_m, widget_names.retarget_to_parent)
				!! retarget_command.make (Current)
				menu_item.add_select_command (retarget_command, Void)
	
				!! tools_m.make_with_text(menu.menu_bar,"&Tools")
				!! menu_item.make_with_text(tools_m,"Class Tool")
				!! i.make(Current, 1)
				menu_item.add_select_command(Current,i)
				!! menu_item.make_with_text(tools_m,"System Tool")	
				!! i.make(Current, 2)
				menu_item.add_select_command(Current,i)
				!! menu_item.make_with_text(tools_m,"Feature Tool")
				!! i.make(Current,3)
				menu_item.add_select_command(Current,i)
				!! menu_item.make_with_text(tools_m,"Hiding Tool")
				!! menu_item.make_with_text(tools_m,"View Tool")			
				!! i.make(Current,6)
				menu_item.add_select_command(Current,i)	
				!! menu_item.make_with_text(tools_m,widget_names.relation_tool)					
				!! i.make(Current,7)
				menu_item.add_select_command(Current,i)
		
				!! option_m.make_with_text (menu.menu_bar, widget_names.options)
				!! sub_menu1.make_with_text (option_m, widget_names.gather)
				!! gather_command.make (Current, 1, graph_page.drawing_area)
				!! menu_item.make_with_text (sub_menu1, widget_names.up)					
				!! gather_command.make (Current, 2, graph_page.drawing_area)
				!! menu_item.make_with_text (sub_menu1, widget_names.left)
				!! gather_command.make (Current, 3, graph_page.drawing_area)
				!! menu_item.make_with_text (sub_menu1, widget_names.up_left)
				!! menu_item.make_with_text(option_m,widget_names.advanced_color_tool)					
				!! i.make(Current,8)
				!! coloring_command.make(Current)
				!! menu_item.make_with_text(option_m,"Select Color...")
				menu_item.add_select_command(coloring_command,i)
				!! i.make(Current, 50)
				menu_item.add_select_command(Current,i)
				!! menu_item.make_with_text (option_m, widget_names.right_angles)
				!! menu_item2.make_with_text (menu_item, widget_names.client)
				!! client_command.make (menu_item2)
				menu_item.add_select_command (client_command, Void)
				!! menu_item3.make_with_text (menu_item, widget_names.inheritance)
				!! inheritance_command.make (menu_item3)
				menu_item3.add_select_command (inheritance_command, Void)
				!! menu_item4.make_with_text (menu_item, widget_names.both)
				!! both_command.make (menu_item2, menu_item3, menu_item4)
				menu_item4.add_select_command (both_command, Void)
				client_command.set_str_both_com (both_command)
				inheritance_command.set_str_both_com (both_command)					

				-- Documentation
				!! docu_m.make_with_text(menu.menu_bar, "&Documentation")
				!! menu_item.make_with_text(docu_m,"Report ...")
				!! i.make(Current,4)
				menu_item.add_select_command(Current,i)	

				-- Preferences
				!! prefer_m.make_with_text(menu.menu_bar,"&Preferences")
				!! menu_item.make_with_text(prefer_m,"Drawing Area Settings")					
				!! i.make(Current,9)
				menu_item.add_select_command(Current,i)

				!! menu_item.make_with_text(prefer_m,"In/Out Settings")					
				!! i.make(Current,11)
				menu_item.add_select_command(Current,i)

			--	!! sep.make(prefer_m)
				!! menu_item.make_with_text(prefer_m,"Preferences Tool")					
				!! i.make(Current,10)
				menu_item.add_select_command(Current,i)
				
				-- Graph Operations
				!! graph_m.make_with_text(menu.menu_bar,"&Graph Options")	
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

	to_be_removed: FLYWEIGHT_FACTORY

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
				if i=4 then
					!REPORT_WINDOW! tool.make (Current)
				elseif i=5 then
					!HTML_WINDOW! tool.make (Current)
				elseif i=6 then
					!! view_t.make_viewer ( Current)
				elseif i=7 then
					!EC_RELATION_WINDOW! ed.make (Current)
				elseif i=8 then
					!! advanced_color.make (Current)
				elseif i=9 then
					!! preference_tool.make_then_direct_to (Current,"Drawing Area")
					preference_tool.set_file(environment.resources_name)
				elseif i=10 then
					!! preference_tool.make(Current)
					preference_tool.set_file(environment.resources_name)
				elseif i=11 then
					!! preference_tool.make_then_direct_to (Current,"In-Out Settings")
					preference_tool.set_file(environment.resources_name)
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
