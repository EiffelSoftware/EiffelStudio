indexing
	description	: "Tool designated to view and edit the context of the current class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "brendel"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONTEXT_TOOL

inherit
	EB_TOOL
		export {EB_CONTEXT_EDITOR}
			manager
		redefine
			menu_name,
			pixmap
		end

	EB_HISTORY_OWNER
		rename
			set_stone as launch_stone
		redefine
			recycle,
			advanced_set_stone
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

	EB_SHARED_PIXMAPS

create
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		local
			development_window: EB_DEVELOPMENT_WINDOW
		do
			development_window ?= manager

				-- Create notebook & pages.
			create notebook
			if has_case then
				create editor.make_with_tool (Current)
			end
			create class_view.make_with_tool (development_window, Current)
			create feature_view.make_with_tool (development_window, Current)
			create external_output_view.make (development_window, Current)
			create c_compilation_output_view.make (development_window, Current)
			create error_output_view.make (development_window, Current)
			create warning_output_view.make (development_window, Current)
			create output_view.make (development_window, Current)

			if has_metrics then
				create metrics.make (development_window, Current)
			end

			create history_manager.make (Current)
			create address_manager.make (Current, True)

			if not Eiffel_project.workbench.is_already_compiled then
				on_project_unloaded
			else
				on_project_loaded
			end
				-- Set pages of the notebook.
			notebook.extend (output_view.widget)

			if has_case then
				notebook.extend (editor.widget)
				diagram_index := 2
			else
				diagram_index := -1
			end
			notebook.extend (class_view.widget)
			notebook.extend (feature_view.widget)
			if has_metrics then
				notebook.extend (metrics.widget)
				if has_case then
					metric_index := 5
				else
					metric_index := 4
				end
			else
				metric_index := -1
			end
			notebook.extend (external_output_view.widget)
			notebook.extend (c_compilation_output_view.widget)
			notebook.extend (error_output_view.widget)
			notebook.extend (warning_output_view.widget)
			notebook.set_item_text (output_view.widget, interface_names.l_Tab_output)
			notebook.set_item_text (external_output_view.widget, interface_names.l_Tab_external_output)
			notebook.set_item_text (c_compilation_output_view.widget, interface_names.l_Tab_c_output)
			notebook.set_item_text (error_output_view.widget,	interface_names.l_Tab_error_output)
			notebook.set_item_text (warning_output_view.widget,	interface_names.l_Tab_warning_output)
			if has_case then
				notebook.set_item_text (editor.widget, interface_names.l_Tab_diagram)
			end
			notebook.set_item_text (class_view.widget, interface_names.l_Tab_class_info)
			notebook.set_item_text (feature_view.widget, interface_names.l_Tab_feature_info)
			if has_metrics then
				notebook.set_item_text (metrics.widget, interface_names.l_Tab_metrics)
			end
			notebook.set_tab_position (notebook.tab_bottom)
			notebook.selection_actions.extend (agent on_tab_changed)
			notebook.set_minimum_size (500, 200)

			class_view.set_parent_notebook (notebook)
			feature_view.set_parent_notebook (notebook)
			output_view.set_parent_notebook (notebook)
			external_output_view.set_parent_notebook (notebook)
			c_compilation_output_view.set_parent_notebook (notebook)
			error_output_view.set_parent_notebook (notebook)
			warning_output_view.set_parent_notebook (notebook)
			error_output_view.set_parent_notebook (notebook)
			notebook.drop_actions.extend (agent on_tab_dropped)
			notebook.drop_actions.set_veto_pebble_function (agent on_tab_droppable)
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			create mini_toolbar
			create header_box
			mini_toolbar.extend (history_manager.back_command.new_mini_toolbar_item)
			mini_toolbar.extend (history_manager.forth_command.new_mini_toolbar_item)
			create explorer_bar_item.make_with_info (
				explorer_bar, widget, title, True, header_box, mini_toolbar)
			explorer_bar_item.set_menu_name (menu_name)
			check
				pixmap_not_void: pixmap /= Void
			end
			explorer_bar_item.set_pixmap (pixmap)
			explorer_bar.add (explorer_bar_item)
			conv_dev ?= manager
			if conv_dev /= void then
				if conv_dev.unified_stone then
					link_to_development_window
				else
					cut_from_development_window
				end
			end
			class_view.set_parent (explorer_bar_item)
			feature_view.set_parent (explorer_bar_item)
			output_view.set_parent (explorer_bar_item)
			external_output_view.set_parent (explorer_bar_item)
			c_compilation_output_view.set_parent (explorer_bar_item)
			error_output_view.set_parent (explorer_bar_item)
			warning_output_view.set_parent (explorer_bar_item)
		end

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current
		do
			Result := notebook
		end

	editor: EB_CONTEXT_EDITOR
			-- Graphically editable view of current class context.

	class_view: EB_CLASS_VIEW
			-- System statistics display.

	feature_view: EB_FEATURES_VIEW
			-- Feature information display.

	output_view: EB_OUTPUT_TOOL
			-- Displays the compiler messages.

	external_output_view: EB_EXTERNAL_OUTPUT_TOOL
			-- External command output display.

	c_compilation_output_view: EB_C_COMPILATION_OUTPUT_TOOL
			-- C compilation output display.

	warning_output_view: EB_WARNING_OUTPUT_TOOL
			-- Compilation warning output display.

	error_output_view: EB_ERROR_OUTPUT_TOOL
			-- Compilation warning output display.

	metrics: EB_METRIC_TOOL
			--

	address_manager: EB_ADDRESS_MANAGER
			-- Manager for the header info.

	window: EV_WINDOW is
			-- Window dialogs can refer to.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev ?= manager
			if conv_dev /= Void then
				Result := conv_dev.window
			else
				create Result
			end
		end

	notebook: EV_NOTEBOOK
			-- Container of `output_view', `external_output_view', `c_compilation_output_view', `editor', `class_view', `feature_view' and `metric'.

	title: STRING is
			-- Title of the tool
		do
			Result := Interface_names.t_Context_tool
		end

	mini_toolbar: EV_TOOL_BAR
			-- Toolbar containing the history commands.

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Context_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := Pixmaps.Icon_context_tool
		end

feature -- Status setting

	synchronize is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			history_manager.synchronize
			if has_metrics then
					-- Inform metric of classes recompilation.
				metrics.set_recompiled (True)
			end
			conv_dev ?= manager
			if conv_dev /= Void then
				if not conv_dev.unified_stone then
					if stone /= Void then
						stone := stone.synchronized_stone
					end
					class_view.invalidate
					feature_view.invalidate
					set_stone (stone)
					if has_case then
						editor.synchronize
					end
				end
			else
				if stone /= Void then
					stone := stone.synchronized_stone
					set_stone (stone)
				end
				refresh
			end
		end

	refresh is
			-- Class has changed in `development_window'.
		do
			if has_case then
				editor.synchronize
			end
			class_view.refresh
			feature_view.refresh
		end

	quick_refresh_editors is
			-- Update content of all editors.
		do
			output_view.quick_refresh_editor
			external_output_view.quick_refresh_editor
			c_compilation_output_view.quick_refresh_editor
			class_view.quick_refresh_editor
			feature_view.quick_refresh_editor
			address_manager.refresh
			error_output_view.quick_refresh_editor
			warning_output_view.quick_refresh_editor
		end

	quick_refresh_margins is
			-- Update margins of all editors.
		do
			output_view.quick_refresh_margin
			external_output_view.quick_refresh_margin
			c_compilation_output_view.quick_refresh_margin
			class_view.quick_refresh_margin
			feature_view.quick_refresh_margin
			address_manager.refresh
			error_output_view.quick_refresh_margin
			warning_output_view.quick_refresh_margin
		end

	cut_from_development_window is
			-- The user decided to isolate the context tool.
		do
			mini_toolbar.show
			header_box.wipe_out
			header_box.extend (address_manager.header_info)
		end

	link_to_development_window is
			-- The user decided to merge the context tool.
		do
			mini_toolbar.hide
			header_box.wipe_out
			header_box.extend (create {EV_CELL})
		end

	on_project_created is
			-- A new project has been created.
		do
			address_manager.on_project_created
		end

	on_project_loaded is
			-- A new project has been loaded. Enable all controls.
		do
		end

	on_project_unloaded is
			-- Current project has been closed:
			-- Disable all control contained in the context tool
			-- (output window excepted).
		do
		end

	set_focus is
			-- Give the focus to the currently selected item in the notebook.
		local
			sit: EV_WIDGET
		do
			sit := notebook.selected_item

			if sit = output_view.widget and then output_view.widget.is_displayed then
				output_view.set_focus
			elseif has_case and then sit = editor.widget and then editor.widget.is_displayed then
				editor.set_focus
			elseif sit = class_view.widget and then class_view.widget.is_displayed then
				class_view.set_focus
			elseif sit = feature_view.widget and then feature_view.widget.is_displayed then
				feature_view.set_focus
			elseif sit = external_output_view.widget and then external_output_view.widget.is_displayed then
				external_output_view.set_focus
			elseif sit = c_compilation_output_view.widget and then c_compilation_output_view.widget.is_displayed then
				c_compilation_output_view.set_focus
			elseif sit = error_output_view.widget and then error_output_view.widget.is_displayed then
				error_output_view.set_focus
			elseif sit = warning_output_view.widget and then warning_output_view.widget.is_displayed then
				warning_output_view.set_focus
			elseif has_metrics and then sit = metrics.widget and then metrics.widget.is_displayed then
				metrics.set_focus
			end
		end

