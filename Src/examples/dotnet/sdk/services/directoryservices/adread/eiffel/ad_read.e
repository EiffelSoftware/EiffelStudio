note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	AD_READ

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			args: NATIVE_ARRAY [SYSTEM_STRING]
			obj_dir_ent: DIRECTORY_ENTRY
			key: SYSTEM_STRING
			names, values: IENUMERATOR
		do
			args := {ENVIRONMENT}.get_command_line_args
			if args.count <= 1 then
				{SYSTEM_CONSOLE}.write_line ("Usage: " + create {STRING}.make_from_cil (args.item (0)) + " <ad_path>")
			else
				create obj_dir_ent.make (args.item (1))
				{SYSTEM_CONSOLE}.write_line ("Name            = " + create {STRING}.make_from_cil (obj_dir_ent.name))
				{SYSTEM_CONSOLE}.write_line ("Path            = " + create {STRING}.make_from_cil (obj_dir_ent.path))
				{SYSTEM_CONSOLE}.write_line ("SchemaClassName = " + create {STRING}.make_from_cil (obj_dir_ent.schema_class_name))
				{SYSTEM_CONSOLE}.write_line
				{SYSTEM_CONSOLE}.write_line ("Properties:")
				from names := obj_dir_ent.properties.property_names.get_enumerator until not names.move_next loop
					key ?= names.current_
					{SYSTEM_CONSOLE}.write_line ("%T{0} = ", key)
					{SYSTEM_CONSOLE}.write_line
					from values := obj_dir_ent.properties.item (key).get_enumerator until not values.move_next loop
						{SYSTEM_CONSOLE}.write_line ("%T%T{0} = ", values.current_)
					end
				end
			end

			{SYSTEM_CONSOLE}.write_line
			{SYSTEM_CONSOLE}.write_line ("Please press Enter to continue...")
			{SYSTEM_CONSOLE}.read_line.do_nothing
		end

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
