note
	description	: "Tool where information (welcome message, Errors, ...) are displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	ES_OUTPUT_TOOL_PANEL

obsolete
	"Please migrate tools. ES_OUTPUTS_TOOL_PANEL replaces this tool but you might be looking for a new tool using the ES_EDITOR_WIDGET or ES_EDITOR_OUTPUT_PANE."

inherit
	EB_TOOL
		redefine
			internal_recycle,
			internal_detach_entities
		end

	EB_SHARED_MANAGERS

	EB_CONSTANTS

	SHARED_DEBUGGER_MANAGER

	SHARED_EIFFEL_PROJECT

	EB_TEXT_OUTPUT_FACTORY

create
	make

feature {NONE} -- Initialization

	make_with_tool
			-- Create a new output tool.
		local
			l_f: EV_FRAME
		do
			create l_f
			l_f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create text_area.make (develop_window)
			auto_recycle (text_area)
			text_area.disable_line_numbers
			l_f.extend (text_area.widget)
			widget := l_f

			check should_not_be_called: False end
			--graphical_output_manager.extend (Current)

				-- Output text is not editable
			text_area.set_read_only (True)
			create output_display_factory
		end

	build_interface
			-- Build interface
		do
			make_with_tool
			if text_area /= Void then
				stone_director.bind (text_area.editor_drawing_area, Current)
			end
		end

	pixmap_failure: EV_PIXMAP
			--
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.pixmaps.icon_pixmaps.tool_output_failed_icon
		end

	pixmap_success: EV_PIXMAP
			-- Pixmap shown when c compilation successed.
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.pixmaps.icon_pixmaps.tool_output_successful_icon
		end

feature -- Clean up

	internal_recycle
			-- <Precursor>
		do
				-- See `make_with_tool' for matching commentted code.
			--graphical_output_manager.prune (Current)
			Precursor
		end

	internal_detach_entities
			-- <Precursor>
		do
			text_area := Void
			Precursor
		ensure then
			text_area_detached: text_area = Void
		end

feature -- Status setting

	set_parent_notebook (a_notebook: EV_NOTEBOOK)
			-- Set `parent_notebok' to `a_notebook'.
		require
			a_notebook_non_void: a_notebook /= Void
			a_notebook_really_parent: a_notebook.has (widget)
		do
			parent_notebook := a_notebook
		end

	force_display
			-- Jump to this tab and display `explorer_parent'.
			-- Only if `Current' is in the focused window.
		do
			if develop_window = Window_manager.last_focused_window then
				if not is_shown or else is_auto_hide then
					show_with_setting
				end
				content.set_focus
			end
		end

	scroll_to_end
			-- Scroll the editor to the bottom.
		do
			text_area.scroll_to_end_when_ready
		end

	on_select
			-- Display information from the selected formatter.
		do
			visible := True
		end

	on_deselect
			-- This view is hidden.
		do
			visible := False
		end

	set_focus
			-- Give the focus to the editor.
		require
			focusable: widget.is_displayed and widget.is_sensitive
		do
			text_area.set_focus
		end

feature -- Status report

	is_general: BOOLEAN
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

	quick_refresh_editor
			-- Refresh the editor.
		do
			text_area.refresh
		end

	quick_refresh_margin
			-- Refresh the editor's margin.
		do
			text_area.margin.refresh
		end

	clear
			-- Clear window
		do
			text_area.clear_window
		end

	process_errors (errors: LINKED_LIST [ERROR])
			-- Display contextual error information from `errors'.
		do
			if not errors.is_empty then
				text_area.handle_before_processing (true)
				error_summary (errors.count, text_area.text_displayed)
				text_area.handle_after_processing
			end
		end

	process_warnings (a_warnings: LINKED_LIST [ERROR])
			-- Display contextual error information from `warnings'.
		do
			if not a_warnings.is_empty then
				text_area.handle_before_processing (true)
				warning_summary (a_warnings.count, text_area.text_displayed)
				text_area.handle_after_processing
			end
		end

	update_pixmap
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

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ES_OUTPUT_TOOL_PANEL
