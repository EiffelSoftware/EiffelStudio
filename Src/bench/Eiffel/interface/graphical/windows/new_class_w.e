indexing

	description:	
		"Model for workbench windows.";
	date: "$Date$";
	revision: "$Revision$"

class NEW_CLASS_W

inherit

	EB_FORM_DIALOG
		rename
			make as form_d_make,
			popdown as form_d_popdown,
			display as form_d_display
		end;
	EB_CONSTANTS;
	COMMAND;
	WARNER_CALLBACKS
		rename
			execute_warner_help as choose_different_name,
			execute_warner_ok as keep_name
		end;
	SHARED_EIFFEL_PROJECT;
	WINDOWS;
	EIFFEL_ENV;
	WINDOW_ATTRIBUTES
	COMPILER_EXPORTER
	
creation

	make

feature -- Initialization

	make (a_tool: CLASS_W) is
		local
			separator: THREE_D_SEPARATOR
		do
			tool := a_tool;
			form_d_make (Interface_names.t_Empty, a_tool.popup_parent);
			set_title (Interface_names.t_New_class);
			!! class_l.make (Interface_names.t_Empty, Current);
			!! cluster_form.make (Interface_names.t_Empty, Current);
			!! cluster_name.make (Interface_names.t_Empty, cluster_form);
			!! cluster_list.make (Interface_names.t_Empty, cluster_form);
			!! file_form.make (Interface_names.t_Empty, Current);
			!! file_label.make (Interface_names.t_Empty, file_form);
			!! file_entry.make (Interface_names.t_Empty, file_form);
			!! form.make (Interface_names.t_Empty, Current);
			!! separator.make (Interface_names.t_Empty, Current);
			form.set_fraction_base (2);
			!! create_b.make (Interface_names.b_Create, form);
			!! cancel_b.make (Interface_names.b_Cancel, form);
			cluster_form.attach_top (cluster_list, 0);
			cluster_form.attach_left (cluster_name, 0);
			cluster_form.attach_right (cluster_list, 0);
			cluster_form.attach_left_widget (cluster_name, cluster_list, 5);
			cluster_form.attach_bottom (cluster_list, 5);
			file_form.attach_left (file_label, 0);
			file_form.attach_right (file_entry, 0);
			file_form.attach_left_widget (file_label, file_entry, 5);
			attach_top (class_l, 5);
			attach_left (class_l, 10);
			attach_left (file_form, 10);
			attach_left (cluster_form, 10);
			attach_top_widget (class_l, file_form, 5);
			attach_top_widget (file_form, cluster_form, 5);
			attach_bottom_widget (separator, cluster_form, 0);
			attach_bottom_widget (form, separator, 5);
			attach_left (separator, 5);
			attach_right (separator, 5);
			form.attach_left (create_b, 3);
			form.attach_top (create_b, 0);
			form.attach_bottom (create_b, 0);
			form.attach_right_position (create_b, 1);
			form.attach_left_position (cancel_b, 1);
			form.attach_right (cancel_b, 0);
			form.attach_top (cancel_b, 0);
			form.attach_bottom (cancel_b, 0);
			attach_right (cluster_form, 5);
			attach_right (file_form, 5);
			attach_left (form, 5);
			attach_right (form, 5);
			attach_bottom (form, 5);
			cluster_name.set_text (Interface_names.l_Cluster);
			file_label.set_text (Interface_names.l_File_name);
			file_entry.add_activate_action (Current, create_new_class);
			cancel_b.add_activate_action (Current, cancel);
			create_b.add_activate_action (Current, create_new_class);
			set_composite_attributes (Current);
			realize;
			set_exclusive_grab
		end;

feature -- Callbacks

	choose_different_name is
			-- The file name of the new class already exists.
			-- The user wants to choose another file name.
		do
			popup
		end;

	keep_name (argument: ANY) is
			-- The file name of the new class already exists.
			-- The user wants to keep it.
		do
			cluster.classes.put (class_i, class_name);
			tool.process_classi (stone)
		end;

feature -- Properties

	cluster_list: SCROLLABLE_LIST;

	file_entry: TEXT_FIELD;

	cluster_form, file_form: FORM;

	class_l: LABEL;

	cluster_name, file_label: LABEL;

	create_b, cancel_b: PUSH_B;

	form: FORM;

	create_new_class: ANY is
		once
			!!Result
		end;

	cancel: ANY is
		once
			!!Result
		end;

	cluster: CLUSTER_I;

	class_name: STRING;

	file_name: STRING;

	class_i: CLASS_I;

	stone: CLASSI_STONE;

	tool: CLASS_W;
			-- Class tool

	aok: BOOLEAN;

feature -- Settings

	display (new_width: INTEGER) is
		do
			set_width (new_width)
			form_d_display
		end

