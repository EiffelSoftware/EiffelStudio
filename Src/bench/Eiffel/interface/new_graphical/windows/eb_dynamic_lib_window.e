indexing
	description	: "Window to create dynamic libraries"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DYNAMIC_LIB_WINDOW

inherit
	EB_WINDOW
		redefine
			make,
			refresh,
			build_file_menu,
			build_edit_menu,
			build_menu_bar,
			init_commands,
			init_size_and_position,
			destroy
		end

	SHARED_EIFFEL_PROJECT

	SHARED_RESOURCES
		rename
			initialized as resources_initialized
		export
			{NONE} all
		end

	PLATFORM_CONSTANTS

creation {EB_WINDOW_MANAGER}
	make

feature {NONE} -- Initialization

	make is
			-- Create a new tool with `man' as manager.
		do
			Precursor {EB_WINDOW}
			create exports.make (10)
		end

	build_interface is
		local
			vb: EV_VERTICAL_BOX
			w: INTEGER
			iw: INTEGER
			ccw: INTEGER
			f: EV_FONT
			sep: EV_HORIZONTAL_SEPARATOR
		do
			set_title (Interface_names.t_Dynamic_lib_window)
			build_tool_bar
			enable_accelerators
			create vb
			create sep
			vb.extend (sep)
			vb.disable_item_expand (sep)
			vb.extend (tool_bar)
			vb.disable_item_expand (tool_bar)
			create exports_list
			if is_windows then
				exports_list.set_column_titles (<<Interface_names.t_Class, Interface_names.t_Creation_routine, Interface_names.t_Exported_feature, Interface_names.t_Alias, Interface_names.t_Index, Interface_names.t_Calling_convention>>)
			else
				exports_list.set_column_titles (<<Interface_names.t_Class, Interface_names.t_Creation_routine, Interface_names.t_Exported_feature, Interface_names.t_Alias>>)
			end
			exports_list.select_actions.extend (~item_selected)
			exports_list.deselect_actions.extend (~item_deselected)
			exports_list.drop_actions.extend (~drop_feature)
			exports_list.disable_multiple_selection
			vb.extend (exports_list)
			window.extend (vb)
			
				-- We give correct sizes to the columns.
				-- A definite size for index and calling convention, the rest for the other columns.
			f := create {EV_FONT}
			
				--| Because of naughty Vision2, the multi_column_list doesn't know its size until it is displayed.
			--w := exports_list.width
			w := initial_width - 10
			if is_windows then
					-- Width of the `Index' column.
				iw := f.string_width ("Index") + 30
					-- Width of the `Calling convention' column.
				from
					valid_calling_conventions.start
				until
					valid_calling_conventions.after
				loop
					ccw := ccw.max (f.string_width (valid_calling_conventions.item))
					valid_calling_conventions.forth
				end
				ccw := ccw + 40
				w := w - iw - ccw
			end
				-- There remains 4 columns.
			w := w // 4
			if is_windows then
				exports_list.set_column_widths (<<w, w, w, w, iw, ccw>>)
			else
				exports_list.set_column_widths (<<w, w, w, w>>)
			end
		end

	init_size_and_position is
			-- Retrieve the size of `Current' from the preferences and affect it.
		do
			window.set_size (initial_width, initial_height)
		end

	init_commands is
			-- Create all the commands `Current' uses.
		local
			kcsts: EV_KEY_CONSTANTS
		do
			create kcsts
				-- Create `new_cmd'.
			create new_cmd.make
			new_cmd.set_pixmaps (Pixmaps.Icon_new_dynamic_lib)
			new_cmd.set_tooltip (Interface_names.e_New_dynamic_lib_definition)
			new_cmd.set_menu_name (Interface_names.m_New)
			new_cmd.set_name ("new_dynamic_lib_definition")
			new_cmd.set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
					create {EV_KEY}.make_with_code (kcsts.Key_n), True, False, False))
			new_cmd.add_agent (~new_def_file)
			new_cmd.enable_sensitive
			
				-- Create `open_cmd'.
			create open_cmd.make
			open_cmd.set_pixmaps (Pixmaps.Icon_open_file)
			open_cmd.set_tooltip (Interface_names.e_Open_dynamic_lib_definition)
			open_cmd.set_menu_name (Interface_names.m_Open_new)
			open_cmd.set_name ("open_dynamic_lib_definition")
			open_cmd.add_agent (~open_def_file)
			open_cmd.set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
					create {EV_KEY}.make_with_code (kcsts.Key_o), True, False, False))
			open_cmd.enable_sensitive
			
				-- Create `save_cmd'.
			create save_cmd.make
			save_cmd.set_pixmaps (Pixmaps.Icon_save)
			save_cmd.set_tooltip (Interface_names.e_Save_dynamic_lib_definition)
			save_cmd.set_menu_name (Interface_names.m_Save_new)
			save_cmd.set_name ("save_dynamic_lib_definition")
			save_cmd.add_agent (~save_def_file)
			save_cmd.set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
					create {EV_KEY}.make_with_code (kcsts.Key_s), True, False, False))
			save_cmd.enable_sensitive
			
				-- Create `save_as_cmd'.
			create save_as_cmd.make
			save_as_cmd.set_menu_name (Interface_names.m_Save_as)
			save_as_cmd.set_name ("save_dynamic_lib_definition_as")
			save_as_cmd.add_agent (~save_def_file_as)
			save_as_cmd.enable_sensitive
			
				-- Create `add_feature_cmd'.
			create add_feature_cmd.make
			add_feature_cmd.set_pixmaps (Pixmaps.Icon_add_exported_feature)
			add_feature_cmd.set_tooltip (Interface_names.e_Add_exported_feature)
			add_feature_cmd.set_menu_name (Interface_names.	m_Add_exported_feature)
			add_feature_cmd.set_name ("add_exported_feature")
			add_feature_cmd.add_agent (~add_feature)
			add_feature_cmd.set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
					create {EV_KEY}.make_with_code (kcsts.Key_a), True, False, False))
			add_feature_cmd.enable_sensitive
			
				-- Create `edit_feature_cmd'.
			create edit_feature_cmd.make
			edit_feature_cmd.set_pixmaps (Pixmaps.Icon_edit_exported_feature)
			edit_feature_cmd.set_tooltip (Interface_names.e_Edit_exported_feature)
			edit_feature_cmd.set_menu_name (Interface_names.m_Edit_exported_feature)
			edit_feature_cmd.set_name ("edit_exported_feature")
			edit_feature_cmd.add_agent (~edit_selected_feature)
			edit_feature_cmd.set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
					create {EV_KEY}.make_with_code (kcsts.Key_e), True, False, False))
			edit_feature_cmd.disable_sensitive
			
				-- Create `remove_feature_cmd'.
			create remove_feature_cmd.make
			remove_feature_cmd.set_pixmaps (Pixmaps.Icon_remove_exported_feature)
			remove_feature_cmd.set_tooltip (Interface_names.e_Remove_exported_feature)
			remove_feature_cmd.set_menu_name (Interface_names.m_Remove_exported_feature)
			remove_feature_cmd.set_name ("remove_exported_feature")
			remove_feature_cmd.add_agent (~remove_selected_feature)
			remove_feature_cmd.set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
					create {EV_KEY}.make_with_code (kcsts.Key_delete), False, False, False))
			remove_feature_cmd.disable_sensitive
			
				-- Create `check_exports_cmd'.
			create check_exports_cmd.make
			check_exports_cmd.set_pixmaps (Pixmaps.Icon_check_exports)
			check_exports_cmd.set_tooltip (Interface_names.e_Check_exports)
			check_exports_cmd.set_menu_name (Interface_names.m_Check_exports)
			check_exports_cmd.set_name ("check_exports")
			check_exports_cmd.add_agent (~check_exported_features)
			check_exports_cmd.set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
					create {EV_KEY}.make_with_code (kcsts.Key_c), True, False, False))
			check_exports_cmd.enable_sensitive
		end
			
	build_file_menu is
			-- Create and build `file_menu'.
		local
			menu_item: EV_MENU_ITEM
			menu_sep: EV_MENU_SEPARATOR
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			create file_menu.make_with_text (Interface_names.m_File)

			command_menu_item := new_cmd.new_menu_item
			file_menu.extend (command_menu_item)
			add_recyclable (command_menu_item)

			command_menu_item := open_cmd.new_menu_item
			file_menu.extend (command_menu_item)
			add_recyclable (command_menu_item)

			command_menu_item := save_cmd.new_menu_item
			file_menu.extend (command_menu_item)
			add_recyclable (command_menu_item)

			command_menu_item := save_as_cmd.new_menu_item
			file_menu.extend (command_menu_item)
			add_recyclable (command_menu_item)

			create menu_sep
			file_menu.extend (menu_sep)

			create menu_item.make_with_text (Interface_names.m_Close)
			menu_item.select_actions.extend (~destroy)
			file_menu.extend (menu_item)
		end

	build_edit_menu is
			-- Generate `edit_menu'.
		local
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			create edit_menu.make_with_text (Interface_names.m_Edit)

			command_menu_item := add_feature_cmd.new_menu_item
			edit_menu.extend (command_menu_item)
			add_recyclable (command_menu_item)

			command_menu_item := edit_feature_cmd.new_menu_item
			edit_menu.extend (command_menu_item)
			add_recyclable (command_menu_item)

			command_menu_item := remove_feature_cmd.new_menu_item
			edit_menu.extend (command_menu_item)
			add_recyclable (command_menu_item)

			command_menu_item := check_exports_cmd.new_menu_item
			edit_menu.extend (command_menu_item)
			add_recyclable (command_menu_item)
		end

	build_menu_bar is
			-- Generate `menu_bar' and fill it with the correct menus.
		local
			mb: EV_MENU_BAR
		do
			create mb
			mb.extend (file_menu)
			mb.extend (edit_menu)
			window.set_menu_bar (mb)
		end

	build_tool_bar is
			-- Create `toolbar' and display it.
		local
			tb: EV_TOOL_BAR
			tbit: EB_COMMAND_TOOL_BAR_BUTTON
			sep: EV_VERTICAL_SEPARATOR
		do
			create tool_bar
			create tb
			tbit := new_cmd.new_toolbar_item (False, False)
			tb.extend (tbit)
			add_recyclable (tbit)
			
			tbit := open_cmd.new_toolbar_item (False, False)
			tb.extend (tbit)
			add_recyclable (tbit)
			
			tbit := save_cmd.new_toolbar_item (False, False)
			tb.extend (tbit)
			add_recyclable (tbit)
			
			tool_bar.extend (tb)
			tool_bar.disable_item_expand (tb)
			create sep
			tool_bar.extend (sep)
			tool_bar.disable_item_expand (sep)
			
			create tb
			tbit := check_exports_cmd.new_toolbar_item (False, False)
			tb.extend (tbit)
			add_recyclable (tbit)

			tbit := add_feature_cmd.new_toolbar_item (False, False)
			tb.extend (tbit)
			add_recyclable (tbit)
			
			tbit := edit_feature_cmd.new_toolbar_item (False, False)
			tb.extend (tbit)
			add_recyclable (tbit)
			
			tbit := remove_feature_cmd.new_toolbar_item (False, False)
			tb.extend (tbit)
			add_recyclable (tbit)
			
			tool_bar.extend (tb)
			tool_bar.disable_item_expand (tb)
		end

	enable_accelerators is
			-- Enable the accelerators of all commands.
		local
			acc: EV_ACCELERATOR
		do
			acc := new_cmd.accelerator
			if acc /= Void then
				window.accelerators.extend (acc)
			end
			acc := open_cmd.accelerator
			if acc /= Void then
				window.accelerators.extend (acc)
			end
			acc := save_cmd.accelerator
			if acc /= Void then
				window.accelerators.extend (acc)
			end
			acc := save_as_cmd.accelerator
			if acc /= Void then
				window.accelerators.extend (acc)
			end
			acc := remove_feature_cmd.accelerator
			if acc /= Void then
				window.accelerators.extend (acc)
			end
			acc := add_feature_cmd.accelerator
			if acc /= Void then
				window.accelerators.extend (acc)
			end
			acc := edit_feature_cmd.accelerator
			if acc /= Void then
				window.accelerators.extend (acc)
			end
			acc := check_exports_cmd.accelerator
			if acc /= Void then
				window.accelerators.extend (acc)
			end
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap representing Current window.
		do
			Result := Pixmaps.Icon_dynamiclib_window
		end

	changed: BOOLEAN
			-- Are there unsaved modifications?

feature -- Status setting

	give_focus is
			-- Grab the focus.
		do
			exports_list.set_focus
		end

	destroy is
			-- Destroy `Current'.
		local
			cd: EV_CONFIRMATION_DIALOG
		do
			if changed and not confirmed then
				create cd.make_with_text (Warning_messages.w_Unsaved_changes)
				cd.button ("OK").select_actions.extend (~force_destroy)
				cd.show_modal_to_window (window)
			else
				Precursor {EB_WINDOW}
			end
		end

