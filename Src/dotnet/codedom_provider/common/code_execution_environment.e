indexing
	description: ".NET environment information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EXECUTION_ENVIRONMENT

feature -- Access

	Clr_version: STRING is
			-- Folder name containing microsoft .NET assemblies corresponding
			-- to loaded .NET runtime.
			-- (i.e. "v1.0.3705" or "v1.1.4322" or...)
		do
			Result:= {RUNTIME_ENVIRONMENT}.get_system_version
		ensure
			exist: Result /= Void
		end

	Framework_path: STRING is
			-- Path to .NET framework
			-- (i.e. "C:\Windows\microsoft.net\framework\v1.1.4322")
		do
			Result := {RUNTIME_ENVIRONMENT}.get_runtime_directory
		ensure
			exist: Result /= Void
		end

	Machine_config_path: STRING is
			-- Path to `machine.config' .NET configuration file
		once
			Result := Framework_path + "CONFIG\machine.config"
		ensure
			exist: Result /= Void
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


end -- class CODE_EXECUTION_ENVIRONMENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------