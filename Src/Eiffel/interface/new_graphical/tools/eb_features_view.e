indexing
	description	: "View with information about a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FEATURES_VIEW

inherit
	EB_CONSTANTS

	WIDGET_OWNER

	SHARED_WORKBENCH

	EB_SHARED_PREFERENCES

	E_FEATURE_COMPARER

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_tool: EB_DEVELOPMENT_WINDOW; a_context: EB_CONTEXT_TOOL) is
			-- Set default values.
		require
			formatters_initialized: a_tool.managed_feature_formatters /= Void
		local
			formatters: like managed_formatters
			conv_ft: EB_FEATURE_TEXT_FORMATTER
			l_flat_formatter: EB_ROUTINE_FLAT_FORMATTER
			l_formatter: EB_FEATURE_INFO_FORMATTER
			l_browser: EB_FEATURE_BROWSER_GRID_VIEW
			l_feature_content_formatter: EB_FEATURE_CONTENT_FORMATTER
			l_drop_actions: EV_PND_ACTION_SEQUENCE
		do
			context := a_context
			formatters := a_tool.managed_feature_formatters
			create managed_formatters.make (10)
			create shared_editor.make (a_tool)
			create l_drop_actions
			l_drop_actions.extend (agent drop_stone)
			shared_editor.disable_line_numbers
			shared_editor.drop_actions.extend (agent drop_stone)
			create l_browser.make (a_tool, l_drop_actions)
			from
				formatters.start
			until
				formatters.after
			loop
				l_formatter := formatters.item
				conv_ft ?= l_formatter
				if conv_ft /= Void then
					conv_ft.set_editor (shared_editor)
					l_flat_formatter ?= l_formatter
					if l_flat_formatter /= Void then
						flat_formatter := l_flat_formatter
					end
				end
				l_feature_content_formatter ?= formatters.item
				if l_feature_content_formatter /= Void then
					l_feature_content_formatter.set_browser (l_browser)
					l_feature_content_formatter.set_editor (shared_editor)
				end
				managed_formatters.extend (l_formatter)
				formatters.forth
			end
			fill_in
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
			if internal_stone = Void then
				Result := context.stone
			else
				Result := internal_stone
			end
		end

	last_widget: EV_WIDGET is
			-- Last set widget
		do
			if formatter_container.readable then
				Result := formatter_container.item
			end
		end
		
feature -- Status setting

	set_parent (explorer: EB_EXPLORER_BAR_ITEM) is
			-- Set `explorer_parent' to `explorer'.
		do
			explorer_parent := explorer
		end

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
			end
			flat_formatter.show_debugged_line
		end

	drop_stone (st: CLASSI_STONE) is
			-- Test if there is a feature with the same name (or routine id?)
			-- in the dropped class.
		require
			st_not_void: st /= Void
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
						context.class_view.pop_default_formatter
					end
				end
				if not found and ofst /= Void then
						-- The dropped class does not have any feature named like the current feature.
					output_line.set_text (Warning_messages.w_No_such_feature_in_this_class (
						ofst.feature_name, st.class_i.name_in_upper))
				end
				if not found then
					launch_stone (st)
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
			context.launch_stone (st)
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
			l_class_feature_formatter: EB_FEATURE_CONTENT_FORMATTER
			l_cursor: CURSOR
			l_control_bar: EV_WIDGET
		do
			if not formatter_container.has (new_widget) then
				formatter_container.replace (new_widget)
				l_formatters := managed_formatters
				l_cursor := l_formatters.cursor
				from
					formatter_tool_bar_area.wipe_out
					l_formatters.start
				until
					l_formatters.after
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
					end
					l_formatters.forth
				end
				l_formatters.go_to (l_cursor)
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
			if
				explorer_parent /= Void and then
				not is_parent_visible
			then
				explorer_parent.associated_command.execute
			end
			if
					-- Another tool is maximized.
				 not explorer_parent.is_maximized and
				 explorer_parent.parent.is_maximized
			then
				explorer_parent.parent.unmaximize
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
			focusable: widget.is_displayed and widget.is_sensitive
		do
			shared_editor.set_focus
		end

feature -- Memory management

	recycle is
			-- Remove all references to `Current' and its descendants.
		do
			shared_editor.recycle
			shared_editor := Void
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
			f: EV_FRAME
		do
			create widget
			create formatter_container
			create output_line
			create tool_bar_area
			create formatter_tool_bar_area
			output_line.align_text_left
			build_tool_bar
			widget.extend (tool_bar_area)
			widget.disable_item_expand (tool_bar_area)
			create sep
			widget.extend (sep)
			widget.disable_item_expand (sep)
			widget.extend (output_line)
			widget.disable_item_expand (output_line)
			create f
			f.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			f.extend (formatter_container)
			widget.extend (f)
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

	context: EB_CONTEXT_TOOL
			-- Container of `Current'. Stone manager.

	managed_formatters: ARRAYED_LIST [EB_FEATURE_INFO_FORMATTER]
			-- Formatters available in `Current' view.

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.

	shared_editor: EB_CLICKABLE_EDITOR
			-- Editor shared by all feature formatters.

	is_parent_visible: BOOLEAN is
			-- Is `explorer_parent' displayed?
		do
			if explorer_parent /= Void then
				Result := explorer_parent.is_visible
			end
		end

	explorer_parent: EB_EXPLORER_BAR_ITEM
			-- Explorer bar item that contains `Current'.

	formatter_tool_bar_area: EV_HORIZONTAL_BOX
			-- Area to contain tool bar from formatter

	tool_bar_area: EV_HORIZONTAL_BOX
			-- Area to contain tool bar

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


