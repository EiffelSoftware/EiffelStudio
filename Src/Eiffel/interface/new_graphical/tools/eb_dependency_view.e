indexing
	description: "Dependency view panel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEPENDENCY_TOOL

inherit
	EB_TOOL
		redefine
			pixmap,
			show,
			close,
			build_mini_toolbar,
			mini_toolbar,
			force_last_stone,
			build_docking_content
		end

	WIDGET_OWNER

	SHARED_WORKBENCH

	EB_SHARED_PREFERENCES

	EB_VIEWPOINT_AREA

	EB_HISTORY_OWNER
		rename
			set_stone as drop_stone
		redefine
			internal_recycle
		end

create
	make

feature {NONE} -- Initialization

	make_with_tool (a_tool: EB_DEVELOPMENT_WINDOW) is
			-- Set default values.
		require
			formatters_initialized: a_tool.managed_class_formatters /= Void
		local
			formatters: like managed_formatters
			conv_ct: EB_DEPENDENCY_FORMATTER
			l_drop_actions: EV_PND_ACTION_SEQUENCE
		do
			formatters := a_tool.managed_dependency_formatters
			create managed_formatters.make (10)
			create l_drop_actions
			l_drop_actions.extend (agent drop_stone)
			create shared_browser.make (a_tool, l_drop_actions)
			shared_browser.set_sorting_status (shared_browser.sorted_columns_from_string (preferences.class_browser_data.dependency_view_sorting_order))
			shared_browser.retrieve_data_actions.extend (agent refresh)
			from
				formatters.start
			until
				formatters.after
			loop
				conv_ct ?= formatters.item
				if conv_ct /= Void then
					conv_ct.set_viewpoints (viewpoints)
					conv_ct.set_browser (shared_browser)
				end
				managed_formatters.extend (formatters.item)
				formatters.forth
			end
			fill_in
		end

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

	build_interface is
			-- Redefine
		do
			make_with_tool (develop_window)
			create history_manager.make (Current)
			create address_manager.make (Current, True)
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build docking content.
		do
			Precursor {EB_TOOL} (a_docking_manager)
--			content.drop_actions.extend (agent drop_stone)
			content.drop_actions.extend (agent on_item_dropped)
		end

feature -- Access

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current'.

	title_for_pre: STRING is
			-- Redefine
		do
			Result := interface_names.to_dependency_tool
		end

	title: STRING_GENERAL is
			-- Redefine
		do
			Result := interface_names.l_tab_dependency_info
		end

	pixmap: EV_PIXMAP is
			-- Redefine
		do
			Result := pixmaps.icon_pixmaps.diagram_supplier_link_icon
		end

	formatter_container: EV_CELL
			-- Cell containing the selected formatter's widget.

	stone: STONE is
			-- Currently managed stone.
		do
			if internal_stone = Void then
				Result := develop_window.tools.stone
			else
				Result := internal_stone
			end
		end

	is_stone_external: BOOLEAN
			-- Does current stone repreasent a .NET class?

	last_widget: EV_WIDGET is
			-- Last set widget
		do
			if formatter_container.readable then
				Result := formatter_container.item
			end
		end

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

	address_manager: EB_ADDRESS_MANAGER
			-- Manager for the header info.

feature -- Status report

	is_stone_equal (a_stone, b_stone: STONE): BOOLEAN is
			-- Is `a_stone' equal to `b_stone'?
		require
			a_stone_attached: a_stone /= Void
			b_stone_attached: b_stone /= Void
		local
			l_a_cluster_stone: CLUSTER_STONE
			l_b_cluster_stone: CLUSTER_STONE
			l_a_path: STRING
			l_b_path: STRING
		do
			Result := a_stone.same_as (b_stone)
			if Result then
				l_a_cluster_stone ?= a_stone
				if l_a_cluster_stone /= Void then
					l_b_cluster_stone ?= b_stone
					l_a_path := l_a_cluster_stone.path
					l_b_path := l_b_cluster_stone.path
					Result := equal (l_a_path, l_b_path)
				end
			end
		end

