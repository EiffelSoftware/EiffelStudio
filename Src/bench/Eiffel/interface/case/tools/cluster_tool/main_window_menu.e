indexing
	description: "Menu for Main Window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW_MENU

inherit
	
	WINDOWS_MANAGER

creation
	make

feature -- Initialization

	make (win: MAIN_WINDOW ) is
			-- Initialize
		local
			create_command: CREATE_PROJECT
			open_command: OPEN_PROJECT
			save_command: SAVE_PROJECT
			save_as_command: SAVE_AS_PROJECT
			import_cluster_command: LOAD_PROJECT_AUX
			import_glossary_command: IMPORT_COM
			generate_system_command: DISPLAY_GENE_COM
			generate_cluster_command: DISPLAY_GENE_COM2
			exit_command: EXIT_PROJECT
			
		do
			window := win
			!! container.make(win)

			!! file_m.make_with_text(container,widget_names.file)

				!! create_i.make_with_text (file_m, widget_names.create_proj)
				!! create_command.make (window)
				create_i.add_activate_command (create_command, Void)

				!! open_i.make_with_text (file_m, widget_names.open_project)
				!! open_command.make (window)
				open_i.add_activate_command (open_command, Void)

				!! recent_system_sm.make_with_text (file_m, widget_names.recent_systems)
				fill_recent_system

				!! save_i.make_with_text (file_m, widget_names.save_proj)
				!! save_command
				save_i.add_activate_command (save_command, Void)

				!! save_as_i.make_with_text (file_m, widget_names.save_proj_as)
				!! save_as_command
				save_as_i.add_activate_command (save_as_command, Void)

				!! import_cluster_i.make_with_text (file_m, widget_names.import_cluster)
				!! import_cluster_command
				import_cluster_i.add_activate_command (import_cluster_command, Void)

				!! import_glossary_i.make_with_text (file_m, widget_names.import_glossary)
				!! import_glossary_command.make (window)
				import_glossary_i.add_activate_command (import_glossary_command, Void)

				!! generate_system_i.make_with_text (file_m, widget_names.generate_eiffel_whole_system)
				!! generate_system_command.make (window)
				generate_system_i.add_activate_command (generate_system_command, Void)

				!! generate_cluster_i.make_with_text (file_m, widget_names.generate_eiffel_this_cluster)
				!! generate_cluster_command.make (window)
				generate_cluster_i.add_activate_command (generate_cluster_command, Void)

				!! exit_i.make_with_text (file_m, widget_names.exit)
				!! exit_command.make (window)
				exit_i.add_activate_command (exit_command, Void)

				!! tools_m.make_with_text(container,"&Tools")

				!! system_i.make_with_text(tools_m,"System Tool")	
				!! class_i.make_with_text(tools_m,"Class Tool")
				!! feature_i.make_with_text(tools_m,"Feature Tool")

				!! docu_m.make_with_text(container, "&Documentation")
				!! html_i.make_with_text(docu_m,"HTML Report")
				!! report_i.make_with_text(docu_m,"Miscellaneous Element Report")

				!! prefer_m.make_with_text(container,"&Preferences")
				!! graph_m.make_with_text(container,"&Modify graph")	

			set_commands
		ensure
			window_set: win = window
		end


feature -- Settings

	set_commands is
		-- Set all the associated commands
	local
		i: EV_ARGUMENT2 [ECASE_WINDOW, INTEGER]
	do
		!! i.make(window, 1)
		class_i.add_activate_command(window,i)
		
		!! i.make(window, 2)
		system_i.add_activate_command(window,i)

		!! i.make(window,3)
		feature_i.add_activate_command(window,i)

		!! i.make(window,4)
		report_i.add_activate_command(window,i)
	
		!! i.make(window,5)
		html_i.add_activate_command(window,i)

	end

feature -- Implementation

	window : MAIN_WINDOW

	container: EV_STATIC_MENU_BAR

	file_m, tools_m,prefer_m,docu_m,graph_m: EV_MENU

	recent_system_sm: EV_MENU_ITEM

	class_i,system_i,feature_i: EV_MENU_ITEM
	open_i: EV_MENU_ITEM
	create_i: EV_MENU_ITEM
	save_i: EV_MENU_ITEM
	save_as_i: EV_MENU_ITEM
	import_cluster_i: EV_MENU_ITEM
	import_glossary_i: EV_MENU_ITEM
	generate_system_i: EV_MENU_ITEM
	generate_cluster_i: EV_MENU_ITEM
	exit_i: EV_MENU_ITEM
	report_i: EV_MENU_ITEM
	html_i: EV_MENU_ITEM

	fill_recent_system is
		local
			file_name	: FILE_NAME
			file	: PLAIN_TEXT_FILE
	
			system_b	: EV_MENU_ITEM
			recent_command	: RECENT_SYSTEM
		do
			!! file_name.make_from_string	(environment.casegen_directory	)	
			file_name.extend	( "recent_system"	)

			!! file.make	( file_name	)

			if file.exists
			then
				file.open_read
	
				from
					file.start
				until
					file.after
				loop
					file.read_line
	
					!! recent_command.make	( window, file.last_string	)
					!! system_b.make_with_text	(recent_system_sm, file.last_string)
					system_b.add_activate_command	( deep_clone	( recent_command	) , Void	)
				end
			end

		end

end -- class MAIN_WINDOW_MENU