feature -- Status report

	is_diagram_selected: BOOLEAN
			-- Is the current tab `editor'?

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			Precursor {EB_HISTORY_OWNER}
				-- Recycle the views
			output_view.recycle
			external_output_view.recycle
			c_compilation_output_view.recycle
			class_view.recycle
			feature_view.recycle
			error_output_view.recycle
			warning_output_view.recycle
			if has_case then
					-- Save the diagram
				editor.store
				editor.recycle
			end
			if has_metrics then
				metrics.recycle
			end
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			notebook.selection_actions.block
			notebook.destroy
			notebook := Void
			manager := Void
		end

feature -- Stone management

	launch_stone (st: STONE) is
			-- Propagate a stone to parents or neighbours.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev ?= manager
			if conv_dev /= Void then
				if conv_dev.unified_stone then
					sending_stone := True
					conv_dev.set_stone (st)
					sending_stone := False
				else
					set_stone (st)
				end
			end
			set_focus
		end

	stone: STONE
			-- Currently managed stone.

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		do
			history_manager.extend (a_stone)
			Eb_debugger_manager.set_stone (a_stone)
			feature_view.set_stone (a_stone)
			class_view.set_stone (a_stone)
			if has_case then
				editor.set_stone (a_stone)
			end
			stone := a_stone
			if has_metrics then
				metrics.set_stone (a_stone)
			end
		end

	advanced_set_stone (a_stone: STONE) is
			-- Switch to the tab corresponding to `a_stone' and set it.
		local
			conv_fst: FEATURE_STONE
			conv_cst: CLASSI_STONE
			ind: INTEGER
		do
			ind := notebook.selected_item_index
			if ind /= diagram_index and ind /= metric_index then
					-- Do not switch tabs if we're in the diagram tool or the metric tool.
				conv_fst ?= a_stone
				if conv_fst /= Void then
					notebook.select_item (feature_view.widget)
				else
					conv_cst ?= a_stone
					if conv_cst /= Void then
						notebook.select_item (class_view.widget)
					end
				end
			end
			launch_stone (a_stone)
		end

