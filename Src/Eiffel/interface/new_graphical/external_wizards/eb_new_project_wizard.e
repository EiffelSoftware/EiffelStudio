note
	description	: "Command to execute an external wizard to create a new project"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_PROJECT_WIZARD

inherit
	EB_EXTERNAL_WIZARD

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
--	make,
	make_with_file

feature {NONE} -- Initialization

	make_with_file (a_filename: PATH)
			-- Load the command from the description file named
			-- `a_filename'.
			--
			-- The file should contain the following lines:
			-- Name=".."
			--
		require
			valid_filename: a_filename /= Void and then not a_filename.is_empty
		local
			file: PLAIN_TEXT_FILE
			entry: TUPLE [name: STRING_32; value: STRING_32]
		do
			create file.make_with_path (a_filename)
			from
				file.open_read
			until
				file.end_of_file
			loop
				file.read_line
				entry := analyse_line (file.last_string)
				if entry /= Void then
					if entry.name.same_string ("name") then
						-- FIXME: better handle Unicode name.
						set_name ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (entry.value))
					elseif entry.name.same_string ("description") then
						-- FIXME: better handle Unicode description.
						set_description ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (wrap_word (entry.value, 70)))
					elseif entry.name.same_string ("location") then
						location := eiffel_layout.new_project_wizards_path.extended (entry.value)
					elseif entry.name.same_string ("platform") then
						target_platform := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (entry.value).as_lower
					end
				end
			end
			file.close
		ensure
			location_is_set: location /= Void and then not location.is_empty
		end

feature -- Access

	name: STRING
			-- Name of the wizard ("WEL Wizard" for example).

	description: STRING
			-- Description for this wizard.

	target_platform: STRING
			-- Target platform for this wizard: "all" for all platform, "windows" for windows, ...

	target_platform_supported: BOOLEAN
			-- Is the target platform supported by the current platform?
		do
			Result := target_platform.same_string ("all") or else target_platform.is_case_insensitive_equal (eiffel_layout.platform_abstraction)
		end

feature -- Status Setting

	set_name (a_name: STRING)
			-- Set `name' to `a_name'.
		do
			name := a_name
		end

	set_description (a_description: STRING)
			-- Set `description' to `a_description'.
		do
			description := a_description
		end

feature {NONE} -- Implementation

	wrap_word (a_string: STRING; a_margin: INTEGER): STRING
			-- Return a copy of `a_string', with a maximum of `a_margin' characters per line.
		local
			original: STRING
			last_space_index: INTEGER
		do
			create Result.make (0)
			from
				original := a_string.string
			until
				original.count < a_margin
			loop
				last_space_index := original.last_index_of (' ', a_margin)
				Result.append (original.substring (1, last_space_index - 1))
				Result.append ("%N")
				original := original.substring (last_space_index + 1, original.count)
			end
			Result.append (original)
		end

feature {NONE} -- Constants

	Additional_parameters: STRING
		do
			Result := "Ace=%"<ACE>%"%NDirectory=%"<DIRECTORY>%"%NCompilation=%"<COMPILATION>%"%NCompilation_type=%"<COMPILATION_TYPE>%""
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class EB_NEW_PROJECT_WIZARD
