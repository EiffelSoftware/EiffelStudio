indexing
	description:
		"View with information about a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_TOOL

inherit
	EB_TOOL
		redefine
			attach_to_docking_manager,
			pixmap,
			mini_toolbar,
			build_mini_toolbar,
			build_docking_content,
			show,
			force_last_stone
		end

	EB_CONSTANTS

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
			conv_ct: EB_CLASS_TEXT_FORMATTER
			l_flat_browser: EB_CLASS_BROWSER_FLAT_VIEW
			l_inheritance_browser: EB_CLASS_BROWSER_TREE_VIEW
			l_reference_browser: EB_CLASS_BROWSER_TREE_VIEW
			l_class_formatter: EB_CLASS_CONTENT_FORMATTER
			l_drop_actions: EV_PND_ACTION_SEQUENCE
		do
			develop_window := a_tool
			formatters := a_tool.managed_class_formatters
			create managed_formatters.make (10)
			create shared_editor.make (a_tool)
			shared_editor.widget.set_border_width (1)
			shared_editor.widget.set_background_color ((create {EV_STOCK_COLORS}).gray)
			create l_drop_actions
			l_drop_actions.extend (agent drop_stone)
			create l_flat_browser.make (a_tool, l_drop_actions)
			l_flat_browser.set_sorting_status (l_flat_browser.sorted_columns_from_string (preferences.class_browser_data.class_flat_view_sorting_order))
			create l_inheritance_browser.make_with_flag (a_tool, l_drop_actions, True)
			l_inheritance_browser.set_sorting_status (l_inheritance_browser.sorted_columns_from_string (preferences.class_browser_data.class_tree_view_sorting_order))
			create l_reference_browser.make_with_flag (a_tool, l_drop_actions, False)
			l_reference_browser.set_sorting_status (l_reference_browser.sorted_columns_from_string (preferences.class_browser_data.class_tree_view_sorting_order))
			l_reference_browser.retrieve_data_actions.extend (agent refresh)
			shared_editor.disable_line_numbers
			shared_editor.drop_actions.extend (agent drop_stone)
			from
				formatters.start
			until
				formatters.after
			loop
				conv_ct ?= formatters.item
				if conv_ct /= Void then
					conv_ct.set_editor (shared_editor)
					conv_ct.set_viewpoints (viewpoints)
				end
				l_class_formatter ?= formatters.item
				if l_class_formatter /= Void then
					if l_class_formatter.is_class_feature_formatter then
						l_class_formatter.set_browser (l_flat_browser)
					else
						if l_class_formatter.is_reference_formatter then
							l_class_formatter.set_browser (l_reference_browser)
						elseif l_class_formatter.is_inheritance_formatter then
							l_class_formatter.set_browser (l_inheritance_browser)
						end
					end
				end
				managed_formatters.extend (formatters.item)
				formatters.forth
			end
			fill_in
			set_widget (shared_editor.widget)

			on_select
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build dockable content.
		do
			Precursor {EB_TOOL}(a_docking_manager)
			content.drop_actions.extend (agent drop_stone)
		end

	saved_formatters: like managed_formatters
			-- Formmatters needed by tool by not in Current stome context.

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Docking issues

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)
			check friend_tool_created: develop_window.tools.diagram_tool /= Void end
			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- EB_TOOL issues

	title: STRING_GENERAL is
			-- Title
		local
			l_constatns: EB_CONSTANTS
		do
			create l_constatns
			Result := l_constatns.interface_names.l_tab_class_info
		end

	title_for_pre: STRING is
			-- Redefine
		local
			l_constatns: EB_CONSTANTS
		do
			create l_constatns
			Result := l_constatns.interface_names.to_class_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.pixmaps.icon_pixmaps.tool_class_icon
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
		end

	build_interface is
			-- Build interface
		do
			make_with_tool (develop_window)

			create history_manager.make (Current)
			create address_manager.make (Current, True)
		end

	show is
			-- Show tool.
		do
			Precursor {EB_TOOL}
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				if managed_formatters.item.selected then
					managed_formatters.item.set_focus
				end
				managed_formatters.forth
			end
		end

feature -- Access

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current'.

	formatter_container: EV_CELL
			-- Cell containing the selected formatter's widget.

	parent_notebook: EV_NOTEBOOK
			-- Needed to pop up when corresponding menus are selected.
			--| Not in implementation because it is used in a precondition.

	address_manager: EB_ADDRESS_MANAGER
			-- Manager for the header info.

	is_stone_external: BOOLEAN
			-- Does current stone repreasent a .NET class?

	last_widget: EV_WIDGET is
			-- Last set widget
		do
			if formatter_container.readable then
				Result := formatter_container.item
			end
		end

