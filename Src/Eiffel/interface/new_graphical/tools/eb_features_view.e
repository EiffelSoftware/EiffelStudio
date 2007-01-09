indexing
	description	: "Tools with information about a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FEATURES_RELATION_TOOL

inherit
	EB_TOOL
		redefine
			attach_to_docking_manager,
			pixmap,
			mini_toolbar,
			build_mini_toolbar,
			build_docking_content,
			show
		end

	EB_CONSTANTS

	WIDGET_OWNER

	SHARED_WORKBENCH

	EB_SHARED_PREFERENCES

	E_FEATURE_COMPARER

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
			formatters_initialized: a_tool.managed_feature_formatters /= Void
		local
			formatters: like managed_formatters
			conv_ft: EB_FEATURE_TEXT_FORMATTER
			l_base_ft: EB_BASIC_FEATURE_FORMATTER
			l_flat_formatter: EB_ROUTINE_FLAT_FORMATTER
			l_formatter: EB_FEATURE_INFO_FORMATTER
			l_browser: EB_FEATURE_BROWSER_GRID_VIEW
			l_feature_content_formatter: EB_FEATURE_CONTENT_FORMATTER
			l_drop_actions: EV_PND_ACTION_SEQUENCE
		do
			formatters := a_tool.managed_feature_formatters
			create managed_formatters.make (10)
			create editor.make (a_tool)
			editor.widget.set_border_width (1)
			editor.widget.set_background_color ((create {EV_STOCK_COLORS}).gray)
			create l_drop_actions
			l_drop_actions.extend (agent drop_stone)
			editor.disable_line_numbers
			editor.drop_actions.extend (agent drop_stone)
			create l_browser.make (a_tool, l_drop_actions)
			l_browser.set_sorting_status (l_browser.sorted_columns_from_string (preferences.class_browser_data.feature_view_sorting_order))
			from
				formatters.start
			until
				formatters.after
			loop
				l_formatter := formatters.item
				conv_ft ?= l_formatter
				if conv_ft /= Void then
					conv_ft.set_editor (editor)
					conv_ft.set_viewpoints (viewpoints)
					l_flat_formatter ?= l_formatter
					if l_flat_formatter /= Void then
						flat_formatter := l_flat_formatter
					end
				end
				if l_formatter /= Void then
					l_base_ft ?= l_formatter
					if l_base_ft /= Void then
						l_formatter.popup_actions.extend (agent hide_viewpoint_area)
					else
						l_formatter.popup_actions.extend (agent show_viewpoint_area)
					end
				end
				l_feature_content_formatter ?= formatters.item
				if l_feature_content_formatter /= Void then
					l_feature_content_formatter.set_browser (l_browser)
				end
				managed_formatters.extend (l_formatter)
				formatters.forth
			end
			fill_in

			-- Now (for new docking Eiffel Studio) there is now on_select actions..
			-- We directly set the widget
			set_widget (editor.widget)
			-- Added following for set `internal_shown' flag.
			on_select
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build dockable content.
		do
			Precursor {EB_TOOL}(a_docking_manager)
			content.drop_actions.extend (agent drop_stone)
		end

feature -- EB_TOOL issues

	title: STRING_GENERAL is
			-- Title
		local
			l_constatns: EB_CONSTANTS
		do
			create l_constatns
			Result := l_constatns.interface_names.l_tab_feature_info
		end

	title_for_pre: STRING is
			-- Title
		local
			l_constatns: EB_CONSTANTS
		do
			create l_constatns
			Result := l_constatns.interface_names.to_Feature_relation_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.pixmaps.icon_pixmaps.tool_feature_icon
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

			-- FIXIT: Address manager issues is common among 	EB_CLASS_TOOL, EB_FEATURE_RELATION_TOOL, EB_DIAGRAM_TOOL.
			-- So, common ancestor or a common helper class?			
			create address_manager.make (Current, True)
		end

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check friend_tool_created: develop_window.tools.class_tool /= Void end
			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
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

	flat_formatter: EB_ROUTINE_FLAT_FORMATTER
			-- Special handle to flat formatters of routine. Required to properly update
			-- breakpoint positions during debugging.

	stone: STONE is
			-- Currently managed stone.
		do
			Result := internal_stone
		end

	address_manager: EB_ADDRESS_MANAGER
			-- Manager for the header info.

	last_widget: EV_WIDGET is
			-- Last set widget
		do
			if formatter_container.readable then
				Result := formatter_container.item
			end
		end

feature -- Status setting

	set_stone (new_stone: STONE) is
			-- Send a stone to feature formatters.
		local
			fst: FEATURE_STONE
			type_changed: BOOLEAN
		do
			fst ?= new_stone
			if fst /= Void then
				type_changed := (fst.e_class.is_true_external and not is_stone_external) or
					(not fst.e_class.is_true_external and is_stone_external)

			end

				-- Toggle stone flag.
			if type_changed then
				is_stone_external := not is_stone_external
			end

				-- Update formatters.
            if is_stone_external then
				enable_dotnet_formatters (True)
			else
				enable_dotnet_formatters (False)
			end
			if fst /= Void then
				update_viewpoints (fst.e_class)
			end
			if fst = Void then
				managed_formatters.first.enable_sensitive
				from
					managed_formatters.start
				until
					managed_formatters.after
				loop
					managed_formatters.item.set_stone (fst)
					managed_formatters.forth
				end
				internal_stone := Void
				history_manager.extend (new_stone)
			elseif
				internal_stone = Void or else
				(internal_stone /= Void and then not same_feature (internal_stone.e_feature, fst.e_feature))
			then
				from
					managed_formatters.start
				until
					managed_formatters.after
				loop
					managed_formatters.item.set_stone (fst)
					managed_formatters.forth
				end
				internal_stone := fst
				history_manager.extend (new_stone)
			end
			flat_formatter.show_debugged_line
		end

	drop_stone (st: CLASSI_STONE) is
			-- Test if there is a feature with the same name (or routine id?)
			-- in the dropped class.
		local
			fst, ofst: FEATURE_STONE
			new_f: E_FEATURE
			cst: CLASSC_STONE
			cl: CLASS_C
			found: BOOLEAN
		do
			fst ?= st
			if fst = Void then
				cst ?= st
				if cst /= Void then
					cl := cst.e_class
					ofst ?= stone
					if ofst /= Void and cl /= Void then
						new_f := ofst.e_feature.ancestor_version (cl)
						if new_f /= Void then
							launch_stone (create {FEATURE_STONE}.make (new_f))
							found := True
						end
					end
					if not found then
						develop_window.tools.class_tool.show
						develop_window.tools.class_tool.pop_default_formatter
					end
				end
				if not found and ofst /= Void then
						-- The dropped class does not have any feature named like the current feature.
					output_line.set_text (Warning_messages.w_No_such_feature_in_this_class (
						ofst.feature_name, st.class_i.name))
				end
				if not found then
					develop_window.tools.class_tool.set_stone (st)
					develop_window.tools.class_tool.content.show
					develop_window.tools.class_tool.content.set_focus
					develop_window.tools.class_tool.set_focus
				end
			else
				launch_stone (fst)
			end
		end

	launch_stone (st: STONE) is
			-- Notify the development window of a new stone.
		require
			valid_stone: st /= Void
		do
			if develop_window.unified_stone then
				develop_window.set_stone (st)
			else
				set_stone (st)
			end
			if content.is_visible then
				set_focus
				content.set_focus
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
			editor.refresh
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
			editor.margin.refresh
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
			l_class_feature_formatter: EB_FEATURE_CONTENT_FORMATTER
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

	pop_feature_flat is
			-- Force the display of `Current' and select the flat form.
		do
			(managed_formatters @ flat_format_index).execute
		end

	pop_default_formatter is
			-- Force the display of `Current' and select the default formatter.
		local
			real_index: INTEGER
		do
			real_index := preferences.context_tool_data.default_feature_formatter_index
			if
				real_index < 1 or
				real_index > managed_formatters.count
			then
					-- The "default default formatter" is the flat format (which is rather fast).
				real_index := flat_format_index
			end
			(managed_formatters @ real_index).execute
		end

	set_focus is
			-- Give the focus to the editor.
		require
			focusable: content.is_visible and widget.is_sensitive
		do
			editor.set_focus
		end

feature -- Actions

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
			editor.recycle
			editor := Void
			content := Void
			develop_window := Void
		end

feature {NONE} -- Implementation

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
					-- First time so default to flat view.
				managed_formatters.i_th (2).enable_select
				used := True
			end

					-- Determine which formatter to give focus based upon previous one.
			if a_flag then
				if managed_formatters.i_th (1).selected then
						-- Previously text so now move to flat.
					managed_formatters.i_th (2).enable_select
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

	used: BOOLEAN
			-- Has the feature view been used yet to perform any formatting?

	is_stone_external: BOOLEAN
			-- Does Current stone represent a .NET class feature?

	flat_format_index: INTEGER is 2
			-- Index of the flat format in the managed formatters.

	tool_bar: EV_TOOL_BAR
			-- Toolbar containing all buttons.

	output_line: EV_LABEL
			-- Line to display status of current formatter.

	internal_stone: FEATURE_STONE
			-- Currently managed stone.

	fill_in is
			-- Display all controls of the window.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			create widget
			create formatter_container
			create output_line
			create tool_bar_area
			create formatter_tool_bar_area
			create outer_container
--			create editor_frame
			output_line.align_text_left
			build_tool_bar
			widget.extend (tool_bar_area)
			widget.disable_item_expand (tool_bar_area)
			create sep
			widget.extend (sep)
			widget.disable_item_expand (sep)
			widget.extend (output_line)
			widget.disable_item_expand (output_line)

--			editor_frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
--			outer_container.extend (formatter_container)
			widget.extend (outer_container)
			output_line.set_text (Interface_names.l_No_feature)
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			formatter: EB_FEATURE_INFO_FORMATTER
		do
			create tool_bar
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

	add_formatter (formatter: EB_FEATURE_INFO_FORMATTER) is
			-- Add `formatter' to managed formatters, create a related menu item and a tool bar button.
		do
			formatter.set_widget_owner (Current)
			tool_bar.extend (formatter.new_button)
			formatter.set_output_line (output_line)
		end

	managed_formatters: ARRAYED_LIST [EB_FEATURE_INFO_FORMATTER]
			-- Formatters available in `Current' view.

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.

	editor: EB_CLICKABLE_EDITOR
			-- Editor shared by all feature formatters.

	mini_toolbar: EV_HORIZONTAL_BOX
			-- Mini tool bar.

	history_toolbar: EV_TOOL_BAR;
			-- Toolbar containing the history commands.

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

	formatter_tool_bar_area: EV_HORIZONTAL_BOX
			-- Area to contain tool bar from formatter

	tool_bar_area: EV_HORIZONTAL_BOX
			-- Area to contain tool bar

	outer_container: EV_CELL
			-- Container to hold `formatter_container' and `editor_frame' (if current formatter is an editor formatter)

--	editor_frame: EV_FRAME
--			-- Frame as borer of an editor if current formatter is and editor formatter

invariant
	flat_formatter_not_void: flat_formatter /= Void

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

end -- class EB_FEATURES_VIEW


