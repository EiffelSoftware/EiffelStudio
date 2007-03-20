indexing
	description: "Tool as formatters container"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FORMATTER_BASED_TOOL

inherit
	EB_TOOL
		redefine
			build_mini_toolbar,
			build_docking_content,
			mini_toolbar,
			force_last_stone,
			show,
			show_with_setting
		end

	SHARED_EIFFEL_PROJECT

	EB_HISTORY_OWNER
		rename
			set_stone as drop_stone
		redefine
			internal_recycle
		end

	EB_VIEWPOINT_AREA

	WIDGET_OWNER

	SHARED_WORKBENCH

	EB_CONSTANTS

	EB_SHARED_PREFERENCES

	EVS_UTILITY

	EB_SHARED_FORMATTER_DIALOGS

feature{NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			create {LINKED_LIST [EB_FORMATTER]} formatters.make
			create {LINKED_LIST [EB_FORMATTER]} customized_formatters.make
			create {LINKED_LIST [EB_FORMATTER]} layout_formatters.make
			on_customized_formatter_loaded_agent := agent on_customized_formatter_loaded
			customized_formatter_manager.change_actions.extend (on_customized_formatter_loaded_agent)

			veto_format_function_agent := agent veto_format

			on_metric_loaded_agent := agent on_metric_loaded
			metric_manager.metric_loaded_actions.extend (on_metric_loaded_agent)

			on_project_loaded_agent := agent on_project_loaded

			eiffel_project.manager.load_agents.extend (on_project_loaded_agent)
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build dockable content.
		do
			Precursor (a_docking_manager)
			content.drop_actions.extend (agent on_item_dropped)
		end

	build_interface is
			-- Build interface
		do
			create history_manager.make (Current)
			create address_manager.make (Current, True)

			initialize
			build_formatters
			fill_in
			on_select
		end

feature -- Access

	formatters: LIST [EB_FORMATTER]
			-- List of formatters to be displayed in Current tool

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current'.

	formatter_container: EV_CELL
			-- Cell containing the selected formatter's widget.

	parent_notebook: EV_NOTEBOOK
			-- Needed to pop up when corresponding menus are selected.
			--| Not in implementation because it is used in a precondition.

	address_manager: EB_ADDRESS_MANAGER
			-- Manager for the header info.

	last_widget: EV_WIDGET is
			-- Last set widget
		do
			if formatter_container.readable then
				Result := formatter_container.item
			end
		end

	predefined_formatters: like formatters is
			-- Predefined formatters
		deferred
		ensure
			result_attached: Result /= Void
		end

	no_target_message: STRING_GENERAL is
			-- Message to be displayed in `output_line' when no stone is set
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.

	is_stone_external: BOOLEAN
			-- Does current stone repreasent a .NET class?

feature -- Setting

	pop_default_formatter is
			-- Popup default formatter specified by `default_formatter'.
		deferred
		end

	drop_stone (st: like last_stone) is
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		deferred
		end

	set_stone (new_stone: STONE) is
			-- Associate current formatter with stone contained in `new_stone'.
		deferred
		end

	invalidate is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.invalidate end)
			set_last_stone (Void)
		end

	refresh is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			do_all_in_list (formatters,
				agent (a_formatter: EB_FORMATTER)
					do
						a_formatter.invalidate
						a_formatter.format
					end
			)
		end

	quick_refresh_editor is
			-- Refresh the editor.
		do
			do_all_in_list (
				displayer_cache.linear_representation,
				agent (a_any: ANY)
					local
						l_displayer: EB_FORMATTER_EDITOR_DISPLAYER
					do
						l_displayer ?= a_any
						if l_displayer /= Void and then l_displayer.editor /= Void then
							l_displayer.editor.refresh
						end
					end
			)
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
			do_all_in_list (
				displayer_cache.linear_representation,
				agent (a_any: ANY)
					local
						l_displayer: EB_FORMATTER_EDITOR_DISPLAYER
					do
						l_displayer ?= a_any
						if l_displayer /= Void and then l_displayer.editor /= Void then
							l_displayer.editor.margin.refresh
						end
					end
			)
		end

	set_parent_notebook (a_notebook: EV_NOTEBOOK) is
			-- Set `parent_notebok' to `a_notebook'.
		require
			a_notebook_non_void: a_notebook /= Void
			a_notebook_really_parent: a_notebook.has (widget)
		do
			parent_notebook := a_notebook
		end

	set_focus is
			-- Give the focus to `Current'.
		require
			focusable: content.is_visible and widget.is_sensitive
		do
			do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.set_focus end)
		end

	set_widget (new_widget: EV_WIDGET) is
			-- Display `new_widget' under the tool bar.
		local
			l_formatters: like formatters
			l_cursor: CURSOR
			l_control_bar: EV_WIDGET
			done: BOOLEAN
		do
			if not formatter_container.has (new_widget) then
				l_formatters := formatters
				l_cursor := l_formatters.cursor
				from
					formatter_tool_bar_area.wipe_out
					l_formatters.start
				until
					l_formatters.after or done
				loop
					if l_formatters.item.selected then
						l_control_bar := l_formatters.item.control_bar
						if l_control_bar /= Void then
							formatter_tool_bar_area.extend (l_control_bar)
							formatter_tool_bar_area.disable_item_expand (l_control_bar)
						end
						outer_container.wipe_out
						outer_container.extend (formatter_container)
						done := True
					end
					l_formatters.forth
				end
				l_formatters.go_to (l_cursor)
				formatter_container.replace (new_widget)
			end
		end

	force_last_stone is
			-- Force that `last_stone' is displayed in formatters in Current view
		do
			if not is_last_stone_processed then
				do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.set_stone (stone) end)
				history_manager.extend (stone)
				Precursor
			end
		end

	show is
			-- Show tool.
		do
			Precursor
			do_all_in_list (
				formatters,
				agent (a_formatter: EB_FORMATTER)
					do
						if a_formatter.selected then
							a_formatter.set_focus
						end
					end
			)
		end

	show_with_setting is
			-- Show current tool (if possible), and do some settings
		do
			Precursor
			pop_default_formatter
			set_focus
		end

	force_display is
			-- Jump to this tab and display `explorer_parent'.
		do
			if
				parent_notebook /= Void and then
				not visible
			then
				parent_notebook.select_item (widget)
			end
		end

	force_reload is
			-- Force to reload `formatters'
		do
			on_customized_formatter_loaded
		end

feature{NONE} -- Implementation/Cache

	displayer_cache: HASH_TABLE [EB_FORMATTER_DISPLAYER, STRING] is
			-- Cache for formatter displayers indexed by name
		do
			if displayer_cache_internal = Void then
				create displayer_cache_internal.make (10)
			end
			Result := displayer_cache_internal
		end

	cached_displayer_names: DS_HASH_SET [STRING] is
			-- Set of names of cached displayers			
		local
			l_cache: like displayer_cache
		do
			create Result.make (10)
			l_cache := displayer_cache
			from
				l_cache.start
			until
				l_cache.after
			loop
				Result.force_last (l_cache.key_for_iteration)
				l_cache.forth
			end
		ensure
			result_attached: Result /= Void
			good_result: Result.count = displayer_cache.count
		end

	needed_displayers: DS_HASH_SET [STRING] is
			-- Set of names of needed displayers for `formatters'
		local
			l_formatters: like formatters
			l_cursor: CURSOR
		do
			create Result.make (10)
			l_formatters := formatters
			l_cursor := l_formatters.cursor
			from
				l_formatters.start
			until
				l_formatters.after
			loop
				if l_formatters.item /= Void then
					Result.force_last (l_formatters.item.displayer_generator.name)
				end
				l_formatters.forth
			end
			l_formatters.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

	remove_cache (a_names: DS_HASH_SET [STRING]) is
			-- Remove cached displayers whose names are given by `a_names'.
		require
			a_names_attached: a_names /= Void
			a_names_valid: not a_names.has (Void)
		local
			l_cursor: DS_HASH_SET_CURSOR [STRING]
			l_cache: like displayer_cache
		do
			l_cursor := a_names.new_cursor
			l_cache := displayer_cache
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_cache.remove (l_cursor.item)
				l_cursor.forth
			end
		end

feature{NONE} -- Implementation

	attach_veto_format_function is
			-- Attach veto format function to `formatters'.
		do
			do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.set_veto_format_function (agent veto_format) end)
		end

	detach_veto_format_function is
			-- Detach veto format function to `formatters'.
		do
			do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.set_veto_format_function (Void) end)
		end

	veto_format_function_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Veto format function

	veto_format: BOOLEAN is
			-- True if format is allowed to go on, otherwise False.
		do
			Result := not is_format_vetoed
		end

	is_format_vetoed: BOOLEAN
			-- Is format vetoed?

	set_is_format_vetoed (b: BOOLEAN) is
			-- Set `is_format_vetoed' with `b'.
		do
			is_format_vetoed := b
		ensure
			is_format_vetoed_set: is_format_vetoed = b
		end

	retrieve_formatters is
			-- Retrieve all formatters related with Current tool and store them in `formatters'
		require
			predefined_formatters_attached: predefined_formatters /= Void
		local
			l_layout_formatters: like layout_formatters
			l_customized_formatters: LIST [EB_FORMATTER]
		do
			detach_veto_format_function
			do_all_in_list (customized_formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.recycle end)

			l_layout_formatters := layout_formatters
			l_layout_formatters.wipe_out
			l_layout_formatters.append (predefined_formatters)

			l_customized_formatters := customized_formatters
			l_customized_formatters.wipe_out
			l_customized_formatters.append (customized_formatter_manager.formatters (title_for_pre, develop_window))

			if not l_customized_formatters.is_empty then
				if not predefined_formatters.is_empty then
					l_layout_formatters.extend (Void)
				end
				l_layout_formatters.append (l_customized_formatters)
			end

			fill_formatters
			attach_veto_format_function
			do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.set_manager (develop_window.tools) end)
		end

	fill_formatters is
			-- Fill `formatters' with non Void formatters in `predefined_formatters' and `customized_formatters'.
		local
			l_formatters: like formatters
		do
			l_formatters := formatters
			l_formatters.wipe_out
			l_formatters.append (predefined_formatters)
			l_formatters.append (customized_formatters)
			from
				l_formatters.start
			until
				l_formatters.after
			loop
				if l_formatters.item = Void then
					l_formatters.remove
				else
					l_formatters.forth
				end
			end
		end

	build_formatters is
			-- Build all formatters
		local
			l_displayers: like cached_displayer_names
		do
			retrieve_formatters
			setup_displayers (formatters)

				-- Removed unused displayers.
			l_displayers := cached_displayer_names
			l_displayers.subtract (needed_displayers)
			remove_cache (l_displayers)
		end

	setup_displayers (a_formatters: LIST [EB_FORMATTER]) is
			-- Setup displayers for every formatter in `a_formatters'
		require
			a_formatters_attached: a_formatters /= Void
		local
			l_formatters: LIST [EB_FORMATTER]
			l_cursor: CURSOR
			l_formatter: EB_FORMATTER
			l_generator: TUPLE [displayer_generator: FUNCTION [ANY, TUPLE, EB_FORMATTER_DISPLAYER]; displayer_name: STRING]
		do
				-- Setup displaysers.
			l_formatters := a_formatters
			l_cursor := l_formatters.cursor
			from
				l_formatters.start
			until
				l_formatters.after
			loop
				l_formatter := l_formatters.item
				if l_formatter /= Void and then l_formatter.displayer = Void then
					l_formatter.set_viewpoints (viewpoints)
					l_generator := l_formatter.displayer_generator
					l_formatter.set_displayer (new_displayer (l_generator.displayer_name, l_generator.displayer_generator))
				end
				l_formatters.forth
			end
			l_formatters.go_to (l_cursor)
		end

	new_displayer (a_name: STRING; a_generator: FUNCTION [ANY, TUPLE, EB_FORMATTER_DISPLAYER]): EB_FORMATTER_DISPLAYER is
			-- New displayer whose name is `a_name' generated from `a_generator'
			-- If there is already a displayer of the same name in cache, use that one instead of generating a new one.
			-- If a new displayer is generated, also put it in cache.
		require
			a_name_attached: a_name /= Void
			a_name_valid: not a_name.is_empty
			a_generator_attached: a_generator /= Void
		local
			l_drop_actions: EV_PND_ACTION_SEQUENCE
			l_cache: like displayer_cache
		do
			l_cache := displayer_cache
			Result := l_cache.item (a_name)
			if Result = Void then
				create l_drop_actions
				l_drop_actions.extend (agent drop_stone)
				Result := a_generator.item ([develop_window, l_drop_actions])
				Result.set_refresher (agent refresh)
				l_cache.put (Result, a_name)
			end
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	displayer_cache_internal: like displayer_cache
			-- Implementation of `displayer_cache'

	on_customized_formatter_loaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_customized_formatter_loaded'

	on_metric_loaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_metric_loaded'

	window: EV_WINDOW is
			-- Window dialogs can refer to.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev ?= develop_window
			if conv_dev /= Void then
				Result := conv_dev.window
			else
				create Result
			end
		end

	mini_toolbar: EV_HORIZONTAL_BOX
			-- Mini tool bar.

	history_toolbar: EV_TOOL_BAR
			-- Toolbar containing the history commands.

	outer_container: EV_CELL
			-- Container to hold `formatter_container' and `editor_frame' (if current formatter is an editor formatter)

	used: BOOLEAN
			-- Has the class view been used yet to perform any formatting?

	tool_bar: EV_TOOL_BAR
			-- Toolbar containing all buttons.

	tool_bar_area: EV_HORIZONTAL_BOX
			-- Area to contain tool bars

	formatter_tool_bar_area: EV_HORIZONTAL_BOX
			-- Area to contain tool bar from formatter

	output_line: EV_LABEL
			-- Line to display status of current formatter.

	layout_formatters: like formatters
			-- List of formatters with possible Void items in it representing separators

	on_project_loaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_project_loaded'

	customized_formatters: like formatters
			-- Customized formatters