feature -- Status setting

	set_stone (new_stone: STONE) is
			-- Send a stone to class formatters.
		do
			set_last_stone (new_stone)
			if widget.is_displayed then
				force_last_stone
			end
		end

	force_last_stone is
			-- Force that `last_stone' is displayed in formatters in Current view
		local
			cst: CLASSC_STONE
			ist: CLASSI_STONE
			fst: FEATURE_STONE
			type_changed: BOOLEAN
			new_stone: like last_stone
		do
			if not is_last_stone_processed then
				new_stone := last_stone
				fst ?= new_stone
					-- If `new_stone' is a feature stone, take the associated class.
				if fst /= Void and then fst.e_feature /= Void then
					create cst.make (fst.e_feature.associated_class)
				else
					cst ?= new_stone
					ist ?= new_stone
				end

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
				if cst = Void or else stone = Void or else not stone.same_as (cst) then
						-- Set the stones.
					from
						managed_formatters.start
					until
						managed_formatters.after
					loop
						managed_formatters.item.set_stone (cst)
						managed_formatters.forth
					end
				end
				stone := cst
				history_manager.extend (stone)
				Precursor
			end
		end

	launch_stone (st: CLASSI_STONE) is
			-- Notify the development window of a new stone.
		do
			if develop_window.unified_stone then
				develop_window.set_stone (st)
			else
				set_stone (st)
			end
			set_focus
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
			stone := Void
		end

	quick_refresh_editor is
			-- Refresh the editor.
		do
			shared_editor.refresh
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
			shared_editor.margin.refresh
		end

	set_parent_notebook (a_notebook: EV_NOTEBOOK) is
			-- Set `parent_notebok' to `a_notebook'.
		require
			a_notebook_non_void: a_notebook /= Void
			a_notebook_really_parent: a_notebook.has (widget)
		do
			parent_notebook := a_notebook
		end

	set_widget (new_widget: EV_WIDGET) is
			-- Display `new_widget' under the tool bar.
		local
			l_formatters: like managed_formatters
			l_class_feature_formatter: EB_CLASS_CONTENT_FORMATTER
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
						l_class_feature_formatter ?= l_formatters.item
						if l_class_feature_formatter /= Void then
							l_control_bar := l_class_feature_formatter.browser.control_bar
							if l_control_bar /= Void then
								formatter_tool_bar_area.extend (l_class_feature_formatter.browser.control_bar)
								formatter_tool_bar_area.disable_item_expand (l_class_feature_formatter.browser.control_bar)
							end
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

	pop_default_formatter is
			-- Pop the default class formatter.
		local
			real_index: INTEGER
		do
			real_index := preferences.context_tool_data.default_class_formatter_index
			if
				real_index < 1 or
				real_index > managed_formatters.count
			then
					-- The "default default formatter" is the ancestors (which is rather fast).
				real_index := 5
			end
			(managed_formatters @ real_index).execute
		end

	set_focus is
			-- Give the focus to `Current'.
		require
			focusable: content.is_visible and widget.is_sensitive
		do
			if shared_editor.editor_drawing_area.is_displayed then
				shared_editor.editor_drawing_area.set_focus
			end
		end

	on_context_change is
			-- Action to be performed when `viewpoints' changes
		do
			token_writer.set_context_group (viewpoints.current_viewpoint)
			refresh
		end

feature -- Memory management

	internal_recycle is
			-- Remove all references to `Current' and its descendants.
		do
			shared_editor.recycle
			shared_editor := Void
			develop_window := Void
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

	fill_in is
			-- Display all controls of the window.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			create widget
			create outer_container
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
			outer_container.extend (formatter_container)
			widget.extend (outer_container)
			output_line.set_text (Interface_names.l_Not_in_system_no_info)
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			formatter: EB_CLASS_INFO_FORMATTER
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

	add_formatter (formatter: EB_CLASS_INFO_FORMATTER) is
			-- Add `formatter' to managed formatters, create a related menu item and a tool bar button.
		do
			formatter.set_widget_owner (Current)
			tool_bar.extend (formatter.new_button)
			formatter.set_output_line (output_line)
		end

	enable_dotnet_formatters (a_flag: BOOLEAN) is
			-- Set sensitivity of formatters to 'a_flag'.
		local
			l_done: BOOLEAN
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
					-- First time so default to ancestors view.
				managed_formatters.i_th (5).enable_select
				used := True
			end

				-- Determine which formatter to give focus based upon previous one.
			if a_flag then
				if managed_formatters.i_th (1).selected then
						-- Previously clickable so now move to contract.
					managed_formatters.i_th (3).enable_select
				elseif managed_formatters.i_th (2).selected then
						-- Previously flat so now interface.
					managed_formatters.i_th (4).enable_select
				else
						-- Set formatter to same as previous one.
					from
						managed_formatters.start
					until
						managed_formatters.after or l_done
					loop
						if managed_formatters.item.selected then
							managed_formatters.i_th (managed_formatters.index_of (managed_formatters.item, 1)).enable_select
							l_done := True
						end
						managed_formatters.forth
					end
				end
			end
		end

	shared_editor: EB_CLICKABLE_EDITOR
			-- The editor used by all formatters.

	managed_formatters: ARRAYED_LIST [EB_CLASS_INFO_FORMATTER]
			-- Formatters available in `Current' view.

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.

	drop_stone (st: CLASSI_STONE) is
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		local
			fst: FEATURE_STONE
		do
			fst ?= st
			if fst /= Void then
				develop_window.tools.features_relation_tool.set_stone (st)
				develop_window.tools.features_relation_tool.content.show
				develop_window.tools.features_relation_tool.content.set_focus
				develop_window.tools.features_relation_tool.set_focus
			else
				launch_stone (st)
				content.set_focus
			end
		end

	stone: CLASSC_STONE
			-- Currently managed stone.

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

	outer_container: EV_CELL;
			-- Container to hold `formatter_container' and `editor_frame' (if current formatter is an editor formatter)

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

end -- class EB_CLASS_VIEW

