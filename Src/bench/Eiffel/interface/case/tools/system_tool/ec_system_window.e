indexing
	description: "Tool which edits the properties of an Eiffel system."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_SYSTEM_WINDOW


inherit
	EC_EDITOR_WINDOW [ SYSTEM_DATA ]
		rename
			toolbar as class_toolbar
		redefine
			make,class_toolbar,update
		end

	PRINT_WINDOW_CALLER

creation
	make

feature -- Initialization

	make(par: EV_WINDOW ) is
			-- Initialize
		local
			sep: EV_HORIZONTAL_SEPARATOR 
		do
			precursor(par)
			set_title("System Tool")
			!! component_page.make(notebook, system, Current)
			!! cluster_chart_page.make(notebook,Void)
			!! class_chart_page.make(notebook,Void)
			!! dico_page.make(notebook, system)

			!! click_text.make (widget_names.text, Current)

			fill_menu
			start_observation
		end

feature -- Implementation

	class_toolbar: SYSTEM_WINDOW_TOOLBAR

	component_page: SYSTEM_COMPONENT_PAGE

	cluster_chart_page: CLUSTER_CHART_PAGE

	class_chart_page: CLASS_CHART_PAGE

	dico_page: SYSTEM_DICO_PAGE

	window_m: EV_MENU

	click_text: SYSTEM_CLICK_TEXT;


	components_i: EV_RADIO_MENU_ITEM
	system_i: EV_RADIO_MENU_ITEM
	clusters_i: EV_RADIO_MENU_ITEM
	dictionary_i: EV_RADIO_MENU_ITEM


feature -- Menu

	fill_menu is
		local
			com: EV_ROUTINE_COMMAND
			print_system_com : PRINT_SYSTEM_COM
			save_size_m,print_m,exit_m: EV_MENU_ITEM

			select_page_notebook: SELECT_PAGE_NOTEBOOK

			exit_argument: EV_ARGUMENT1 [ECASE_WINDOW]
			format_argument: EV_ARGUMENT1 [INTEGER]

		do
			if menu /= Void then
				-- File Menu
				!! print_m.make_with_text(menu.file_m,widget_names.print_label)
				!! print_system_com.make (Current)
				print_m.add_select_command (print_system_com, Void)

				!! exit_m.make_with_text(menu.file_m, widget_names.exit)
				!! com.make (~exit_window)
				!! exit_argument.make (Current)
				exit_m.add_select_command(com, exit_argument)

				!! window_m.make_with_text (menu.menu_bar, widget_names.window)
				!! save_size_m.make_with_text (window_m, widget_names.save_size)
				!! com.make (~save_dimensions)
				save_size_m.add_select_command (com, Void)

				-- Format_menu
				!! select_page_notebook.make (notebook)

				!! components_i.make_with_text (menu.format_m, widget_names.components)
				!! format_argument.make (1)
				components_i.add_select_command (select_page_notebook, clone (format_argument))

				!! system_i.make_peer_with_text (menu.format_m, widget_names.system_chart, components_i)
				!! format_argument.make (2)
				system_i.add_select_command (select_page_notebook, clone (format_argument))
					
				!! clusters_i.make_peer_with_text (menu.format_m, widget_names.cluster_charts, components_i)
				!! format_argument.make (3)
				clusters_i.add_select_command (select_page_notebook, clone (format_argument))
					
				!! dictionary_i.make_peer_with_text (menu.format_m, widget_names.dictionary, components_i)
				!! format_argument.make (4)
				dictionary_i.add_select_command (select_page_notebook, clone (format_argument))
					
			end
		end

