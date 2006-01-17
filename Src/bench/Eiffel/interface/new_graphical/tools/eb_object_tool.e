indexing
	description: "Tool that displays the top of the call stack and an object during a debugging session."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_TOOL

inherit

	EB_TOOL
		redefine
			menu_name,
			pixmap,
			make
		end

	EB_RECYCLABLE
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
		end

	SHARED_DEBUG
		export
			{NONE} all
		end

	VALUE_TYPES
		export
			{NONE} all
		end
	
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end
		
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end
	
	DEBUGGING_UPDATE_ON_IDLE
		redefine
			update, real_update
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER) is
			-- Initialize `Current'.
		do
			min_slice_ref.set_item (preferences.debug_tool_data.min_slice)
			max_slice_ref.set_item (preferences.debug_tool_data.max_slice)		
			Precursor {EB_TOOL} (a_manager)
			display_first_attributes := True
			display_first_onces := False
			display_first_special := True
			display_first := True
		end

	build_interface is
			-- Build all the tool's widgets.
		do
			create displayed_objects.make

			create stack_objects_tree
			stack_objects_tree.drop_actions.extend (agent drop_stack_element)
			stack_objects_tree.key_press_actions.extend (agent debug_value_key_action (stack_objects_tree, ?))
			stack_objects_tree.set_minimum_size (100, 100)

			create objects_tree
			objects_tree.drop_actions.extend (agent add_object)
			objects_tree.key_press_actions.extend (agent object_key_action)
			objects_tree.key_press_actions.extend (agent debug_value_key_action (objects_tree, ?))

			create split
			split.set_first (stack_objects_tree)
			split.set_second (objects_tree)

			expand_result := True
			expand_args := True
			expand_locals := True
			widget := split
			
			create_update_on_idle_agent
		end

	build_mini_toolbar is
			-- Build associated tool bar
		local
			cmd: EB_SET_SLICE_SIZE_CMD
		do
			create remove_object_cmd.make (Current)
			remove_object_cmd.enable_sensitive
			create mini_toolbar
			mini_toolbar.extend (remove_object_cmd.new_mini_toolbar_item)

			create cmd.make (Current)
			cmd.enable_sensitive
			mini_toolbar.extend (cmd.new_mini_toolbar_item)

			create pretty_print_cmd.make
			pretty_print_cmd.enable_sensitive
			mini_toolbar.extend (pretty_print_cmd.new_mini_toolbar_item)

			create hex_format_cmd.make (agent set_hexa_mode (?))
			hex_format_cmd.enable_sensitive
			mini_toolbar.extend (hex_format_cmd.new_mini_toolbar_item)
		ensure
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end
			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_mini_toolbar (
				explorer_bar, widget, title, False, mini_toolbar
			)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Associated mini tool bar.

	widget: EV_WIDGET
			-- Widget representing Current.

	title: STRING is 
			-- Title of the tool.
		do
			Result := Interface_names.t_Object_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Object_tools
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
--| To be done.
--			Result := Pixmaps.Icon_object_tool
		end

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

feature -- Query

	get_object_display_parameters (addr: STRING): EB_OBJECT_DISPLAY_PARAMETERS is
			-- Return managed object located at address `addr'.
		require
			valid_address: addr /= Void
		local
			found: BOOLEAN
		do
			from
				displayed_objects.start
			until
				displayed_objects.after
				or else found
			loop
				Result := displayed_objects.item
				found := Result.address.is_equal (addr)
				displayed_objects.forth
			end
			if not found then
				Result := Void
			end
		end
		
feature -- Properties setting

	hexa_mode_enabled: BOOLEAN

	set_hexa_mode (v: BOOLEAN) is
		do
			hexa_mode_enabled := v
			stack_objects_tree.recursive_do_all (agent propagate_hexa_mode)
			objects_tree.recursive_do_all (agent propagate_hexa_mode)
		end
	
	propagate_hexa_mode (t: EV_TREE_ITEM) is
		local
			l_eb_t: EB_OBJECT_TREE_ITEM
		do
			l_eb_t ?= t
			if l_eb_t /= Void then
				l_eb_t.update
			end
		end		