feature -- Basic operations

	save is
			-- Save `Current's state into a .def file.
			-- May be cancelled by the user.
		do
			save_def_file
		end

feature -- Stone process

	refresh is
			-- Synchronize the display with the internal dynamic library representation.
		do
			refresh_list
		end

	synchronize is
			-- A compilation is over, update `Current's internal state.
		local
			exp: DYNAMIC_LIB_EXPORT_FEATURE
		do
			from
				exports.start
			until
				exports.after
			loop
				exp := exports.item
				exp.synchronize
				if valid_exported_feature (exp) then
					exports.forth
				else
					exports.remove
					changed := True
				end
			end
			refresh_list
		end

feature -- Basic operation

feature -- Window Settings

feature -- Formats

feature {NONE} -- Status

	exports: ARRAYED_LIST [DYNAMIC_LIB_EXPORT_FEATURE]
			-- The abstract representation for all the exported features.
	
	file_name: FILE_NAME
			-- The name of the file we are currently working on.
			-- May be Void if no file is loaded.

feature {NONE} -- Implementation: File operations

	open_def_file is
			-- Let the user select a `.def' file and open it.
			-- Cancelling is possible.
		local
			cd: EV_CONFIRMATION_DIALOG
		do
			if changed then
				create cd.make_with_text (Warning_messages.w_Unsaved_changes)
				cd.button ("OK").select_actions.extend (~ask_for_file_name (True, ~load_dynamic_lib))
				cd.show_modal_to_window (window)
			else
				ask_for_file_name (True, ~load_dynamic_lib)
			end
		end

	save_def_file is
			-- Write the contents of `Current' to `file_name' if any,
			-- Prompt the user for a file name otherwise.
			-- Cancelling is possible.
		local
			qd: EV_QUESTION_DIALOG
			pb: INTEGER
		do
			pb := export_definition_problem
			if pb = 0 then
				actually_save
			else
				create qd.make_with_text (Warning_messages.w_Save_invalid_definition)
				qd.button ("Yes").select_actions.extend (~actually_save)
				qd.show_modal_to_window (window)
			end
		end

	save_def_file_as is
			-- Prompt the user for a file name and save the contents of `Current' to it.
			-- Cancelling is possible.
		local
			qd: EV_QUESTION_DIALOG
			pb: INTEGER
		do
			pb := export_definition_problem
			if pb = 0 then
				ask_for_file_name (False, ~actually_save)
			else
				create qd.make_with_text (Warning_messages.w_Save_invalid_definition)
				qd.button ("Yes").select_actions.extend (~ask_for_file_name (False, ~actually_save))
				qd.show_modal_to_window (window)
			end
		end

	new_def_file is
			-- Prompt the user for a file name and create a new `.def' file.
			-- Cancelling is possible.
		local
			cd: EV_CONFIRMATION_DIALOG
		do
			if changed then
				create cd.make_with_text (Warning_messages.w_Unsaved_changes)
				cd.button ("OK").select_actions.extend (~reset)
				cd.show_modal_to_window (window)
			else
				reset
			end
		end

	actually_save is
			-- Save the definition whether or not there are errors.
		do
			save_ok := False
			save_to_dynamic_lib
			save_dynamic_lib
			if save_ok then
				changed := False
			end
		end

	force_destroy is
			-- Destroy without asking.
		do
			confirmed := True
			destroy
		end

	confirmed: BOOLEAN
			-- Did the user already confirm he wanted to exit?

