indexing

	description: 
		"Data describing the system for a given project.";
	date: "$Date$";
	revision: "$Revision$"
 
class SYSTEM_DATA 

inherit

	NAME_DATA
		rename
			name as view_name,
			set_name as set_view_name
		redefine
			has_elements, update_display
		end;
	STORABLE
		rename
			class_name as exception_class_name
		end
	
	SHARED_FILE_SERVER

creation

	make

feature -- Initialization

	make is
			-- Create the SYSTEM_DATA object.
		do
			!! error_track
			!! counter
			!! hide_show
			is_modified := True
			decrement_cluster_view_number
			!! root_cluster.make_root ("SYSTEM_ARCHITECTURE", cluster_view_number)
			root_cluster.set_width (700)
			root_cluster.set_height (1000)
			hide_show.set_grid_spacing(20)
			use_editor := FALSE
			!! view_description.make_with_default
			!! System_classes.make (100)
			--hide_show.set_show_bon(Resources.show_bon)
			view_name := ""
		ensure
			grid_is_not_magnetic: not is_grid_magnetic
			grid_is_not_visible: not is_grid_visible
			grid_spacing_is_20: grid_spacing = 20
		end

feature -- Properties

	error_occured: BOOLEAN

	change_view_selected: BOOLEAN

	current_directory: STRING

	project_initialized: BOOLEAN

	saved: BOOLEAN

	hide_show : SYSTEM_HIDE_SHOW

	counter : SYSTEM_COUNTER

	root_cluster: CLUSTER_DATA;
			-- Root cluster containing all system
			-- entities (classes and clusters).

	show_bon: BOOLEAN is
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.show_bon
		end

	is_grid_visible: BOOLEAN is
			-- Is grid visible in a graphical representation on screen ?
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.is_grid_visible
		end

	is_grid_magnetic: BOOLEAN is
			-- Do entities glu to the grid as if it was magnetic ?
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.is_grid_magnetic
		end

	grid_spacing: INTEGER is
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.grid_spacing
		end
	
	use_editor : BOOLEAN
			-- do we want to use a text editor for 
			-- the descriptions ??

	set_use_editor ( b :BOOLEAN ) is
		do
			use_editor := b
		end

	class_id_number: INTEGER;
			-- Last number use for default class name and id

	cluster_view_number: INTEGER is
			-- Last number use for default cluster name and id
	require
		valid_counter	: counter	/= void
	do
		Result := counter.cluster_view_number 
	end

	class_view_number: INTEGER is 
			-- Last number use for last class view data
	require
		valid_counter	: counter	/= void
	do
		Result := counter.class_view_number
	end

	is_modified: BOOLEAN;
			-- Has Current system data been modified ?

	system_classes: HASH_TABLE [CLASS_DATA, INTEGER];
			-- All classes in System hashed on their ids

	hyper_system_classes : HASH_TABLE [ STRING, INTEGER ]
			-- All the names of classes of the initial system that contained
			-- the current system; it avoids loss of information during the
			-- retrieving phase ...

	is_aggreg_hidden: BOOLEAN is
			-- Is aggregate relations hidden ?
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.is_aggreg_hidden
		end

	is_client_hidden: BOOLEAN is
			-- Is client relations hidden ?
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.is_client_hidden
		end

	is_inheritance_hidden: BOOLEAN is
			-- Is inheritance relations hidden ?
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.is_inheritance_hidden
		end

	is_label_hidden: BOOLEAN is
			-- Is relations labels hidden ?
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.is_label_hidden
		end

	show_all_relations: BOOLEAN is
			-- Show all relations (includes relationship
			-- resulting from implementation) ?
		require
			valide_hide_show	: hide_show	/= void
		do
			Result := hide_show.show_all_relations
		end

	set_saved (b: like saved) is 
		do
			saved := b
		end

	set_show_bon ( b: BOOLEAN ) is
		require
			valide_hide_show	: hide_show	/= void
		do
			hide_show.set_show_bon ( b)
		end

	set_is_client_hidden (b: BOOLEAN) is
			-- Set is_client_hidden to `b'
		require
			valide_hide_show	: hide_show	/= void
		do
			hide_show.set_is_client_hidden(b)
		end

	set_is_label_hidden (b: BOOLEAN) is
			-- Set is_label_hidden to `b'
		require
			valide_hide_show	: hide_show	/= void
		do
			hide_show.set_is_label_hidden( b )
		end

	set_is_inheritance_hidden (b: BOOLEAN) is
			-- Set is_inheritance_hidden to `b'
		require
			valide_hide_show	: hide_show	/= void
		do
			hide_show.set_is_inheritance_hidden(b)
		end

	set_is_aggreg_hidden (b: BOOLEAN) is
			-- Set is_aggreg_hidden to `b'
		require
			valide_hide_show	: hide_show	/= void
		do
			hide_show.set_is_aggreg_hidden(b)
		end

	set_grid_visible (value: like is_grid_visible) is
			-- Set `grid_visible'.
		require
			valide_hide_show	: hide_show	/= void
		do
			hide_show.set_grid_visible(value)
		end

	set_grid_magnetic (value: like is_grid_magnetic) is
			-- Set `grid_magnetic'.
		require
			valide_hide_show	: hide_show	/= void
		do
			hide_show.set_grid_magnetic(value)
		end

	set_grid_spacing (value: like grid_spacing) is
			-- Set `grid_spacing'.
		require
			value_positive : value >0
			valide_hide_show	: hide_show	/= void
		do
			hide_show.set_grid_spacing(value)
		end


	str_client : BOOLEAN 
			-- Straight link ?

	str_inh : BOOLEAN
			-- Straight link
		
	str_both : BOOLEAN
			-- Straight link

	uml_layout : BOOLEAN
		-- is current edited with BON or UML ?	
	
	set_uml_layout (b : BOOLEAN ) is
		-- set current edited with BON or UMl ( BON<=>FALSE )	
		do
			uml_layout := b
		end
		-- 
	view_name: STRING;

	view_id: INTEGER;
			-- System view id

	view_description: DESCRIPTION_DATA;

	has_elements: BOOLEAN is True;
	
	has_view: BOOLEAN is
			-- Does Current have a view?
		do
			Result := view_information.view /= Void
		end;

	stone_type: INTEGER is do end;

	cluster_data_to_save : CLUSTER_DATA

	workarea_picked: WORKAREA

	View: SYSTEM_VIEW is
		require	
			has_view: has_view
		do
			Result := view_information.view
		ensure
			valid_result: Result /= Void
		end 

	view_name_stone: VIEW_NAME_STONE is
		do
			!! Result.make (Current, view_id, view_name)
		end;

feature -- converter/ html generation

	has_converter : BOOLEAN

	set_converter (b: BOOLEAN ) is 
		-- put a boolean at TRUE if the user says he has a converter 
		-- Postscript/ GIF
	do
		has_converter := b
	end

	convert_has_a_rotate_function : INTEGER 
		-- 0 -> we do not know 
		-- 1 -> yes
		-- 2 -> no

	set_convert_has_a_rotate_function ( i : INTEGER ) is
		do
			convert_has_a_rotate_function := i
		end	

	set_current_directory (d: like current_directory) is
		do
			current_directory := d
		end

	
	set_generation_html ( b : BOOLEAN ) is
		-- This boolean indicates when EiffelCase is currently 
		-- generation HTML sources. This is useful at least in the 
		-- class generate_classes...
	do
		generation_html := b
	end

	generation_html : BOOLEAN

feature -- light saving

	is_in_retrieving_mode: BOOLEAN

	set_light_save ( b : BOOLEAN ) is
		do
			light_save := b
		end

	light_save : BOOLEAN

feature -- automatic load at the beginning of a project

	set_automatic_load ( s : STRING ) is
		do
			file_starter := s
		end

	file_starter : STRING

feature -- Setting

		modify_str_client(b: BOOLEAN )  is 
		do
			str_client := b	
		end

		modify_str_inh(b: BOOLEAN )  is 
		do
			str_inh := b 
		end

		set_str_both (b: BOOLEAN) is
		do
			str_both := b
		end

		modify_str_both is 
		do
			str_both := not str_both
			str_client := str_both
			str_inh := str_both
		end

	set_is_modified is
			-- Set is_modified to `b' and 
			-- update visually system is not saved.
		do
			is_modified := True;
	--		Windows.main_graph_window.set_not_saved;
		ensure
			is_modified_set: is_modified
		end;

	set_view_name (s: STRING) is
			-- Update `name'.
		do
			view_name := clone (s);
		end;

	set_view_id (i: like view_id) is
			-- Set view_id to `i'.
		require
			valid_i: i > 0
		do
			view_id := i
		end;

	set_workarea_picked (w: like workarea_picked) is
		do
			workarea_picked := w
		end

	set_show_all_relations (b: BOOLEAN) is
			-- Set show_all_relations to `b'
		require
			valid_hide_show	: hide_show	/= void
		do
			hide_show.set_show_all_relations(b)
		end

	set_retrieve_view_after_reverse (b:BOOLEAN ) is
		do
			retrieve_view_after_reverse := b
		end

	retrieve_view_after_reverse : BOOLEAN

	set_system_to_load ( b : BOOLEAN ) is
		do
			has_system_data_to_load := b
		end

	has_system_data_to_load : BOOLEAN

	--has_system_data_to_save : BOOLEAN

	--set_timer_for_sneak ( t : TIMER ) is
	--	-- set timer of Sneak Windows
	--require
	--	timer_not_void : t/= Void
	--do
	--	timer_for_sneak := t
	--end

	--timer_for_sneak : TIMER
		-- timer for the Sneak Windows

feature  -- speed indicator parameters
		-- This indicates to the user the state of the load/save/generation ...

	--counter_cluster, counter_class : INTEGER

	--max_class, max_cluster : INTEGER

	set_total (cl: CLUSTER_DATA ) is
		require
			valid_counter	: counter	/= void
		do
			counter.set_total ( cl )
		end

	init_counter is 
		require
			valid_counter	: counter	/= void
		do
			counter.init_counter
		end

	set_class_label ( s : STRING ) is
		require
			valid_counter	: counter	/= void
		do
			counter.set_class_label ( s )	
		end

	set_cluster_label ( s: STRING ) is
		require
			valid_counter	: counter	/= void
		do
			counter.set_cluster_label ( s )	
		end

feature -- Access

	root_class: CLASS_DATA is
			-- Root class of system.
			-- Void if none.
		require
			valid_system_classes	: system_classes	/= void
		do
			from
				system_classes.start
			until
				system_classes.after or else
				Result /= Void
			loop
				if system_classes.item_for_iteration.is_root then
					Result := system_classes.item_for_iteration
				end;
				system_classes.forth
			end;
		end;

	valid_project_name: BOOLEAN is
			-- Is the project name valid (ie non empty)?
		require
			valid_environment	: environment	/= void
		do
			Result := not Environment.project_directory.empty
		end;

	retrieve_view_list: SYSTEM_VIEW_LIST is
		local
			view_file: RAW_FILE
		do
			!! view_file.make (Environment.view_file_name);
			Result := retrieve_view_list_with_file (view_file)
		end;

	retrieve_view_list_with_file (view_file: RAW_FILE): SYSTEM_VIEW_LIST is
		require
			valid_view_file: view_file /= void;
			view_file_closed: view_file.is_closed
		local
			storable: STORABLE
		do
			if not rescued then
				!! storable;
				if view_file.exists and then view_file.is_readable then
					view_file.open_read;
					Result ?= storable.retrieved (view_file);
					view_file.close;
				end;
			end
		rescue
			rescued := true;

			--else
			--rescued := false
			--io.error.putstring ("Error: retrieving file ");
			--io.error.putstring (view_file.name);
			--io.error.putstring (".%N")
			--end

			retry
			
		end;

	class_of_name (str: STRING)	: CLASS_DATA	is
			-- Class data with name `str'.
			-- Void, if not found
		require
			valid_str: str /= Void	
			valid_system_classes	: system_classes	/= void
		local
			found	: BOOLEAN
			str_upper	: STRING
		do

			found	:= false

			str_upper	:= clone	( str	)
			str_upper.to_upper

			from
				system_classes.start
			until
				system_classes.after	or
				found
			loop
				if system_classes.item_for_iteration.name.is_equal (str_upper) then
					Result	:= system_classes.item_for_iteration
					found	:= true
				end;
				system_classes.forth
			end

			if	not found
			then
				Result	:= void
			end
		end

	parent_of_name (str: STRING)	: CLASS_DATA	is
			-- Class data with name `str'.
			-- Void, if not found
		require
			valid_str: str /= Void	
			valid_system_classes	: system_classes	/= void
		local
			found	: BOOLEAN
			class_data : CLASS_DATA
			inherit_link : INHERIT_DATA
		do

			found	:= false
			from
				system_classes.start
			until
				system_classes.after	or
				found
			loop
				class_data := system_classes.item_for_iteration
				if class_data.get_link_with_parent (str) /= Void then
					Result	:= class_data
					found	:= true
				end;
				system_classes.forth
			end

			if	not found
			then
				Result	:= void
			end
		end

	class_of_id (i: INTEGER): CLASS_DATA is
			-- Class data with id `i'.
			-- Void, if not found
		require
			valid_i: i > 0
		do
			Result := system_classes.item (i)
		end;

	cluster_of_name (name: STRING): CLUSTER_DATA is
			-- Cluster data with name `name'.
			-- Void, if not found
		require
			valid_name: name /= Void
		do
			Result := cluster_by_name (name, root_cluster);
		end;

	clusters_in_system: SORTED_TWO_WAY_LIST [CLUSTER_DATA] is 
			-- Clusters in the system. Sorted.
		do
			!! Result.make;
			clusters_in_system_with_list (root_cluster, Result)
			Result.sort
		end;

	number_of_clusters: INTEGER is
			-- Number of clusters in system
		local
			list: SORTED_TWO_WAY_LIST [CLUSTER_DATA]
		do
			!! list.make;
			clusters_in_system_with_list (root_cluster, list);
			Result := list.count
		end;

	classes_in_system: SORTED_TWO_WAY_LIST [CLASS_DATA] is
			-- Sorted classes in system
		require
			valid_system_classes	: system_classes	/= void
		do
			!! Result.make;
			from
				system_classes.start;
			until
				system_classes.after
			loop
				Result.put_front (system_classes.item_for_iteration);
				system_classes.forth
			end;
			Result.sort
		end;

	has_cluster (a_string: STRING): BOOLEAN is
			-- Does the cluster whose name is `a_string' exists ?
		require
			searched_name_not_Void: a_string /= Void;
			searched_name_not_empty: not a_string.empty
		do
			Result := cluster_by_name (a_string, root_cluster) /= Void
		end; 

	classes_with_prefix (str: STRING)	: SORTED_TWO_WAY_LIST	[ CLASS_DATA	]	is
			-- Classes in system that have the prefix
			-- value `str' 
		require
			valid_str: str /= Void 
		local
			search_string: STRING;
			class_data: CLASS_DATA
			l	: SORTED_TWO_WAY_LIST	[ CLASS_DATA ]		
		do

			!! l.make
			if str.count > 0 then
				search_string := clone (str)
				search_string.to_upper;
				if search_string.item (str.count) = '*' then
					if search_string.count = 1 then
						search_string := "";
					else
						search_string := search_string.substring
										(1, search_string.count - 1);
					end;
					search_for_classes	( search_string	, l	)
				else
					l.put_front	( class_of_name	( search_string	) )
				end
			end
			Result	:= l
		ensure
			valid_result: Result /= Void
		end;

	clusters_with_prefix (str: STRING): SORTED_TWO_WAY_LIST [CLUSTER_DATA] is
			-- Classes in system that have the prefix
			-- value `str' 
		require
			valid_str: str /= Void 
		local
			search_string: STRING;
			cluster: CLUSTER_DATA
		do
			!! Result.make;
			if str.count > 0 then
				search_string := clone (str)
				search_string.to_upper;
				if search_string.item (str.count) = '*' then
					if search_string.count = 1 then
						search_string := "";
					else
						search_string := search_string.substring
									(1, search_string.count - 1);
					end;
					search_for_clusters (search_string, root_cluster, Result);
				else
					cluster := cluster_of_name (search_string);
					if cluster /= Void then
						Result.put_front (cluster)
					end
				end	
			end
		ensure
			valid_result: Result /= Void
		end;