feature{NONE} -- Actions

	on_customized_formatter_loaded is
			-- Action to be performed when customized formatters are loaded in `customized_formatter_manager'.
		local
			l_stone: like stone
		do
			l_stone := stone
			if customized_formatter_manager.has_formatters then
				load_metrics (False, metric_names.t_loading_metrics, develop_window)
				show_error_message (agent metric_manager.last_error, agent metric_manager.clear_last_error, develop_window.window)
			end
			build_formatters
			attach_formatters
			invalidate
			on_select
			set_stone (l_stone)
			formatter_dialog.on_items_reloaded
		end

	on_metric_loaded is
			-- Action to be performed when metrices are loaded/reloaded in `metric_manager'
		local
			l_last_stone: like last_stone
		do
			if customized_formatter_manager.is_loaded and then customized_formatter_manager.has_formatters then
				do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do if a_formatter /= Void then a_formatter.synchronize end end)
				l_last_stone := last_stone
				invalidate
				set_stone (l_last_stone)
			end
		end

	on_item_dropped (a_pebble: ANY) is
			-- Action to be performed when `a_pebble' is dropped
		local
			l_stone: like last_stone
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				drop_stone (l_stone)
			end
		end

	on_context_change is
			-- Action to be performed when `viewpoints' changes
		do
			token_writer.set_context_group (viewpoints.current_viewpoint)
			refresh
		end

	on_select is
			-- Display information from the selected formatter.
		do
			visible := True
			do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.on_shown end)
		end

	on_deselect is
			-- This view is hidden.
		do
			do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.on_hidden end)
			visible := False
		end

	on_setup_customized_formatters is
			-- Action to be performed to reload customized formatters
		do
			popup_formatter_dialog (develop_window)
		end

	on_project_loaded is
			-- Action to be performed when project is loaded into EiffelStudio
		do
			reload_customized_formatter (False)
		end