feature {NONE} -- Implementation: Feature operations

	add_feature is
			-- Prompt the user for a feature to add to the list.
			-- May be cancelled.
		do
			create_properties_dialog (False)
			properties_dialog.show_modal_to_window (window)
		end

	drop_feature (fst: FEATURE_STONE) is
			-- Add the dropped feature associated to `fst' to the list.
			-- Prompt the user for the creation routine, if necessary.
			-- May be cancelled.
		local
			wd: EV_WARNING_DIALOG
		do
			current_class := fst.e_feature.associated_class
			current_feature := fst.e_feature
			if not valid_class (current_class) then
				create wd.make_with_text (Warning_messages.w_Class_cannot_export)
				wd.show_modal_to_window (window)
			elseif not valid_feature (current_feature, current_class) then
				create wd.make_with_text (Warning_messages.w_Feature_cannot_be_exported)
				wd.show_modal_to_window (window)
			else
				current_creation_routine := Void
				current_alias := Void
				current_index := 0
				current_calling_convention := Void
				choose_creation_routine (~generate_new_exported_feature)
			end
		end

	edit_selected_feature is
			-- Modify the exportation properties of the selected feature.
		local
			sel: EV_MULTI_COLUMN_LIST_ROW
		do
			sel := exports_list.selected_item
			if sel /= Void then
				modified_exported_feature ?= sel.data
				if modified_exported_feature /= Void then
					create_properties_dialog (True)
					initialize_modification_dialog
					properties_dialog.show_modal_to_window (window)
				end
			end
		end

	remove_selected_feature is
			-- Remove the selected feature from the exported features.
		local
			sel: EV_MULTI_COLUMN_LIST_ROW
			f: DYNAMIC_LIB_EXPORT_FEATURE
		do
			sel := exports_list.selected_item
			if sel /= Void then
				f ?= sel.data
				if f /= Void then
					changed := True
					exports.start
					exports.prune_all (f)
					refresh_list
				end
			end
		end

	check_exported_features is
			-- Check the validity of the exported features,
			-- both one at a time and globally.
		local
			pb: INTEGER
			id: EV_INFORMATION_DIALOG
			err: EV_MULTI_COLUMN_LIST_ROW
		do
			pb := export_definition_problem
			if pb = 0 then
				create id.make_with_text (Warning_messages.w_No_errors_found)
			elseif pb = -1 then
				create id.make_with_text (Warning_messages.w_Conflicting_exports)
			else
				err := exports_list.i_th (pb)
				if err /= Void then
					err.enable_select
				end
				create id.make_with_text (Warning_messages.w_Invalid_feature_exportation)
			end
			id.show_modal_to_window (window)
		end

	reset is
			-- Wipe out all data (`file_name', `exports' and `exports_list').
		do
			exports.wipe_out
			exports_list.wipe_out
			file_name := Void
		end

feature {NONE} -- Implementation: Basic event handling

	item_selected (it: EV_MULTI_COLUMN_LIST_ROW) is
			-- An item was selected in `exports_list'. Enable the related commands.
		do
			edit_feature_cmd.enable_sensitive
			remove_feature_cmd.enable_sensitive
		end

	item_deselected (it: EV_MULTI_COLUMN_LIST_ROW) is
			-- An item was selected in `exports_list'. Enable the related commands.
		do
			edit_feature_cmd.disable_sensitive
			remove_feature_cmd.disable_sensitive
		end

feature {NONE} -- Implementation: Graphical interface

	exports_list: EV_MULTI_COLUMN_LIST
			-- The list displaying all currently exported features.
	
	tool_bar: EV_HORIZONTAL_BOX
			-- The container of `Current's toolbar.

	new_cmd: EB_STANDARD_CMD
			-- Command to create a new '.def' file.

	open_cmd: EB_STANDARD_CMD
			-- Command to open a '.def' file.

	save_cmd: EB_STANDARD_CMD
			-- Command to save the current '.def' file.

	save_as_cmd: EB_STANDARD_CMD
			-- Command to save a '.def' file.

	remove_feature_cmd: EB_STANDARD_CMD
			-- Command to remove an exported feature.

	add_feature_cmd: EB_STANDARD_CMD
			-- Command to add an exported feature.

	edit_feature_cmd: EB_STANDARD_CMD
			-- Command to modify the export status of an exported feature.

	check_exports_cmd: EB_STANDARD_CMD
			-- Command to check the validity of the library definition as a whole.

	initial_width: INTEGER is
			-- Initial width for the dialog.
		do
			Result := integer_resource_value ("dyn_lib_window_width", 400)
		end

	initial_height: INTEGER is
			-- Initial width for the dialog.
		do
			Result := integer_resource_value ("dyn_lib_window_height", 200)
		end

	save_width_and_height is
			-- Save current width and height to the preferences.
		do
			set_integer_resource ("dyn_lib_window_width", window.width)
			set_integer_resource ("dyn_lib_window_height", window.height)
		ensure
			size_saved: initial_width = window.width and 
						initial_height = window.height
		end

	refresh_list is
			-- Refresh `exports_list' according to `exports'.
		local
			sel: EV_MULTI_COLUMN_LIST_ROW
		do
			sel := exports_list.selected_item
			exports_list.wipe_out
			from
				exports.start
			until
				exports.after
			loop
				exports_list.extend (feature_to_row (exports.item))
				exports.forth
			end
			if sel /= Void then
				item_deselected (sel)
			end
		end

	feature_to_row (exp: DYNAMIC_LIB_EXPORT_FEATURE): EV_MULTI_COLUMN_LIST_ROW is
			-- Convert `exp' into a row for `exports_list'.
		require
			feature_not_void: exp /= Void
		do
			create Result
			Result.set_data (exp)
			if exp.compiled_class /= Void then
				Result.extend (exp.compiled_class.name_in_upper)
			else
				Result.extend (empty_string)
			end
			if exp.creation_routine /= Void then
				Result.extend (exp.creation_routine.name)
			else
				Result.extend (empty_string)
			end
			if exp.routine /= Void then
				Result.extend (exp.routine.name)
			else
				Result.extend (empty_string)
			end
			if exp.alias_name /= Void then
				Result.extend (exp.alias_name)
			else
				Result.extend (empty_string)
			end
			if is_windows then
				if exp.index /= 0 then
					Result.extend (exp.index.out)
				else
					Result.extend (empty_string)
				end
				if exp.call_type /= Void then
					Result.extend (exp.call_type)
				else
					Result.extend (empty_string)
				end
			end
		end

	empty_string: STRING is ""

