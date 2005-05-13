indexing
	description: ".NET environment information"
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