feature -- researches 

	search_class_with_name ( s: STRING ): CLASS_DATA	is
	require
		valid_system_classes	: system_classes	/= void
	do
		from system_classes.start
		until
			system_classes.after
		loop
			if system_classes.item_for_iteration.name.is_equal(s) then
				Result := system_classes.item_for_iteration
			end
			system_classes.forth
		end
	end
feature -- Element change

	reset_numbers is
			-- set 0 to 'class_number' and 'cluster_number'
		require
			valid_counter	: counter	/= void
		do
			class_id_number := 0;
			counter.set_class_view_number(0)
			counter.set_cluster_view_number(0)
		end;

	increment_class_id_number is
		do
			class_id_number := class_id_number + 1
		ensure
			incremented: class_id_number = old class_id_number + 1
		end;

	increment_class_view_number is
		do
			counter.increment_class_view_number
		end

	increment_cluster_view_number is
		require
			valid_counter	: counter	/= void
		do
			counter.increment_cluster_view_number
		end

	decrement_cluster_view_number is
		require
			valid_counter	: counter	/= void
		do
			counter.decrement_cluster_view_number
		end

feature -- Update

	update_name is
			-- Update the view name
		do
			--set_is_modified;
--			Windows.main_graph_window.update_title;
--			Windows.update_view_window
		end;

	update_display (a_data: DATA) is
			-- Update relevant details after a name change
			-- using stone type `st_type'.
		do
--			Windows.update_view_window;
--			set_is_modified
		end;

	update_view_list is
			-- Update the view list by adding/updating the Current
			-- view.
		require
			valid_proj: valid_project_name
		local
			view_file: RAW_FILE;
			system_view_list: SYSTEM_VIEW_LIST;
			system_view_info: SYSTEM_VIEW_INFO;
		do
			!! view_file.make (Environment.view_file_name);
			if view_file.exists and then view_file.is_readable then
				view_file.open_read;
				system_view_list ?= retrieved (view_file);
				view_file.close;
				if system_view_list = Void then
					!! system_view_list.make (0);
					system_view_list.add_default;
				else
					system_view_list.update_list;
				end
			else
				!! system_view_list.make (0);
				system_view_list.add_default;
			end;
		end;


feature -- Removal

	wipe_out is
			-- Clear the global system and update
			-- the interface
		require
			valid_temporary_system_file_server	: temporary_system_file_server	/= void
			valid_class_content_server	: class_content_server	/= void
		do
			reset_numbers;
			--Windows.clear
			history.wipe_out;
			workareas.wipe_out; 
			-- Clear tmp files if we have not
			-- saved the current system and
			-- we do not want to save it.
			Temporary_system_file_server.remove_tmp_files;
			Class_content_server.delete_classes_not_in_system;	
			Temporary_system_file_server.clear;
			Class_content_server.clear;
			make;
		end; -- wipe_out

feature -- Error Tracking 

	error_track : ERROR_TRACK

feature -- Output

	rescued: BOOLEAN;

	focus: STRING is
		do
			Result := clone (view_name)
		end;

	generate_view_details (text_area: TEXT_AREA) is
			-- Generate view details into `text_area'.
		require
			valid_text_area: text_area /= Void
		do
			text_area.append_string ("View: ");
			text_area.append_clickable_string (view_name_stone, view_name);
			text_area.new_line;
			text_area.append_string ("Description ");
			text_area.new_line;
			text_area.indent;
			view_description.generate (text_area, Current );
			text_area.exdent;
		end;

	generate_documentation (path_or_command: STRING; 
				filter_format: STRING;
				to_printer: BOOLEAN;
				print_clust_ch: BOOLEAN;
				print_system_ch: BOOLEAN;
				print_class_spec: BOOLEAN;
				print_class_ch: BOOLEAN;
				print_class_dict: BOOLEAN) is
			-- Print documentation for current system.
		require
			valid_path_or_command: path_or_command /= Void;
			valid_filter: filter_format /= Void
		local
			file: INDENT_FILE;
			temp_file_name, file_name: FILE_NAME;
			cluster_list: SORTED_TWO_WAY_LIST [CLUSTER_DATA];
			class_list: SORTED_TWO_WAY_LIST [CLASS_DATA];
			parser: FILTER_PARSER;
		do