feature{NONE} -- Implementation

	build_mini_toolbar is
			-- Redefine
		do
			create history_toolbar
			history_toolbar.extend (history_manager.back_command.new_mini_toolbar_item)
			history_toolbar.extend (history_manager.forth_command.new_mini_toolbar_item)

			create mini_toolbar
			mini_toolbar.extend (address_manager.header_info)
			mini_toolbar.extend (history_toolbar)
			address_manager.label_changed_actions.extend (agent (develop_window.docking_manager).update_mini_tool_bar_size (content))
		end

	do_all_in_list (a_list: LIST [ANY]; a_agent: PROCEDURE [ANY, TUPLE [ANY]]) is
			-- Call `a_agent' for every element in `a_list'.
		require
			a_list_attached: a_list /= Void
			a_agent_attached: a_agent /= Void
		do
			a_list.do_all (a_agent)
		end

	fill_in is
			-- Display all controls of the window.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			create widget
			create formatter_container
			create output_line
			create outer_container
			create tool_bar_area
			create formatter_tool_bar_area
			create sep
			output_line.align_text_left
			build_tool_bar
			widget.extend (tool_bar_area)
			widget.disable_item_expand (tool_bar_area)
			widget.extend (sep)
			widget.disable_item_expand (sep)
			widget.extend (output_line)
			widget.disable_item_expand (output_line)
			outer_container.wipe_out
			outer_container.extend (formatter_container)
			widget.extend (outer_container)
			output_line.set_text (no_target_message)
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			l_cell: EV_CELL
			l_setup_toolbar: EV_TOOL_BAR
		do
			create tool_bar
			create l_cell
			create l_setup_toolbar
			tool_bar_area.extend (tool_bar)
			tool_bar_area.disable_item_expand (tool_bar)
			tool_bar_area.extend (formatter_tool_bar_area)
			tool_bar_area.disable_item_expand (formatter_tool_bar_area)
			tool_bar_area.extend (viewpoint_area)
			tool_bar_area.disable_item_expand (viewpoint_area)
			tool_bar_area.extend (l_cell)
			tool_bar_area.extend (l_setup_toolbar)
			tool_bar_area.disable_item_expand (l_setup_toolbar)

			l_setup_toolbar.extend (customized_formatter_button)
			attach_formatters
		end

	attach_formatters is
			-- Attach `formatters' in Current tool
		local
			l_formatters: like formatters
			l_cursor: CURSOR
			l_formatter: EB_FORMATTER
			l_control_bar: EV_WIDGET
		do
			set_is_format_vetoed (True)
			tool_bar.wipe_out
			set_is_format_vetoed (False)
			formatter_tool_bar_area.wipe_out
			viewpoint_area.hide
			l_formatters := layout_formatters
			l_cursor := l_formatters.cursor
			from
				l_formatters.start
			until
				l_formatters.after
			loop
				l_formatter := l_formatters.item
				if l_formatter /= Void then
					l_formatter.set_widget_owner (Current)
					tool_bar.extend (l_formatter.new_button)
					l_formatter.set_output_line (output_line)
					if l_formatter.selected then
						l_control_bar := l_formatters.item.control_bar
						if l_control_bar /= Void then
							formatter_tool_bar_area.extend (l_control_bar)
							formatter_tool_bar_area.disable_item_expand (l_control_bar)
						end
					end
				else
					tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
				end
				l_formatters.forth
			end
			pop_default_formatter
		end

	customized_formatter_button: EV_TOOL_BAR_BUTTON is
			-- Button used to setup customized formatters
		do
			if customized_formatter_button_internal = Void then
				create customized_formatter_button_internal
				customized_formatter_button_internal.set_pixmap (pixmaps.icon_pixmaps.general_edit_icon)
				 customized_formatter_button_internal.set_tooltip (interface_names.f_customize_formatter)
				 customized_formatter_button_internal.select_actions.extend (agent on_setup_customized_formatters)
			end
			Result := customized_formatter_button_internal
		ensure
			result_attached: Result /= Void
		end

	customized_formatter_button_internal: like customized_formatter_button
			-- Implementation of `customized_formatter_button'

feature{NONE} -- Recycle

	internal_recycle is
			-- To be called when the button has became useless.
		do
			Precursor

			safe_remove_agent (on_customized_formatter_loaded_agent, customized_formatter_manager.change_actions)
			if eiffel_project.manager.load_agents.has (on_project_loaded_agent) then
				eiffel_project.manager.load_agents.prune_all (on_project_loaded_agent)
			end
			detach_veto_format_function
			do_all_in_list (customized_formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.recycle end)
			do_all_in_list (displayer_cache.linear_representation, agent (a_displayer: EB_FORMATTER_DISPLAYER) do a_displayer.recycle end)

			develop_window := Void
		end

invariant
	on_customized_formatter_loaded_agent_attached: on_customized_formatter_loaded_agent /= Void
	on_metric_loaded_agent_attached: on_metric_loaded_agent /= Void
	formatters_attached: formatters /= Void
	on_project_loaded_agent_attached: on_project_loaded_agent /= Void
	customized_formatters_attached: customized_formatters /= Void
	veto_format_function_agent_attached: veto_format_function_agent /= Void

end