feature -- Access

	call (class_n: STRING; cl: CLUSTER_I) is
		require
			valid_args: class_n /= Void 
		local
			str, str2: STRING;
			clus_list: LINKED_LIST [CLUSTER_I];
			str_el: SCROLLABLE_LIST_STRING_ELEMENT;
			clus: CLUSTER_I
			new_width: INTEGER
		do
			cluster := cl;
			class_name := clone (class_n);
			str2 :=  clone (class_n);
			str2.to_upper;
			class_name.to_lower;
			!! str.make (0);
			str.append ("Class name: ");
			str.append (str2);
			class_l.set_text (str);	
			file_name := clone (class_name);
			file_name.append (".e");
			file_entry.set_text (file_name);
			new_width := file_name.count;
			clus_list := Eiffel_universe.clusters_sorted_by_tag
			if not clus_list.is_empty then
				from
					clus_list.start
				until
					clus_list.after
				loop
					clus := clus_list.item;
					if not (clus.is_precompiled or clus.is_library) then
						!! str_el.make (0);
						str_el.append (clus.cluster_name);
						cluster_list.extend (str_el);
						new_width := new_width.max (str_el.count)
					end;
					clus_list.forth
				end;
				if cluster_list.is_empty then
					create_b.set_insensitive
				else
					if cl = Void then
						cluster_list.select_i_th (1);
					else
						cluster_list.start;
						cluster_list.compare_objects;
						!! str_el.make (0);
						str_el.append (cl.cluster_name);
						cluster_list.search (str_el);
						if cluster_list.after then
							cluster_list.select_i_th (1);
						else
							cluster_list.select_item
						end;
						if cluster_list.count < 10 then
							cluster_list.set_visible_item_count (cluster_list.count)
						else
							cluster_list.set_visible_item_count (10);
						end
					end
				end
			else
				create_b.set_insensitive
			end;
			display ((200).max (new_width * 12))
		end;

	change_cluster is
			-- Howdy Howdy
		local
			clun: STRING;
			clu: CLUSTER_I; 
		do
			if cluster_list.selected_item /= Void then
				clun := cluster_list.selected_item.value; 
				clun.to_lower;
				clu := Eiffel_universe.cluster_of_name (clun);
				if clu = Void then
					aok := False;
					warner (tool.popup_parent).gotcha_call (Warning_messages.w_Invalid_cluster_name (clun))
				else
					aok := True;
					cluster := clu
				end;
			end;
		end;

	popdown is
			-- Popdown the cluster_list.
		do
			cluster_list.wipe_out;
			form_d_popdown
		end

feature -- Execution

	execute (argument: ANY) is
		local
			f_name: FILE_NAME;
			--file: PLAIN_TEXT_FILE;
			file: RAW_FILE; -- Windows specific 
			base_name: STRING;
		do
			if argument = create_new_class then
				change_cluster;
				file_name := file_entry.text;
				if aok then
					!! f_name.make_from_string (cluster.path);
					f_name.set_file_name (file_name);
					base_name := file_name;
					!! file.make (f_name);
					!! class_i.make (class_name)
					class_i.set_cluster (cluster);
					class_i.set_file_details (class_name, base_name);
					if cluster.has_base_name (base_name) then
						warner (tool.popup_parent).gotcha_call 
							(Warning_messages.w_Class_already_in_cluster (base_name));
					elseif
						(not file.exists and then not file.is_creatable)
					then
						warner (tool.popup_parent).gotcha_call (Warning_messages.w_Cannot_create_file (f_name))
					else 
						!! stone.make (class_i);
						if not file.exists then
							load_default_class_text (file);
							popdown;
						elseif
							not (file.is_readable and then file.is_plain)
						then
							popdown;
							warner (tool.popup_parent).gotcha_call (Warning_messages.w_Cannot_read_file (f_name))
						else
								--| Reading in existing file (created outside
								--| ebench). Ask for confirmation
							popdown;
							warner (tool.popup_parent).custom_call
								(Current, Warning_messages.w_File_exists_edit_it (f_name),
								" Edit ", "Select another file", Void)
						end;
					end;
				end;
			elseif argument = cancel then
				popdown
				if last_warner /= Void then
					last_warner.popdown
				end
			end;
		end;

	load_default_class_text (output: RAW_FILE) is
			-- Loads the default class text.
		local
			--input: PLAIN_TEXT_FILE;
			input: RAW_FILE;
			in_buf: STRING
		do
			!! input.make (Default_class_file);
			if input.exists and then input.is_readable then
				input.open_read;
				input.read_stream (input.count)
				in_buf := input.last_string
				in_buf.replace_substring_all ("$classname", stone.stone_signature);
				output.open_write;
				output.putstring (in_buf);
				output.close
			end;
			cluster.add_new_classs (class_i);
			!! stone.make (class_i);
			tool.process_classi (stone)
		end;

end -- class NEW_CLASS_W
