indexing
	description: "Tool that displays the top of the call stack and an object during a debugging session."
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

	EB_DEBUG_TOOL_DATA
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

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER; an_explorer_bar: like explorer_bar) is
			-- Initialize `Current'.
		do
			min_slice_ref.set_item (min_slice)
			max_slice_ref.set_item (max_slice)
			Precursor {EB_TOOL} (a_manager, an_explorer_bar)
			display_first_attributes := True
			display_first_onces := False
			display_first_special := True
			display_first := True
			update_agent := agent real_update
		end

	build_interface is
			-- Build all the tool's widgets.
		do
			create displayed_objects.make
			create split
			split.disable_flat_separator
			create local_tree
			local_tree.drop_actions.extend (agent drop_stack_element)
			local_tree.key_press_actions.extend (agent debug_value_key_action (local_tree, ?))
			local_tree.set_minimum_size (100, 100)
			split.set_first (local_tree)
			create object_tree
			object_tree.drop_actions.extend (agent add_object)
			object_tree.key_press_actions.extend (agent object_key_action)
			object_tree.key_press_actions.extend (agent debug_value_key_action (object_tree, ?))
			split.set_second (object_tree)
			split.enable_flat_separator
			expand_result := True
			expand_args := True
			expand_locals := True
			widget := split
		end

	build_explorer_bar is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		local
			mini_toolbar: EV_TOOL_BAR
			cmd: EB_SET_SLICE_SIZE_CMD
		do
			create remove_object_cmd.make (Current)
			remove_object_cmd.enable_sensitive
			create mini_toolbar
			mini_toolbar.extend (remove_object_cmd.new_mini_toolbar_item)
			create cmd.make (Current)
			cmd.enable_sensitive
			mini_toolbar.extend (cmd.new_mini_toolbar_item)
			create pretty_print_cmd.make (Current)
			pretty_print_cmd.enable_sensitive
			mini_toolbar.extend (pretty_print_cmd.new_mini_toolbar_item)

			create explorer_bar_item.make_with_mini_toolbar (
				explorer_bar, widget, title, False, mini_toolbar
			)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

feature -- Access

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
			Result := Interface_names.m_Call_stack_tool
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
--| To be done.
--			Result := Pixmaps.Icon_object_tool
		end

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

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

feature -- Status setting

	add_object (a_stone: OBJECT_STONE) is
			-- Add the object represented by `a_stone' to the managed objects.
		local
			n_obj: EB_OBJECT_DISPLAY_PARAMETERS
			conv_spec: SPECIAL_VALUE
			abstract_value: ABSTRACT_DEBUG_VALUE			
			
			exists: BOOLEAN
			tree_item: EV_TREE_ITEM
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
				tree_item := a_stone.tree_item
				if Application.is_dotnet then
					if tree_item /= Void then
						abstract_value ?= tree_item.data
					else
						abstract_value ?= a_stone.debug_value
					end
					if abstract_value /= Void then
						Application.imp_dotnet.keep_object (abstract_value)					
						create {EB_OBJECT_DISPLAY_PARAMETERS_DOTNET} n_obj.make_from_debug_value (abstract_value)
					end
					if n_obj = Void then
						create {EB_OBJECT_DISPLAY_PARAMETERS_DOTNET} n_obj.make (a_stone.dynamic_class, a_stone.object_address)
					end
					debugger_manager.kept_objects.extend (a_stone.object_address)
					displayed_objects.extend (n_obj)
					
					n_obj.to_tree_item (object_tree)
				else
					if tree_item /= Void then
						conv_spec ?= tree_item.data
						if conv_spec /= Void then
							create {EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC} n_obj.make_from_debug_value (conv_spec)
						end
					end
					if n_obj = Void then
						create {EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC} n_obj.make (a_stone.dynamic_class, a_stone.object_address)
					end
					debugger_manager.kept_objects.extend (a_stone.object_address)
					displayed_objects.extend (n_obj)
					n_obj.to_tree_item (object_tree)					
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
						object_tree.start
							--| The first item is the current object. It cannot be removed.
						if not object_tree.is_empty then
							object_tree.forth
						end
					until
						object_tree.after
					loop
						taddr ?= object_tree.item.data
						if
							taddr /= Void and then
							taddr.is_equal (addr)
						then
							object_tree.remove
							if Application.is_dotnet then
								Application.imp_dotnet.remove_kept_object_by_address (taddr)
							end
						else
							object_tree.forth
						end
					end
				else
					displayed_objects.forth
				end
			end
		end

	remove_selected_object is
			-- Remove the selected top-level item of the object tree, if any.
		local
			str: STRING
			item: EV_TREE_NODE
		do
			item := object_tree.selected_item
			if
				item /= Void and then
				item.parent = item.parent_tree
			then
				str ?= item.data
				if str /= Void then
					remove_object (str)
				end
			end
		end

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			conv_stack: CALL_STACK_STONE
			obj: EB_OBJECT_DISPLAY_PARAMETERS
			cse: CALL_STACK_ELEMENT
		do
			debug ("debug_recv")
				print ("EB_OBJECT_TOOL.set_stone%N")
			end
			if can_refresh then
				conv_stack ?= a_stone
				if conv_stack /= Void then
					if Application.status.is_stopped then
						build_local_tree
						object_tree.start
						if not object_tree.is_empty then
							object_tree.remove
						end

						cse := current_stack_element

						if current_object /= Void then
							display_first := current_object.display
							display_first_attributes := current_object.display_attributes
							display_first_special := current_object.display_special
							display_first_onces := current_object.display_onces
						end

						if Application.is_dotnet then
							create {EB_OBJECT_DISPLAY_PARAMETERS_DOTNET} obj.make (cse.dynamic_class, cse.object_address)
						else
							create {EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC} obj.make (cse.dynamic_class, cse.object_address)
						end
						obj.set_front (True)
						obj.set_display (display_first)
						obj.set_display_attributes (display_first_attributes)
						obj.set_display_onces (display_first_onces)
						obj.set_display_special (display_first_special)
						obj.to_tree_item (object_tree)
						
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
			build_local_tree
			build_object_tree
		end

	update is
			-- Display current execution status.
			--| Deferred implementation for optimization purposes.
		do
			(create {EV_ENVIRONMENT}).application.idle_actions.prune_all (update_agent)
			local_tree.wipe_out
			object_tree.wipe_out;
			(create {EV_ENVIRONMENT}).application.idle_actions.extend (update_agent)
		end

	set_debugger_manager (a_manager: like debugger_manager) is
			-- Affect `a_manager' to `debugger_manager'.
		do
			debugger_manager := a_manager
		end

	change_manager (a_manager: EB_TOOL_MANAGER; an_explorer_bar: like explorer_bar) is
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
			item: EV_TREE_NODE
		do
			item := object_tree.selected_item
			if
				item /= Void and then
				item.parent = item.parent_tree
			then
				str ?= item.data
				if str /= Void then
					Result := is_removable (str)
				end
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
			set_integer_resource ("min_slice", min_slice_ref.item)
			set_integer_resource ("max_slice", max_slice_ref.item)
			debugger_manager.kept_objects.wipe_out
			if Application.is_dotnet then
				Application.imp_dotnet.recycle_kept_object
			end
			displayed_objects.wipe_out
			pretty_print_cmd.end_debug
			explorer_bar_item.recycle
			if current_object /= Void then
				display_first := current_object.display
				display_first_attributes := current_object.display_attributes
				display_first_special := current_object.display_special
				display_first_onces := current_object.display_onces
			end
		end