feature -- Status setting

	set_stone (new_stone: STONE) is
			-- Send a stone to formatters.
		local
			fs: FEATURE_STONE
			cs: CLASSC_STONE
		do
			fs ?= new_stone
			if fs /= Void then
				check
					feature_not_void: fs.e_feature /= Void
					class_not_void: fs.e_feature.associated_class /= Void
				end
				create cs.make (fs.e_feature.associated_class)
			end
			if cs /= Void then
					-- Take the class of the feature.
					-- We do not extend a feature stone into a class tool.
				set_last_stone (cs)
			else
				set_last_stone (new_stone)
			end
			if widget.is_displayed or else is_auto_hide then
				force_last_stone
			end
		end

	decide_tool_to_display (a_st: STONE) is
			-- Decide which tool to display.
		local
			fs: FEATURE_STONE
		do
			fs ?= a_st
			if fs /= Void then
				develop_window.tools.show_default_tool_of_feature
			else
				show
				set_focus
			end
		end

	on_select is
			-- Display information from the selected formatter.
		do
			visible := True
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				managed_formatters.item.on_shown
				managed_formatters.forth
			end
		end

	on_deselect is
			-- This view is hidden.
		do
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				managed_formatters.item.on_hidden
				managed_formatters.forth
			end
			visible := False
		end

	refresh is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				managed_formatters.item.invalidate
					-- Only the selected formatter will refresh itself in fact.
				managed_formatters.item.format
				managed_formatters.forth
			end
		end

	invalidate is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				managed_formatters.item.invalidate
				managed_formatters.forth
			end
			internal_stone := Void
		end

	quick_refresh_editor is
			-- Refresh the editor.
		do
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
		end

	set_widget (new_widget: EV_WIDGET) is
			-- Display `new_widget' under the tool bar.
		local
			l_formatters: like managed_formatters
			l_formatter: EB_DEPENDENCY_FORMATTER
			l_cursor: CURSOR
			l_control_bar: EV_WIDGET
			done: BOOLEAN
		do
			if not formatter_container.has (new_widget) then
				l_formatters := managed_formatters
				l_cursor := l_formatters.cursor
				from
					formatter_tool_bar_area.wipe_out
					l_formatters.start
				until
					l_formatters.after or done
				loop
					if l_formatters.item.selected then
						l_formatter := l_formatters.item
						l_control_bar := l_formatter.browser.control_bar
						if l_control_bar /= Void then
							formatter_tool_bar_area.extend (l_formatter.browser.control_bar)
							formatter_tool_bar_area.disable_item_expand (l_formatter.browser.control_bar)
						end
						done := True
					end
					l_formatters.forth
				end
				l_formatters.go_to (l_cursor)
				formatter_container.replace (new_widget)
			end
		end

	force_display is
			-- Jump to this tab and display `explorer_parent'.
		do
			content.show
		end

	pop_default_formatter is
			-- Pop the default class formatter.
		local
			real_index: INTEGER
		do
			real_index := 2
			(managed_formatters @ real_index).execute
		end

	set_focus is
			-- Give the focus to `Current'.
		require
			focusable: widget.is_displayed and widget.is_sensitive
		do
			if shared_browser.widget.is_displayed then
				shared_browser.widget.set_focus
			end
		end

	on_context_change is
			-- Action to be performed when `viewpoints' changes
		do
			token_writer.set_context_group (viewpoints.current_viewpoint)
			refresh
		end

	show is
			-- Redefine
		do
			Precursor {EB_TOOL}
			if not visible then
				on_select
			end
		end

	close is
			-- Redefine
		do
			Precursor {EB_TOOL}
			on_deselect
		end

