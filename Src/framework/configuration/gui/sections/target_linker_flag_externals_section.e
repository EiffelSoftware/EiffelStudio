note
	description: "Section for external linker flag."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_LINKER_FLAG_EXTERNALS_SECTION

inherit
	TARGET_EXTERNAL_BASE_SECTION

create
	make

feature -- Access

	name: READABLE_STRING_32
			-- Name of the section.
		once
			Result := conf_interface_names.external_linker_flag_tree
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.project_settings_linker_flag_icon
		end

feature -- Element update

	add_external
			-- Add a new external.
		local
			l_external: CONF_EXTERNAL_LINKER_FLAG
			l_ext_sec: EXTERNAL_LINKER_FLAG_SECTION
		do
				-- add it in the configuration
			l_external := configuration_window.conf_factory.new_external_linker_flag ("new", target)
			target.add_external_linker_flag (l_external)

				-- create and select the section
			create l_ext_sec.make (l_external, target, configuration_window)
			extend (l_ext_sec)
			expand
			l_ext_sec.enable_select
		end

feature {NONE} -- Section properties

	add_text: STRING_GENERAL
			-- Menu entry text to add a new item.
		do
			Result := conf_interface_names.external_add_linker_flag
		end

	add_icon: EV_PIXMAP
			-- Menu entry icon to add a new item.
		do
			Result := conf_pixmaps.new_linker_flag_icon
		end

	add_button: SD_TOOL_BAR_BUTTON
			-- Toolbar button to add a new item.
		do
			Result := toolbar.add_linker_flag_button
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
end
