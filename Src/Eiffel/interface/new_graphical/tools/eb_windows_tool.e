indexing
	description	: "Tool to view all opened windows"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WINDOWS_TOOL

inherit
	EB_TOOL
		redefine
			menu_name,
			pixmap,
			pixel_buffer,
			widget,
			attach_to_docking_manager,
			show
		end

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		do
			widget := window_manager.new_widget
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER} -- Initialization

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
			check friend_created: develop_window.tools.favorites_tool  /= Void end
		end

feature -- Access

	widget: EB_WINDOW_MANAGER_LIST
			-- Widget representing Current

	title: STRING_GENERAL is
			-- Redefine
		do
			Result := interface_names.t_windows_tool
		end

	title_for_pre: STRING is
			-- Title for prefence, STRING_8
		do
			Result := Interface_names.to_windows_tool
		end

	menu_name: STRING_GENERAL is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Windows_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := pixmaps.icon_pixmaps.windows_windows_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer
		do
			Result := pixmaps.icon_pixmaps.windows_windows_icon_buffer
		end

	show is
			-- Show tool.
		do
			Precursor {EB_TOOL}
			widget.set_focus
		end

feature -- Memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			widget.recycle
			widget := Void
			develop_window := Void
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

end -- class EB_WINDOWS_TOOL
