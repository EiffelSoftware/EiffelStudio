note

	description:

		"Setenv tasks"

	library: "Gobo Eiffel Ant"
	copyright: "Copyright (c) 2001, Sven Ehrke and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class GEANT_SETENV_TASK

inherit

	GEANT_TASK
		redefine
			make,
			build_command,
			command
		end

create

	make

feature {NONE} -- Initialization

	make (a_project: GEANT_PROJECT; an_xml_element: XM_ELEMENT)
			-- Create a new task with information held in `an_element'.
		local
			a_value: STRING
		do
			Precursor {GEANT_TASK} (a_project, an_xml_element)

				-- name:
			if has_attribute (Name_attribute_name) then
				a_value := attribute_value (Name_attribute_name)
				if a_value.count > 0 then
					command.set_name (a_value)
				end
			end
				-- value:
			if has_attribute (Value_attribute_name) then
				a_value := attribute_value (Value_attribute_name)
				command.set_value (a_value)
			end
		end

	build_command (a_project: GEANT_PROJECT)
			-- Create instance of `command'
		do
			create command.make (a_project)
		end

feature -- Access

	command: GEANT_SETENV_COMMAND
			-- Setenv commands

feature {NONE} -- Constants

	Name_attribute_name: STRING
			-- "name" attribute name
		once
			Result := "name"
		ensure
			attribute_name_not_void: Result /= Void
			attribute_name_not_empty: Result.count > 0
		end

	Value_attribute_name: STRING
			-- Name of xml attribute for value
		once
			Result := "value"
		ensure
			attribute_name_not_void: Result /= Void
			atribute_name_not_empty: Result.count > 0
		end

end
