note
	description: "[
			Profile that overrides compiler behavior.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_PROFILE

create
	default_create

feature -- Initialization

	initialize_from_arguments
			-- Initialize current based on the command line arguments from current execution.
		local
			l_args: ES_ARGUMENTS
			l_arg: IMMUTABLE_STRING_32
			l_pos: INTEGER
		do
				-- Reinitialize `flags'.
			reset
			create l_args
			if l_args.index_of_word_option (compat_option_name) > 0 then
				set_compatible_mode
			elseif l_args.index_of_word_option (experiment_option_name) > 0 then
				set_experimental_mode
			end
			if l_args.index_of_word_option (full_option_name) > 0 then
				set_full_class_checking_mode
			end
			if l_args.index_of_word_option (safe_option_name) > 0 then
				set_safe_mode
			end

				-- Process the platform part. If we encounter something invalid
				-- we simply ignore it and let the actual argument parsing code
				-- handle this properly.
			l_pos := l_args.index_of_word_option (platform_option_name)
			if l_pos > 0 and then l_pos + 1 <= l_args.argument_count then
				l_arg := l_args.argument (l_pos + 1)
				if is_platform_valid (l_arg) then
					set_platform (l_arg)
				end
			end
		end

feature -- Access

	compat_option_name: STRING = "compat"
	experiment_option_name: STRING = "experiment"
	full_option_name: STRING = "full"
	safe_option_name: STRING = "safe"
	platform_option_name: STRING = "platform"
			-- Name of command line options that can be used to initialize Current

	command_line: STRING
			-- Command line option needed to mimic current profile
		local
			l_options: like command_line_list
		do
			create Result.make (20)
			from
				l_options := command_line_list
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

	command_line_list: ARRAYED_LIST [STRING]
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
			if is_safe_mode then
				create l_option.make (1 + safe_option_name.count)
				l_option.append_character ('-')
				l_option.append (safe_option_name)
				Result.extend (l_option)
			end
			if is_platform_set then
				create l_option.make (1 + platform_option_name.count)
				l_option.append_character ('-')
				l_option.append (platform_option_name)
				l_option.append_character (' ')
				l_option.append (platform_mode)
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

	platform_mode: STRING
			-- Name of platform if set.
		require
			is_platform_set: is_platform_set
		do
			inspect flags & platform_mask
			when unix_platform_flag then Result := "unix"
			when windows_platform_flag then Result := "windows"
			when mac_platform_flag then Result := "macintosh"
			when vxworks_platform_flag then Result := "vxworks"
			else
				check known_platform: False end
				Result := "unix"
			end
		end

feature -- Status report

	is_compatible_mode: BOOLEAN
			-- Is the compiler being run in compatbile mode?
		do
			Result := flags & compatible_mode_flag = compatible_mode_flag
		end

	is_default_mode: BOOLEAN
			-- Is the compiler being run in default mode?
		do
			Result := not is_compatible_mode and not is_experimental_mode
		end

	is_experimental_mode: BOOLEAN
			-- Is the compiler being run in experimental mode?
		do
			Result := flags & experimental_mode_flag = experimental_mode_flag
		end

	is_frozen_variant_supported: BOOLEAN
			-- Is `frozen' or `variant' fully supported?
		do
				-- Only when experimental mode is enabled for the time being.
			Result := flags & experimental_mode_flag = experimental_mode_flag
		end

	is_full_class_checking_mode: BOOLEAN
			-- Is the compiler being run in experimental mode?
		do
			Result := flags & full_mode_flag = full_mode_flag
		end

	is_safe_mode: BOOLEAN
			-- Are "-safe" versions of ECFs used?
		do
			Result := flags & safe_mode_flag /= 0
		end

	is_platform_set: BOOLEAN
			-- Is the platform set?
		do
			Result := (flags & platform_mask) /= 0
		end

	is_platform_valid (a_platform: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_platform' a valid platform specification?
		do
			Result := a_platform.is_case_insensitive_equal ("windows") or
				a_platform.is_case_insensitive_equal ("unix") or
				a_platform.is_case_insensitive_equal ("macintosh") or
				a_platform.is_case_insensitive_equal ("vxworks")
		end

	is_unix_platform: BOOLEAN
			-- Are we targetting the unix platform?
		require
			is_platform_set: is_platform_set
		do
			Result := (flags & platform_mask) = unix_platform_flag
		ensure
			exclusive_answer: Result implies (not is_windows_platform and not is_mac_platform and not is_vxworks_platform)
		end

	is_windows_platform: BOOLEAN
			-- Are we targetting the windows platform?
		require
			is_platform_set: is_platform_set
		do
			Result := (flags & platform_mask) = windows_platform_flag
		ensure
			exclusive_answer: Result implies (not is_unix_platform and not is_mac_platform and not is_vxworks_platform)
		end

	is_mac_platform: BOOLEAN
			-- Are we targetting the mac platform?
		require
			is_platform_set: is_platform_set
		do
			Result := (flags & platform_mask) = mac_platform_flag
		ensure
			exclusive_answer: Result implies (not is_unix_platform and not is_windows_platform and not is_vxworks_platform)
		end

	is_vxworks_platform: BOOLEAN
			-- Are we targetting the vxworks platform?
		require
			is_platform_set: is_platform_set
		do
			Result := (flags & platform_mask) = vxworks_platform_flag
		ensure
			exclusive_answer: Result implies (not is_unix_platform and not is_windows_platform and not is_mac_platform)
		end

feature -- Settings

	set_compatible_mode
			-- Set compiler in compatible mode.
		do
			flags := flags | compatible_mode_flag
		ensure
			is_compatible_mode: is_compatible_mode
		end

	set_experimental_mode
			-- Set compiler in experimental mode.
		do
				-- In the 7.3 release, it has the effect of enabling type interval.
			flags := flags | experimental_mode_flag
		ensure
			is_experimental_mode: is_experimental_mode
		end

	set_full_class_checking_mode
			-- Set compiler in full class checking mode.
		do
			flags := flags | full_mode_flag
		ensure
			is_full_class_checking_mode: is_full_class_checking_mode
		end

	set_safe_mode
			-- Use "-safe" versions of ECF if available.
		do
			flags := flags | safe_mode_flag
		ensure
			is_safe_mode: is_safe_mode
		end

	set_platform (a_platform: READABLE_STRING_GENERAL)
		require
			is_platform_valid: is_platform_valid (a_platform)
		do
			if a_platform.is_case_insensitive_equal ("windows") then
				set_is_windows_platform
			elseif a_platform.is_case_insensitive_equal ("unix") then
				set_is_unix_platform
			elseif a_platform.is_case_insensitive_equal ("macintosh") then
				set_is_mac_platform
			elseif a_platform.is_case_insensitive_equal ("vxworks") then
				set_is_vxworks_platform
			end
		end

	set_is_windows_platform
			-- Use windows as target compilation
		do
			flags := (flags & platform_mask.bit_not) | windows_platform_flag
		ensure
			is_windows_platform: is_windows_platform
		end

	set_is_unix_platform
			-- Use unix as target compilation
		do
			flags := (flags & platform_mask.bit_not) | unix_platform_flag
		end

	set_is_mac_platform
			-- Use mac as target compilation
		do
			flags := (flags & platform_mask.bit_not) | mac_platform_flag
		end

	set_is_vxworks_platform
			-- Use vxworks as target compilation
		do
			flags := (flags & platform_mask.bit_not) | vxworks_platform_flag
		end

	reset
			-- Reset current
		do
			flags := 0
		ensure
			is_default_mode: is_default_mode
		end

feature {NONE}

	flags: NATURAL_32
			-- Storage for flags

	compatible_mode_flag: NATURAL_32 = 0x0001
	experimental_mode_flag: NATURAL_32 = 0x0002
	full_mode_flag: NATURAL_32 = 0x0004
	safe_mode_flag: NATURAL_32 = 0x0008
			-- Compilation flag

	platform_mask: NATURAL_32 = 0x00F0
	unix_platform_flag: NATURAL_32 = 0x0010
	windows_platform_flag: NATURAL_32 = 0x0020
	mac_platform_flag: NATURAL_32 = 0x0030
	vxworks_platform_flag: NATURAL_32 = 0x0040
			-- Platform target flags.

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