--			if not rescued then
--				temp_file_name := Environment.temporary_file_name;
--				!! parser.make (filter_format, Environment.filters_directory);
--				--Windows.set_watch_cursor;
--				if print_clust_ch then
--					LINKED_LIST [CLUSTEB_DATA] := clusters_in_system;
--					if to_printer then
--						!! file.make (temp_file_name, parser);
--					else
--						!! file_name.make_from_string (path_or_command);
--						file_name.extend (Environment.cluster_chart_name);
--						if parser.extension/= Void then
--							file_name.add_extension ( parser.extension)
--						end
--						!! file.make (file_name, parser);
--					end;
--					generate_cluster_charts_with_clusters (file, LINKED_LIST [CLUSTER_DATA]);
--					file.close;
--					if to_printer then
--						if not Environment.platform.is_equal("Windows") then
--							Environment.print_to_printer (path_or_command, file); 
--						else
--							Environment.printer_module.print_from_file(file,"Cluster list")
--						end
--					end;
--				end;
--				if print_system_ch then
--					if LINKED_LIST [CLUSTER_DATA] = Void then
--						LINKED_LIST [CLUSTER_DATA] := clusters_in_system;
--					end;
--					if to_printer then
--						!! file.make (temp_file_name, parser);
--					else
--						!! file_name.make_from_string (path_or_command);
--						file_name.extend (Environment.system_chart_name);
--						if parser.extension/= Void then
--							file_name.add_extension ( parser.extension)
--						end
--						!! file.make (file_name, parser);
----					end;
--					generate_chart_with_clusters (file, LINKED_LIST [CLUSTER_DATA]);
--					file.close;
--					if to_printer then
--						if not Environment.platform.is_equal("Windows")  then
--							Environment.print_to_printer (path_or_command, file); 
--						else
--							Environment.printer_module.print_from_file(file,"Chart")
--						end
--					end;
--				end;
--				LINKED_LIST [CLUSTER_DATA] := Void;
--				if print_class_spec then
--					class_list := classes_in_system;
--					if to_printer then
--						!! file.make (temp_file_name, parser);
--					else
--						!! file_name.make_from_string (path_or_command);
--						file_name.extend (Environment.class_interface_name);
--						if parser.extension/= Void then
--							file_name.add_extension ( parser.extension)
--						end
--						!! file.make (file_name, parser);
--					end;
--					generate_class_specifications_with_classes (file, class_list);
--					file.close;
--					if to_printer then
--						if not Environment.platform.is_equal("Windows") then
--							Environment.print_to_printer (path_or_command, file); 
--						else
--							Environment.printer_module.print_from_file(file,"Class specifications")
--						end
--					end;
--				end;
--				if print_class_ch then
--					if class_list = Void then
--						class_list := classes_in_system
--					end;
--					if to_printer then
--						!! file.make (temp_file_name, parser);
--					else
--						!! file_name.make_from_string (path_or_command);
--						file_name.extend (Environment.class_chart_name);
--						if parser.extension/= Void then
--							file_name.add_extension ( parser.extension)
--						end
--						!! file.make (file_name, parser);
--					end;
--					generate_class_charts_with_classes (file, class_list);
--					file.close;
--					if to_printer then
--						if not Environment.platform.is_equal("Windows") then
--							Environment.print_to_printer (path_or_command, file); 
--						else
--							Environment.printer_module.print_from_file(file,"Classes chart")
--						end
--					end;
--				end;
--				if print_class_dict then
--					if class_list = Void then
--						class_list := classes_in_system
--					end;
--					if to_printer then
--						!! file.make (temp_file_name, parser);
--					else
--						!! file_name.make_from_string (path_or_command);
--						file_name.extend (Environment.class_dictionary_name);
--						if parser.extension/= Void then
--							file_name.add_extension ( parser.extension)
--						end
--						!! file.make (file_name, parser);
--					end;
--					generate_class_dictionary_with_classes (file, class_list);
--					file.close;
--					if to_printer then
--						if not Environment.platform.is_equal("Windows") then
--							Environment.print_to_printer (path_or_command, file); 
--						else
--							Environment.printer_module.print_from_file(file,"Glossary")
--						end
--					end;
--				end;
--				!! file.make_with_name (temp_file_name);
--				if file.exists then
--					file.delete
--				end;
--				--Windows.restore_cursor;
--			else
--				Windows_manager.popup_error ( Message_keys.print_doc_er,
--								Void,Windows_manager.main_window)
--				rescued := false;
--			end;
--		rescue
--			if
--				original_exception = Io_exception or else 
--				original_exception = Operating_system_exception 
--			then
--				rescued := True;
--				--Windows.restore_cursor;
--				if not file.is_closed then
--					file.close
--				end;
--				retry;
--			end;
		end;

	generate_eiffelcode (path: STRING) is
			-- Generate eiffel code to disk for Current
			-- system.
		require
			valid_path: path /= Void;
			valid_environement	: environment	/= void
		do
