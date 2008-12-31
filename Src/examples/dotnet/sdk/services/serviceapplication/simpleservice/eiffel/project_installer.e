note
	status: "See notice at end of class."
	legal: "See notice at end of class."

	metadata:
		create {RUN_INSTALLER_ATTRIBUTE}.make (True) end

	dotnet_constructors:
		make

class
	PROJECT_INSTALLER

inherit
	INSTALLER
		rename
			make as base_make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize installer
		do
			create service_installer.make
			create process_installer.make

				-- Services will run under System account
			process_installer.account := {SERVICE_ACCOUNT}.local_system

				-- Service will have Start Type of Manual
			service_installer.start_type := {SERVICE_START_MODE}.manual
			service_installer.service_name := {SIMPLE_SERVICE}.simple_service_name

			installers.add (service_installer).do_nothing
			installers.add (process_installer).do_nothing
		end

feature -- Access

	service_installer: SERVICE_INSTALLER
	process_installer: SERVICE_PROCESS_INSTALLER

invariant
	service_installer_attached: service_installer /= Void
	process_installer_attached: process_installer /= Void

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software/Microsoft Corporation. All rights reserved."
	license: "[
			This file is part of the Microsoft .NET Framework SDK Code Samples.

			This source code is intended only as a supplement to Microsoft
			Development Tools and/or on-line documentation.  See these other
			materials for detailed information regarding Microsoft code samples.

			THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
			KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
			IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
			PARTICULAR PURPOSE.
		]"


end
