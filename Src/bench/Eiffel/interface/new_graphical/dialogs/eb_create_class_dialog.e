indexing
	description: "Dialog for choosing where to put a new class"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_CLASS_DIALOG

inherit
	EV_DIALOG
	NEW_EB_CONSTANTS
	EB_TOOL_COMMAND
		rename
			make as make_command
		redefine
			tool
		end
--	WARNER_CALLBACKS
--		rename
--			execute_warner_help as choose_different_name,
--			execute_warner_ok as keep_name
--		end
	SHARED_EIFFEL_PROJECT
	EB_SHARED_INTERFACE_TOOLS
	EIFFEL_ENV
--	WINDOW_ATTRIBUTES

creation

	make_default

feature -- Initialization

	make_default (a_tool: EB_CLASS_TOOL) is
		do
			make_command (a_tool)
			make (a_tool.parent_window)
			set_title (Interface_names.t_New_class)
			create name_frame.make_with_text (display_area, "Class name")
			display_area.set_child_expandable (name_frame, False)
			create class_l.make (name_frame)
			create file_frame.make_with_text (display_area, Interface_names.l_File_name)
			display_area.set_child_expandable (file_frame, False)
			create file_entry.make (file_frame)
			create cluster_frame.make_with_text (display_area, Interface_names.l_Cluster)
			create cluster_list.make (cluster_frame)
			create create_b.make_with_text (action_area, Interface_names.b_Create)
			create cancel_b.make_with_text (action_area, Interface_names.b_Cancel)

			file_entry.add_return_command (Current, create_new_class)
			cancel_b.add_click_command (Current, cancel)
			create_b.add_click_command (Current, create_new_class)
--			set_composite_attributes (Current)
			allow_resize
			set_modal (True)
		end

feature -- Callbacks

	choose_different_name is
			-- The file name of the new class already exists.
			-- The user wants to choose another file name.
		do
			show
		end

	keep_name (argument: ANY) is
			-- The file name of the new class already exists.
			-- The user wants to keep it.
		do
			cluster.classes.put (class_i, class_name)
			tool.process_class (stone)
		end

feature -- Properties

	cluster_list: EV_LIST

	file_entry: EV_TEXT_FIELD

	class_l: EV_LABEL

	name_frame, cluster_frame, file_frame: EV_FRAME

	create_b, cancel_b: EV_BUTTON

	create_new_class: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	edit_class: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	cancel: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	cluster: CLUSTER_I

	class_name: STRING

	file_name: STRING

	class_i: CLASS_I

	stone: CLASSI_STONE

	tool: EB_CLASS_TOOL
			-- Class tool

	aok: BOOLEAN

feature -- Settings

--	display (new_width: INTEGER) is
--		do
--			set_width (new_width)
--			form_d_display
--		end

feature -- Access

	call (class_n: STRING) is
		require
			valid_args: class_n /= Void 
		local
			str: STRING
			clus_list: LINKED_LIST [CLUSTER_I]
			clus: CLUSTER_I
			i: EV_LIST_ITEM
			new_width: INTEGER
		do
			cluster := tool.cluster
			str :=  clone (class_n)
			str.to_upper
			class_l.set_text (str)	
			class_name := clone (class_n)
			class_name.to_lower
			file_name := clone (class_name)
			file_name.append (".e")
			file_entry.set_text (file_name)
			new_width := file_name.count
			clus_list := Eiffel_universe.clusters_sorted_by_tag
			if not clus_list.empty then
				from
					clus_list.start
				until
					clus_list.after
				loop
					clus := clus_list.item
					if not clus.is_precompiled then
						create i.make_with_text (cluster_list, clus.cluster_name)
						i.set_data (clus)
						new_width := new_width.max (i.text.count)
					end
					clus_list.forth
				end
				if cluster_list.count = 0 then
					create_b.set_insensitive (True)
				else
					i := Void
					if cluster /= Void then
						i := cluster_list.find_item_by_data (cluster)
					end
					if i = Void then
						i := cluster_list.get_item (1)
					end
					i.set_selected (True)
--					if cluster_list.count < 10 then
--						cluster_list.set_visible_item_count (cluster_list.count)
--					else
--						cluster_list.set_visible_item_count (10)
--					end
				end
			else
				create_b.set_insensitive (True)
			end
			show
--			display ((200).max (new_width * 12))
		end

	change_cluster is
			-- Howdy Howdy
		local
			clu_n: STRING
			clu: CLUSTER_I 
			wd: EV_WARNING_DIALOG
		do
			if cluster_list.selected_item /= Void then
				clu_n := cluster_list.selected_item.text
				clu_n.to_lower
				clu := Eiffel_universe.cluster_of_name (clu_n)
				if clu = Void then
					aok := False
					create wd.make_default (tool.parent_window, Interface_names.t_Warning, Warning_messages.w_Invalid_cluster_name)
				else
					aok := True
					cluster := clu
				end
			end
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		local
			f_name: FILE_NAME
			--file: PLAIN_TEXT_FILE
			file: RAW_FILE -- Windows specific 
			str: STRING
			base_name: STRING
			wd: EV_WARNING_DIALOG
		do
			if argument = create_new_class then
				change_cluster
				file_name := file_entry.text
				if aok then
					create f_name.make_from_string (cluster.path)
					f_name.set_file_name (file_name)
					base_name := file_name
					create file.make (f_name)
					create class_i.make_with_cluster (cluster)
					class_i.set_file_details (class_name, base_name)
					if cluster.has_base_name (base_name) then
						create wd.make_default (tool.parent_window, Interface_names.t_Warning,
							Warning_messages.w_Class_already_in_cluster (base_name))
					elseif
						(not file.exists and then not file.is_creatable)
					then
						create wd.make_default (tool.parent_window, Interface_names.t_Warning,
							Warning_messages.w_Cannot_create_file (f_name))
					else 
						create stone.make (class_i)
						if not file.exists then
							load_default_class_text (file)
							destroy
						elseif
							not (file.is_readable and then file.is_plain)
						then
							create wd.make_default (tool.parent_window, Interface_names.t_Warning,
								Warning_messages.w_Cannot_create_file (f_name))
							destroy
						else
								--| Reading in existing file (created outside
								--| ebench). Ask for confirmation
							create wd.make_with_text (tool.parent_window, Interface_names.t_Warning,
								Warning_messages.w_File_exists_edit_it (f_name))
							wd.show_ok_cancel_buttons
							wd.add_ok_command (Current, Edit_class)
							wd.show
						end
					end
				end
			elseif argument = Edit_class then
					-- The file name of the new class already exists.
					-- The user wants to keep it.
				cluster.classes.put (class_i, class_name)
				tool.process_class (stone)
			elseif argument = cancel then
				destroy
			end
		end

	load_default_class_text (output: RAW_FILE) is
			-- Loads the default class text.
		local
			--input: PLAIN_TEXT_FILE
			input: RAW_FILE
			in_buf: STRING
		do
			create input.make (Default_class_file)
			if input.exists and then input.is_readable then
				input.open_read
				input.read_stream (input.count)
				in_buf := input.last_string
				in_buf.replace_substring_all ("$classname", stone.stone_signature)
				output.open_write
				output.putstring (in_buf)
				output.close
			end
			cluster.add_new_classs (class_i)
			create stone.make (class_i)
			tool.process_class (stone)
		end

end -- class EB_CREATE_CLASS_DIALOG
