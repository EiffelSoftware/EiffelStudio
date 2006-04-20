indexing
	description: "Warning configuration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_WARNING

inherit
	CONF_VALIDITY

create
	make

feature {NONE} -- Initialization

	make is
			-- Create.
		do
			create internal_warnings.make (2)
		end

feature -- Access, stored in configuration file

	is_enabled (a_warning: STRING): BOOLEAN is
			-- Is `a_warning' enabled?
		require
			a_warning_valid: valid_warning (a_warning)
		do
			if internal_warnings.has (a_warning) then
				Result := internal_warnings.found_item
			else
				Result := True
			end
		end


feature {CONF_ACCESS} -- Update, stored in configuration file

	enable (a_warning: STRING) is
			-- Enable `a_warning'.
		require
			a_warning_valid: valid_warning (a_warning)
		do
			internal_warnings.force (True, a_warning)
		end

	disable (a_warning: STRING) is
			-- Disable `a_warning'.
		require
			a_warning_valid: valid_warning (a_warning)
		do
			internal_warnings.force (False, a_warning)
		end


feature -- Merging

	merge (other: like Current) is
			-- Merge warning options.
		local
			l_tmp: like internal_warnings
		do
			l_tmp := other.internal_warnings.twin
			l_tmp.merge (internal_warnings)
			internal_warnings := l_tmp
		end

feature {CONF_WARNING, CONF_VISITOR} -- Implementation, attributes stored in configuration file

	internal_warnings: HASH_TABLE [BOOLEAN, STRING];
			-- The status of the warnings.

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
