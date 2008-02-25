indexing
    description: "[
        A command used to show a tool through a tool shim {ES_TOOL} descendants.
    ]"
    legal: "See notice at end of class."
    status: "See notice at end of class.";
    date: "$date$";
    revision: "$revision$"

class
    ES_NEW_TOOL_COMMAND

inherit
    EB_DEVELOPMENT_WINDOW_COMMAND
        rename
            make as target_make
        end

    EB_TOOLBARABLE_AND_MENUABLE_COMMAND
        redefine
            new_sd_toolbar_item,
            pixel_buffer,
            mini_pixmap,
            mini_pixel_buffer
        end

    SHARED_LOCALE

create
    make

feature {NONE} -- Initialization

    make (a_tool: like tool) is
            -- Creation method.
        require
            a_tool_attached: a_tool /= Void
            a_tool_window_set: a_tool.window /= Void
        do
            target_make (a_tool.window)
            tool_type := a_tool.window.shell_tools.dynamic_tool_type (a_tool.generating_type)
            is_sensitive := True
        end

feature -- Access

    tool: ES_TOOL [EB_TOOL]
            -- Active tool
        require
            not_is_recycled: not is_recycled
        do
            Result := internal_tool
            if Result = Void or else Result.is_recycled then
                Result := target.shell_tools.tool_next_available_edition (tool_type, False)
                internal_tool := Result
            end
        ensure
            result_attached: Result /= Void
            result_consistent: Result = tool
        end

    tooltip: STRING_GENERAL is
            -- Tooltip for Current
        do
            Result := "Create a new edition of this tool"
        end

    description: STRING_GENERAL is
            -- Description for current command.
        do
            Result := tooltip
        end

    menu_name: STRING_GENERAL is
            -- Name as it appears in menus.
        do
            Result := tool.title
        end

    name: STRING is
            -- Name to be displayed.
        do
            Result := tool_type.generating_type
            if internal_tool /= Void and then internal_tool.edition > 1 then
                Result.append (":" + internal_tool.edition.out)
            end
        end

    pixmap: EV_PIXMAP is
            -- Pixmap representing the item (for buttons)
        do
            Result := tool.icon_pixmap
        end

    pixel_buffer: EV_PIXEL_BUFFER is
            -- Pixel buffer representing the command.
        do
            Result := tool.icon
        end

    mini_pixmap: EV_PIXMAP
            -- Mini pixmap
        do
            Result := (create {EB_SHARED_PIXMAPS}).mini_pixmaps.new_tool_edition_icon
        end

    mini_pixel_buffer: EV_PIXEL_BUFFER
            -- Mini pixel buffer
        do
            Result := (create {EB_SHARED_PIXMAPS}).mini_pixmaps.new_tool_edition_icon_buffer
        end

feature {NONE} -- Access

    tool_type: TYPE [ES_TOOL [EB_TOOL]]
            -- Tool managed.

feature -- Execution

    execute is
            -- Execute command (toggle between show and hide).
        local
            l_shared: SD_SHARED
            l_x, l_y: INTEGER
            l_window: EV_WINDOW
        do
            if not tool.panel.shown then
                create l_shared
                l_window := tool.window.window
                l_x := l_window.screen_x + l_window.width // 2 - l_shared.default_floating_window_width // 2
                l_y := l_window.screen_y + l_window.height // 2 - l_shared.default_floating_window_height // 2

                l_shared.set_default_screen_x (l_x)
                l_shared.set_default_screen_y (l_y)

                tool.show (True)
            end
        end

feature -- Basic operations

    new_sd_toolbar_item (a_display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
            -- Create a new toolbar button for this command.
        do
            create Result.make (Current)
            initialize_sd_toolbar_item (Result, a_display_text)
            Result.select_actions.extend (agent execute)
            auto_recycle (Result)
        end

feature {NONE} -- Internal implementation cache

    internal_tool: like tool
            -- Cached version of `tool'.
            -- Note: Do not use directly!

invariant
    tool_type_attached: not is_recycled implies tool_type /= Void

;indexing
    copyright:    "Copyright (c) 1984-2007, Eiffel Software"
    license:    "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
    licensing_options:    "http://www.eiffel.com/licensing"
    copying: "[
            This file is part of Eiffel Software's Eiffel Development Environment.
            
            Eiffel Software's Eiffel Development Environment is free
            software; you can redistribute it and/or modify it under
            the terms of the GNU General Public License as published
            by the Free Software Foundation, version 2 of the License
            (available at the URL listed under "license" above).
            
            Eiffel Software's Eiffel Development Environment is
            distributed in the hope that it will be useful,    but
            WITHOUT ANY WARRANTY; without even the implied warranty
            of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
            See the    GNU General Public License for more details.
            
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