feature {NONE} -- Implementation: Creation routine selection

	choose_creation_routine (next_action: PROCEDURE [ANY, TUPLE []]) is
			-- If possible, find a valid creation routine of `current_class',
			-- and set `current_creation_routine' after asking the user if necessary.
			-- Call `next_action' iff a creation routine was chosen.
		require
			current_class_set: valid_class (current_class)
		local
			wd: EV_WARNING_DIALOG
		do
			call_back := next_action
			creation_routine_list := valid_creation_routines (current_class)
			if creation_routine_list /= Void then
				if creation_routine_list.count = 1 then
					current_creation_routine := creation_routine_list.first
					next_action.call ([])
				elseif creation_routine_list.count > 1 then
					display_creation_routine_choice
				else
						--| Nothing to choose.
					create wd.make_with_text (Warning_messages.w_No_valid_creation_routine)
					wd.show_modal_to_window (window)
				end
			else
					--| Nothing to choose.
				create wd.make_with_text (Warning_messages.w_No_valid_creation_routine)
				wd.show_modal_to_window (window)
			end
		end

	valid_creation_routines (cl:CLASS_C): LIST [E_FEATURE] is
			-- Calculate the list of valid creation procedure.
		require
			valid_class_c: cl /= Void and then cl.has_feature_table
		local
			list_creators: ARRAY [STRING]
			tmp_creation: E_FEATURE
			dfcr: FEATURE_I
			i, max: INTEGER
		do
			create {ARRAYED_LIST [E_FEATURE]} Result.make (5)
			if cl.creators /= Void then
				list_creators ?= cl.creators.current_keys
				if list_creators /= Void then
					max := list_creators.upper
					from
						i := list_creators.lower
					until
						i > max
					loop
						tmp_creation := cl.feature_with_name (list_creators @ i)
						if tmp_creation /= Void and then not tmp_creation.has_arguments then
							Result.extend (tmp_creation)
						end
						i := i + 1
					end
				end
			else
				dfcr := cl.default_create_feature
				if dfcr /= Void then
					Result.extend (dfcr.api_feature (cl.class_id))
				end
			end
		ensure
			not_void_result: Result /= Void
			only_valid_creation_routines: Result.for_all (~valid_creation_routine (?, cl))
		end

	display_creation_routine_choice is
			-- Display feature names from `creation_routine_list' to `choice'.
		require
			feature_list_not_void: creation_routine_list /= Void
			feature_list_has_several_elements: creation_routine_list.count > 1
		local
			choice: EB_CHOICE_DIALOG
			feature_names: ARRAYED_LIST [STRING]
		do
			create feature_names.make (creation_routine_list.count)
			from
				creation_routine_list.start
			until
				creation_routine_list.after
			loop
				feature_names.extend (creation_routine_list.item.name)
				creation_routine_list.forth
			end
			if not feature_names.is_empty then
				if feature_names.count = 1 then
					process_creation_routine_callback (1)
				else
					create choice.make_default (~process_creation_routine_callback (?))
					choice.set_title (Interface_names.t_Select_feature)
					choice.set_list (feature_names)
					choice.set_position (window.screen_x + window.width // 3, window.screen_y + window.height // 3)
					choice.show
				end
			else
				-- No creation routine is available
			end
		end

	process_creation_routine_callback (pos: INTEGER) is
			-- The choice `pos' has been selected, process the choice.
		require
			looking_for_a_creation_routine: creation_routine_list /= Void
		do
			if pos > 0 then
				current_creation_routine := creation_routine_list.i_th (pos)
			end
			creation_routine_list := Void
			call_back.call ([])
		end

	creation_routine_list: LIST [E_FEATURE]
			-- The creation routines of `current_class' among which the user may choose.

	call_back: PROCEDURE [ANY, TUPLE []]
			-- What should be executed after choosing a creation routine.

feature {NONE} -- Implementation: Low_level dialog, file operations

	save_to_dynamic_lib is
			-- Save the current `exports' to `dynamic_library'.
		local
			exp: DYNAMIC_LIB_EXPORT_FEATURE
		do
			create dynamic_library
				-- This is necessary because the E_DYNAMIC_LIB's content is once (!).
			dynamic_library.dynamic_lib_exports.clear_all
			from
				exports.start
			until
				exports.after
			loop
				exp := exports.item
				if valid_exported_feature (exp) then
					dynamic_library.add_export_feature (exp.compiled_class, exp.creation_routine,
						exp.routine, exp.index, exp.alias_name, exp.call_type)
				end
				exports.forth
			end
		end

	save_dynamic_lib is
			-- Write the contents of `dynamic_lib' to `file_name'.
		require
			valid_dynamic_library: dynamic_library /= Void
		local
			wd: EV_WARNING_DIALOG
			rescued: BOOLEAN
			f: PLAIN_TEXT_FILE
		do
			save_ok := False
			if not rescued then
				if file_name /= Void then
						-- It is really a save operation.
					create f.make_create_read_write (file_name)
					dynamic_library.save_to_file (f)
					f.close
					save_ok := True
				else
						-- It is really a save as operation.
					ask_for_file_name (False, ~save_dynamic_lib)
				end
			else
				if file_name /= Void then
					create wd.make_with_text (Warning_messages.w_Cannot_save_library (file_name))
					wd.show_modal_to_window (window)
				end
			end
		rescue
			rescued := True
			retry
		end

	save_ok: BOOLEAN
			-- Was the last save effective?

	load_ok: BOOLEAN
			-- Was the last load effective?

	load_dynamic_lib is
			-- Initialize `dynamic_lib' from `file_name'.
		local
			wd: EV_WARNING_DIALOG
			rescued: BOOLEAN
			f: PLAIN_TEXT_FILE
		do
			if not rescued then
				if file_name /= Void then
					create dynamic_library
					create f.make_open_read (file_name)
					if not (dynamic_library.parse_exports_from_file (f)) then
						create wd.make_with_text (Warning_messages.w_Error_parsing_the_library_file)
						wd.show_modal_to_window (window)
					end
					f.close
					load_ok := False
					load_from_dynamic_lib
					if load_ok then
						changed := False
					end
				else
					ask_for_file_name (True, ~load_dynamic_lib)
				end
			else
				if file_name /= Void then
					create wd.make_with_text (Warning_messages.w_Cannot_load_library (file_name))
					wd.show_modal_to_window (window)
				end
			end
		rescue
			rescued := True
			retry
		end

	load_from_dynamic_lib is
			-- Retrieve the information in `dynamic_library' definition to initialize `Current'.
		require
			dynamic_library_initialized: dynamic_library /= Void
		local
			dynamic_lib_exports: HASH_TABLE [LINKED_LIST[DYNAMIC_LIB_EXPORT_FEATURE],INTEGER]
			exp_list: LINKED_LIST[DYNAMIC_LIB_EXPORT_FEATURE]
		do
			dynamic_lib_exports := dynamic_library.dynamic_lib_exports
			exports.wipe_out
			exports_list.wipe_out
			from
				dynamic_lib_exports.start
			until
				dynamic_lib_exports.after
			loop
				exp_list := dynamic_lib_exports.item_for_iteration
				from
					exp_list.start
				until
					exp_list.after
				loop
					exports.extend (exp_list.item)
					exports_list.extend (feature_to_row (exp_list.item))
					exp_list.forth
				end
				dynamic_lib_exports.forth
			end
			load_ok := True
		end

	ask_for_file_name (load: BOOLEAN; next_action: PROCEDURE [ANY, TUPLE []]) is
			-- Prompt the user for a `.def' file, set `file_name' to the chosen file name, and execute `next_action'.
			-- If `load' then we assume we want to open a file. Otherwise we want to save it.
		local
			dd: EV_FILE_DIALOG
		do
			file_call_back := next_action
			if load then
				create {EV_FILE_OPEN_DIALOG} dd
			else
				create {EV_FILE_SAVE_DIALOG} dd
			end
			dd.set_start_directory (Eiffel_project.name)
			dd.set_filter ("*.def")
			dd.ok_actions.extend (~file_was_chosen (dd))
			dd.show_modal_to_window (window)
		end

	file_was_chosen (dd: EV_FILE_DIALOG) is
			-- The user selected a file in `dd'.
			-- Set `file_name' accordingly and call `file_call_back'.
		require
			valid_dialog: dd /= Void
		local
			fn: FILE_NAME
			tmpfn: STRING
		do
			tmpfn := dd.file_name
			if not tmpfn.is_empty then
				create fn.make_from_string (tmpfn)
				if not (tmpfn.substring (tmpfn.count - 3, tmpfn.count)).is_equal (".def") then
					fn.add_extension ("def")
				end
				file_name := fn
				file_call_back.call ([])
			end
		end

	dynamic_library: E_DYNAMIC_LIB
			-- Helper to read/write .def files.

	file_call_back: PROCEDURE [ANY, TUPLE []]
			-- Action performed after a file has been chosen.

feature {NONE} -- Implementation: Feature creation

	generate_new_exported_feature is
			-- Effectively add an element to `exports' and `exports_list'.
		require
			valid_export: valid_export_parameters (current_class, current_creation_routine, current_feature,
												current_alias, current_index, current_calling_convention)
		local
			exp: DYNAMIC_LIB_EXPORT_FEATURE
		do
			if current_feature = current_creation_routine then
				current_feature := Void
			end
			create exp.make (current_class, current_creation_routine, current_feature)
			if current_alias /= Void then
				exp.set_alias_name (current_alias)
			end
			if current_index /= 0 then
				exp.set_index (current_index)
			end
			if current_calling_convention /= Void then
				exp.set_call_type (current_calling_convention)
			end
			exports.extend (exp)
			exports_list.extend (feature_to_row (exp))
			changed := True
		ensure
			new_export_displayed: exports_list.count = (old exports_list.count) + 1
			new_export_stored: exports.count = (old exports.count) + 1
		end

	current_class: CLASS_C
			-- The class from which a new feature should be exported.
	
	current_creation_routine: E_FEATURE
			-- The creation routine used to create `current_class' when exporting `current_feature'.
	
	current_feature: E_FEATURE
			-- The new feature that should be exported.
	
	current_alias: STRING
			-- Name under which `current_feature' should be exported.
	
	current_index: INTEGER
			-- Index in the dynamic library which should correspond to `current_feature'.
	
	current_calling_convention: STRING
			-- Calling convention that should be used to call `current_feature' in the dynamic library.

feature {NONE} -- Implementation: Properties dialog

	create_properties_dialog (for_modification: BOOLEAN) is
			-- Generate `properties_dialog' and if `for_modification', give it a layout of modification dialog.
		require
			possible_to_modify: for_modification implies modified_exported_feature /= Void and then
					modified_exported_feature.routine /= Void and then modified_exported_feature.compiled_class /= Void
		local
			ilab: EV_LABEL
			mainvb: EV_VERTICAL_BOX
			vb: EV_VERTICAL_BOX
			fr: EV_FRAME
			hb: EV_HORIZONTAL_BOX
			f: EV_FONT
			info_width: INTEGER
			ccw: INTEGER
			cancelb: EV_BUTTON
			maxind: INTEGER
		do
			create properties_dialog
			properties_dialog.set_title (Interface_names.t_Feature_properties)
			create mainvb
			properties_dialog.extend (mainvb)
			mainvb.set_padding (Layout_constants.small_padding_size)
			mainvb.set_border_width (Layout_constants.default_border_size)
			create vb
			vb.set_border_width (Layout_constants.small_border_size)
			vb.set_padding (Layout_constants.small_padding_size)
			
				-- Determine the width of the info labels.
			f := create {EV_FONT}
			info_width := f.string_width (Interface_names.l_Class)
			info_width := info_width.max (f.string_width (Interface_names.l_Feature))
			info_width := info_width.max (f.string_width (Interface_names.l_Alias_name))
			info_width := info_width.max (f.string_width (Interface_names.l_Creation))
			info_width := info_width.max (f.string_width (Interface_names.l_Index))
			info_width := info_width.max (f.string_width (Interface_names.l_Calling_convention))
			
			create hb
			hb.set_padding (Layout_constants.default_padding_size)
			create ilab.make_with_text (Interface_names.l_Class)
			ilab.align_text_left
			ilab.set_minimum_width (info_width)
			hb.extend (ilab)
			hb.disable_item_expand (ilab)
			create class_field
			if for_modification then
				class_field.disable_edit
			else
				class_field.return_actions.extend (~new_class_name)
				class_field.focus_out_actions.extend (~new_class_name)
				class_field.focus_in_actions.extend (~remove_push_button)
			end
			class_field.set_minimum_width (f.string_width ("A_LONG_CLASS_NAME"))
			hb.extend (class_field)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			
			create hb
			hb.set_padding (Layout_constants.default_padding_size)
			create ilab.make_with_text (Interface_names.l_Creation)
			ilab.align_text_left
			ilab.set_minimum_width (info_width)
			hb.extend (ilab)
			hb.disable_item_expand (ilab)
			create creation_combo
			creation_combo.disable_edit
			hb.extend (creation_combo)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			
			create hb
			hb.set_padding (Layout_constants.default_padding_size)
			create ilab.make_with_text (Interface_names.l_Feature)
			ilab.align_text_left
			ilab.set_minimum_width (info_width)
			hb.extend (ilab)
			hb.disable_item_expand (ilab)
			create feature_field
			if for_modification then
				feature_field.disable_edit
			else
				feature_field.return_actions.extend (~on_creation_ok)
			end
			hb.extend (feature_field)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			
			create hb
			hb.set_padding (Layout_constants.default_padding_size)
			create ilab.make_with_text (Interface_names.l_Alias_name)
			ilab.align_text_left
			ilab.set_minimum_width (info_width)
			hb.extend (ilab)
			hb.disable_item_expand (ilab)
			create alias_field
			hb.extend (alias_field)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			
			if is_windows then
				create hb
				hb.set_padding (Layout_constants.default_padding_size)
				create ilab.make_with_text (Interface_names.l_Index)
				ilab.align_text_left
				ilab.set_minimum_width (info_width)
				hb.extend (ilab)
				hb.disable_item_expand (ilab)
				create index_field
				index_field.set_leap (1)
				maxind :=  (1 |<< 15) - 1
				index_field.value_range.adapt (0 |..| maxind)
				index_field.set_minimum_width (f.string_width ("20") + 50)
				hb.extend (index_field)
				hb.disable_item_expand (index_field)
				vb.extend (hb)
				vb.disable_item_expand (hb)
				
				create hb
				hb.set_padding (Layout_constants.default_padding_size)
				create ilab.make_with_text (Interface_names.l_Calling_convention)
				ilab.align_text_left
				ilab.set_minimum_width (info_width)
				hb.extend (ilab)
				hb.disable_item_expand (ilab)
				create call_combo
				call_combo.disable_edit
				hb.extend (call_combo)
				from
					valid_calling_conventions.start
				until
					valid_calling_conventions.after
				loop
					ccw := ccw.max (f.string_width (valid_calling_conventions.item))
					valid_calling_conventions.forth
				end
				ccw := ccw + 30
				call_combo.set_minimum_width (ccw)
				from
					valid_calling_conventions.start
				until
					valid_calling_conventions.after
				loop
					call_combo.extend (create {EV_LIST_ITEM}.make_with_text (valid_calling_conventions.item))
					valid_calling_conventions.forth
				end
				initial_calling_convention := call_combo.selected_item.text
				hb.disable_item_expand (call_combo)
				vb.extend (hb)
				vb.disable_item_expand (hb)
			end
			
			create fr.make_with_text (Interface_names.l_Feature_properties)
			fr.extend (vb)
			mainvb.extend (fr)
			
			create okb.make_with_text (Interface_names.b_Ok)
			Layout_constants.set_default_size_for_button (okb)
			if for_modification then
				okb.select_actions.extend (~on_modification_ok)
				properties_dialog.show_actions.extend (alias_field~set_focus)
			else
				okb.select_actions.extend (~on_creation_ok)
				properties_dialog.show_actions.extend (class_field~set_focus)
			end
			create cancelb.make_with_text (Interface_names.b_Cancel)
			Layout_constants.set_default_size_for_button (cancelb)
			cancelb.select_actions.extend (properties_dialog~destroy)
			
			create hb
			hb.set_padding (Layout_constants.default_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			mainvb.extend (hb)
			
			properties_dialog.set_maximum_height (properties_dialog.height)
			properties_dialog.set_default_cancel_button (cancelb)
			if for_modification then
				properties_dialog.set_default_push_button (okb)
			end
		ensure
			dialog_created: valid_properties_dialog
		end

	valid_properties_dialog: BOOLEAN is
			-- Contract support.
		do
			if is_windows then
				Result := properties_dialog /= Void and 
						class_field /= Void and feature_field /= Void and
						creation_combo /= Void and alias_field /= Void and
						index_field /= Void and call_combo /= Void
			else
				Result := properties_dialog /= Void and 
						class_field /= Void and feature_field /= Void and
						creation_combo /= Void and alias_field /= Void
			end
		end

	initialize_modification_dialog is
			-- Fill in the fields of `properties_dialog' according to `modified_exported_feature'.
		require
			properties_dialog_created: valid_properties_dialog
			feature_being_modified: modified_exported_feature /= Void
			valid_modified_feature: modified_exported_feature.compiled_class /= Void and
									modified_exported_feature.routine /= Void
		local
			cit: EV_LIST_ITEM
			curcr: STRING
			crname: STRING
			curcc: STRING
		do
			available_creation_routines := valid_creation_routines (modified_exported_feature.compiled_class)
			class_field.set_text (modified_exported_feature.compiled_class.name)
			feature_field.set_text (modified_exported_feature.routine.name)
			if modified_exported_feature.creation_routine /= Void then
				curcr := modified_exported_feature.creation_routine.name
			end
			from
				available_creation_routines.start
			until
				available_creation_routines.after
			loop
				crname := available_creation_routines.item.name
				create cit.make_with_text (crname)
				creation_combo.extend (cit)
				if curcr /= Void and then curcr.is_equal (crname) then
					cit.enable_select
				end
				available_creation_routines.forth
			end
			if modified_exported_feature.alias_name /= Void then
				alias_field.set_text (modified_exported_feature.alias_name)
			end
			if is_windows then
				if modified_exported_feature.index > 0 then
					index_field.set_value (modified_exported_feature.index)
				end
				curcc := modified_exported_feature.call_type
				if curcc /= Void then
					from
						call_combo.start
					until
						call_combo.after
					loop
						cit := call_combo.item
						if cit /= Void and then cit.text.is_equal (curcc) then
							cit.enable_select
						end
						call_combo.forth
					end
				end
				initial_calling_convention := call_combo.selected_item.text
			end
		end

	on_modification_ok is
			-- Check if the modified feature is valid enough,
			-- update `modified_exported_feature' if necessary.
		require
			really_modifying: valid_properties_dialog
			feature_being_modified: modified_exported_feature /= Void and then
					modified_exported_feature.compiled_class /= Void and then
					modified_exported_feature.routine /= Void
		local
			cl: CLASS_C
			f: E_FEATURE
			cr: E_FEATURE
			al: STRING
			ind: INTEGER
			cc: STRING
			cd: EV_WARNING_DIALOG
		do
			cl := modified_exported_feature.compiled_class
			f := modified_exported_feature.routine
			cr := cl.feature_with_name (creation_combo.selected_item.text)
			al := alias_field.text
			if is_windows then
				ind := index_field.value
				cc := call_combo.selected_item.text
			end
			if not valid_export_parameters (cl, cr, f, al, ind, cc) then
				if cl = Void then
					create cd.make_with_text (Warning_messages.w_Not_a_compiled_class (class_field.text))
				elseif not valid_class (cl) then
					create cd.make_with_text (Warning_messages.w_Class_cannot_export)
				elseif f = Void then
					create cd.make_with_text (Warning_messages.w_No_exported_feature (feature_field.text, class_field.text))
				elseif not valid_feature (f, cl) then
					create cd.make_with_text (Warning_messages.w_Feature_cannot_be_exported)
				elseif not valid_creation_routine (cr, cl) then
					create cd.make_with_text (Warning_messages.w_No_valid_creation_routine)
				elseif not al.is_empty and then not valid_alias (al) then
					create cd.make_with_text (Warning_messages.w_Invalid_alias)
				elseif is_windows and then ind /= 0 and then not valid_index (ind) then
					create cd.make_with_text (Warning_messages.w_Invalid_index)
				else
					create cd.make_with_text (Warning_messages.w_Invalid_parameters)
				end
				cd.show_modal_to_window (properties_dialog)
			else
					-- Ah we can update the exported feature.
				modified_exported_feature.set_creation_routine (cr)
				if not al.is_empty then
					modified_exported_feature.set_alias_name (al)
				else
					modified_exported_feature.remove_alias_name
				end
				if is_windows then
					if ind /= 0 then
						modified_exported_feature.set_index (ind)
					else
						modified_exported_feature.remove_index
					end
					if not initial_calling_convention.is_equal (cc) then
						modified_exported_feature.set_call_type (cc)
					else
						modified_exported_feature.remove_call_type
					end
				else
					modified_exported_feature.remove_index
					modified_exported_feature.remove_call_type
				end
				properties_dialog.destroy
				changed := True
				refresh_list
			end
		end

	on_creation_ok is
			-- Check if the modified feature is valid enough,
			-- update `modified_exported_feature' if necessary.
		require
			really_creating: valid_properties_dialog
		local
			cl: CLASS_C
			f: E_FEATURE
			cr: E_FEATURE
			al: STRING
			ind: INTEGER
			cc: STRING
			cd: EV_WARNING_DIALOG
			tmp: STRING
			exp: DYNAMIC_LIB_EXPORT_FEATURE
			clist: LIST [CLASS_I]
		do
			tmp := class_field.text
			if tmp /= Void and then not tmp.is_empty then
				clist := Eiffel_universe.compiled_classes_with_name (tmp)
				if not clist.is_empty then
					cl := clist.first.compiled_class
				end
			end
			tmp := feature_field.text
			if cl /= Void and then cl.has_feature_table and then not tmp.is_empty then
				tmp.to_lower
				f := cl.feature_with_name (tmp)
				tmp := creation_combo.selected_item.text
				if not tmp.is_empty then
					tmp.to_lower
					cr := cl.feature_with_name (tmp)
				end
			end
			al := alias_field.text
			ind := index_field.value
			cc := call_combo.selected_item.text
			if not valid_export_parameters (cl, cr, f, al, ind, cc) then
				if cl = Void then
					create cd.make_with_text (Warning_messages.w_Not_a_compiled_class (class_field.text))
				elseif not valid_class (cl) then
					create cd.make_with_text (Warning_messages.w_Class_cannot_export)
				elseif f = Void then
					create cd.make_with_text (Warning_messages.w_No_exported_feature (feature_field.text, class_field.text))
				elseif not valid_feature (f, cl) then
					create cd.make_with_text (Warning_messages.w_Feature_cannot_be_exported)
				elseif not valid_creation_routine (cr, cl) then
					create cd.make_with_text (Warning_messages.w_No_valid_creation_routine)
				elseif not al.is_empty and then not valid_alias (al) then
					create cd.make_with_text (Warning_messages.w_Invalid_alias)
				elseif is_windows and then ind /= 0 and then not valid_index (ind) then
					create cd.make_with_text (Warning_messages.w_Invalid_index)
				else
					create cd.make_with_text (Warning_messages.w_Invalid_parameters)
				end
				cd.show_modal_to_window (properties_dialog)
			else
					-- Ah we can create a new exported feature.
				create exp.make (cl, cr, f)
				if not al.is_empty then
					exp.set_alias_name (al)
				end
				if is_windows then
					if ind /= 0 then
						exp.set_index (ind)
					end
					if not initial_calling_convention.is_equal (cc) then
						exp.set_call_type (cc)
					end
				else
					exp.remove_index
					exp.remove_call_type
				end
				exports.extend (exp)
				changed := True
				properties_dialog.destroy
				refresh_list
			end
		end

	new_class_name is
			-- A new class name was entered in `class_field'.
			-- Update the creation routines list if possible.
		require
			really_creating: valid_properties_dialog
		local
			cl: CLASS_C
			tmp: STRING
			cit: EV_LIST_ITEM
			clist: LIST [CLASS_I]
		do
			creation_combo.wipe_out
			tmp := class_field.text
			if not tmp.is_empty then
				tmp.to_lower
				clist := Eiffel_universe.compiled_classes_with_name (tmp)
				if not clist.is_empty then
					cl := clist.first.compiled_class
				end
			end
			if cl = Void then
					-- The entered class does not exist or is not compiled.
				create cit.make_with_text (Warning_messages.w_Not_a_compiled_class_line (tmp))
				creation_combo.extend (cit)
			elseif not valid_class (cl) then
					-- The entered class name is invalid.
				create cit.make_with_text (Warning_messages.w_Class_cannot_export)
				creation_combo.extend (cit)
			else
				class_field.set_text (cl.name_in_upper)
					-- Fill in `creation_combo' with the list of valid creation routines of `cl'.
				available_creation_routines := valid_creation_routines (cl)
				if not available_creation_routines.is_empty then
					from
						available_creation_routines.start
					until
						available_creation_routines.after
					loop
						create cit.make_with_text (available_creation_routines.item.name)
						creation_combo.extend (cit)
						available_creation_routines.forth
					end
					feature_field.set_focus
--					properties_dialog.set_default_push_button (okb)
				else
						-- The entered class has no valid creation routine.
					create cit.make_with_text (Warning_messages.W_no_valid_creation_routine)
					creation_combo.extend (cit)
				end
			end
		end

	remove_push_button is
			-- If possible, remove `default_push_button' of `properties_dialog'.
		require
			properties_dialog_exists: properties_dialog /= Void
		do
			if properties_dialog.default_push_button /= Void then
				properties_dialog.remove_default_push_button
			end
		end

	properties_dialog: EV_DIALOG
			-- Dialog used to alter the status of exported features (and to add new features).
	
	class_field: EV_TEXT_FIELD
			-- Field containing the class name
			--| (only valid if a `new feature' dialog has been created, not if a modification dialog was created).

	feature_field: EV_TEXT_FIELD
			-- Field containing the feature name
			--| (only valid if a `new feature' dialog has been created, not if a modification dialog was created).

	creation_combo: EV_COMBO_BOX
			-- Combo box containing the selected creation routine name.
	
	alias_field: EV_TEXT_FIELD
			-- Text field containing the (optional) alias name.
	
	index_field: EV_SPIN_BUTTON
			-- Spin button containing the (optional) index.

	call_combo: EV_COMBO_BOX
			-- Combo box containing the chosen (optional) calling convention.

	okb: EV_BUTTON
			-- `OK' button for the properties dialog.

	initial_calling_convention: STRING
			-- Calling convention with which we initialized the combo box, to know if it was user-modified.

	available_creation_routines: LIST [E_FEATURE]
			-- List of valid creation routines displayed in the properties dialog.

	modified_exported_feature: DYNAMIC_LIB_EXPORT_FEATURE
			-- A reference to the exported feature being modified.

feature {NONE} -- Implementation: checks

	valid_exported_feature (exp: DYNAMIC_LIB_EXPORT_FEATURE): BOOLEAN is
			-- Is `exp' a valid export feature?
		do
			Result := valid_export_parameters (exp.compiled_class, exp.creation_routine, exp.routine,
												exp.alias_name, exp.index, exp.call_type)
		end
			
	valid_export_parameters (cl: CLASS_C; cr: E_FEATURE; f: E_FEATURE;
							al: STRING; ind: INTEGER_REF; cc: STRING): BOOLEAN is
			-- Is the export feature defined by these parameters valid?
			-- `cl': its class, `cr': the creation routine, `f': the exported feature,
			-- `ind': the index, `al': an alias name, `cc': the calling convention.
		do
			Result :=	valid_class (cl) and then
							-- At least a feature must be declared,
							-- but a creation is not necessary (the feature might be a creation routine).
						f /= Void and then
						(cr /= Void implies valid_creation_routine (cr, cl)) and then
						(cr = Void implies valid_creation_routine (f, cl)) and then
						valid_feature (f, cl) and then
							-- All other parameters are optional.
						(ind /= 0 implies ind > 0) and then
						((al /= Void and then not al.is_empty) implies valid_alias (al)) and then
						((cc /= Void and then not cc.is_empty) implies valid_calling_convention (cc))
		end

	conflicting_exports: BOOLEAN is
			-- Do some exported features present conflicts?
			-- It may be the case if the exported names are similar, or if indices are similar.
		local
			exp: DYNAMIC_LIB_EXPORT_FEATURE
			cur: CURSOR
			oa: STRING
		do
			from
				exports.start
			until
				exports.after or Result
			loop
				exp := exports.item
				cur := exports.cursor
				from
					exports.forth
				until
					exports.after or Result
				loop
					oa := exports.item.exported_name
					if
							-- Two indices are similar.
						exports.item.index /= 0 and exports.item.index = exp.index or else
							-- Two exported names are similar.
						oa /= Void and then oa.is_equal (exp.exported_name)
					then
						Result := True
					end
					exports.forth
				end
				exports.go_to (cur)
				exports.forth
			end
		end

	export_definition_problem: INTEGER is
			-- Does `Current' represent a valid definition file?
			-- All exported features must be valid, and there must be no conflict.
			-- Return the index of an invalid exported feature if there is an invalid feature,
			-- -1 if there is a conflict, 0 if everything is ok.
		do
			from
				exports.start
				Result := 0
			until
				exports.after or Result /= 0
			loop
				if not valid_exported_feature (exports.item) then
					Result := exports.index
				end
				exports.forth
			end
			if Result = 0 then
				if conflicting_exports then
					Result := -1
				end
			end
		end

	valid_class (c: CLASS_C): BOOLEAN is
			-- Is `c' a valid class to export to a dynamic library?
		do
			Result := c /= void and then c.has_feature_table and then not c.is_deferred and then c.generics = Void
		end

	valid_creation_routine (f: E_FEATURE; cl: CLASS_C): BOOLEAN is
			-- Is `f' a valid creation routine for `cl'?
		require
			valid_class: valid_class (cl)
		do
			Result :=	f /= Void and then
						not f.has_arguments and then
						cl.valid_creation_procedure (f.name) and then
						f.is_procedure
		end

	valid_feature (f: E_FEATURE; cl: CLASS_C): BOOLEAN is
			-- Is `f' a valid feature to export for `cl'?
		require
			valid_current_class: valid_class (cl)
		do
			Result := 	f /= Void and then
						cl.feature_table.has (f.name) and then
						not f.is_attribute and then
						not f.is_deferred and then
						not f.is_external
		end

	valid_alias (al: STRING): BOOLEAN is
			-- Is `al' a valid alias?
		local
			c: CHARACTER
			i,j: INTEGER
		do
			Result := al /= Void and not al.is_empty
			if Result then
				c := al @ 1
				Result := c = '_' or c.is_alpha
				from
					i := 2
					j := al.count
				until
					i > j or not Result
				loop
					c := al @ i
					Result := c.is_digit or c = '_' or c.is_alpha
					i := i + 1
				end
			end
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid integer to be an index in a dynamic library?
		do
			Result := i > 0
		end

	valid_calling_convention (cc: STRING): BOOLEAN is
			-- Is `cc' a valid calling convention?
		do
			Result := valid_calling_conventions.has (cc)
		end

	valid_calling_conventions: LIST [STRING] is
			-- Supported valid calling conventions.
			--| Only support the VC++ calling conventions, since this tool doesn't generate DLL's for Borland,
			--| and the calling convention has no meaning for this tool on Unix systems.
		once
			create {ARRAYED_LIST [STRING]} Result.make (3)
			Result.compare_objects
			Result.extend ("__cdecl")
			Result.extend ("__fastcall")
			Result.extend ("__stdcall")
		end

invariant
	exports_exist: exports /= Void
	exports_list_exists: exports_list /= Void
	graphical_synchronization_ok: exports_list.count = exports.count

end -- class EB_DYNAMIC_LIB_WINDOW