--			if not rescued then 
--				error_track.Start_eiffel_generation 
--				Windows.set_watch_cursor;
--				Environment.remove_directory (Environment.generated_directory)
--				root_cluster.generate_code_to_disk
--				if not Windows.error_occured then
--					generate_ace (clone (path))
--				end
--				Windows.restore_cursor
--				if error_track.eiffel_generation_failed then
--					Windows.error (Windows.main_graph_window, "E48", error_track.eiffel_generation_message )
--				end
--			else
--				Windows.error (Windows.main_graph_window, 
--								Message_keys.generate_code_er,
--								Void)
--				rescued := false
--			end
--		rescue
--			if 
----				original_exception = Io_exception or else 
--				original_exception = Operating_system_exception 
--			then
--				rescued := True
--				Windows.restore_cursor
--				retry;
--			end;
		end;

	generate_to_eiffel_project (caller: EV_WINDOW) is
			-- Generate eiffel code to eiffel project on disk 
			-- for Current system.
		local
		--	classes_to_merge: MERGING_CLASS_LIST
		--	classes_merger: CLASSES_MERGER
		do
			if not rescued then
				--error_track.Start_eiffel_generation 
			--	Windows.set_watch_cursor;
				--Environment.remove_directory (Environment.generated_directory)
				--!! classes_to_merge.make
				--root_cluster.generate_code_to_eiffel_project (classes_to_merge, caller)
				--if not classes_to_merge.empty then
				--	classes_to_merge.sort
					--!! classes_merger.make (classes_to_merge)
				--end
			--	if not WIndows.error_occured then
				--	generate_ace (clone (root_cluster.reversed_engineered_file_name))
			--	end
			--	Windows.ace_window.close
			--	Windows.restore_cursor
				--if error_track.eiffel_generation_failed then
			--		Windows.error (Windows.main_graph_window, "E48", error_track.eiffel_generation_message )
				--end
			else
			--	Windows.error (Windows.main_graph_window, 
			--					Message_keys.generate_code_er,
			--					Void);
				rescued := false;
			end;
		rescue
			if 
				original_exception = Io_exception or else 
				original_exception = Operating_system_exception 
			then
				rescued := True;
				--Windows.restore_cursor;
				retry;
			end;
		end;

	generate_class_dictionary (text_area: TEXT_AREA) is
			-- Generate class dictionary. 
		require
			valid_text_area: text_area /= Void;
		do
			generate_class_dictionary_with_classes (text_area, classes_in_system)
		end;

	generate_chart (text_area: TEXT_AREA) is
			-- Generate system chart in list.
		require
			valid_text_area: text_area /= Void;
		do
			generate_chart_with_clusters (text_area, clusters_in_system)
		end;


feature -- Initialization of the paths 

	initialize_cluster_paths( cl : CLUSTER_DATA ) is
		-- iniitialize the cluster paths	
		do
			if cl=Void then
				set_path_cluster (root_cluster)
			else
				set_path_cluster (cl)
			end	
		end

	set_path_cluster (cl:CLUSTER_DATA) is
			-- implement the path for each cluster 	
		require
			valid_cl	: cl	/= void
		local
			fi : FILE_NAME	
		do
			--if cl.is_root or else
			--	(cl.parent_cluster.is_root ) then
			--	if cl.reversed_engineered_file_name/= Void and then
			--		cl.reversed_engineered_file_name.count>0 then
			--		-- there is already a path here
			--	else
			--		!! fi.make_from_string ( Environment.generated_directory )
			--		if not cl.is_root then
			--			fi.extend(cl.parent_cluster.reversed_engineered_file_name)
				--	end
				--	fi.extend( cl.file_name )
				--	cl.set_reversed_engineered_file_name ( fi )
				--end	
			--else
				--!! fi.make_from_string(cl.parent_cluster.reversed_engineered_file_name)
				--fi.extend ( cl.file_name )
				--cl.set_reversed_engineered_file_name ( fi )	
			--end
		--	if cl.content/= Void --and then
				--cl.content.clusters/= Void and then
				--cl.content.clusters.count>0 then
				--from
			--		cl.content.clusters.start
			--	until
			--		cl.content.clusters.after
			--	loop
			--		set_path_cluster ( cl.content.clusters.item )
			--		cl.content.clusters.forth
			--	end
			--end	
		end	

	set_project_initialized is
		do
			project_initialized := true
		end

