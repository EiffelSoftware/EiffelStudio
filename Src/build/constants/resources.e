-- Resource values read in. 
-- Note: Keep attribute names same as resource value
-- names so it is easier to document the resource names.
class RESOURCES

inherit

	WINDOWS

creation

	initialize

feature -- Color Resources
	
	background_color: COLOR;
			-- Background color for interface

	background_figure_color: COLOR;
			-- Background color for all figures

	foreground_color: COLOR;
			-- Foreground color for interface

	foreground_figure_color: COLOR;
			-- Foreground color for all figures

	drawing_area_color: COLOR;
			-- Drawing area color

	app_dr_area_color: COLOR
			-- Application editor drawing area color

	app_background_figure_color: COLOR
			-- Application editor figures background color

	app_foreground_figure_color: COLOR	
			-- Application editor figures foreground color

	selected_color: COLOR;
			-- Selected color when control 
			-- left clicked is done on a context

	second_selected_color: COLOR;	
			-- Second selected color just in
			-- case that the current widget
			-- has the selected color

feature {NONE} -- Color initialization

	initialize_color_values (resource: RESOURCE_TABLE) is
		do
			background_color := get_color (resource, 
										"background_color", Void);
			background_figure_color := get_color (resource, 
										"background_figure_color", "white");
			foreground_color := get_color (resource, 
										"foreground_color", Void);
			foreground_figure_color := get_color (resource, 
										"foreground_figure_color", "black");
			drawing_area_color := get_color (resource, 
										"drawing_area_color", "white");
			app_dr_area_color := get_color (resource,
										"app_dr_area_color", "LightYellow")
			app_background_figure_color := get_color (resource,
										"app_background_figure_color", "white")
			app_foreground_figure_color := get_color (resource,
										"app_foreground_figure_color", "DarkMagenta")
			selected_color := get_color (resource, 
										"selected_color", "grey");
			second_selected_color := get_color (resource, 
										"second_selected_color", "black");
		end;

	get_color (resource: RESOURCE_TABLE; 
			resource_value, default_value: STRING): COLOR is
		require
			valid_resource: resource /= Void;
			valid_resource_value: resource_value /= Void
		local
			color_name: STRING
		do
			color_name :=  resource.get_string (resource_value, default_value);
			if color_name /= Void and then not color_name.empty then
				!! Result.make;
				Result.set_name (color_name)
			end
		end;

feature -- Font values

	focus_label_font: FONT;
			-- Font for focus_labels

	default_font: FONT;
			-- Font used for text in interface

	check_fonts (widget: WIDGET) is
			-- Check fonts used in system
		do
			focus_label_font := check_font_validity 
								(focus_label_font, widget);
			default_font := check_font_validity 
								(default_font, widget);
		end;

feature {NONE} -- Initialize font values

	initialize_font_values (resource: RESOURCE_TABLE) is
		do
			focus_label_font := get_font (resource, "focus_label_font", Void);
			default_font := get_font (resource, "default_font", Void);
		end;

	check_font_validity (font: FONT; widget: WIDGET): FONT is
			-- Check `font' validity for `widget'. If font
			-- is in valid return VOID
		do
			if font /= Void then
				if font.is_font_valid then
					Result := Font;	
				else
					io.error.putstring ("Warning: cannot load font ");
					io.error.putstring (font.name);
					io.error.new_line;
				end;
			end;
		ensure
			valid_result: Result /= Void implies Result.is_font_valid
		end;

	get_font (resource: RESOURCE_TABLE; 
			resource_value, default_value: STRING): FONT is
		require
			valid_resource: resource /= Void;
			valid_resource_value: resource_value /= Void
		local
			font_name: STRING
		do
			font_name :=  resource.get_string (resource_value, default_value);
			if font_name /= Void and then not font_name.empty then
				!! Result.make;
				Result.set_name (font_name);
			end
		end;

