note
	description	: "[
		EiffelGraphicalCompiler$ tool. Ancestor of all tools in the workbench,
		providing dragging capabilities (transport). A tool is
		composed of a container and manager
		
		Note: DO NOT USE as a base class for new tools in EiffelStudio!
			  Please use {ES_DOCKABLE_TOOL_PANEL} instead.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "$Author$"

deferred class
	EB_TOOL

inherit
	REFACTORING_HELPER

	HASHABLE

	EB_RECYCLABLE
		redefine
			internal_detach_entities
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	SHARED_PLATFORM_CONSTANTS
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SHARED_WORKBENCH

	EB_SHARED_MANAGERS

	EB_METRIC_SHARED

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_window: like develop_window; a_tool: like tool_descriptor)
			-- Initializes a tool window
			--
			-- `a_window': The host shell window the tool will be shown in.
			-- `a_tool': The tool descriptor used to instatiate the tool.
		require
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
			not_a_tool_is_recycled: not a_tool.is_recycled
		do
			develop_window := a_window
			tool_descriptor := a_tool
			build_interface
			if not attached {ES_DOCKABLE_TOOL_PANEL [EV_WIDGET]} Current as l_dockable then
					-- Hack for transition period.
					-- This is done in {ES_DOCKABLE_TOOL_PANEL}.initialize
				build_mini_toolbar
				if mini_toolbar /= Void then
					if attached {SD_WIDGET_TOOL_BAR} mini_toolbar as l_widget_tb then
						l_widget_tb.compute_minimum_size
					end
					content.set_mini_toolbar (mini_toolbar)
					content.update_mini_tool_bar_size
				end
				content.set_user_widget (widget)
			end
		ensure
			develop_window_set: develop_window = a_window
			tool_descriptor_set: tool_descriptor = a_tool
		end

	build_interface
			-- Build all the tool's widgets.
		deferred
		ensure
			widget_created: widget /= Void
		end

	build_mini_toolbar
			-- Build `mini_toolbar'
		do
		end

feature -- Access

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := tool_descriptor.content_id.hash_code
		end

feature {NONE} -- Access: User interface

	content: attached SD_CONTENT
			-- Access to the tool's docking content
		require
			is_interface_usable: is_interface_usable
		do
			Result := tool_descriptor.content
		end

feature -- Access

	widget: EV_WIDGET
			-- Widget representing Current
		deferred
		end

	title: STRING_GENERAL
			-- Title of the tool which for show, it maybe not in English.
		do
			Result := tool_descriptor.edition_title
		ensure then
			valid_title: Result /= Void and then not Result.is_empty
		end

	mini_toolbar: EV_WIDGET
			-- Mini tool bar assiociate with Current.

	pixmap: EV_PIXMAP
			-- Pixmap as it appears in toolbars and menu, there is no pixmap by default.
		do
			Result := tool_descriptor.icon_pixmap
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer as it appears in toolbars and menu, there is no pixmap by default.
		do
			Result := tool_descriptor.icon
		end

	develop_window: EB_DEVELOPMENT_WINDOW
			-- Development window.

feature {NONE} -- Access

	tool_descriptor: attached ES_TOOL [EB_TOOL]
			-- Descriptor used to created tool.

feature -- Status report

	is_shown: BOOLEAN
			-- Indicates if foundation tool is current displayed.
		do
			if is_visible then
				Result := content.user_widget.is_displayed
			end
		ensure
			is_interface_usable: Result implies is_interface_usable
			is_visible: Result implies is_visible
			widget_is_displayed: Result implies content.user_widget.is_displayed
		end

	is_visible: BOOLEAN
			-- Indicates if foundation tool is current visible, which is not the same as being shown.
			-- Visible refers to tool UI being available to click on (as a tab or auto-hide tab.)
		do
			if is_interface_usable then
				Result := content.is_visible
			end
		ensure
			is_interface_usable: Result implies is_interface_usable
			content_is_visible: Result implies content.is_visible
		end

feature {NONE} -- Status report

	is_auto_hide: BOOLEAN
			-- Inidicates if the tool is currently in an auto-hidden state.
		require
			is_interface_usable: is_interface_usable
		do
			if is_visible then
				Result := content.state_value = {SD_ENUMERATION}.auto_hide
			end
		ensure
			is_interface_usable: Result implies is_interface_usable
			is_visible: Result implies is_visible
			content_is_auto_hide: Result implies content.state_value = {SD_ENUMERATION}.auto_hide
		end

feature -- Status setting

	close
			-- Close the tool (if possible)
		do
			content.hide
			ev_application.do_once_on_idle (agent set_focus_to_editor_when_idle)
			tool_descriptor.close
		end

	show
			-- Show the tool (if possible)
		do
			if not is_shown or else is_auto_hide then
				content.show
			end
			content.set_focus
		end

	show_with_setting
			-- Show current tool (if possible), and do some settings
		do
			show
		end

	has_focus: BOOLEAN
			-- Any widget of the tool has focus?
		do
			if widget /= Void then
				Result := has_focus_on_widgets_internal (widget)
			end
		end

feature {NONE} -- Helpers

	frozen stock_pixmaps: attached ES_PIXMAPS_16X16
			-- Shared access to stock 16x16 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).icon_pixmaps
		end

	frozen stock_mini_pixmaps: attached ES_PIXMAPS_10X10
			-- Shared access to stock 10x10 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).mini_pixmaps
		end

	frozen stone_director: attached ES_TOOL_STONE_REDIRECT_HELPER
			-- Shared access to a stone redirection helper
		require
			develop_window_is_interface_usable: internal_stone_director = Void implies develop_window.is_interface_usable
		local
			l_result: like internal_stone_director
		do
			l_result := internal_stone_director
			if l_result = Void then
				create Result.make (develop_window)
				internal_stone_director := Result
				auto_recycle (internal_stone_director)
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = stone_director
		end

feature {ES_TOOL} -- Event handlers

	on_edition_changed
			-- Called when a tool's edition number changes due to purging recycled tools.
		do
		end

feature {NONE} -- Implementation

	has_focus_on_widgets_internal (a_widget: EV_WIDGET): BOOLEAN
			-- Any widget has focus.
		local
			l_container: EV_CONTAINER
			l_linear_representation: LINEAR [EV_WIDGET]
		do
			l_container ?= a_widget
			if l_container /= Void then
				l_linear_representation := l_container.linear_representation
				if l_linear_representation /= Void and then not l_linear_representation.is_empty then
					from
						l_linear_representation.start
					until
						l_linear_representation.after or Result
					loop
						if l_linear_representation.item.has_focus then
							Result := true
						else
							Result := has_focus_on_widgets_internal (l_linear_representation.item)
						end
						l_linear_representation.forth
					end
				elseif l_container.has_focus then
					Result := true
				end
			elseif a_widget.has_focus then
				Result := true
			end
		end

	set_focus_to_editor_when_idle
			-- Set focus to editor when idle.
		local
			l_editor: EB_SMART_EDITOR
			da: EV_DRAWING_AREA
		do
			if develop_window /= Void and then not develop_window.is_recycled then
				l_editor := develop_window.editors_manager.current_editor
				if l_editor /= Void then
					develop_window.editors_manager.select_editor (l_editor, False)
					da := l_editor.editor_drawing_area
					if da.is_displayed and da.is_sensitive then
						l_editor.editor_drawing_area.set_focus
					end
				end
			end
		end

	set_focus_if_possible (a_widget: EV_WIDGET)
			-- Set focus to `a_widget' when possble.
		require
			a_widget_not_void: a_widget /= Void
		do
			if
				not a_widget.is_destroyed and then
				a_widget.is_displayed and then
				a_widget.is_sensitive
			then
				a_widget.set_focus
			end
		end

feature {NONE} -- Memory management

	internal_recycle
			-- Recycle tool.
		do
			if content /= Void then
				content.destroy
			end
			if mini_toolbar /= Void then
				mini_toolbar.destroy
			end
		ensure then
			content_destroyed: old content /= Void implies (old content).is_destroyed
			mini_toolbar_destroyed: old mini_toolbar /= Void implies (old mini_toolbar).is_destroyed
		end

	internal_detach_entities
			-- <Precusor>
		do
			develop_window := Void
			mini_toolbar := Void
			internal_stone_director := Void
			Precursor
		ensure then
			develop_window_detached: develop_window = Void
			mini_toolbar_detached: mini_toolbar = Void
			internal_stone_director_detached: internal_stone_director = Void
		end

feature {NONE} -- Implementation: Internal cache

	internal_stone_director: detachable like stone_director
			-- Cached version of `stone_director'
			-- Note: Do not use directly!

invariant
	develop_window_attached: is_interface_usable implies develop_window /= Void
		-- Customizable tool needs to be converted.
	--tool_descriptor_attached: not is_recycled implies tool_descriptor /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class EB_TOOL