feature -- Storage

	storage_info: S_SYSTEM_DATA is
		do
			!! Result;
			Result.set_root_cluster(root_cluster.storage_info)	
			Result.set_class_view_number (class_view_number);
			Result.set_cluster_view_number (cluster_view_number);
			Result.set_class_id_number (class_id_number);
			Result.set_hyper ( hyper_system_classes )
		end

	save_project (save_as: BOOLEAN) is
			-- Store project to `file'.
		require
			save_as_or_is_modified: save_as or is_modified
			valid_Class_content_server	: Class_content_server	/= void
		local
			v: SYSTEM_VIEW;
		do
				-- First save modified classes in tmp files
				-- (Places modified files in the System file server)
		--	Class_content_server.tmp_save_classes;
				-- Save the system data in a tmp file
		--	Temporary_system_file_server.tmp_save_system (storage_info)
				-- Save the view data in a tmp file
		--	!! v.make (Current);
		--	v.tmp_store_to_disk;
				-- All files are now stored temporarily. Now,
				-- save the project.
		--	Temporary_system_file_server.save_eiffelcase_format;
		--	v.save_to_disk;
		--	is_modified := False;

		--	set_saved (true)
		--ensure
		--	not_modified: not is_modified
		end;

	retrieve_project_with_view (file: RAW_FILE; storage_path: STRING; v: SYSTEM_VIEW) is
			-- Retrieve project that used from `file' with view `v'.
			-- Use `storage_path` to retrieve class internal
			-- information
		require
			file_exists: file.exists;
			file_readable: file.is_readable;
			valid_file	: file	/= void
		local
			retrieved_system: S_SYSTEM_DATA;
		do
			file.open_read;
			--Windows.restore_cursor;
			--Windows.set_watch_cursor;
			retrieved_system ?= retrieved (file);
			check
				valid_retrieved_system: retrieved_system /= Void
			end;
			file.close;
		
			make_from_storer (v, storage_path, retrieved_system);
			
			--Windows.main_graph_window.set_title("Ecase 4.3")
			--Windows.main_graph_window.update_title
			--windows.restore_cursor
			--windows.set_watch_cursor
		end

	tmp_id : INTEGER
		-- allows partial loading ...

	retrieve_project_with_view_file (file, view_file: RAW_FILE; storage_path: STRING) is
			-- Retrieve project that used from `file' and
			-- use `storage_path` to retrieve class internal
			-- information
		require
			file_exists: file.exists;
			file_readable: file.is_readable;
			valid_path: storage_path /= Void;
			view_file: view_file /= Void;
			view_file_exists: view_file.exists;
			view_file_readable: view_file.is_readable;
		local
			retrieved_system: S_SYSTEM_DATA;
			v: SYSTEM_VIEW;
			view_file_name: STRING
		do
			--windows.restore_cursor;
			--windows.set_watch_cursor;
			view_file.open_read;
			v ?= retrieved (view_file);
			view_file.close;
			retrieve_project_with_view (file, storage_path, v);
			view_information.process_icons;
			view_information.clear
			--Windows.main_graph_window.set_title("super ecase")
			--Windows.main_graph_window.update_title
		end;

feature -- count

	count_classes_and_clusters ( c : s_cluster_data ) is
	require
		valid_counter	: counter	/= void
	do
		counter.count_classes_and_clusters ( c )
	end
			
	count_classes_and_clusters_in_cluster ( c : cluster_data ) is
	require
		valid_counter	: counter	/= void
	do
		counter.count_classes_and_clusters_in_cluster ( c )
	end

	class_view_number_tmp : INTEGER is
	require
		valid_counter	: counter	/= void
	do
		Result := counter.class_view_number_tmp
	end
	
	cluster_view_number_tmp : INTEGER is
	require
		valid_counter	: counter	/= void
	do
		Result := counter.cluster_view_number_tmp
	end

	decrement_cluster_view_number_tmp is
	require
		valid_counter	: counter	/= void
	do
		counter.decrement_cluster_view_number_tmp
	end

	decrement_class_view_number_tmp is
	require
		valid_counter	: counter	/= void
	do
		counter.decrement_class_view_number_tmp
	end
	
			
	check_size_of_cluster ( cl : CLUSTER_DATA ) is
	do
		resize_cluster_if_glutton ( cl )
	end


feature -- Import of a Cluster
		
	-- This method is called by Import a Cluster

-- 	make_spc	( s	: S_SYSTEM_DATA	) is
-- 			-- case where we import a cluster
-- 			require
-- 				valid_storer: s /= Void;
-- 			local
-- 				add_cluster_u: ADD_CLUSTER_U
-- 				cluster : CLUSTER_DATA
-- 			do
-- 
-- 				if windows.main_graph_window.entity /= Void then
-- 					-- new implementation, pascalf, beginning of July, 1998
-- 					if cluster_of_name(s.root_cluster.name)/= Void then
-- 						-- a cluster already exists with this name !!
-- 						Windows.message(Windows.main_graph_window, "Mz" , s.root_cluster.name)
-- 					else
-- 						-- no problem at this point	
-- 						!! tmp_classes.make(20)	
-- 						build_cluster_clone ( s.root_cluster, root_cluster, TRUE )
-- 						set_system_to_load ( FALSE )
-- 						look_for_inh_in_imported_cluster ( s )
-- 						look_for_links 
-- 						update_system_link
-- 						workareas.update_drawing
-- 					end
-- 				else
-- 					Windows_manager.popup_message("Mg" , s.root_cluster.name )
-- 				end
-- 			end

		init_import is 
			do
				!! tmp_classes.make(20)	
			end

-- 		build_cluster_clone ( s_clus : S_CLUSTER_DATA ; cl : CLUSTER_DATA; b : BOOLEAN)  is
-- 				-- b is t know if it is the root or not
-- 			local
-- 					add_cluster_u: ADD_CLUSTER_U
-- 					new_clu : CLUSTER_DATA
-- 			do
-- 				if cluster_of_name(s_clus.name)/= Void then
-- 					-- a cluster already exists with this name !!
-- 					Windows.message(Windows.main_graph_window, "Mz" , s_clus.name)
-- 				else
-- 					decrement_cluster_view_number
-- 					!! new_clu.make ( s_clus.name, cluster_view_number )
-- 					if b then 
-- 						new_clu.set_x ( 10 )
-- 						new_clu.set_y ( 10 )
-- 						new_clu.set_default
-- 						new_clu.set_icon ( TRUE )
-- 					else
-- 						new_clu.set_x ( s_clus.x )
-- 						new_clu.set_y ( s_clus.y )
-- 						new_clu.set_default
-- 						new_clu.set_icon ( TRUE )
-- 						new_clu.set_hidden ( s_clus.is_hidden )
-- 					end
-- 					if s_clus.chart /= VOid then
-- 						new_clu.set_chart ( s_clus )
-- 					end
-- 					!! add_cluster_u.make ( cl, new_clu )
-- 					if s_clus.clusters/= Void 
-- 						and then  s_clus.clusters.count >0 then
-- 						from
-- 							s_clus.clusters.start
-- 						until
-- 							s_clus.clusters.after
-- 						loop
-- 							build_cluster_clone ( s_clus.clusters.item, new_clu, FALSE)
-- 							s_clus.clusters.forth
-- 						end
-- 					end
-- 					if s_clus.classes/= Void
-- 							and then s_clus.classes.count >0 then
-- 						from
-- 							s_clus.classes.start
-- 						until
-- 							s_clus.classes.after
-- 						loop
-- 							if class_of_name ( s_clus.classes.item.name ) /= Void 
-- 								--and then class_of_name ( s_clus.classes.item.name)	/= void then
-- 							then
-- 								Windows.message (Windows.main_graph_window, "Mz", s_clus.classes.item.name)
-- 							else
-- 								build_class_clone ( s_clus.classes.item, new_clu )
-- 							end
-- 							s_clus.classes.forth
-- 						end
-- 					end
-- 					resize_cluster_if_glutton ( new_clu )
-- 				end
-- 			end

		build_class_clone ( s_class : S_CLASS_DATA; clu : CLUSTER_DATA ) is
			-- some work need to be done ...
			local
				add_cl : ADD_CLASS_U
				cl : CLASS_DATA
				clc : CLASS_CONTENT
				description1: DESCRIPTION_DATA
				generics : LINKED_LIST [ GENERIC_DATA ]
				g_l : FIXED_LIST [ S_GENERIC_DATA ]
				generic_data : GENERIC_DATA
				file_n : FILE_NAME
			do
				increment_class_view_number
				System.increment_class_id_number
				!!cl.make ( s_class.name, class_view_number )

				cl.set_id ( System.class_id_number )


				cl.set_x ( s_class.x )
				cl.set_y ( s_class.y )
				cl.set_color_name ( s_class.color_name )
				cl.set_hidden ( s_class.is_hidden )
			--	if s_class.description= Void then
			--		!! description1.make_with_default
			--	else
			--		!! description1.make_from_storer ( s_class.description )
			--	end
			--	cl.set_description ( description1 )			
				!! file_n.make_from_string ( s_class.file_name )
				cl.set_file_name (file_n)
		
				cl.set_deferred (s_class.is_deferred)
				cl.set_interfaced (s_class.is_interfaced)
				cl.set_is_effective (s_class.is_effective)
				cl.set_persistent(s_class.is_persistent)
				cl.set_reused (s_class.is_reused)
				cl.set_root ( FALSE )
	
			--	cl.create_internal_file
				--if s_class.disk_content/= Void then
				--	!! clc.make_from_storer ( s_class.disk_content, cl )
				--	cl.set_content ( clc )
				--end

				g_l := s_class.generics
				if g_l /= Void then
					from
						!! generics.make	
						g_l.start
					until
						g_l.after
					loop
						!! generic_data.make_from_storer (g_l.item )
						generics.put_right ( generic_data )
						g_l.forth
						generics.forth
					end
					cl.set_generics( generics )	
				end
				
				-- !! add_cl.make ( clu, cl)
				tmp_classes.put ( cl,cl.name )	
			end

		resize_cluster_if_glutton ( new_clu : CLUSTER_DATA ) is
			-- this procedure is responsible for resizing the cluster in order
			-- to surround the entities it contains.
			require
				valid_new_clu	: new_clu	/= void
			local
				new_clu_hei, new_clu_wid : INTEGER
			do
				new_clu_hei := 20
				new_clu_wid := 30
				if new_clu.clusters/= Void and then
					new_clu.clusters.count>0 then
						from
							new_clu.clusters.start
						until
							new_clu.clusters.after
						loop
							if new_clu_hei < (new_clu.clusters.item.height+new_clu.clusters.item.y) then
								new_clu_hei := 	(new_clu.clusters.item.height+new_clu.clusters.item.y)+20
							end
							if new_clu_wid < (new_clu.clusters.item.width+new_clu.clusters.item.x) then
								new_clu_wid := 	(new_clu.clusters.item.width+new_clu.clusters.item.x)+20
							end
							new_clu.clusters.forth
						end
				end
				if new_clu.classes/= Void and then
					new_clu.classes.count>0 then
						from
							new_clu.classes.start
						until
							new_clu.classes.after
						loop
							if new_clu_hei < (20+new_clu.classes.item.y) then
								new_clu_hei := 	(new_clu.classes.item.y)+20
							end
							if new_clu_wid < (50+new_clu.classes.item.x) then
								new_clu_wid := 	(new_clu.classes.item.x)+50
							end
							new_clu.classes.forth
						end
				end
				new_clu.set_width ( new_clu_wid )
				new_clu.set_height ( new_clu_hei )
			end

feature {NONE } -- Implementation

		tmp_classes : HASH_TABLE [ CLASS_DATA, STRING ]
	
	
	
feature
	-- Update	
	look_for_links is
		-- this procedure has to merge the links from list1 to classes_in_system 
		-- we avoid to deal with list 2 to list2 ...
		require
			valid_system_classes	: system_classes	/= void
		local
			cl : CLASS_DATA	
			fea : FEATURE_CLAUSE_LIST
			comm : ADD_CLI_SUP_COM
			comm1 : ADD_AGGREG_COM
			comm2 : ADD_INH_COM
			c	: CLASS_DATA

			name	: STRING
			parent_name	: STRING

		do
--			from
--				system_classes.start
--			until
--				system_classes.after
--			loop
--				cl := system_classes.item_for_iteration	
--				--let's deal with the client-supplier/aggreg links ...	
--				if tmp_classes /= Void 
--				then
--					if tmp_classes.item(cl.name) = Void and then  
--						cl.content/= Void and then
--						cl.content.feature_clause_list/= Void
--						and then cl.content.feature_clause_list.count>0 then
--							fea := cl.content.feature_clause_list
--							from
--								fea.start
--							until
--								fea.after
--							loop
--								if fea.item.features/= Void and then
--									fea.item.features.count >0 then
--										-- let's deal with the features
--										from
--											fea.item.features.start
--										until
--											fea.item.features.after
--										loop
--											if	fea.item.features.item.result_type /= void
--											then
--												name	:= fea.item.features.item.result_type.type.name
--											else
--												name	:= fea.item.features.item.name
--											end
--											if	tmp_classes.has	( name) 
--											then
--												-- it means that there is a link to establish
--												if fea.item.features.item.is_expanded then
--													!! comm1
--													comm1.need_n ( TRUE )
--													comm1.build_link ( Windows.main_graph_window.draw_window,
--														cl,
--														tmp_classes.item ( fea.item.features.item.result_type.type.name))	
--													comm1.need_n ( FALSE )	
--												else
--													!! comm
--													comm.need_n ( TRUE )		
--													comm.build_link ( Windows.main_graph_window.draw_window,
--														cl,
--														tmp_classes.item ( fea.item.features.item.result_type.type.name))
--													comm.need_n ( FALSE )
--												end
--											end	
--											fea.item.features.forth
--										end
--								end
--								fea.forth
--							end
--					end
--				end
--				-- let's deal with the inheritance links ...
--				if cl.parent_links/= Void and then
--					cl.parent_links.count >0 then
--					from
--						cl.parent_links.start
--					until
--						cl.parent_links.after
--					loop
--						if	cl.parent_links.item.parent	/= void
--						then
--							parent_name	:= cl.parent_links.item.parent.name
--						else
--							parent_name	:= cl.parent_links.item.t_o_name
--						end
--						if tmp_classes.has ( parent_name ) then
--								!! comm2
--								comm2.build_link ( Windows.main_graph_window.draw_window, 
--										cl, tmp_classes.item ( cl.parent_links.item.parent.name ))
--						end
--						cl.parent_links.forth
--					end
--				end	
--				system_classes.forth
--			end
--			if tmp_classes /= Void
--			then
--				from
--					tmp_classes.start
--				until
--					tmp_classes.after
--				loop
--					cl := tmp_classes.item_for_iteration	
--					--let's deal with the client-supplier/aggreg links ...	
--					if cl.content/= Void and then
--						cl.content.feature_clause_list/= Void
--						and then cl.content.feature_clause_list.count>0 then
--							fea := cl.content.feature_clause_list
--							from
--								fea.start
--							until
--								fea.after
--							loop
--								if fea.item.features/= Void and then
--									fea.item.features.count >0 then
--										-- let's deal with the features
--										from
--											fea.item.features.start
--										until
--											fea.item.features.after
--										loop
--											if	fea.item.features.item.result_type	/= void
--											then
--												c	:= class_of_name (fea.item.features.item.result_type.type.name )
--											else
--												c	:= class_of_name	( fea.item.features.item.name	)
--											end
--											if	c /= Void
--											then
--												-- it means that there is a link to establish
--												if fea.item.features.item.is_expanded then
--													!! comm1
--													comm1.need_n ( TRUE )
--													comm1.build_link	( Windows.main_graph_window.draw_window	, cl	, c	)	
--													comm1.need_n ( FALSE )	
--												else
--													!! comm
--													comm.need_n ( TRUE )		
--													comm.build_link	( Windows.main_graph_window.draw_window	, cl	, c	)
--													comm.need_n ( FALSE )
--												end
--											end	
--											fea.item.features.forth
--										end
--								end
--								fea.forth
--							end
--					end
--					-- Here, it is not possible to deal with the inheritance,
--					-- indeed the generated classes do not contain the information !!
--					-- temporary : I only generate the inheritance links within the imported cluster ...
--					-- it is made above, before this procedure in : look_for_inh_in_imported_cluster	
--					tmp_classes.forth	
--				end
--			end
		end

	update_system_link is 
			--This is used to find and retrieve the links ....	
			--This way to retrieve HAS TO BE CHANGED .
			--The current storage structure of the Kernel is bad and does not
			--carry the information we want.
			--The inheritance links have to be carried the way the cli-sup are ...	
		local
			cl,cl2 : CLASS_DATA	
			lin : ADD_INH_COM 
			client_link	: ADD_CLI_SUP_COM
			s_class : CLASS_DATA
			parent_name	: STRING
			heir_name	: STRING
			supplier_name	: STRING
			client_name	: STRING
		do
			from
				system_classes.start
			until
				system_classes.after
			loop
				s_class := system_classes.item_for_iteration
				if s_class /= Void then
					if s_class.heir_links/= Void and then s_class.heir_links.count>0 then
					-- we found inheritances ...
						from
							s_class.heir_links.start
						until
							s_class.heir_links.after
						loop
							parent_name	:= s_class.heir_links.item.t_o_name
							if parent_name /= Void
							then
								cl2 := class_of_name	( parent_name	)
								if cl2 /= Void then
									 !! lin
						   			build_link	( clone	( lin	) , s_class	, cl2 )
								end	
							end

							s_class.heir_links.forth
						end	
					end
					if s_class.parent_links/= Void and then s_class.parent_links.count>0 then
					-- we found inheritances ...
						from
							s_class.parent_links.start
						until
							s_class.parent_links.after
						loop
							heir_name	:= s_class.parent_links.item.f_rom_name
							if heir_name /= Void
							then
								cl2 := class_of_name	( heir_name	)
								if cl2 /= Void then
									 !! lin
						   			build_link	( clone	( lin	) , cl2	, s_class	)
								end	
							end
							s_class.parent_links.forth
						end	
					end
					if s_class.client_links/= Void and then s_class.client_links.count>0 then
					-- we found inheritances ...
						from
							s_class.client_links.start
						until
							s_class.client_links.after
						loop
							supplier_name	:= s_class.client_links.item.t_o_name
							if supplier_name /= Void
							then
								cl2 := class_of_name	( supplier_name	)
								if cl2 /= Void then
									 !! client_link
									-- Added by pascalf, has to be checked out
									client_link.need_n ( TRUE) 
						   			build_link	( clone	( client_link	) , s_class	, cl2 )
									client_link.need_n ( FALSE )
								end	
							end

							s_class.client_links.forth
						end	
					end
					if s_class.supplier_links/= Void and then s_class.supplier_links.count>0 then
					-- we found inheritances ...
						from
							s_class.supplier_links.start
						until
							s_class.supplier_links.after
						loop
							client_name	:= s_class.supplier_links.item.f_rom_name
							if client_name /= Void
							then
								cl2 := class_of_name	( client_name	)
								if cl2 /= Void then
									 !! client_link
									client_link.need_n ( TRUE) 
						   			build_link	( clone	( client_link	) , cl2	, s_class	)
									client_link.need_n ( FALSE) 
								end	
							end
							s_class.supplier_links.forth
						end	
					end
				end	

				system_classes.forth	
			end	
		end

	look_for_inh_in_imported_cluster ( s_cluster : S_SYSTEM_DATA ) is 
			--This is used to find and retrieve the links ....	
			--This way to retrieve HAS TO BE CHANGED .
			--The current storage structure of the Kernel is bad and does not
			--carry the information we want.
			--The inheritance links have to be carried the way the cli-sup are ...	
		local
			cl,cl2 : CLASS_DATA	
			lin : ADD_INH_COM 
			s_class : S_CLASS_DATA
		do
			!! li_class.make  	
			look_for_s_classes ( s_cluster.root_cluster )	
			-- let's now create these links ... !!!
			from
				tmp_classes.start
			until
				tmp_classes.after
			loop
				s_class := look_for ( tmp_classes.item_for_iteration.name )	
				if s_class /= Void then
					if s_class.heir_links/= Void and then s_class.heir_links.count>0 then
					-- we found inheritances ...
						from
							s_class.heir_links.start
						until
							s_class.heir_links.after
						loop
							--cl2 := look_for_one_s ( s_class.heir_links.item.t_o )
							cl2 := class_of_name	( s_class.heir_links.item.t_o_name	)
							if cl2 /= Void then
								 !! lin
					   			build_link	( clone	( lin	) , tmp_classes.item_for_iteration	, cl2 )
							end	
							--cl2	:= parent_of_name	( s_class.heir_links.item.t_o_name	)
							--if	cl2	/= Void
							--then
							--!! lin
					   		--build_link	( clone	( lin	) , tmp_classes.item_for_iteration	, cl2 )
							--end

							s_class.heir_links.forth
						end	
					end
					cl2	:= parent_of_name	( s_class.name	)
					if	cl2	/= Void
					then
						!! lin
		   				build_link	( clone	( lin	) , cl2	, tmp_classes.item_for_iteration	)
					end
				end	

				tmp_classes.forth	
			end	
		end

	build_link	( l : ADD_LINK_COM ; c1 : CLASS_DATA ; c2 : CLASS_DATA ) is
	do
--		l.build_link ( Windows.Main_graph_window.draw_window	, c1	, c2	)
	end

	look_for ( s : STRING ) : S_CLASS_DATA is
		require
			valid_li_class	: li_class	/= void
		local
			found : BOOLEAN	
		do
			from
				li_class.start
			until
				found or li_class.after
			loop
				if li_class.item.name.is_equal ( s ) then
					Result := li_class.item
					found := TRUE 
				end	
				li_class.forth
			end		
		end	
	 
	look_for_one_s ( i :INTEGER ) : CLASS_DATA is
		require
			valid_li_class	: li_class	/= void
		local
			found : BOOLEAN
		do
			from
				li_class.start	
			until
				found or li_class.after 
			loop
				if li_class.item.id=i then
					found := TRUE 
					Result :=tmp_classes.item ( li_class.item.name ) 	
				end	
				li_class.forth
			end	
		end

	
	li_class : LINKED_LIST [ S_CLASS_DATA ]
			-- temporary variable for construction ...i

	look_for_s_classes ( s_cl : S_CLUSTER_DATA ) is
		require
			valid_s_cl	: s_cl	/= void
		do
			if s_cl.clusters/= Void and then s_cl.clusters.count>0 then
				from
					s_cl.clusters.start
				until
					s_cl.clusters.after
				loop
					look_for_s_classes ( s_cl.clusters.item )
					s_cl.clusters.forth
				end
			end
			if s_cl.classes/= Void and then s_cl.classes.count >0 then
				from
					s_cl.classes.start
				until
					s_cl.classes.after
				loop
					li_class.extend (s_cl.classes.item )
					s_cl.classes.forth
				end
			end
		end	
				

	make_from_storer (v: SYSTEM_VIEW; path: STRING; s: S_SYSTEM_DATA) is
		require
			valid_v: v /= Void;
			valid_path: path /= Void;
			valid_storer: s /= Void;
		do
			wipe_out; 
			is_in_retrieving_mode := TRUE
			hyper_system_classes := s.hyper_system_classes
			if hyper_system_classes = Void then
				!! hyper_system_classes.make ( 20 )
			end	

			view_information.initialize_for_retrieving (v);

			counter.set_class_view_number_tmp(0)
			counter.set_cluster_view_number_tmp(0)
			count_classes_and_clusters(s.root_cluster)

			class_id_number := s.class_id_number;
	
			if retrieve_view_after_reverse then
				--we take no risk !!
				 counter.set_class_view_number(class_view_number_tmp+s.class_view_number)
				 counter.set_cluster_view_number(s.cluster_view_number-cluster_view_number_tmp)
			else
				counter.set_class_view_number(s.class_view_number) 
				counter.set_cluster_view_number(s.cluster_view_number)
			end

			fill_and_update_linkables (s.root_cluster,
				View_information.system_classes);
			hide_show.set_show_bon(View.show_bon)
			hide_show.set_grid_spacing(View.grid_spacing)
			hide_show.set_grid_visible(View.is_grid_visible)
			hide_show.set_grid_magnetic(View.is_grid_magnetic)
			hide_show.set_is_aggreg_hidden(View.is_aggreg_hidden)
			hide_show.set_is_client_hidden(View.is_client_hidden)
			hide_show.set_is_inheritance_hidden(View.is_inheritance_hidden)
			hide_show.set_is_label_hidden(View.is_label_hidden)
			hide_show.set_show_all_relations(View.show_all_relations)

			view_id := View.view_id;
			view_name := View.view_name;
			view_description := View.description;
				-- Retrieve the data (pass 1)
			!! root_cluster.make_root_from_storer (s.root_cluster, path);
				-- Now retrieve the view (pass 2)
				-- Update shared handles
			view_information.retrieve_shared_handles;
				-- Now retrieve the view
			root_cluster.update_root_view (view_information.is_new_view);
			view_information.retrieve_reverse_links
			is_in_retrieving_mode := FALSE
		end

feature {NONE} -- Implementation

	fill_and_update_linkables (cluster: S_CLUSTER_DATA;
			system_class_views: HASH_TABLE [CLASS_DATA, INTEGER]) is
			-- Fill in `system_classes' with class_data
			-- and `system_clusters' with cluster_data
			-- using the content of `s_cluster_data'.
			-- Also update the view_ids of class_data using
			-- old classes before Current was reversed 
			-- engineered.
		require
			valid_cluster: cluster /= Void;
		local
			s_classes: FIXED_LIST [S_CLASS_DATA];
			s_clusters: FIXED_LIST [S_CLUSTER_DATA];
			class_data: CLASS_DATA;
			s_class_data: S_CLASS_DATA;
			cluster_data: CLUSTER_DATA;
			sys_classes: like system_classes;
			add_project: INTEGER -- To be able to load a second project ...
			old_view_id, view_id_cl : INTEGER
			cl : CLASS_DATA
			info_title: STRING
		do
			s_classes := cluster.classes;
			if s_classes /= Void then
				from
					sys_classes := system_classes;
					s_classes.start;
				until
					s_classes.after
				loop
					s_class_data := s_classes.item;
					if has_system_data_to_load then
						!! class_data.make 
							(s_class_data.name, 
							s_class_data.view_id + view_id);
						sys_classes.put (class_data, s_class_data.id + class_id_number);
					else
							view_id_cl := s_class_data.view_id
					end
					s_class_data.set_view_id (view_id_cl) -- in order to prepare linkable_make_from_storer with a true value			
					!! class_data.make	(s_class_data.name, 
							s_class_data.view_id);
					sys_classes.put (class_data, s_class_data.id); -- in_cluster added
					system_class_views.put (class_data, 
								s_class_data.view_id);
					check
						no_class_conflict: not 
							system_classes.conflict
					end
					-- Update the view id
					s_classes.forth
				end
				s_classes := Void
			end
			s_clusters := cluster.clusters;
			if s_clusters /= Void then
				from
					s_clusters.start
				until
					s_clusters.after
				loop
					fill_and_update_linkables (s_clusters.item,
						system_class_views);
					s_clusters.forth
				end
			end
		end

