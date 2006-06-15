indexing
	description: "Command to display the callees of a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CALLEES_FORMATTER

inherit
	EB_CALLERS_FORMATTER
		redefine
			create_feature_cmd,
			symbol,
			menu_name,
			command_name
		end

create
	make

feature -- Access

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		do
			Result := internal_symbol
			if Result = Void then
				create Result.make (1, 2)
				inspect
					flag
				when {DEPEND_UNIT}.is_in_assignment_flag then
					Result.put (pixmaps.icon_pixmaps.feature_assignees_icon, 1)
					Result.put (pixmaps.icon_pixmaps.feature_assignees_icon, 2)
				when {DEPEND_UNIT}.is_in_creation_flag then
					Result.put (pixmaps.icon_pixmaps.feature_creaters_icon, 1)
					Result.put (pixmaps.icon_pixmaps.feature_creaters_icon, 2)
				else
					Result.put (pixmaps.icon_pixmaps.feature_callees_icon, 1)
					Result.put (pixmaps.icon_pixmaps.feature_callees_icon, 2)
				end
				internal_symbol := Result
			end
		end

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			inspect flag
			when {DEPEND_UNIT}.is_in_assignment_flag then
				Result := interface_names.m_show_assignees
			when {DEPEND_UNIT}.is_in_creation_flag then
				Result := interface_names.m_Show_creation
			else
				Result := Interface_names.m_Showcallees
			end
		end

	command_name: STRING is
			-- Name of the command.
		do
			inspect flag
			when {DEPEND_UNIT}.is_in_assignment_flag then
				Result := interface_names.l_assignees
			when {DEPEND_UNIT}.is_in_creation_flag then
				-- Fixme: Use the proper name (Jasonw)
				Result := interface_names.l_created
			else
				Result := Interface_names.l_callees
			end
		end

feature{NONE} -- Implementation

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			associated_feature_non_void: associated_feature /= Void
		do
			create feature_cmd.make (editor.text_displayed, associated_feature)
			if preferences.feature_tool_data.show_all_callers then
				feature_cmd.set_all_callers
			end
			feature_cmd.set_flag (flag)
			feature_cmd.show_callees
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
