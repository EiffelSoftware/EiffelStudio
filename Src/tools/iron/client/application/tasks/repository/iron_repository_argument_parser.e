note
	description: "[
			Summary description for {IRON_REPOSITORY_ARGUMENT_PARSER}.
						
				iron repository ...
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPOSITORY_ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_parser
		redefine
			switch_groups
		end

	IRON_REPOSITORY_ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make (a_task: IRON_TASK)
			-- Initialize argument parser
		do
			task := a_task
			make_parser (False, False)
			set_argument_source (a_task.argument_source)
			is_using_builtin_switches := not is_verbose_switch_used
--			set_is_using_separated_switch_values (False)
--			set_non_switched_argument_validator (create {ARGUMENT_DIRECTORY_VALIDATOR})
		end

	task: IRON_TASK

feature -- Access

	is_info: BOOLEAN
		do
			Result := has_option (info_switch)
		end

	is_listing: BOOLEAN
		do
			Result := has_option (list_switch)
		end

	repository_url: detachable IMMUTABLE_STRING_32
		do
			if has_non_switched_argument then
				Result := value
			end
		end

	repository_to_add: detachable IMMUTABLE_STRING_8
		local
			v: IMMUTABLE_STRING_32
		do
			if
				has_option (add_switch) and then
				attached option_of_name (add_switch) as opt
			then
				v := opt.value
				if v.is_valid_as_string_8 then
					create Result.make_from_string (v.as_string_8)
				end
			end
		end

	repository_to_remove: detachable IMMUTABLE_STRING_32
		local
			v: IMMUTABLE_STRING_32
		do
			if
				has_option (remove_switch) and then
				attached option_of_name (remove_switch) as opt
			then
				v := opt.value
				create Result.make_from_string (v)
			end
		end

feature {NONE} -- Usage

	name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({IRON_CONSTANTS}.executable_name + " " + task.name)
		end

feature {NONE} -- Usage

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "uri")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Repository uri (including version)")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "uri")
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (12)
			Result.extend (create {ARGUMENT_SWITCH}.make (list_switch, "List repositories", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (add_switch, "Add repository", True, False, "name", "Registration name for associated url", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (remove_switch, "Remove repository", True, False, "name_or_url", "Registered name or repository url including the version", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (info_switch, "Info on local repository settings", True, False))
			add_verbose_switch (Result)
			add_simulation_switch (Result)
			add_batch_interactive_switch (Result)
		end

	switch_groups: attached ARRAYED_LIST [attached ARGUMENT_GROUP]
			-- Valid switch grouping
		once
			create Result.make (3)
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (verbose_switch), switch_of_name (info_switch)>>, False))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (verbose_switch), switch_of_name (list_switch)>>, False))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (verbose_switch), switch_of_name (add_switch)>>, True))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (verbose_switch), switch_of_name (remove_switch)>>, False))
		end

	info_switch: STRING = "info"
	list_switch: STRING = "l|list"
	add_switch: STRING = "a|add"
	remove_switch: STRING = "d|remove"

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