feature {RETRIEVE_PROJECT} -- Implementation

	update_from (other: like Current) is
		require
			valid_counter	: counter	/= void
			valid_hide_show	: hide_show	/= void
		do
			class_id_number := other.class_id_number;
			counter.set_class_view_number(other.class_view_number)
			counter.set_cluster_view_number(other.cluster_view_number)
			hide_show.set_grid_spacing (other.grid_spacing)
			hide_show.set_is_aggreg_hidden(other.is_aggreg_hidden)
			hide_show.set_is_client_hidden(other.is_client_hidden)
			hide_show.set_grid_magnetic(other.is_grid_magnetic)
			hide_show.set_grid_visible(other.is_grid_visible)
			hide_show.set_show_bon(other.show_bon)
			hide_show.set_is_inheritance_hidden(other.is_inheritance_hidden)
			hide_show.set_is_label_hidden(other.is_label_hidden)
			hide_show.set_show_all_relations(other.show_all_relations)
			root_cluster := other.root_cluster
			system_classes := other.system_classes;
			view_description := other.view_description;
			view_id := other.view_id;
			view_name := other.view_name;
		end;
	
feature {NONE} -- Implementation access

	clusters_in_system_with_list (cluster: CLUSTER_DATA; 
					l: SORTED_TWO_WAY_LIST [CLUSTER_DATA]) is 
			-- Clusters in the system. Call sort after calling
			-- this routine to make list sorted.
		require
			valid_cluster: cluster /= Void
			valid_l: l /= Void
		local
			clusters: LINKED_LIST [ CLUSTER_DATA ]
		do
			l.put_front (cluster);
			clusters := cluster.clusters;
			from
				clusters.start
			until
				clusters.after
			loop
				clusters_in_system_with_list (clusters.item, l);
				clusters.forth
			end
		end;

	cluster_by_name (cluster_name: STRING; 
				cluster: CLUSTER_DATA): CLUSTER_DATA is
		require
			valid_cluster_name: cluster_name /= Void
			valid_cluster	: cluster	/= void
		local
			cl: CLUSTER_DATA
			clusters: LINKED_LIST [ CLUSTER_DATA ]
		do
			if cluster.name.is_equal (cluster_name) then
				Result := cluster
			end;
			if Result = Void then
				clusters := cluster.clusters;
				from
					clusters.start
				until
					clusters.after or else Result /= Void
				loop
					Result := cluster_by_name (cluster_name, clusters.item);
					clusters.forth
				end
			end
		end;

	search_for_classes (str: STRING; l: SORTED_TWO_WAY_LIST [CLASS_DATA]) is
				-- Classes in system for that have the prefix
				-- value `str' and if found put into list `l'.
		require
			valid_str: str /= Void;
			valid_l: l /= Void
		local
			n, tmp: STRING;
		do
					
			if str.empty then
				from
					system_classes.start
				until
					system_classes.after
				loop
					l.put_front (system_classes.item_for_iteration);
					system_classes.forth
				end;
			else
				from
					system_classes.start
				until
					system_classes.after
				loop
					n := system_classes.item_for_iteration.name;
					if n.count >= str.count then
						tmp := n.substring (1, str.count);
						if tmp.is_equal (str) then
							l.put_front (system_classes.item_for_iteration);
						end
					end;
					system_classes.forth
				end;
			end;
			l.sort;
		end;

	search_for_clusters (str: STRING; cl: CLUSTER_DATA;
						l: SORTED_TWO_WAY_LIST [CLUSTER_DATA]) is
					-- Clusters in system for that have the prefix
				-- value `str' and if found put into list `l'.
		require
				valid_str: str /= Void;
				valid_cl: cl /= Void;
				valid_l: l /= Void
		local
				n, tmp: STRING;
				clusters: LINKED_LIST [ CLUSTER_DATA ]
		do
				n := cl.name;
				if str.empty then
					l.extend (cl)
				elseif n.count >= str.count then
					tmp := n.substring (1, str.count);
					if tmp.is_equal (str) then
						l.extend (cl);
					end;
				end;
				from
					clusters := cl.clusters;
					clusters.start
				until
					clusters.after
				loop
					search_for_clusters (str, clusters.item, l);
					clusters.forth
				end;
		end;

