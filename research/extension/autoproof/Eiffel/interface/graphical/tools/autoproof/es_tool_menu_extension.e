note
	description: "An implementation of a tool menu extension service."

class
	ES_TOOL_MENU_EXTENSION

inherit
	TOOL_MENU_EXTENSION_S
	DISPOSABLE_SAFE
	EB_SHARED_PIXMAPS
	EB_SHARED_WINDOW_MANAGER
	SHARED_LOCALE

feature -- Modification

	extend
		(extender: PROCEDURE [
			READABLE_STRING_32, -- name
			READABLE_STRING_GENERAL, -- icon
			BOOLEAN, -- is_sensitive
			PROCEDURE -- action
		])
			-- <Precursor>
		do
			extender
				(locale.translation_in_context ("AutoProof", "menu.tool"),
				icon_pixmaps.verifier_verify_name,
				True,
				agent
					local
						c: ES_SHOW_TOOL_COMMAND
					do
						if
							attached window_manager.last_focused_development_window as w and then
							attached w.shell_tools.tool ({ES_AUTOPROOF_TOOL}) as t
						then
							c := w.commands.show_shell_tool_commands.item (t)
							if c = Void then
								create c.make (t)
								w.auto_recycle (c)
								w.commands.show_shell_tool_commands.force (c, t)
							end
							c.execute
						end
					end)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2018-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end
