indexing
	description: "Finish freezing's argument parser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER

create
	make

feature -- Access

	location: STRING is
			-- Location specified by user, via command line
		require
			successful: successful
			has_location: has_location
		local
			l_opt: ARGUMENT_OPTION
		once
			l_opt := option_of_name (location_switch)
			if l_opt /= Void then
				Result := l_opt.value
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	generate_only: BOOLEAN is
			-- Indicates if only a make file should be generated
		require
			successful: successful
		once
			Result := has_option (generate_only_switch)
		end

	silent: BOOLEAN is
			-- Indicates if ui should be surpressed
		require
			successful: successful
		once
			Result := has_option (silent_switch)
		end

	force_32bit_code_generation: BOOLEAN is
			-- Indicates if 32 bit code should be generated
		require
			successful: successful
		once
			Result := has_option (x86_switch)
		end

feature -- Query

	has_location: BOOLEAN is
			-- Indicates if user specified a location
		require
			successful: successful
		once
			Result := has_option (location_switch)
		end


feature {NONE} -- Usage

	name: STRING is
			-- Full name of application
		once
			Result := "Eiffel C/C++ Compilation Tool"
		end

	version: STRING is
			-- Version number of application
		once
			Result := "5.7"
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH] is
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (4)
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (location_switch, "Alternative location to compile C code in.", True, False, "directory", "Location to compile C code in", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (generate_only_switch, "Informs tool to only generate a Makefile.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (x86_switch, "Generate 32bit lib DLLs for .NET projects.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (silent_switch, "Supresses confirmation dialog", True, True))
		end

feature {NONE} -- Switches

	location_switch: STRING is "location"
	generate_only_switch: STRING is "generate_only"
	silent_switch: STRING is "silent"
	x86_switch: STRING is "x86";
			-- Argument switches

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

end -- class {ARGUMENT_PARSER}
