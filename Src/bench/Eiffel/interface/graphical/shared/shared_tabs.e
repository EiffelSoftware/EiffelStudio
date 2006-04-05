indexing
	description: "Shared tabular information."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SHARED_TABS

inherit
	EB_CONSTANTS

feature -- Properties

	default_tab_length: INTEGER_REF is
			-- Default tabulation length
		local
			tab_integer: INTEGER
		once
			create Result;
			tab_integer := General_resources.tab_step.actual_value;
			Result.set_item (tab_integer)
		end;

	Minimum_step: INTEGER is 2;
			-- Minimum length for a tab

	Maximum_step: INTEGER is 16;
			-- Maximum length for a tab

	Default_tab_step: INTEGER is 4;

feature -- Settings

	set_default_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `default_tab_length'.
		do
			default_tab_length.set_item (new_length)
		ensure
			assigned: default_tab_length.item = new_length
		end;

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

end -- class SHARED_TABS