feature {EB_SET_SLICE_SIZE_CMD}

	debug_value_to_item (dv: ABSTRACT_DEBUG_VALUE): EV_TREE_ITEM is
			-- Convert `dv' into a tree item.
		local
			ost: OBJECT_STONE
		do
			create Result.make_with_text (dv.name + ": " + dv.dump_value.type_and_value)
			Result.set_pixmap (icons @ (dv.kind))
			Result.set_data (dv)
			if dv.expandable and not dv.is_external_type then
				Result.extend (create {EV_TREE_ITEM}.make_with_text ("Bug"))
				Result.expand_actions.extend (agent fill_item (Result))
			end
			if dv.address /= Void and not dv.is_external_type then
					--| For now we don't support this for external type
				create ost.make (dv.address, dv.name, dv.dynamic_class)
				ost.set_associated_tree_item (Result)
				ost.set_associated_debug_value (dv)
				Result.set_pebble (ost)
				Result.set_accept_cursor (ost.stone_cursor)
				Result.set_deny_cursor (ost.X_stone_cursor)				
			end
		end

feature {NONE} -- Implementation

	current_stack_element: CALL_STACK_ELEMENT is
			-- Stack element currently displayed in `local_tree'.
		do
			Result := Application.status.current_stack_element
		end

	displayed_objects: LINKED_LIST [EB_OBJECT_DISPLAY_PARAMETERS]
			-- All displayed objects, their addresses, types and display options.

	expand_result: BOOLEAN
			-- Should the "Result" tree item be expanded?

	expand_args: BOOLEAN
			-- Should the "Arguments" tree item be expanded?

	expand_locals: BOOLEAN
			-- Should the "Locals" tree item be expanded?

	local_tree: EV_TREE
			-- Graphical tree displaying local variables, arguments and the result.

	object_tree: EV_TREE
			-- Graphical tree displaying an object (or maybe several).

	pretty_print_cmd: EB_PRETTY_PRINT_CMD
			-- Command that is used to display extended information concerning objects.

	remove_object_cmd: EB_REMOVE_OBJECT_CMD
			-- Command that is used to remove objects from the tree.

	split: EB_HORIZONTAL_SPLIT_AREA
			-- Split area that contains both `local_tree' and `object_tree'.

	icons: ARRAY [EV_PIXMAP] is
			-- List of available icons for objects.
		once
			create Result.make (Immediate_value, External_reference_value)
			Result.put (Pixmaps.Icon_void_object, Void_value)
			Result.put (Pixmaps.Icon_object_symbol, Reference_value)
			Result.put (Pixmaps.Icon_immediate_value, Immediate_value)
			Result.put (Pixmaps.Icon_object_symbol, Special_value)
			Result.put (Pixmaps.Icon_expanded_object, Expanded_value)
			Result.put (Pixmaps.Icon_external_symbol, External_reference_value)
		end

	update_agent: PROCEDURE [ANY, TUPLE]
			-- Procedure used to update Current.

	real_update is
			-- Display current execution status.
		do
			(create {EV_ENVIRONMENT}).application.idle_actions.prune_all (update_agent)
			if Application.status /= Void then
				pretty_print_cmd.refresh
				if Application.status.is_stopped then
					build_local_tree
					build_object_tree
				else
					if current_object /= Void then
							-- We are after an execution step, save the current object's display.
						display_first := current_object.display
						display_first_attributes := current_object.display_attributes
						display_first_special := current_object.display_special
						display_first_onces := current_object.display_onces
					end
					local_tree.wipe_out
					object_tree.wipe_out
				end
			end
		end

	show_text_in_popup (txt: STRING; x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- 
		local
			w_dlg: EB_INFORMATION_DIALOG
		do
			create w_dlg.make_with_text (txt)
			w_dlg.show_modal_to_window (Debugger_manager.debugging_window.window)		
		end
		
	build_exception_info (a_tree: EV_TREE) is
			-- Display exception info
			-- for now only for Dotnet systems
		local
			item: EV_TREE_ITEM
			l_exception_detail: TUPLE [STRING, STRING]
			l_exception_module_detail: STRING
			l_exception_message, l_exception_to_string: STRING
			exception_item: EV_TREE_ITEM
		do
			if Application.is_dotnet and then Application.imp_dotnet.exception_occured then
				l_exception_detail := Application.imp_dotnet.exception_details
				if l_exception_detail /= Void then
					l_exception_module_detail ?= l_exception_detail.item (2)
					
					create exception_item
					if Application.imp_dotnet.exception_handled then
						exception_item.set_text ("Exception raised :: First chance")
					else
						exception_item.set_text ("Exception raised :: UnHandled")
					end
					exception_item.set_pixmap (Pixmaps.Icon_green_tick)
					
						--| Exception message
					
					l_exception_message := Application.imp_dotnet.exception_message
					if l_exception_message /= Void then
						create item
						item.set_data (l_exception_message)
						item.set_text (l_exception_message)
						item.set_tooltip (l_exception_message)
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
					l_exception_to_string := Application.imp_dotnet.exception_to_string
					if l_exception_to_string /= Void then
						create item
						item.set_data (l_exception_to_string)
						item.set_text ("Double click to see Exception or Ctrl-C to copy to clipboard")-- + l_exception_to_string)
						item.set_tooltip (l_exception_to_string)
						item.set_pixmap (Pixmaps.Icon_exception)
						item.pointer_double_press_actions.extend (agent show_text_in_popup (l_exception_to_string, ?,?,?,?,?,?,?,?))
						exception_item.extend (item)						
					end						

					a_tree.extend (exception_item)
					exception_item.expand
				end
			end
		end

	build_local_tree is
			-- Create the tree that contains locals and parameters.
		local
			item: EV_TREE_ITEM
			module_item: EV_TREE_ITEM

			list: LIST [ABSTRACT_DEBUG_VALUE]
			dv: ABSTRACT_DEBUG_VALUE
			cse: CALL_STACK_ELEMENT
			cse_dotnet: CALL_STACK_ELEMENT_DOTNET

			tmp: SORTABLE_ARRAY [ABSTRACT_DEBUG_VALUE]
			i: INTEGER
			dbg_nb: INTEGER

		do
			local_tree.wipe_out

			if Application.call_stack_is_empty and then Application.is_dotnet then
				build_exception_info (local_tree)
			else
				cse := current_stack_element

				if Application.is_dotnet then
					cse_dotnet ?= cse

					create module_item
					module_item.set_text ("Module = " + cse_dotnet.dotnet_module_filename)
					module_item.set_data (cse_dotnet.dotnet_module_name)
					module_item.set_pixmap (Pixmaps.Icon_green_tick)
					local_tree.extend (module_item)				

					build_exception_info (local_tree)
				end
				
					-- Fill in the arguments, if any.
				list := cse.arguments
				if
					list /= Void and then
					not list.is_empty
				then
					create item
					item.set_text (Interface_names.l_Arguments)
					item.set_pixmap (Pixmaps.Icon_feature_clause_any)
					local_tree.extend (item)
					from
						list.start
					until
						list.after
					loop
						item.extend (debug_value_to_item (list.item))
						list.forth
					end
					if expand_args then
						item.expand
					end
				end

					-- Fill in the locals, if any.
				list := cse.locals
				if
					list /= Void and then
					not list.is_empty
				then
					create item
					item.set_text (Interface_names.l_Locals)
					item.set_pixmap (Pixmaps.Icon_feature_clause_any)
					local_tree.extend (item)
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
						item.extend (debug_value_to_item (tmp @ i))
						i := i + 1
					end
					if expand_locals then
						item.expand
					end
				end

					-- Display the result, if any.
				dv := cse.result_value
				if
					dv /= Void
				then
					create item
					item.set_text (Interface_names.l_Result)
					item.set_pixmap (Pixmaps.Icon_feature_clause_any)
					local_tree.extend (item)
					item.extend (debug_value_to_item (dv))
					if expand_result then
						item.expand
					end
				end
			end
		end

	clean_debugger_kept_value is
		require
			Application.is_dotnet
		local
			l_addresses_to_keep: LINKED_LIST [STRING]
		do
			from
				create l_addresses_to_keep.make
				displayed_objects.start
			until
				displayed_objects.after				
			loop
				l_addresses_to_keep.extend (displayed_objects.item.address)
				displayed_objects.forth				
			end
			Application.imp_dotnet.keep_only_objects (l_addresses_to_keep)
		end	
	
	build_object_tree is
			-- Create the tree that contains object information.
		local
			value: ABSTRACT_DEBUG_VALUE
		do
			debug ("debug_recv")
				print ("EB_OBJECT_TOOL.build_object_tree%N")
			end
			object_tree.wipe_out
			if Application.is_dotnet then
				clean_debugger_kept_value			
			end
			
			if current_object /= Void then
				display_first := current_object.display
				display_first_attributes := current_object.display_attributes
				display_first_special := current_object.display_special
				display_first_onces := current_object.display_onces
			end

			if Application.is_dotnet then
				if not Application.call_stack_is_empty then
					value := application.imp_dotnet.status.current_stack_element_dotnet.current_object
					Application.imp_dotnet.keep_object (value)	
					check 
						value_not_void: value /= Void
					end
					create {EB_OBJECT_DISPLAY_PARAMETERS_DOTNET} current_object.make_from_debug_value (value)
				end
			else
				create {EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC} current_object.make_from_stack_element (current_stack_element)
			end
			if current_object /= Void then
				current_object.set_display (display_first)
				current_object.set_display_attributes (display_first_attributes)
				current_object.set_display_onces (display_first_onces)
				current_object.set_display_special (display_first_special)
				current_object.to_tree_item (object_tree)
			end
			
			add_displayed_objects_to_tree (object_tree)
		end
		
	add_displayed_objects_to_tree (a_object_tree: EV_TREE) is
			-- 
		do
			from
				displayed_objects.start
			until
				displayed_objects.after
			loop
				displayed_objects.item.to_tree_item (a_object_tree)
				displayed_objects.forth
			end
		end


	fill_item (item: EV_TREE_ITEM) is
			-- If a tree item was expandable, fill it with its children. (Not the onces)
		local
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
			dv: ABSTRACT_DEBUG_VALUE
			folder_item: EV_TREE_ITEM
			new_item: EV_TREE_ITEM
			list: LIST [ABSTRACT_DEBUG_VALUE]
			flist: LIST [E_FEATURE]
		do
			item.expand_actions.wipe_out
			dv ?= item.data
			if dv /= Void then
				list := dv.children
				if not list.is_empty then
					create folder_item.make_with_text (Interface_names.l_Object_attributes)
					folder_item.set_pixmap (Pixmaps.Icon_attributes)
					item.extend (folder_item)

					from
						list.start
					until
						list.after
					loop
						folder_item.extend (debug_value_to_item (list.item))
						list.forth
					end
					conv_abs_spec ?= dv
					if conv_abs_spec /= Void then
						if conv_abs_spec.sp_lower > 0 then
							folder_item.put_front (create {EV_TREE_ITEM}.make_with_text (
								Interface_names.l_More_items))
						end
						if 0 <= conv_abs_spec.sp_upper and then conv_abs_spec.sp_upper < conv_abs_spec.capacity - 1 then
							folder_item.extend (create {EV_TREE_ITEM}.make_with_text (
								Interface_names.l_More_items))
						end
						folder_item.expand
					else
						folder_item.expand
					end
				end
				if dv.dynamic_class = Void then
					--| FIXME: JFIAT : why do we have Void dynamic_class ?
					--| ANSWER : because of external class in dotnet system
				else
					flist := dv.dynamic_class.once_functions
					if not flist.is_empty then
						create folder_item.make_with_text (Interface_names.l_Once_functions)
						folder_item.set_pixmap (Pixmaps.Icon_once_objects)
						item.extend (folder_item)
						create new_item.make_with_text (Interface_names.l_Dummy)
							--| Add expand actions.
						folder_item.extend (new_item)
						folder_item.set_data (dv)
						folder_item.expand_actions.extend (agent fill_onces (folder_item))
					end
				end
			end
				-- We remove the dummy item.
			item.start
			item.remove
		end

	fill_onces (parent: EV_TREE_ITEM) is
			-- Fill `parent' with the once functions of the debug_value it is in.
		local
			once_r: ONCE_REQUEST
			item: EV_TREE_ITEM
			flist: LIST [E_FEATURE]
			dv: ABSTRACT_DEBUG_VALUE

			item_dv: ABSTRACT_DEBUG_VALUE
			l_dotnet_ref_value: EIFNET_DEBUG_REFERENCE_VALUE
			l_feat: E_FEATURE
		do
			dv ?= parent.data
			parent.expand_actions.wipe_out
			if dv /= Void then
				flist := dv.dynamic_class.once_functions
				if Application.is_dotnet then
					l_dotnet_ref_value ?= dv
					check
						dotnet_ref_value: l_dotnet_ref_value /= Void
					end
					
					--| Eiffel dotnet |--
					from
						flist.start
					until
						flist.after
					loop
						l_feat := flist.item				
						item_dv := l_dotnet_ref_value.once_function_value (l_feat)
						if item_dv /= Void then
							item := debug_value_to_item (item_dv)						
						else
							create item
							item.set_pixmap (Pixmaps.Icon_void_object)
							item.set_text (l_feat.name + Interface_names.l_Not_yet_called)
						end						
						parent.extend (item)

						flist.forth
					end
				else 
					--| Classic Eiffel |--
					once_r := Application.debug_info.Once_request

					from
						flist.start
					until
						flist.after
					loop
						l_feat := flist.item
						
						if once_r.already_called (l_feat) then
							item := debug_value_to_item (once_r.once_result (l_feat))
						else
							create item
							item.set_pixmap (Pixmaps.Icon_void_object)
							item.set_text (l_feat.name + Interface_names.l_Not_yet_called)
						end
						parent.extend (item)
						flist.forth
					end
				end
			end
				-- We remove the dummy item.
			parent.start
			parent.remove
		end

	drop_stack_element (st: CALL_STACK_STONE) is
			-- Display stack element represented by `st'.
		do
			debugger_manager.launch_stone (st)
		end

	object_key_action (k: EV_KEY) is
			-- Actions performed when a key is pressed on a top-level object.
			-- Handle `Del'.
		local
			csts: EV_KEY_CONSTANTS
		do
			create csts
			if k.code = csts.Key_delete then
				remove_object_cmd.execute
			end
		end

	debug_value_key_action (tree: EV_TREE; k: EV_KEY) is
			-- Actions performed when a key is pressed on a debug_value.
			-- Handle `Ctrl+C'.
		local
			csts: EV_KEY_CONSTANTS
			dv: ABSTRACT_DEBUG_VALUE
			text_data: STRING
			it: EV_TREE_NODE
		do
			create csts
			if
				k.code = csts.Key_c or k.code = csts.Key_insert and then
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

	display_first, display_first_attributes, display_first_onces, display_first_special: BOOLEAN
			-- Memorize the display parameters of the current object.

end