feature -- C output pixmap management

	start_c_output_pixmap_timer is
			-- Start timer to draw pixmap animation on c output panel
		do
			c_output_timer_counter := 1
			c_output_pixmap_timer.set_interval (300)
		end

	stop_c_output_pixmap_timer is
			-- Stop timer to draw pixmap animation on c output panel
		do
			c_output_pixmap_timer.set_interval (0)
			draw_pixmap_on_tab (c_output_panel_tab, Void)
		end

	c_output_timer_counter: INTEGER
			-- Counter to indicate which pixmap should be displayed

	c_output_pixmap_timer: EV_TIMEOUT is
			-- Timer to draw c output pixmap
		once
			Create Result
			Result.set_interval (0)
			Result.actions.extend (agent on_draw_c_output_pixmap)
		end

	on_draw_c_output_pixmap is
			-- Draw pixmap animation for C output.
		do
			draw_pixmap_on_tab (c_output_panel_tab, Icon_compiling.item (c_output_timer_counter))
			c_output_timer_counter := c_output_timer_counter + 1
			if c_output_timer_counter > 4 then
				c_output_timer_counter := 1
			end
		end

	draw_pixmap_on_tab (a_tab: EV_NOTEBOOK_TAB; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' on `a_tab'.
			-- If `a_pixmap' is Void, clear any existing pixmap on `a_tab'.
		require
			a_tab_not_void: a_tab /= Void
		do
			a_tab.remove_pixmap
			if a_pixmap /= Void then
				a_tab.set_pixmap (a_pixmap)
			end
		end

	c_output_panel_tab: EV_NOTEBOOK_TAB is
			-- Notebook tab for C output
		do
			if notebook /= Void then
				Result := notebook.item_tab (c_compilation_output_view.widget)
			end
		end

feature {EB_DEVELOPMENT_WINDOW} -- Private stone management

	sending_stone: BOOLEAN
			-- Is `Current' sending a stone to its development window?

feature {NONE} -- Implementation

	header_box: EV_HORIZONTAL_BOX
			-- Box that contains the address_manager header_info when the context tool is separated from the development window.

	diagram_index: INTEGER
			-- Index of the diagram tool in the notebook.

	metric_index: INTEGER
			-- Index of the metrics in the notebook.

	on_tab_changed is
			-- User selected a different tab.
		do
			if has_case and then notebook.selected_item = editor.widget then
				output_view.on_deselect
				external_output_view.on_deselect
				c_compilation_output_view.on_deselect
				is_diagram_selected := True
				editor.on_select
				class_view.on_deselect
				feature_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			elseif notebook.selected_item = class_view.widget then
				output_view.on_deselect
				external_output_view.on_deselect
				c_compilation_output_view.on_deselect
				is_diagram_selected := False
				class_view.on_select
				feature_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			elseif notebook.selected_item = feature_view.widget then
				output_view.on_deselect
				external_output_view.on_deselect
				c_compilation_output_view.on_deselect
				is_diagram_selected := False
				feature_view.on_select
				class_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			elseif has_metrics and then notebook.selected_item = metrics.widget then
				output_view.on_deselect
				external_output_view.on_deselect
				c_compilation_output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				metrics.on_select
			elseif notebook.selected_item = output_view.widget then
				output_view.on_select
				external_output_view.on_deselect
				c_compilation_output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			elseif notebook.selected_item = external_output_view.widget then
				external_output_view.on_select
				c_compilation_output_view.on_deselect
				output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			elseif notebook.selected_item = c_compilation_output_view.widget then
				c_compilation_output_view.on_select
				external_output_view.on_deselect
				output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			elseif notebook.selected_item = error_output_view.widget then
				error_output_view.on_select
				external_output_view.on_deselect
				output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			elseif notebook.selected_item = warning_output_view.widget then
				warning_output_view.on_select
				external_output_view.on_deselect
				output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			else
				output_view.on_deselect
				external_output_view.on_deselect
				c_compilation_output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				if has_metrics then
					metrics.on_deselect
				end
			end
		end

	on_tab_droppable (a_pebble: ANY): BOOLEAN is
			-- Can be data be dropped on `notebook' for a particular notebook item?
			-- Will be true for all tab items except `output_view', `c_compilation_output_view',
			-- `warning_output_view', `error_output_view' and `external_output_view' when `a_pebble' is of type `STONE'.
		require
			notebook_not_void: notebook /= Void
			notebook_not_destroyed: not notebook.is_destroyed
		local
			l_tab_index: INTEGER
			l_stone: STONE
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				l_tab_index := notebook.pointed_tab_index
				Result := l_tab_index > 0 and then (notebook.i_th (l_tab_index) /= output_view.widget and notebook.i_th (l_tab_index) /= external_output_view.widget
						  and notebook.i_th (l_tab_index) /= c_compilation_output_view.widget and notebook.i_th (l_tab_index) /= error_output_view.widget
						  and notebook.i_th (l_tab_index) /= warning_output_view.widget
				)
			end
		end

	on_tab_dropped (a_pebble: ANY) is
			-- Action called when `a_pebble' is dropped on a notebook item.
			-- It will target current to `a_pebble'.
		require
			notebook_not_void: notebook /= Void
			notebook_not_destroyed: not notebook.is_destroyed
			notebook_has_pointed_tab: notebook.pointed_tab_index > 0
			not_output_view: notebook.i_th (notebook.pointed_tab_index) /= output_view.widget
			not_external_output_wiew: notebook.i_th (notebook.pointed_tab_index) /= external_output_view.widget
			not_c_compilation_output_wiew: notebook.i_th (notebook.pointed_tab_index) /= c_compilation_output_view.widget
			not_error_output_wiew: notebook.i_th (notebook.pointed_tab_index) /= error_output_view.widget
			not_warningn_output_wiew: notebook.i_th (notebook.pointed_tab_index) /= warning_output_view.widget
		local
			l_tab_index: INTEGER
			l_stone: STONE
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				l_tab_index := notebook.pointed_tab_index
				if l_tab_index > 0 then
					notebook.select_item (notebook.i_th (l_tab_index))
					set_stone (l_stone)
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_CONTEXT_TOOL
