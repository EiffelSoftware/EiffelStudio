indexing
	description: "Command to display the callers of a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CALLERS_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		rename
			make as feature_formatter_make
		redefine
			feature_cmd,
			is_dotnet_formatter
		end

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_manager: like manager; a_flag: INTEGER_8) is
			-- Create callers formatter associated with `a_manager' and which only
			-- look for `a_flag' type callers.
		require
			a_manager_not_void: a_manager /= Void
		do
			flag := a_flag
			feature_formatter_make (a_manager)
		ensure
			manager_set: manager = a_manager
			flag_set: flag = a_flag
		end

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		do
			Result := internal_symbol
			if Result = Void then
				create Result.make (1, 2)
				inspect
					flag
				when {DEPEND_UNIT}.is_in_assignment_flag then
					Result.put (pixmaps.icon_format_assigners, 1)
					Result.put (pixmaps.icon_format_assigners, 2)
				when {DEPEND_UNIT}.is_in_creation_flag then
					Result.put (pixmaps.icon_format_creator_callers, 1)
					Result.put (pixmaps.icon_format_creator_callers, 2)
				else
					Result.put (pixmaps.icon_format_feature_callers, 1)
					Result.put (pixmaps.icon_format_feature_callers, 2)
				end
				internal_symbol := Result
			end
		end

	feature_cmd: E_SHOW_CALLERS
			-- Feature command that can generate the information.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			inspect flag
			when {DEPEND_UNIT}.is_in_assignment_flag then
				Result := interface_names.m_show_assigners
			when {DEPEND_UNIT}.is_in_creation_flag then
				Result := interface_names.m_show_creators
			else
				Result := Interface_names.m_Showcallers
			end
		end

 	flag: INTEGER_8
 			-- Flag for type of callers.

feature {NONE} -- Properties

	internal_symbol: like symbol
			-- Once per object storage for `symbol.

	command_name: STRING is
			-- Name of the command.
		do
			inspect flag
			when {DEPEND_UNIT}.is_in_assignment_flag then
				Result := interface_names.l_assigners
			when {DEPEND_UNIT}.is_in_creation_flag then
				Result := interface_names.l_creators
			else
				Result := Interface_names.l_callers
			end
		end

	post_fix: STRING is
			-- String symbol of the command, used as an extension when saving.
		do
			inspect flag
			when {DEPEND_UNIT}.is_in_assignment_flag then
				Result := "ass"
			when {DEPEND_UNIT}.is_in_creation_flag then
				Result := "cre"
			else
				Result := "cal"
			end
		end

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET XML types?
		do
			Result := True
		end

feature {NONE} -- Implementation

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
		end

	has_breakpoints: BOOLEAN is False;
			-- Should breakpoints be shown in Current?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_CALLERS_FORMATTER

