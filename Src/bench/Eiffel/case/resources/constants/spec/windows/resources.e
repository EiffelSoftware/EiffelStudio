indexing

	description: "All resources used for EiffelCase."
	author: "pascalf"
	date: "$Date$";
	revision: "$Revision$"

class RESOURCES 

inherit

	ONCES

	CONSTANTS

creation

	initialize

feature -- Access

	get_color(s: STRING): EV_COLOR is
		local
			s1: STRING
		do
			Result ?= resource_structure.table.get_value(s)
			if Result= Void then
				s1 := clone(s)
				s1.append(" : resource name has no associated value, default applied.")
				-- Warning, we apply the default.
			end
		end

	get_font(s: STRING): EV_FONT is
		local
			s1: STRING
		do
			Result ?= resource_structure.table.get_value(s)
			if Result= Void then
				s1 := clone(s)
				s1.append(" : resource name has no associated value, default applied.")
				-- Warning, we apply the default.
			end
		end

	get_integer(s: STRING): INTEGER is
		do

		end

	get_string(s: STRING): STRING is
		do

		end


feature -- Graphic values (21)

	link_arrow_size: INTEGER
	link_bracket_size: INTEGER
	link_apart: INTEGER
	link_width: INTEGER
	link_label_space: INTEGER
	link_x_offset: INTEGER
	link_y_offset: INTEGER
	class_reused_offset: INTEGER
	class_ellipse_y_offset: INTEGER
	class_ellipse_x_offset: INTEGER
	class_symbols_spacing: INTEGER
	class_generic_offset: INTEGER
	class_symbols_offset: INTEGER
	class_root_offset: INTEGER
	cluster_width: INTEGER
	cluster_height: INTEGER
	cluster_icon_x_margin: INTEGER
	cluster_icon_y_margin: INTEGER
	cluster_title_margin: INTEGER
	sneak_window_display: INTEGER
	delay_sneak : INTEGER

feature {NONE}

	initialize_graphic_values is
			-- Create graphic resources
		local
			tab: RESOURCES_TABLE
		do
			tab := resource_structure.table
			link_arrow_size := tab.get_integer ("link_arrow_size", 6);
			link_bracket_size := tab.get_integer ("link_bracket_size", 6);
			link_width := tab.get_integer ("link_width", 2);
			link_apart := tab.get_integer ("link_apart", 1);
			link_x_offset := tab.get_integer ("link_x_offset", 5); 
			link_y_offset := tab.get_integer ("link_y_offset", 5); 
			link_label_space := tab.get_integer ("link_label_space", 2);
			class_reused_offset := tab.get_integer ("class_reused_offset", 2);
			class_ellipse_y_offset := tab.get_integer ("class_ellipse_y_offset", 6);
			class_ellipse_x_offset := tab.get_integer ("class_ellipse_x_offset", 10);
			class_symbols_spacing := tab.get_integer ("class_symbols_spacing", 2);
			class_generic_offset := tab.get_integer ("class_generic_offset", 2);
			class_symbols_offset := tab.get_integer ("class_symbol_offset", 2);
			class_root_offset := tab.get_integer ("class_root_offset", 2);
			cluster_width := tab.get_integer ("cluster_width", 75);
			cluster_height := tab.get_integer ("cluster_height", 75);
			cluster_icon_x_margin := tab.get_integer ("cluster_icon_x_margin", 10);
			cluster_icon_y_margin := tab.get_integer ("cluster_icon_y_margin", 30);
			cluster_title_margin := tab.get_integer ("cluster_title_margin", 5);
			width_for_scattering := tab.get_integer ("width_to_scatter", 400 )
			sneak_window_display := tab.get_integer ("sneak_window_display", 1)
			delay_sneak := tab.get_integer ("delay_for_sneak", 1500)
		end;

feature -- Misc (10)

	width_for_scattering : INTEGER
	window_max_free_list: INTEGER; -- Number of windows to be saved in free list
	show_bon: BOOLEAN; -- Show Bon notation?
	nbr_color_per_line: INTEGER; -- Number of colors per line in Color Window
	printer_command: STRING -- Printer command
	history_size: INTEGER -- Size of the history
	tab_length: INTEGER; -- Tab length within text areas
	multiplicity_max_value: INTEGER; -- Maximal value of link multiplicit ("i" if above)
	editor_name : STRING -- name of the text editor we want to use	
	converter : STRING -- scipt used for going from postscript to gif, jpg, ...depends on the user
	auto_save_delay : INTEGER -- delay for automatic saving a project in the BACKUP ...

