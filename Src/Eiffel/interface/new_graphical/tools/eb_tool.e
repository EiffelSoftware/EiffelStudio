indexing
	description	: "[
		EiffelGraphicalCompiler$ tool. Ancestor of all tools in the workbench,
		providing dragging capabilities (transport). A tool is
		composed of a container and manager
		
		Note: DO NOT USE as a base class for new tools in EiffelStudio!
		      Please use {ES_DOCKABLE_TOOL_WINDOW} instead.
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

	EB_DOCKING_MANAGER_ATTACHABLE

	EB_RECYCLABLE

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
			a_tool_attached: a_tool /= Void
			not_a_tool_is_recycled: not a_tool.is_recycled
		do
			develop_window := a_window
			tool_descriptor := a_tool
			build_interface
		ensure
			develop_window_set: develop_window = a_window
			tool_descriptor_set: tool_descriptor = a_tool
		end

	build_interface is
			-- Build all the tool's widgets.
		deferred
		ensure
			widget_created: widget /= Void
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER)is
			-- Build the `content' item and
			-- Add it to `a_docking_manager'.
		do
			build_mini_toolbar

			create content.make_with_widget (widget, title_for_pre)

			content.set_long_title (title)
			content.set_short_title (title)

			if mini_toolbar /= Void then
				content.set_mini_toolbar (mini_toolbar)
			end

			if pixmap /= Void then
				content.set_pixmap (pixmap)
			end
			if pixel_buffer /= Void then
				content.set_pixel_buffer (pixel_buffer)
			end
			register_action (content.close_request_actions, agent close)
			register_action (content.focus_in_actions, agent show)
		end

	build_mini_toolbar is
			-- Build `mini_toolbar'
		do
		end

feature -- Change

	set_manager (m: like develop_window) is
			-- Set value `m' to `develop_window'
		require
			m /= Void
		do
			develop_window := m
		end

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current
		deferred
		end

	title_for_pre: STRING is
			-- Title of the tool
		do
			Result := tool_descriptor.type_id
		ensure then
			valid_title: Result /= Void and then not Result.is_empty
		end

	title: STRING_GENERAL is
			-- Title of the tool which for show, it maybe not in English.
		do
			Result := tool_descriptor.edition_title
		ensure then
			valid_title: Result /= Void and then not Result.is_empty
		end

	mini_toolbar: EV_WIDGET
			-- Mini tool bar assiociate with Current.

	minimized_title: STRING_GENERAL is
			-- Title of the tool when minimized.
			--
			-- By default this name is the same as `title', redefine this
			-- feature to have a different minimized title.
		do
			Result := title
		ensure
			valid_minimized_title: minimized_title /= Void and then not minimized_title.is_empty
		end

	menu_name: STRING_GENERAL is
			-- Name as it may appear in a menu.
			--
			-- By default this name is the same as `title', redefine this
			-- feature to have a different name.
		do
			Result := title
		ensure
			valid_menu_name: menu_name /= Void and then not menu_name.is_empty
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it appears in toolbars and menu, there is no pixmap by default.
		do
			Result := tool_descriptor.icon_pixmap
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer as it appears in toolbars and menu, there is no pixmap by default.
		do
			Result := tool_descriptor.icon
		end

	develop_window: EB_DEVELOPMENT_WINDOW
			-- Development window.

feature {NONE} -- Access

	tool_descriptor: ES_TOOL [like Current]
			-- Descriptor used to created tool.

feature -- Status report

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		do
			if is_interface_usable and then content /= Void and then not is_recycled then
				Result := content.is_visible and then widget.is_displayed
			end
		ensure
			content_is_visible: Result implies content.is_visible
			widget_is_displayed: Result implies widget.is_displayed
		end

	is_auto_hide: BOOLEAN is
			-- Is current auto hide status and content visible?
		do
			if is_interface_usable and then content /= Void and then content.is_visible then
				Result := content.state_value = {SD_ENUMERATION}.auto_hide
			end
		end

	is_customized_tool: BOOLEAN is
			-- Is Current tool a customized tool?
		do
		end

feature -- Status setting

	close is
			-- Close the tool (if possible)
		do
			content.hide
			ev_application.do_once_on_idle (agent set_focus_to_editor_when_idle)
			tool_descriptor.close
		end

	show is
			-- Show the tool (if possible)
		do
			if not shown or else is_auto_hide then
				content.show
			end
			content.set_focus
		end

	show_with_setting is
			-- Show current tool (if possible), and do some settings
		do
			show
		end

	has_focus: BOOLEAN is
			-- Any widget of the tool has focus?
		do
			if widget /= Void then
				Result := has_focus_on_widgets_internal (widget)
			end
		end

feature {ES_TOOL} -- Event handlers

	on_edition_changed
			-- Called when a tool's edition number changes due to purging recycled tools
		do
			content.set_unique_title (title_for_pre)
			content.set_long_title (title)
		end

feature {NONE} -- Implementation

	has_focus_on_widgets_internal (a_widget: EV_WIDGET): BOOLEAN is
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

	set_focus_to_editor_when_idle is
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

	set_focus_if_possible (a_widget: EV_WIDGET) is
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

	internal_recycle is
			-- Recycle tool.
		do
			if content /= Void then
				content.destroy
				content := Void
			end
			develop_window := Void
			tool_descriptor := Void
			if mini_toolbar /= Void then
				mini_toolbar.destroy
				mini_toolbar := Void
			end
		ensure then
			content_detached: content = Void
			develop_window_detached: develop_window = Void
			tool_descriptor_detached: tool_descriptor = Void
			mini_toolbar_detached: mini_toolbar = Void
		end

invariant
	develop_window_attached: not is_recycled implies develop_window /= Void
		-- Customizable tool needs to be converted.
	--tool_descriptor_attached: not is_recycled implies tool_descriptor /= Void

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

end -- class EB_TOOL
