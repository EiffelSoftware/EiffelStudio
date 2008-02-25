indexing
	description	: "Tool where information (welcome message, Errors, ...) are displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	ES_OUTPUT_TOOL_PANEL

inherit
	EB_TOOL
		redefine
			attach_to_docking_manager,
			internal_recycle
		end

	EB_SHARED_MANAGERS

	EB_RECYCLABLE

	EB_CONSTANTS

	SHARED_DEBUGGER_MANAGER

	SHARED_EIFFEL_PROJECT

	EB_TEXT_OUTPUT_FACTORY

create
	make

feature {NONE} -- Initialization

	make_with_tool is
			-- Create a new output tool.
		local
			l_f: EV_FRAME
		do
			create l_f
			l_f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create text_area.make (develop_window)
			text_area.drop_actions.extend (agent drop_class)
			text_area.drop_actions.extend (agent drop_feature)
			text_area.drop_actions.extend (agent drop_cluster)
			text_area.disable_line_numbers
			l_f.extend (text_area.widget)
			widget := l_f
			graphical_output_manager.extend (Current)

				-- Output text is not editable
			text_area.set_read_only (True)
			create output_display_factory
		end

	build_interface is
			-- Build interface
		do
			make_with_tool
		end

	pixmap_failure: EV_PIXMAP is
			--
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.pixmaps.icon_pixmaps.tool_output_failed_icon
		end

	pixmap_success: EV_PIXMAP is
			-- Pixmap shown when c compilation successed.
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.pixmaps.icon_pixmaps.tool_output_successful_icon
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER} -- Initialization

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Clean up

	internal_recycle is
			-- To be called before destroying this objects
		do
			graphical_output_manager.prune (Current)
			if text_area /= Void then
				text_area.recycle
				text_area := Void
			end
			Precursor {EB_TOOL}
		ensure then
			text_area_detached: text_area = Void
		end

feature -- Status setting

	set_parent_notebook (a_notebook: EV_NOTEBOOK) is
			-- Set `parent_notebok' to `a_notebook'.
		require
			a_notebook_non_void: a_notebook /= Void
			a_notebook_really_parent: a_notebook.has (widget)
		do
			parent_notebook := a_notebook
		end

	force_display is
			-- Jump to this tab and display `explorer_parent'.
			-- Only if `Current' is in the focused window.
		do
			if develop_window = Window_manager.last_focused_window then
				if not shown or else is_auto_hide then
					show_with_setting
				end
				content.set_focus
			end
		end

	scroll_to_end is
			-- Scroll the editor to the bottom.
		do
			text_area.scroll_to_end_when_ready
		end

	on_select is
			-- Display information from the selected formatter.
		do
			visible := True
		end

	on_deselect is
			-- This view is hidden.
		do
			visible := False
		end

	set_focus is
			-- Give the focus to the editor.
		require
			focusable: widget.is_displayed and widget.is_sensitive
		do
			text_area.set_focus
		end

feature -- Status report

	is_general: BOOLEAN is
			-- Is general output tool?
		do
			Result := true
		end

feature -- Access

	widget: EV_WIDGET
			-- Graphical representation for Current.

	parent_notebook: EV_NOTEBOOK
			-- Needed to pop up when corresponding menus are selected.
			--| Not in implementation because it is used in a precondition.

	text_area: EB_CLICKABLE_EDITOR
			-- Editor to handle the displayed text is displayed.

	output_display_factory: EB_TEXT_OUTPUT_FACTORY
			-- Output display factory.

feature -- Basic operation

	quick_refresh_editor is
			-- Refresh the editor.
		do
			text_area.refresh
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
			text_area.margin.refresh
		end

	clear is
			-- Clear window
		do
			text_area.clear_window
		end

	process_errors (errors: LINKED_LIST [ERROR]) is
			-- Display contextual error information from `errors'.
		do
			if not errors.is_empty then
				text_area.handle_before_processing (true)
				error_summary (errors.count, text_area.text_displayed)
				text_area.handle_after_processing
			end
		end

	process_warnings (a_warnings: LINKED_LIST [ERROR]) is
			-- Display contextual error information from `warnings'.
		do
			if not a_warnings.is_empty then
				text_area.handle_before_processing (true)
				warning_summary (a_warnings.count, text_area.text_displayed)
				text_area.handle_after_processing
			end
		end

	update_pixmap is
			-- Update pixmap after compilation
		do
			if eiffel_project.successful then
				content.set_pixmap (pixmap_success)
			else
				content.set_pixmap (pixmap_failure)
			end
		end

feature {NONE} -- Implementation

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.

	drop_breakable (st: BREAKABLE_STONE) is
			-- Inform `Current's manager that a stone concerning breakpoints has been dropped.
		do

		end

	drop_class (st: CLASSI_STONE) is
			-- Drop `st' in the context tool and pop the `class info' tab.
		require
			st_valid: st /= Void
		local
			l_class_tool: ES_CLASS_TOOL_PANEL
			l_feature_tool: ES_FEATURES_RELATION_TOOL_PANEL
			l_feature_stone: FEATURE_STONE
		do
			l_feature_stone ?= st
			if l_feature_stone /= Void then
				l_feature_tool := develop_window.tools.features_relation_tool
				l_feature_tool.set_stone (st)
				l_feature_tool.content.show
				l_feature_tool.content.set_focus
				l_feature_tool.set_focus
			else
				l_class_tool := develop_window.tools.class_tool
				l_class_tool.set_stone (st)
				l_class_tool.content.show
				l_class_tool.content.set_focus
				l_class_tool.set_focus
			end
		end

	drop_feature (st: FEATURE_STONE) is
			-- Drop `st' in the context tool and pop the `feature info' tab.
		require
			st_valid: st /= Void
		local
			l_feature_tool: ES_FEATURES_RELATION_TOOL_PANEL
		do
			l_feature_tool := develop_window.tools.features_relation_tool
			l_feature_tool.set_stone (st)
			l_feature_tool.content.show
			l_feature_tool.content.set_focus
			l_feature_tool.set_focus
		end

	drop_cluster (st: CLUSTER_STONE) is
			-- Drop `st' in the context tool.
		require
			st_valid: st /= Void
		do
			develop_window.tools.launch_stone (st)
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

end -- class ES_OUTPUT_TOOL_PANEL