feature -- Integer Misc Values

	history_size: INTEGER;
	window_free_list_number: INTEGER;
	command_file_name: STRING;
	perm_window_file_name: STRING;
	temp_window_file_name: STRING;
			-- Base file name
	tab_length: INTEGER; 
			-- Tab length within error message dialog box
			-- (The error display should be changed to the
			-- command tool window!


feature {NONE} -- Integer Values initialization

	initialize_misc_values (resource: RESOURCE_TABLE) is
		do
			history_size 
				:= resource.get_integer ("history_size", 20);
			window_free_list_number 
				:= resource.get_integer ("window_free_list_number", 0);
			command_file_name
				:= resource.get_string ("command_file_name", "command");
			command_file_name.to_lower;
			perm_window_file_name
				:= resource.get_string ("perm_window_file_name", "perm_wind");
			perm_window_file_name.to_lower;
			temp_window_file_name
				:= resource.get_string ("temp_window_file_name", "temp_wind");
			temp_window_file_name.to_lower;
			tab_length 
			:= resource.get_pos_integer ("tab_length", 1);
		end;

feature -- Window sizes

		-- Application editor
	app_dr_area_width: INTEGER;
	app_dr_area_height: INTEGER;
	app_ed_width: INTEGER;
	app_ed_height: INTEGER;
	app_ed_x: INTEGER;
	app_ed_y: INTEGER;

		-- Command Catalog
	cmd_cat_width: INTEGER;
	cmd_cat_height: INTEGER;
	cmd_cat_x: INTEGER;
	cmd_cat_y: INTEGER;

		-- Command Instance Editor
	cmd_inst_ed_width: INTEGER;
	cmd_inst_ed_height: INTEGER;

		-- Command Type Editor
	-- cmd_type_ed_width: INTEGER;
	-- cmd_type_ed_height: INTEGER;
	cmd_ed_height: INTEGER
	
		-- Context Catalog
	cont_cat_width: INTEGER;
	cont_cat_height: INTEGER;
	cont_cat_x: INTEGER;
	cont_cat_y: INTEGER;

		-- Context Editor
	cont_ed_width: INTEGER;
	cont_ed_height: INTEGER;

		-- History Window
	history_wnd_width: INTEGER
	history_wnd_height: INTEGER

		-- Help Window
	
	help_wnd_width: INTEGER;
	help_wnd_height: INTEGER;

		-- Main panel
	main_panel_width: INTEGER;
	main_panel_height: INTEGER;
	main_panel_x: INTEGER;
	main_panel_y: INTEGER;

		-- Namer Window
	namer_wnd_width: INTEGER;
	namer_wnd_height: INTEGER;
	
		-- State Editor
	state_ed_width: INTEGER;
	state_ed_height: INTEGER;

		-- Translation Editor
	trans_ed_width: INTEGER;
	trans_ed_height: INTEGER;

		-- Context Tree
	tree_width: INTEGER;
	tree_height: INTEGER;
	tree_x: INTEGER;
	tree_y: INTEGER;

		-- Object tool generator
	object_tool_generator_width: INTEGER
	object_tool_generator_height: INTEGER
	object_tool_generator_x: INTEGER
	object_tool_generator_y: INTEGER

		-- Object command generator
	object_command_generator_width: INTEGER
	object_command_generator_height: INTEGER

		-- Class selector
	class_importer_width: INTEGER
	class_importer_height: INTEGER
	class_importer_x: INTEGER
	class_importer_y: INTEGER

feature {NONE} -- Integer Values initialization

	initialize_window_size_values (resource: RESOURCE_TABLE) is
		do
			app_ed_width := resource.get_pos_integer ("app_ed_width", 600);
			app_ed_height := resource.get_pos_integer ("app_ed_height", 400);
			app_dr_area_width := resource.get_pos_integer ("app_dr_area_width", 500);
			app_dr_area_height := resource.get_pos_integer ("app_dr_area_height", 500);
			app_ed_x := resource.get_integer ("app_ed_x", 500);
			app_ed_y := resource.get_integer ("app_ed_y", 500);

			cmd_cat_width := resource.get_pos_integer ("cmd_cat_width", 420);
			cmd_cat_height := resource.get_pos_integer ("cmd_cat_height", 270);
			cmd_cat_x := resource.get_integer ("cmd_cat_x", 0);
			cmd_cat_y := resource.get_integer ("cmd_cat_y", 315);

			cmd_inst_ed_width := resource.get_pos_integer ("cmd_inst_ed_width", 365);
			cmd_inst_ed_height := resource.get_pos_integer ("cmd_inst_ed_height", 167);

			-- cmd_type_ed_width := resource.get_pos_integer ("cmd_type_ed_width", 500);
			-- cmd_type_ed_height := resource.get_pos_integer ("cmd_type_ed_height", 650);
			cmd_ed_height := resource.get_pos_integer ("cmd_ed_height", 400);

			cont_cat_width := resource.get_pos_integer ("cont_cat_width", 320);
			cont_cat_height := resource.get_pos_integer ("cont_cat_height", 270);
			cont_cat_x := resource.get_integer ("cont_cat_x", 0);
			cont_cat_y := resource.get_integer ("cont_cat_y", 0);

			cont_ed_width := resource.get_pos_integer ("cont_ed_width", 310);
			cont_ed_height := resource.get_pos_integer ("cont_ed_height", 410);

			help_wnd_width := resource.get_pos_integer ("help_wnd_width", 450);
			help_wnd_height := resource.get_pos_integer ("help_wnd_height", 500);

			history_wnd_width := resource.get_pos_integer ("history_wnd_width", 200);
			history_wnd_height := resource.get_pos_integer ("history_wnd_height", 300);

			main_panel_width := resource.get_pos_integer ("main_panel_width", 550);
			main_panel_height := resource.get_pos_integer ("main_panel_height", 180);
			main_panel_x := resource.get_integer ("main_panel_x", -1);
			main_panel_y := resource.get_integer ("main_panel_y", 0);

			namer_wnd_width := resource.get_pos_integer ("namer_wnd_width", 330);
			namer_wnd_height := resource.get_pos_integer ("namer_wnd_height", 70);

			state_ed_width := resource.get_pos_integer ("state_ed_width", 300);
			state_ed_height := resource.get_pos_integer ("state_ed_height", 300);

			trans_ed_width := resource.get_pos_integer ("trans_ed_width", 170);
			trans_ed_height := resource.get_pos_integer ("trans_ed_height", 120);

			tree_width := resource.get_pos_integer ("tree_width", 320);
			tree_height := resource.get_pos_integer ("tree_height", 270);
			tree_x := resource.get_integer ("tree_x", 345);
			tree_y := resource.get_integer ("tree_y", 0);

			object_tool_generator_width := resource.get_pos_integer ("object_tool_generator_width", 505)
			object_tool_generator_height := resource.get_pos_integer ("object_tool_generator_height", 580)
			object_tool_generator_x := resource.get_pos_integer ("object_tool_generator_x", 0)
			object_tool_generator_y := resource.get_pos_integer ("object_tool_generator_y", 0)

			object_command_generator_width := resource.get_pos_integer ("object_command_generator_width", 410)
			object_command_generator_height := resource.get_pos_integer ("object_command_generator_height", 135)

			class_importer_width := resource.get_pos_integer ("class_importer_width", 160)
			class_importer_height := resource.get_pos_integer ("class_importer_height", 300)
			class_importer_x := resource.get_pos_integer ("class_importer_x", 0)
			class_importer_y := resource.get_pos_integer ("class_importer_y", 0)

		end;

feature {NONE} -- Creation

	initialize is
			-- Resources specified by the user
		local
			parser: RESOURCE_PARSER;
			file_names: RESOURCE_FILES;
			file_name: FILE_NAME;
			resource_table: RESOURCE_TABLE
		once
			!! resource_table.make (20);
			!! parser;
			!! file_names.make ("build");

			file_name := file_names.system_general;
			if file_name /= Void and then not file_name.empty then
				parser.parse_file (file_name, resource_table)
			end;
			file_name := file_names.user_general;
			if file_name /= Void and then not file_name.empty then
				parser.parse_file (file_name, resource_table)
			end;
			file_name := file_names.system_specific;
			if file_name /= Void and then not file_name.empty then
				parser.parse_file (file_name, resource_table)
			end;
			file_name := file_names.user_specific;
			if file_name /= Void and then not file_name.empty then
				parser.parse_file (file_name, resource_table)
			end;
debug ("RESOURCES")
	io.error.put_string ("RESOURCE TABLE:");
	io.error.new_line;
	from resource_table.start until resource_table.after loop
		io.error.put_string ("%Tname = ");
		io.error.put_string (resource_table.key_for_iteration);
		io.error.put_string (", value = ");
		io.error.put_string (resource_table.item_for_iteration);
		io.error.new_line;
		resource_table.forth
	end
end
			initialize_color_values (resource_table);
			initialize_font_values (resource_table);
			initialize_window_size_values (resource_table);
			initialize_misc_values (resource_table);
debug ("RESOURCES")
	io.error.put_string ("finished initializing resources");
	io.error.new_line;
end;
		end

end