--| NOTA jfiat 2004-09-24: Not used for now, but soon
--feature -- Layout
--
--	backup_layout is
--			-- 
--		do
--			if current_object /= Void then
--				display_first := current_object.display
--				display_first_attributes := current_object.display_attributes
--				display_first_onces := current_object.display_onces
--				display_first_special := current_object.display_special
--			end
--		end
--		
--	restore_layout is
--			-- 
--		do
--			if current_object /= Void then
--				current_object.set_display (display_first)
--				current_object.set_display_attributes (display_first_attributes)
--				current_object.set_display_onces (display_first_onces)
--				current_object.set_display_special (display_first_special)
----				current_object.apply_layout_to_attached_tree_item (curr)
--			end
--		end

feature -- Status setting

	add_object (a_stone: OBJECT_STONE) is
			-- Add the object represented by `a_stone' to the managed objects.
		local
			n_obj: EB_OBJECT_DISPLAY_PARAMETERS
			conv_spec: SPECIAL_VALUE
			abstract_value: ABSTRACT_DEBUG_VALUE			
			
			exists: BOOLEAN
			l_item: EV_ANY
		do
			debug ("debug_recv")
				print ("EB_OBJECT_TOOL.refresh%N")
			end
			from
				displayed_objects.start
			until
				displayed_objects.after
				or else exists
			loop
				exists := displayed_objects.item.address.is_equal (a_stone.object_address)
				displayed_objects.forth
			end
			if not exists then
				l_item := a_stone.ev_item
				if Application.is_dotnet then
					if l_item /= Void then
						abstract_value ?= l_item.data
					end
					if abstract_value /= Void then
						create {EB_OBJECT_DISPLAY_PARAMETERS_DOTNET} n_obj.make_from_debug_value (Current, abstract_value)
					end
					if n_obj = Void then
						create {EB_OBJECT_DISPLAY_PARAMETERS_DOTNET} n_obj.make (Current, a_stone.dynamic_class, a_stone.object_address)
					end
					debugger_manager.keep_object (a_stone.object_address)
					displayed_objects.extend (n_obj)
					
					n_obj.build_and_attach_to_parent (objects_tree)
				else
					if l_item /= Void then
						conv_spec ?= l_item.data
						if conv_spec /= Void then
							create {EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC} n_obj.make_from_debug_value (Current, conv_spec)
						end
					end
					if n_obj = Void then
						create {EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC} n_obj.make (Current, a_stone.dynamic_class, a_stone.object_address)
					end
					debugger_manager.keep_object (a_stone.object_address)
					displayed_objects.extend (n_obj)
					n_obj.build_and_attach_to_parent (objects_tree)					
				end
			end
		end

	remove_object (addr: STRING) is
			-- Remove the object at address `addr' from the managed objects.
		local
			exists: BOOLEAN
			taddr: STRING
		do
			from
				displayed_objects.start
			until
				displayed_objects.after
				or else exists
			loop
				exists := displayed_objects.item.address.is_equal (addr)
				if exists then
					displayed_objects.remove
					-- The address may be used by an expression.
					--debugger_manager.kept_objects.start
					--debugger_manager.kept_objects.prune_all (addr)
					from
						objects_tree.start
							--| The first item is the current object. It cannot be removed.
						if not objects_tree.is_empty then
							objects_tree.forth
						end
					until
						objects_tree.after
					loop
						taddr ?= objects_tree.item.data
						if
							taddr /= Void and then
							taddr.is_equal (addr)
						then
							objects_tree.remove
						else
							objects_tree.forth
						end
					end
				else
					displayed_objects.forth
				end
			end
		end

	selected_object_address: STRING is
		local
			item: EV_TREE_NODE
		do
			item := objects_tree.selected_item
			if item /= Void and then item.parent = item.parent_tree then
				Result ?= item.data
			end
		end		

	remove_selected_object is
			-- Remove the selected top-level item of the object tree, if any.
		local
			str: STRING
		do
			str := selected_object_address
			if str /= Void then
				remove_object (str)
			end
		end

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			conv_stack: CALL_STACK_STONE
			obj: EB_OBJECT_DISPLAY_PARAMETERS
			cse: EIFFEL_CALL_STACK_ELEMENT
			item: EV_TREE_ITEM
		do
			debug ("debug_recv")
				print ("EB_OBJECT_TOOL.set_stone%N")
			end
			if can_refresh then
				conv_stack ?= a_stone
				if conv_stack /= Void then
					if Application.status.is_stopped then
						clean_stack_objects_tree						
						build_stack_objects_tree (stack_objects_tree)
						objects_tree.start
						if not objects_tree.is_empty then
							objects_tree.remove
						end

						if current_object /= Void then
							display_first := current_object.display
							display_first_attributes := current_object.display_attributes
							display_first_special := current_object.display_special
							display_first_onces := current_object.display_onces
						end

						cse ?= current_stack_element
						check
							cse /= Void
						end
						if Application.is_dotnet then
							create {EB_OBJECT_DISPLAY_PARAMETERS_DOTNET} obj.make (Current, cse.dynamic_class, cse.object_address)
						else
							create {EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC} obj.make (Current, cse.dynamic_class, cse.object_address)
						end
						obj.set_front (True)
						obj.set_display (display_first)
						obj.set_display_attributes (display_first_attributes)
						obj.set_display_onces (display_first_onces)
						obj.set_display_special (display_first_special)

						obj.build_and_attach_to_parent (objects_tree)
						item := obj.object_tree_item
						item.set_text (Interface_names.l_Current_object + ": " + item.text)

						current_object := obj
					end
				end
			end
		end

	enable_refresh is
			-- Set `can_refresh' to `True'.
		do
			can_refresh := True
		end

	disable_refresh is
			-- Set `can_refresh' to `False'.
		do
			can_refresh := False
		end
		
	refresh is
			-- Class has changed in `development_window'.
		do
			clean_stack_objects_tree
			build_stack_objects_tree (stack_objects_tree)
			clean_objects_tree
			build_object_tree
		end

	clean_objects_tree is
		do
			objects_tree.wipe_out
		end

	update is
			-- Display current execution status.
			--| Deferred implementation for optimization purposes.
		local
			l_status: APPLICATION_STATUS
		do
			cancel_process_real_update_on_idle
			clean_stack_objects_tree
			clean_objects_tree

			l_status := application.status
			if l_status /= Void then
				process_real_update_on_idle (l_status.is_stopped)
			end
		end
	
	set_debugger_manager (a_manager: like debugger_manager) is
			-- Affect `a_manager' to `debugger_manager'.
		do
			debugger_manager := a_manager
		end

	change_manager_and_explorer_bar (a_manager: EB_TOOL_MANAGER; an_explorer_bar: EB_EXPLORER_BAR) is
			-- Change the window and explorer bar `Current' is in.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end

feature -- Status report

	is_removable (addr: STRING): BOOLEAN is
			-- Does `addr' represent an object that can be removed from the tree?
			-- I.e. is the object a top-level object different from the current object?
		do
			from
				displayed_objects.start
			until
				displayed_objects.after
				or else Result
			loop
				Result := displayed_objects.item.address.is_equal (addr)
				displayed_objects.forth
			end
		end

	is_selected_removable: BOOLEAN is
			-- Is there a selected item in the tree that can be removed from the tree?
			-- I.e. is the selected object, if any, a top-level object different from the current object?
		local
			str: STRING
		do
			str := selected_object_address
			if str /= Void then
				Result := is_removable (str)
			end
		end

	can_refresh: BOOLEAN
			-- Should we display the trees when a stone is set?
			--| For optimization purposes.

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			preferences.debug_tool_data.min_slice_preference.set_value (min_slice_ref.item)
			preferences.debug_tool_data.max_slice_preference.set_value (max_slice_ref.item)
			debugger_manager.kept_objects.wipe_out
			displayed_objects.wipe_out
			pretty_print_cmd.end_debug
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			if current_object /= Void then
				display_first := current_object.display
				display_first_attributes := current_object.display_attributes
				display_first_special := current_object.display_special
				display_first_onces := current_object.display_onces
				current_object := Void
			end
		end