feature -- Output

	print_document (target: STRING;
				format: STRING; 
				print_graphics: BOOLEAN) is
		-- print current format
	local
		parser : FILTER_PARSER
		file : INDENT_FILE
		file_name : FILE_NAME

		error: BOOLEAN
	do
		if not error then
			if notebook /= Void then
				if notebook.current_page /= 1 then
					--we reuse existing routines
					if format /= Void or Environment.is_motif then 
						System.generate_documentation (target,
							format,
							format = Void,
							FALSE,notebook.current_page = 2,FALSE,FALSE, notebook.current_page = 4)
					else
						--	Environment.printer_module.initialize ( Current )
						--	Environment.printer_module.print_text (click_text,
						--		"System Generation")
						--	Environment.printer_module.restore
					end
				else
					-- creation of the files 
					!! parser.make (format, Environment.filters_directory)
					if format /= Void then
						!! file_name.make
						file_name.extend (target)
	--					if notebook.current_page = 1 then
	--						file_name.extend("components")
	--					else
	--						file_name.extend("modified")
	--					end
	--					if parser.extension/=Void and then parser.extension.count>0 then
	--						file_name.add_extension(parser.extension)
	--					end
						!! file.make(file_name, parser )
					else
						!! file.make(Environment.temporary_file_name, parser)
					end
		
					-- generation
					convert ( file ) 
					if format = Void then
						if Environment.is_motif then 
							Environment.print_to_printer(target, file )
						else
						--	Environment.printer_module.initialize ( Current )
						--	Environment.printer_module.print_text (click_text,
						--		"System Generation")
						--	Environment.printer_module.restore
						end
					end	
					file.close
				end
			end
		end
	rescue
		error := true
		retry
	end

convert ( fi : INDENT_FILE ) is
		-- routine which convert a text in an "indent" text
	local
		li : LINKED_LIST[ STRING ]	
		ind1, ind2 : INTEGER	
	do
-- 		if click_text /= Void then
-- 			!! li.make
-- 			from
-- 				ind1:=1
-- 				ind2:=1
-- 			until
-- 				ind1=0 
-- 			loop
-- 				ind1:= click_text.text.index_of('%N', ind2)
-- 				if ind1>0 then
-- 					li.extend(click_text.text.substring(ind2,ind1))
-- 				end
-- 				ind2 := ind1 +1 
-- 			end
-- 			-- now let's store it in the file
-- 			from
-- 				li.start
-- 			until
-- 				li.after
-- 			loop
-- 				fi.append_string(li.item)
-- 				fi.new_line
-- 				li.forth
-- 			end
-- 		end	
	end


feature -- Observation
	
	start_observation is
		-- Start the observation of entities
-- 		local
-- 			cla: SORTED_TWO_WAY_LIST [CLASS_DATA]
-- 			clu: SORTED_TWO_WAY_LIST [CLUSTER_DATA]
		do
-- 			from
-- 				cla := system.classes_in_system
-- 				cla.start
-- 			until
-- 				cla.after
-- 			loop
-- 				observer_management.add_observer(cla.item, Current)
-- 				cla.forth
-- 			end
-- 			from
-- 				clu := system.clusters_in_system
-- 				clu.start
-- 			until
-- 				clu.after
-- 			loop
-- 				observer_management.add_observer(clu.item, Current)
-- 				clu.forth
-- 			end	
		end

	update is
		-- Update the entities of Current.
		do
			component_page.update
			cluster_chart_page.update
			class_chart_page.update
			dico_page.update
		end

	remove_observation is
		-- Start the observation of entities
		local
			cla: SORTED_TWO_WAY_LIST [CLASS_DATA]
			clu: SORTED_TWO_WAY_LIST [CLUSTER_DATA]
		do
-- 			from
-- 				cla := system.classes_in_system
-- 				cla.start
-- 			until
-- 				cla.after
-- 			loop
-- 				observer_management.remove_observer(cla.item, Current)
-- 				cla.forth
-- 			end
-- 			from
-- 				clu := system.clusters_in_system
-- 				clu.start
-- 			until
-- 				clu.after
-- 			loop
-- 				observer_management.remove_observer(clu.item, Current)
-- 				clu.forth
-- 			end	
		end


feature -- savable parameters

	get_height_name	: STRING	is "system_tool_height"
	
	get_width_name	: STRING	is "system_tool_width"

end -- class EC_SYSTEM_WINDOW