feature {NONE} -- Generation

	generate_chart_with_clusters (text_area: TEXT_AREA; 
				list: SORTED_TWO_WAY_LIST [CLUSTER_DATA]) is
			-- Generate system chart in list.
		require
			valid_text_area: text_area /= Void;
			valid_list: list /= Void
		local
			cluster: CLUSTER_DATA
		do
		--	list.start;
		--		-- Remove root class
		--	list.prune (root_cluster);
		--	text_area.append_keyword ("system_chart");
		--	text_area.append_space;
		--	root_cluster.generate_name (text_area);
		--	text_area.new_line;
		--	root_cluster.generate_description (text_area);
		--	root_cluster.chart.generate (text_area, root_cluster, True);
		--	from
		--		list.start
		--	until
		--		list.after
		--	loop
		--		text_area.append_keyword ("cluster");
		--		text_area.append_space;
		--		list.item.generate_name (text_area);
		--		text_area.new_line;
		--		list.item.generate_description (text_area);
		--		list.forth
		--	end;
		--		-- Put it back into the list
		--	list.extend (root_cluster);
		end;

	generate_class_dictionary_with_classes (text_area: TEXT_AREA
					list: SORTED_TWO_WAY_LIST [CLASS_DATA];) is
			-- Generate class dictionary. 
		require
			valid_text_area: text_area /= Void;
			valid_list: list /= Void
		local
			class_data: CLASS_DATA;
		do
			text_area.append_keyword ("class_dictionary");
			text_area.append_space;
			root_cluster.generate_name (text_area);
			text_area.new_line;
			from
				list.start
			until
				list.after
			loop
				if counter.max_general>0 then
					counter.increment_general
				end
				class_data := list.item;
				text_area.append_keyword ("class");
				text_area.append_space;
				class_data.generate_name (text_area);
				text_area.append_space;
				text_area.append_keyword ("cluster");
				text_area.append_space;
				class_data.parent_cluster.generate_name (text_area);
				text_area.new_line;
				class_data.generate_description (text_area);
				text_area.new_line;
				list.forth
			end
		end;

	generate_ace (path: STRING) is
		require
			valid_root_cluster	: root_cluster	/= void
		local	
			file: INDENT_FILE;
			file_name: FILE_NAME;
			name: STRING;
			rel_path: STRING;
			class_data: CLASS_DATA
			err : STRING -- error content
			check_file: CHECK_FILE	
		do