feature {EB_SET_SLICE_SIZE_CMD, EB_OBJECT_DISPLAY_PARAMETERS}

	debug_value_to_tree_item (dv: ABSTRACT_DEBUG_VALUE): EB_OBJECT_TREE_ITEM is
			-- Convert `dv' into a tree item.
		do
			if application.is_dotnet then
				create {EB_DOTNET_OBJECT_TREE_ITEM} Result.make_with_value (dv, Current)
			else
				create {EB_CLASSIC_OBJECT_TREE_ITEM} Result.make_with_value (dv, Current)
			end
		end

feature {NONE} -- Layout Implementation

	clean_stack_objects_tree is
		do
			record_stack_expand_info			
			stack_objects_tree.wipe_out
		end

	record_stack_expand_info is
		do
			if not stack_objects_tree.is_empty then
				if internal_locals_tree_item /= Void then
					expand_locals := internal_locals_tree_item.is_expanded
				end
				if internal_arguments_tree_item /= Void then
					expand_args := internal_arguments_tree_item.is_expanded
				end
				if internal_result_tree_item /= Void then
					expand_result := internal_result_tree_item.is_expanded
				end
			end
		end

	expand_result: BOOLEAN
			-- Should the "Result" tree item be expanded?

	expand_args: BOOLEAN
			-- Should the "Arguments" tree item be expanded?

	expand_locals: BOOLEAN
			-- Should the "Locals" tree item be expanded?

feature {NONE} -- Implementation

	current_stack_element: CALL_STACK_ELEMENT is
			-- Stack element currently displayed in `stack_objects_tree'.
		do
			Result := Application.status.current_call_stack_element
		end

	displayed_objects: LINKED_LIST [EB_OBJECT_DISPLAY_PARAMETERS]
			-- All displayed objects, their addresses, types and display options.

	objects_tree: EV_TREE

	stack_objects_tree: EV_TREE
			-- Graphical tree displaying local variables, arguments and the result.
			
	current_object_tree_node: EV_TREE_NODE
			-- Graphical tree displaying an object (or maybe several).
	
	pretty_print_cmd: EB_PRETTY_PRINT_CMD
			-- Command that is used to display extended information concerning objects.

	remove_object_cmd: EB_REMOVE_OBJECT_CMD
			-- Command that is used to remove objects from the tree.

	hex_format_cmd: EB_HEX_FORMAT_CMD
			-- Command that is used to switch hex/dec formatting for numerical values

	split: EV_HORIZONTAL_SPLIT_AREA
			-- Split area that contains both `stack_objects_tree' and `objects_tree'.
			
	real_update (dbg_was_stopped: BOOLEAN) is
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running			
		local
			l_status: APPLICATION_STATUS
		do
			l_status := application.status
			if l_status /= Void then
				pretty_print_cmd.refresh
				clean_stack_objects_tree
				clean_objects_tree

				if l_status.is_stopped and dbg_was_stopped then
					if
						l_status.has_valid_call_stack
						and then l_status.has_valid_current_eiffel_call_stack_element
							--| FIXME jfiat [2005/01/27] : maybe in futur evolution, 
							--| we'll display some external data...
					then
						build_stack_objects_tree (stack_objects_tree)
						build_object_tree
					end
				else
					if current_object /= Void then
							-- We are after an execution step, save the current object's display.
						display_first := current_object.display
						display_first_attributes := current_object.display_attributes
						display_first_special := current_object.display_special
						display_first_onces := current_object.display_onces
					end
				end
			end
		end

	show_exception_dialog (a_tag, a_msg: STRING; x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG		
		do
			create dlg.make (a_tag, a_msg)
			dlg.show_modal_to_window (Debugger_manager.debugging_window.window)
		end

	build_exception_info (a_target_container: EV_TREE) is
			-- Display exception info
			-- for now only for Dotnet systems
		local
			item: EV_TREE_ITEM
			l_exception_module_detail: STRING
			l_exception_tag, l_exception_message: STRING
			exception_item: EV_TREE_ITEM
		do
			if Application.is_dotnet and then Application.imp_dotnet.exception_occurred then
				l_exception_module_detail := Application.imp_dotnet.exception_module_name
				if l_exception_module_detail /= Void then
					create exception_item
					if Application.imp_dotnet.exception_handled then
						exception_item.set_text ("Exception raised :: First chance")
					else
						exception_item.set_text ("Exception raised :: UnHandled")
					end
					exception_item.set_pixmap (Pixmaps.Icon_debugger_exception)
					
						--| Exception message
					l_exception_tag := Application.imp_dotnet.exception_message
					if l_exception_tag /= Void then
						create item
						item.set_data (l_exception_tag)
						item.set_text (l_exception_tag)
						item.set_tooltip (l_exception_tag)
						item.set_pixmap (Pixmaps.Icon_exception)
						exception_item.extend (item)						
					end	
					
						--| Module name
					create item
					item.set_text ("Module " + l_exception_module_detail)
					item.set_data (l_exception_module_detail)
					item.set_pixmap (Pixmaps.Icon_exception)
					exception_item.extend (item)
					
						--| Exception to_string					
					l_exception_message := Application.imp_dotnet.exception_to_string
					if l_exception_message /= Void then
						create item
						item.set_data (l_exception_message)
						item.set_text ("Double click to see Exception or Ctrl-C to copy to clipboard")-- + l_exception_to_string)
						item.set_tooltip (l_exception_message)
						item.set_pixmap (Pixmaps.Icon_exception)
						item.pointer_double_press_actions.extend (agent show_exception_dialog (l_exception_tag, l_exception_message, ?,?,?,?,?,?,?,?))
						exception_item.extend (item)						
					end
					a_target_container.extend (exception_item)
					exception_item.expand
				end
			end
		end

	build_stack_objects_tree (a_target_container: EV_TREE) is
		do
			build_stack_info (a_target_container)
			build_stack_objects (a_target_container)
			if not a_target_container.is_empty then
				a_target_container.first.enable_select	
			end
		end

	build_stack_info (a_target_container: EV_TREE) is
			-- Create the tree that contains call stack info
		do
			if Application.current_call_stack_is_empty then
				build_exception_info (a_target_container)
			else
				build_exception_info (a_target_container)
			end
		end

	build_stack_objects (a_target_container: EV_TREE) is
			-- Create the tree that contains locals (Result) and parameters.
		local
			item: EV_TREE_ITEM
			cse: EIFFEL_CALL_STACK_ELEMENT
		do
			if not Application.current_call_stack_is_empty then
				cse ?= current_stack_element
				if cse /= Void then
					create item.make_with_text ("{"	+ cse.dynamic_class.name_in_upper + "}." + cse.routine_name )
					item.set_pixmap (pixmaps.icon_arrow_empty)
					-- fixme jfiat
					a_target_container.extend (item)
				
						-- Fill in the arguments, if any.
					build_arguments_tree_item (cse)
					item := internal_arguments_tree_item
					if item /= Void then
						a_target_container.extend (item)
						if expand_args then
							item.expand
						end
					end
	
						-- Fill in the locals, if any.
					build_locals_tree_item (cse)
					item := internal_locals_tree_item
					if item /= Void then
						a_target_container.extend (item)
						if expand_locals then
							item.expand
						end
					end

						-- Display the result, if any.
					build_result_tree_item (cse)
					item := internal_result_tree_item
					if item /= Void then
						a_target_container.extend (item)
						if expand_result then
							item.expand
						end
					end
				end
			end
		end

	build_result_tree_item (cse: EIFFEL_CALL_STACK_ELEMENT) is
			-- Create the tree that contains result.
		require
			call_stack_not_void: cse /= Void
		local
			item: EV_TREE_ITEM
			dv: ABSTRACT_DEBUG_VALUE
		do
				-- Display the result, if any.
			if cse.has_result then
				item := internal_result_tree_item
				if item = Void then
					create internal_result_tree_item
					item := internal_result_tree_item
				else
					item.wipe_out
				end
				item.set_text (Interface_names.l_Result)
				item.set_pixmap (Pixmaps.Icon_feature_clause_any)
				
				dv := cse.result_value
				if
					dv /= Void
				then
					item.extend (debug_value_to_tree_item (dv))
				end
			else
				internal_result_tree_item := Void
			end
		end

	internal_result_tree_item: EV_TREE_ITEM

	build_arguments_tree_item (cse: EIFFEL_CALL_STACK_ELEMENT) is
			-- Create the tree that contains arguments.
		require
			call_stack_not_void: cse /= Void
		local
			item: EV_TREE_ITEM
			list: LIST [ABSTRACT_DEBUG_VALUE]
		do
				-- Fill in the arguments, if any.
			list := cse.arguments
			if
				list /= Void and then
				not list.is_empty
			then
				item := internal_arguments_tree_item
				if item = Void then
					create internal_arguments_tree_item
					item := internal_arguments_tree_item
				else
					item.wipe_out
				end
				item.set_text (Interface_names.l_Arguments)
				item.set_pixmap (Pixmaps.Icon_feature_clause_any)
				from
					list.start
				until
					list.after
				loop
					item.extend (debug_value_to_tree_item (list.item))
					list.forth
				end
			else
				internal_arguments_tree_item := Void
			end
		end

	internal_arguments_tree_item: EV_TREE_ITEM

	build_locals_tree_item (cse: EIFFEL_CALL_STACK_ELEMENT) is
			-- Create the tree item that contains locals
		require
			call_stack_not_void: cse /= Void
		local
			list: LIST [ABSTRACT_DEBUG_VALUE]
			item: EV_TREE_ITEM
			tmp: SORTABLE_ARRAY [ABSTRACT_DEBUG_VALUE]
			i: INTEGER
			dbg_nb: INTEGER
		do
				-- Fill in the locals, if any.
			list := cse.locals
			if
				list /= Void and then
				not list.is_empty
			then
				item := internal_locals_tree_item
				if item = Void then
					create internal_locals_tree_item
					item := internal_locals_tree_item
				else
					item.wipe_out
				end
				item.set_text (Interface_names.l_Locals)
				item.set_pixmap (Pixmaps.Icon_feature_clause_any)
				dbg_nb := list.count
				create tmp.make (1, dbg_nb)
				from
					list.start
					i := 1
				until
					list.after
				loop
					tmp.put (list.item, i)
					i := i + 1
					list.forth
				end
				tmp.sort
				from
					i := 1
				until
					i > dbg_nb
				loop
					item.extend (debug_value_to_tree_item (tmp @ i))
					i := i + 1
				end
			else
				internal_locals_tree_item := Void
			end
		end

	internal_locals_tree_item: EV_TREE_ITEM
	
	build_object_tree is
			-- Create the tree that contains object information.
		local
			value: ABSTRACT_DEBUG_VALUE
			cse: EIFFEL_CALL_STACK_ELEMENT
			item: EV_TREE_ITEM
		do
			debug ("debug_recv")
				print ("EB_OBJECT_TOOL.build_object_tree%N")
			end
			
				--| Current object
			if current_object /= Void then
				display_first := current_object.display
				display_first_attributes := current_object.display_attributes
				display_first_special := current_object.display_special
				display_first_onces := current_object.display_onces
			end

			if Application.is_dotnet then
				if not Application.current_call_stack_is_empty then
					value := application.imp_dotnet.status.current_call_stack_element_dotnet.current_object
					check
						value_not_void: value /= Void
					end
					create {EB_OBJECT_DISPLAY_PARAMETERS_DOTNET} current_object.make_from_debug_value (Current, value)
				end
			else
				cse ?= current_stack_element
				check
					cse /= Void
				end
				create {EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC} current_object.make_from_stack_element (Current, cse)
			end
			if current_object /= Void then
				current_object.set_display (display_first)
				current_object.set_display_attributes (display_first_attributes)
				current_object.set_display_onces (display_first_onces)
				current_object.set_display_special (display_first_special)
				current_object.build_and_attach_to_parent (objects_tree)
				item := current_object.object_tree_item
				item.set_text (Interface_names.l_Current_object + ": " + item.text)
			end
				--| Added objects
			add_displayed_objects_to_tree (objects_tree)
		end
		
	add_displayed_objects_to_tree (a_object_tree: EV_TREE) is
			-- 
		do
			from
				displayed_objects.start
			until
				displayed_objects.after
			loop
				displayed_objects.item.build_and_attach_to_parent (a_object_tree)
				displayed_objects.forth
			end
		end

	drop_stack_element (st: CALL_STACK_STONE) is
			-- Display stack element represented by `st'.
		do
			debugger_manager.launch_stone (st)
		end

	object_key_action (k: EV_KEY) is
			-- Actions performed when a key is pressed on a top-level object.
			-- Handle `Del'.
		do
			if k.code = {EV_KEY_CONSTANTS}.Key_delete then
				remove_object_cmd.execute
			end
		end

	debug_value_key_action (tree: EV_TREE; k: EV_KEY) is
			-- Actions performed when a key is pressed on a debug_value.
			-- Handle `Ctrl+C'.
		local
			dv: ABSTRACT_DEBUG_VALUE
			text_data: STRING
			it: EV_TREE_NODE
		do
			if
				k.code = {EV_KEY_CONSTANTS}.Key_c or k.code = {EV_KEY_CONSTANTS}.Key_insert and then
				ev_application.ctrl_pressed and then
				not ev_application.alt_pressed and then
				not ev_application.Shift_pressed
			then
				it := tree.selected_item
				if it /= Void then
					dv ?= it.data
				end
					--| if the NODE contains a DEBUG_VALUE
				if dv /= Void then
					ev_application.clipboard.set_text (dv.dump_value.full_output)
				else
					text_data ?= it.data
						--| if the NODE contains a STRING value
					if text_data /= Void then
						ev_application.clipboard.set_text (text_data)
					end
				end
			end
		end

	current_object: EB_OBJECT_DISPLAY_PARAMETERS
			-- The display parameters for the current object (for the current stack)
			-- It is recreated at each execution step.

	display_first, display_first_attributes, display_first_onces, display_first_special: BOOLEAN;
			-- Memorize the display parameters of the current object.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
