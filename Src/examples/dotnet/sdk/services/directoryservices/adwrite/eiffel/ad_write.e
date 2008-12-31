note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	AD_WRITE

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
			prop: SYSTEM_STRING
			values: IENUMERATOR

		do
			args := {ENVIRONMENT}.get_command_line_args
			if args.count <= 3 then
				{SYSTEM_CONSOLE}.write_line ("Usage: " + create {STRING}.make_from_cil (args.item (0)) + " <property> <value>")
			else
				create obj_dir_ent.make (args.item (1))
				{SYSTEM_CONSOLE}.write_line ("Name            = " + create {STRING}.make_from_cil (obj_dir_ent.name))
				{SYSTEM_CONSOLE}.write_line ("Path            = " + create {STRING}.make_from_cil (obj_dir_ent.path))
				{SYSTEM_CONSOLE}.write_line ("SchemaClassName = " + create {STRING}.make_from_cil (obj_dir_ent.schema_class_name))

				prop := args.item (2)
				if obj_dir_ent.properties.contains (prop) then
					from values := obj_dir_ent.properties.item (prop).get_enumerator until not values.move_next loop
						{SYSTEM_CONSOLE}.write_line ("{0} = {1}", prop, values.current_)
					end
				else
					{SYSTEM_CONSOLE}.write_line ("Property {0}'s value is not yet set", prop)
				end
				{SYSTEM_CONSOLE}.write_line ("... changing to ")
				obj_dir_ent.properties.item (prop).value := args.item (3)
				obj_dir_ent.commit_changes

				from values := obj_dir_ent.properties.item (prop).get_enumerator until not values.move_next loop
					{SYSTEM_CONSOLE}.write_line ("{0} = {1}", prop, values.current_)
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
