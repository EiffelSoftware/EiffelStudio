indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_INCLUDE_EXTERNALS_SECTION

inherit
	TARGET_EXTERNAL_BASE_SECTION

create
	make

feature -- Access

	name: STRING is
			-- Name of the section.
		once
			Result := conf_interface_names.external_include_tree
		end

	icon: EV_PIXMAP is
			-- Icon of the section.
		once
			Result := pixmaps.icon_pixmaps.project_settings_include_file_icon
		end

feature -- Element update

	add_external is
			-- Add a new external.
		local
			l_external: CONF_EXTERNAL_INCLUDE
			l_ext_sec: EXTERNAL_INCLUDE_SECTION
		do
				-- add it in the configuration
			l_external := configuration_window.conf_factory.new_external_include ("new")
			target.add_external_include (l_external)

				-- create and select the section
			create l_ext_sec.make (l_external, target, configuration_window)
			extend (l_ext_sec)
			expand
			l_ext_sec.enable_select
		end

feature {NONE} -- Implementation

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.reset_sensitive

			toolbar.add_include_button.select_actions.wipe_out
			toolbar.add_include_button.select_actions.extend (agent add_external)
			toolbar.add_include_button.enable_sensitive
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
end