--			!! check_file.make	
--			!! file_name.make_from_string (path);
--			root_cluster.deal_with_dollar	( file_name	)
--			file_name.extend ("Ace");
--			file_name.add_extension ("reversed")
--			!! file.make (file_name, Void);
--			err := check_file.check_load ( file, FALSE )
--			if err.count=0 then
--				err := check_file.check_save (file, FALSE )
--			end
--				if err.count >0 then
--				Windows.message (Windows.main_graph_window, "Mc", clone(err) )
--			else
--			file.append_string ("system ");
--			name := root_cluster.name_in_lower_case;
--			file.append_string (name);
--			file.new_line;
--			file.new_line;
--			file.append_string ("root");
--			file.new_line;
--			file.new_line;
--			file.indent;
--			class_data := root_class;
--			if class_data /= Void then
--				file.append_string (class_data.name);
--			else
--				file.append_string ("ROOT_CLASS")
--			end;
--			file.append_string (": %"make%"")
--			file.exdent;
--			file.new_line;
--			file.new_line;
--			file.append_string ("default");
--			file.new_line;
--			file.new_line;
--			file.indent;
--			file.append_string ("assertion (require)");
--			file.new_line;
--			file.new_line;
--			file.exdent;
--			file.append_string ("cluster");
--			file.new_line;
--			file.new_line;
--			file.indent;
--			generate_cluster_line_for_ace (root_cluster, file,
--						Environment.generated_directory)
--			file.exdent;
--			file.new_line;
--			file.append_string ("end");
--			file.new_line;
--			file.close;
--			end
		end;

	generate_class_specifications_with_classes (text_area: TEXT_AREA;
			list: SORTED_TWO_WAY_LIST [CLASS_DATA]) is
			-- Generate all class specification (interfaces) in system
			-- contained in list.
		require
			valid_list	: list	/= void
		do
			from
				list.start
			until
				list.after
			loop
				if counter.max_general>0 then
					counter.increment_general
				end	
				list.item.generate_specification (text_area);
				list.forth;
				if not list.after then
					text_area.new_line
				end	
			end
		end;

	generate_class_charts_with_classes (text_area: TEXT_AREA;
			list: SORTED_TWO_WAY_LIST [CLASS_DATA]) is
			-- Generate all charts contained in list 
		require
			valid_list	: list	/= void
		do
			from
				list.start
			until
				list.after
			loop
				if counter.max_general>0 then
					counter.increment_general
				end
				list.item.generate_chart (text_area);
				text_area.new_line;
				list.forth
			end
		end;

	generate_cluster_charts_with_clusters (text_area: TEXT_AREA;
			list: SORTED_TWO_WAY_LIST [CLUSTER_DATA]) is
			-- Generate all cluster charts in system.
		require
			valid_list	: list	/= void
		do
			from
				list.start
			until
				list.after
			loop
				if counter.max_general>0 then
					counter.increment_general
				end	
				list.item.generate_chart (text_area);
				list.forth
			end
		end;

	generate_cluster_line_for_ace (cluster: CLUSTER_DATA;
				ace_file: INDENT_FILE; rel_path: STRING) is
		require
			valid_ace_valid	: ace_file	/= void
			valid_cluster	: cluster	/= void
		local
			clusters: LINKED_LIST [CLUSTER_DATA];
			tmp: DIRECTORY_NAME
		do
			--if not cluster.is_root 
			--	then
			--		cluster.set_re_file_name_from_parent
			--end
		--	ace_file.append_string (cluster.name_in_lower_case);
		--	if not cluster.is_root and then not cluster.parent_cluster.is_root then
		--		ace_file.append_string(" (")
		--		ace_file.append_string(rel_path )
		--		ace_file.append_string(") : %"")
		--		!! tmp.make_from_string ("$")
		--		tmp.extend(cluster.file_name)
		--		ace_file.append_string(tmp)
		--	else
		--	-	!! tmp.make_from_string (cluster.reversed_engineered_file_name)		
		--		ace_file.append_string (": %"");
		--		ace_file.append_string(tmp)
		--	end
		--	ace_file.append_string ("%";");
		--	ace_file.new_line;
		--	from
		--		clusters := cluster.clusters;
		--		clusters.start
		--	until
		--		clusters.after
		--	loop
		--		generate_cluster_line_for_ace (clusters.item, ace_file,
		--				clone(cluster.name_in_lower_case))
		--		clusters.forth
		--	end
		end;

feature -- directories for the Tools ( used by the file selector )
		
		index_directory : STRING

		set_index_d ( s : STRING ) is
			do
				index_directory := clone (s)
			end

		namer_directory : STRING

		set_namer_d ( s : STRING ) is
			do
				namer_directory := clone (s)
			end
		
		docu_directory : STRING 
		
		set_docu_d ( s: STRING ) is
			do
				docu_directory := clone (s)
			end

		set_error_occured (b: like error_occured) is
			do
				error_occured := b
			end
		
invariant

	has_root_cluster: root_cluster /= void;
	spacing_more_than_10: grid_spacing >= 10;
	spacing_less_than_40: grid_spacing <= 40;
	--has_description: view_description /= void

end -- class SYSTEM_DATA
