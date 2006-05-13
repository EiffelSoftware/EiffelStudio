indexing
	description: "Command to display the ancestors of a routine."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ROUTINE_ANCESTORS_FORMATTER

inherit
	EB_FEATURE_CONTENT_FORMATTER
		redefine
			is_dotnet_formatter
		end

create
	make

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_feature_ancestors, 1)
			Result.put (Pixmaps.Icon_format_feature_ancestors, 2)
		end

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showpast
		end

feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Routine_ancestors
		end

	post_fix: STRING is "ran"
			-- String symbol of the command, used as an extension when saving.

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET XML types?
		do
			Result := True
		end

feature {NONE} -- Implementation

	has_breakpoints: BOOLEAN is False;
			-- Should breakpoints be shown in Current?

	criterion: QL_CRITERION is
			-- Criterion of current formatter
		do
			create {QL_FEATURE_ANCESTOR_RELATION_CRI}Result.make (query_feature_item_from_e_feature (associated_feature).wrapped_domain)
		end

	rebuild_browser is
			-- Rebuild `browser'.
		do
			browser.set_is_branch_id_used (True)
			browser.set_is_written_class_used (True)
			browser.set_is_signature_displayed (True)
			browser.set_is_version_from_displayed (False)
			browser.set_feature_item (associated_feature)
			browser.rebuild_interface
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

end -- class EB_ROUTINE_ANCESTORS_FORMATTER


