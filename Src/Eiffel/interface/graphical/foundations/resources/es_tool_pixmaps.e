note
	description: "[
		Base class for all tool-specific pixmap matrix accessor classes.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_TOOL_PIXMAPS

inherit
	ES_PIXMAPS
		rename
			make as make_from_name
		redefine
			resource_handler
		end

feature {NONE} -- Initialization

	make (a_tool: attached ES_TOOL [EB_TOOL]; a_name: attached STRING)
			-- Initialized a tool's pixmap accessor.
			--
			-- `a_tool': The tool to retrieve the pixmaps for.
			-- `a_name': An identifier/moniker used to load a pixmap image.
		require
			a_tool_is_interface_usable: a_tool.is_interface_usable
			not_a_name_is_empty: not a_name.is_empty
		local
			l_matrix: PATH
		do
				-- Create icon file name
			l_matrix := tool_utilities.tool_associated_path (a_tool).extended (a_name)
			if attached eiffel_layout.user_priority_file_name (l_matrix, True) as l_user_matrix then
					-- The user has replaced the icons.
				l_matrix := l_user_matrix
			end
			if attached {EV_PIXEL_BUFFER} resource_handler.retrieve_matrix (l_matrix.name) as l_buffer then
				make_from_buffer (l_buffer)
			else
				if attached logger.service as l_logger_service then
					l_logger_service.put_message_with_severity (
						locale_formatter.formatted_translation (w_could_not_load_tool_icons_1, [a_tool.title]),
						{ENVIRONMENT_CATEGORIES}.none,
						{PRIORITY_LEVELS}.high
					)
				end

				make_from_buffer (create {EV_PIXEL_BUFFER}.make_with_size (1, 1))
			end
		end

feature {NONE} -- Helpers

	resource_handler: attached ES_TOOL_PIXMAP_RESOURCE_HANDLER
			-- <Precursor>
		once
			create Result.make
		end

	tool_utilities: attached ES_TOOL_UTILITIES
			-- Access to EiffelStudio tool utility functions.
		once
			create Result
		end

feature {NONE} -- Internationalization

	w_could_not_load_tool_icons_1: STRING = "Cannot read pixmap icon file for $1.%N%NPlease make sure the installation is not corrupted."

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

