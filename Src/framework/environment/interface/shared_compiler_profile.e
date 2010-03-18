note
	description: "[
			Find out if compiler is compiling against compatible/default or experimental libraries.
			Note that this notion is relative to the current version of the compiler.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_COMPILER_PROFILE

feature -- Initialization

	initialize_from_arguments
			-- Initialize current based on the command line arguments from current execution.
		local
			l_args: ES_ARGUMENTS
		do
				-- Reinitialize `flags'.
			flags.put (0)
			create l_args
			if l_args.index_of_word_option (compat_option_name) > 0 then
				set_compatible_mode
			elseif l_args.index_of_word_option (experiment_option_name) > 0 then
				set_experimental_mode
			end
			if l_args.index_of_word_option (full_option_name) > 0 then
				set_full_class_checking_mode
			end
		end

feature -- Access

	compat_option_name: STRING = "compat"
	experiment_option_name: STRING = "experiment"
	full_option_name: STRING = "full"
			-- Name of command line options that can be used to initialize Current

	command_line_profile_option: STRING
			-- Command line option needed to mimic current profile
		local
			l_options: like command_line_profile_option_list
		do
			create Result.make (20)
			from
				l_options := command_line_profile_option_list
				l_options.start
			until
				l_options.after
			loop
				if not l_options.isfirst then
					Result.append_character (' ')
				end
				Result.append (l_options.item)
				l_options.forth
			end
		end

	command_line_profile_option_list: ARRAYED_LIST [STRING]
			-- Command line option needed to mimic current profile
		local
			l_option: detachable STRING
		do
			create Result.make (2)
			if is_compatible_mode then
				create l_option.make (1 + compat_option_name.count)
				l_option.append_character ('-')
				l_option.append (compat_option_name)
			elseif is_experimental_mode then
				create l_option.make (1 + experiment_option_name.count)
				l_option.append_character ('-')
				l_option.append (experiment_option_name)
			end
			if l_option /= Void then
				Result.extend (l_option)
			end
			if is_full_class_checking_mode then
				create l_option.make (1 + full_option_name.count)
				l_option.append_character ('-')
				l_option.append (full_option_name)
				Result.extend (l_option)
			end
		end

	version_mode: STRING
		do
			if is_compatible_mode then
				Result := "compatible"
			elseif is_experimental_mode then
				Result := "experimental"
			else
				Result := ""
			end
		end
feature -- Status report

	is_compatible_mode: BOOLEAN
			-- Is the compiler being run in compatbile mode?
		do
			Result := flags.item & compatible_mode_flag = compatible_mode_flag
		end

	is_default_mode: BOOLEAN
			-- Is the compiler being run in default mode?
		do
			Result := not is_compatible_mode and not is_experimental_mode
		end

	is_experimental_mode: BOOLEAN
			-- Is the compiler being run in experimental mode?
		do
				-- In the 6.6. release, it has no effect.
--			Result := flags.item & experimental_mode_flag = experimental_mode_flag
		end

	is_full_class_checking_mode: BOOLEAN
			-- Is the compiler being run in experimental mode?
		do
			Result := flags.item & full_mode_flag = full_mode_flag
		end

feature -- Settings

	set_compatible_mode
			-- Set compiler in compatible mode.
		do
			flags.put (flags.item | compatible_mode_flag)
		ensure
			is_compatible_mode: is_compatible_mode
		end

	set_experimental_mode
			-- Set compiler in experimental mode.
		do
				-- In the 6.6. release, it has no effect.
--			flags.put (flags.item | experimental_mode_flag)
--		ensure
--			is_experimental_mode: is_experimental_mode
		end

	set_full_class_checking_mode
			-- Set compiler in full class checking mode.
		do
			flags.put (flags.item | full_mode_flag)
		ensure
			is_full_class_checking_mode: is_full_class_checking_mode
		end

	reset
			-- Reset current
		do
			flags.put (0)
		ensure
			is_default_mode: is_default_mode
		end

feature {NONE}

	flags: CELL [NATURAL_8]
			-- Storage for flags
		once
			create Result.put (0)
		end

	compatible_mode_flag: NATURAL_8 = 1
	experimental_mode_flag: NATURAL_8 = 2
	full_mode_flag: NATURAL_8 = 4
			-- Various flags.

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