feature -- save config

	save_config ( s : STRING ; new_name : STRING)	is
			-- command that save s 
			-- in the .ecr file
	do
	end


feature {NONE} -- Misc

	initialize_misc_values  is
			-- Create graphic resources
		local
			tab: RESOURCES_TABLE
		do
			tab := resource_structure.table
			window_max_free_list := tab.get_integer ("window_max_free_list", 1)
			history_size := tab.get_integer ("history_size", 10);
			tab_length := tab.get_integer ("tab_length", 8);
			nbr_color_per_line := tab.get_integer	("nbr_color_per_line", 4)
			printer_command := tab.get_string ("printer_command", "none")
			editor_name := tab.get_string ("editor_for_descriptions", "vi")
			converter := tab.get_string ("converter", "no_converter")
			show_bon := tab.get_boolean ("show_bon", True);
			multiplicity_max_value := tab.get_integer ("multiplicity_max_value", 9)
			auto_save_delay := tab.get_integer ("automatic_saving_delay", 10 )
		end;

feature -- Window size values 

		-- Graph cluster window
	cluster_window_width: INTEGER
	cluster_window_height: INTEGER
	cluster_window_x: INTEGER
	cluster_window_y: INTEGER

		-- Auxilary Graph cluster window
	aux_cluster_window_width: INTEGER
	aux_cluster_window_height: INTEGER
	aux_cluster_window_x: INTEGER
	aux_cluster_window_y: INTEGER

		-- Hidden Entity Window
	hidden_entity_window_width: INTEGER
	hidden_entity_window_height: INTEGER

		-- Relation Window
	relation_window_width: INTEGER;
	relation_window_height: INTEGER;

		-- Preferences Window
	preference_window_width: INTEGER
	preference_window_height: INTEGER

		-- Algo Window
	algo_window_width : INTEGER
	algo_window_height : INTEGER

		-- Sneak Window
	sneak_window_width: INTEGER
	sneak_window_height: INTEGER

		-- History Window
	history_window_width: INTEGER 
	history_window_height: INTEGER

feature {NONE} -- Window size values

	initialize_window_size_values  is
		local
			tab: RESOURCES_TABLE
		do
			tab := resource_structure.table		
			cluster_window_width := tab.get_integer ("cluster_tool_width", 900);
			cluster_window_height := tab.get_integer ("cluster_tool_height", 700);
			cluster_window_x := tab.get_integer ("cluster_tool_x", 0);
			cluster_window_y := tab.get_integer ("cluster_tool_y", 0);
			algo_window_width := tab.get_integer ("algo_tool_width", 450);
			algo_window_height := tab.get_integer ("algo_tool_height", 500);
			aux_cluster_window_width := tab.get_integer ("auxiliary_cluster_tool_width", 400);
			aux_cluster_window_height := tab.get_integer ("auxiliary_cluster_tool_height", 700);
			aux_cluster_window_x := tab.get_integer ("auxiliary_cluster_tool_x", 100);
			aux_cluster_window_y := tab.get_integer ("auxiliary_cluster_tool_y", 100);
			relation_window_width := tab.get_integer ("relation_tool_width", 500);
			relation_window_height := tab.get_integer ("relation_tool_height", 200);
			hidden_entity_window_width := tab.get_integer ("hidden_component_tool_width", 300);
			hidden_entity_window_height := tab.get_integer ("hidden_component_tool_height", 300);
			history_window_width := tab.get_integer ("history_tool_width", 200);
			history_window_height := tab.get_integer ("history_tool_height", 300);
			preference_window_width := tab.get_integer ("preference_tool_width", 200);
			preference_window_height := tab.get_integer ("preference_tool_height", 250);
			sneak_window_width := tab.get_integer ("sneak_window_width", 400);
			sneak_window_height := tab.get_integer ("sneak_window_height", 400);

		end

feature -- Access

	resource_structure: RESOURCE_STRUCTURE
		-- new storage structure.

feature {NONE,RETRIEVE_PROJECT} -- Creation & Re-initialization

	initialize is
			-- Resources specified by the user
		local
			file_name: FILE_NAME
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
		do	
			!! file_name.make_from_string(environment.resources_name)

			!! parser.make 
			!! file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				!! s.make(file.count)
				s.append (file.last_string)
				parser.parse_string(s)
				parser.set_end_of_file
				file.close		
			end
			!! resource_structure.make(parser)
			reinitialize
		end

feature {PREFERENCE_WINDOW}

		reinitialize is 
			do
				initialize_graphic_values 
				initialize_window_size_values
				initialize_misc_values
			end
end 