feature -- Memory management

	internal_recycle is
			-- Remove all references to `Current' and its descendants.
		do
			develop_window := Void
			Precursor {EB_HISTORY_OWNER}
		end

feature {NONE} -- Implementation

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

	internal_stone: STONE
			-- Currently managed stone.

	fill_in is
			-- Display all controls of the window.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			create widget
			create outer_container
			create editor_frame
			create formatter_container
			create output_line
			output_line.align_text_left
			create tool_bar_area
			create formatter_tool_bar_area
			build_tool_bar
			create sep
			widget.extend (sep)
			widget.disable_item_expand (sep)
			widget.extend (output_line)
			widget.disable_item_expand (output_line)
			editor_frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			outer_container.extend (formatter_container)
			widget.extend (outer_container)
			output_line.set_text (Interface_names.l_Not_in_system_no_info)
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			formatter: EB_DEPENDENCY_FORMATTER
		do
			create tool_bar
			widget.extend (tool_bar_area)
			widget.disable_item_expand (tool_bar_area)
			tool_bar_area.extend (tool_bar)
			tool_bar_area.disable_item_expand (tool_bar)
			tool_bar_area.extend (formatter_tool_bar_area)
			tool_bar_area.disable_item_expand (formatter_tool_bar_area)
			tool_bar_area.extend (viewpoint_area)
			tool_bar_area.disable_item_expand (viewpoint_area)
			viewpoint_area.hide
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				formatter := managed_formatters.item
				if formatter /= Void then
					add_formatter (formatter)
					managed_formatters.forth
				else
					tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
					managed_formatters.remove
				end
			end
		end

	add_formatter (formatter: EB_DEPENDENCY_FORMATTER) is
			-- Add `formatter' to managed formatters, create a related menu item and a tool bar button.
		do
			formatter.set_widget_owner (Current)
			tool_bar.extend (formatter.new_button)
			formatter.set_output_line (output_line)
		end

	enable_dotnet_formatters (a_flag: BOOLEAN) is
			-- Set sensitivity of formatters to 'a_flag'.
		do
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				if
					(managed_formatters.item.is_dotnet_formatter and a_flag) or
					(not a_flag)
				then
					managed_formatters.item.enable_sensitive
				else
					managed_formatters.item.disable_sensitive
				end
				managed_formatters.forth
			end

			if not used then
					-- First time so default to suppliers view.
				managed_formatters.i_th (2).enable_select
				used := True
			end
		end

	managed_formatters: ARRAYED_LIST [EB_DEPENDENCY_FORMATTER]
			-- Formatters available in `Current' view.

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.

	drop_stone (st: STONE) is
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		local
			fst: FEATURE_STONE
		do
			decide_tool_to_display (st)
			if develop_window.unified_stone then
				develop_window.set_stone (st)
			else
				develop_window.tools.set_stone (st)
			end
			fst ?= st
			if fst /= Void and then address_manager /= Void then
				address_manager.hide_address_bar
			end
		end

	outer_container: EV_CELL
			-- Container to hold `formatter_container' and `editor_frame' (if current formatter is an editor formatter)

	editor_frame: EV_FRAME
			-- Frame as borer of an editor if current formatter is and editor formatter

	saved_formatters: like managed_formatters
			-- Formmatters needed by tool by not in Current stome context.

	shared_browser: EB_CLASS_BROWSER_DEPENDENCY_VIEW
			-- Browser used to display dependency information

	history_toolbar: EV_TOOL_BAR
			-- Toolbar containing the history commands.

	mini_toolbar: EV_HORIZONTAL_BOX
			-- Mini tool bar.

	force_last_stone is
			-- Force `last_stone' to be displayed in formatters of Current tool.
		local
			new_stone: like last_stone
			cst: CLASSC_STONE
			ist: CLASSI_STONE
			fst: FEATURE_STONE
			type_changed: BOOLEAN
			cluster_stone: CLUSTER_STONE
			target_stone: TARGET_STONE
			l_stone: STONE
		do
			if not is_last_stone_processed then
				new_stone := last_stone
				if new_stone /= Void then
					fst ?= new_stone
					cst ?= new_stone
					ist ?= new_stone
					cluster_stone ?= new_stone
					target_stone ?= new_stone
						-- If `new_stone' is a feature stone, take the associated class.
					if fst /= Void and then fst.e_feature /= Void then
						create cst.make (fst.e_feature.associated_class)
						l_stone := cst
					elseif cst /= Void or else ist /= Void then
						if cst /= Void then
							type_changed := (cst.e_class.is_true_external and not is_stone_external) or
								(not cst.e_class.is_true_external and is_stone_external)
						elseif ist /= Void then
							type_changed := (ist.class_i.is_external_class and not is_stone_external) or
								(not ist.class_i.is_external_class and is_stone_external)
						end

						if type_changed then
							-- Toggle stone flag.
			            	is_stone_external := not is_stone_external
			            end

			            	-- Update formatters.
			            if is_stone_external and cst /= Void then
							enable_dotnet_formatters (True)
						else
							enable_dotnet_formatters (False)
						end
						if cst /= Void then
							update_viewpoints (cst.e_class)
						end
						l_stone := cst
					elseif target_stone /= Void or else cluster_stone /= Void then
						l_stone := new_stone
					end

					if l_stone = Void or else internal_stone = Void or else not is_stone_equal (l_stone, internal_stone) then
							-- Set the stones.
						from
							managed_formatters.start
						until
							managed_formatters.after
						loop
							managed_formatters.item.set_stone (l_stone)
							managed_formatters.forth
						end
					end
					internal_stone := l_stone
					history_manager.extend (stone)
				end
				Precursor
			end
		end

	on_item_dropped (a_pebble: ANY) is
			-- Action to be performed when `a_pebble' is dropped
		local
			l_stone: STONE
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				drop_stone (l_stone)
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


end
