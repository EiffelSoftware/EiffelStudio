indexing
	description	: "Tool designated to view and edit the context of the current class."
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
			create editor.make_with_tool (Current)
			create class_view.make_with_tool (development_window, Current)
			create feature_view.make_with_tool (development_window, Current)
			create output_view.make (development_window, Current)
			create metrics.make (development_window, Current)

			if not Eiffel_project.workbench.is_already_compiled then
				on_project_unloaded
			else
				on_project_loaded
			end
				-- Set pages of the notebook.
			notebook.extend (output_view.widget)
			notebook.extend (editor.widget)
			notebook.extend (class_view.widget)
			notebook.extend (feature_view.widget)
			notebook.extend (metrics.widget)
			notebook.set_item_text (output_view.widget, interface_names.l_Tab_output)
			notebook.set_item_text (editor.widget, interface_names.l_Tab_diagram)
			notebook.set_item_text (class_view.widget, interface_names.l_Tab_class_info)
			notebook.set_item_text (feature_view.widget, interface_names.l_Tab_feature_info)
			notebook.set_item_text (metrics.widget, interface_names.l_Tab_metrics)
			notebook.set_tab_position (notebook.Tab_bottom)
			notebook.selection_actions.extend (~on_tab_changed)
			notebook.set_minimum_size (500, 200)

			class_view.set_parent_notebook (notebook)
			feature_view.set_parent_notebook (notebook)
			output_view.set_parent_notebook (notebook)
		end

	build_explorer_bar is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			create history_manager.make (Current)
			create address_manager.make (Current, True)
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
			explorer_bar.repack_widgets
			class_view.set_parent (explorer_bar_item)
			feature_view.set_parent (explorer_bar_item)
			output_view.set_parent (explorer_bar_item)
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
			-- Container of `output_view', `editor', `class_view', `feature_view' and `metric'.

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

	pixmap: ARRAY [EV_PIXMAP] is
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
				-- Inform metric of classes recompilation.
			metrics.set_recompiled (True)
			conv_dev ?= manager
			if conv_dev /= Void then
				if not conv_dev.unified_stone then
					if stone /= Void then
						stone := stone.synchronized_stone
						set_stone (stone)
					end
					refresh
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
			editor.synchronize
			class_view.refresh
			feature_view.refresh
		end

	quick_refresh is
			-- Class has changed in `development_window'.
		do
			output_view.quick_refresh
			class_view.quick_refresh
			feature_view.quick_refresh
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
			editor.widget.enable_sensitive
			class_view.widget.enable_sensitive
			feature_view.widget.enable_sensitive
			metrics.widget.enable_sensitive
		end

	on_project_unloaded is
			-- Current project has been closed:
			-- Disable all control contained in the context tool
			-- (output window excepted).
		do
			editor.widget.disable_sensitive
			class_view.widget.disable_sensitive
			feature_view.widget.disable_sensitive
			metrics.widget.disable_sensitive
		end

	set_focus is
			-- Give the focus to the currently selected item in the notebook.
		local
			sit: EV_WIDGET
		do
			sit := notebook.selected_item
			if sit = output_view.widget then
				output_view.set_focus
			elseif sit = editor.widget then
				editor.set_focus
			elseif sit = class_view.widget then
				class_view.set_focus
			elseif sit = feature_view.widget then
				feature_view.set_focus
			elseif sit = metrics.widget then
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
			class_view.recycle
			feature_view.recycle
				-- Save the diagram
			editor.store
			editor.recycle
			metrics.recycle
			explorer_bar_item.recycle
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
					conv_dev.set_stone (st)
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
		local
			fw: EV_WIDGET
		do
			history_manager.extend (a_stone)
			debugger_manager.set_stone (a_stone)
			feature_view.set_stone (a_stone)
			class_view.set_stone (a_stone)
			editor.set_stone (a_stone)
			stone := a_stone
			metrics.set_stone (a_stone)
		end

	advanced_set_stone (a_stone: STONE) is
			-- Switch to the tab corresponding to `a_stone' and set it.
		local
			conv_fst: FEATURE_STONE
			conv_cst: CLASSI_STONE
			ind: INTEGER
		do
			ind := notebook.selected_item_index
			if ind /= 2 and ind /= 5 then
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

feature {NONE} -- Implementation

	header_box: EV_HORIZONTAL_BOX
			-- Box that contains the address_manager header_info when the context tool is separated from the development window.

	on_tab_changed is
			-- User selected a different tab.
		do
			if notebook.selected_item = editor.widget then
				output_view.on_deselect
				is_diagram_selected := True
				editor.on_select
				class_view.on_deselect
				feature_view.on_deselect
				metrics.on_deselect
			elseif notebook.selected_item = class_view.widget then
				output_view.on_deselect
				is_diagram_selected := False
				class_view.on_select
				feature_view.on_deselect
				metrics.on_deselect
			elseif notebook.selected_item = feature_view.widget then
				output_view.on_deselect
				is_diagram_selected := False
				feature_view.on_select
				class_view.on_deselect
				metrics.on_deselect
			elseif notebook.selected_item = metrics.widget then
				output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				metrics.on_select
			elseif notebook.selected_item = output_view.widget then
				output_view.on_select
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				metrics.on_deselect
			else
				output_view.on_deselect
				is_diagram_selected := False
				class_view.on_deselect
				feature_view.on_deselect
				metrics.on_deselect
			end
		end

end -- class EB_CONTEXT_TOOL
