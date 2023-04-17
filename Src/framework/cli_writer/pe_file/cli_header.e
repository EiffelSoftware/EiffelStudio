note
	description: "CLI Header. See ECMA Partition II 24.3.2 "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_HEADER

inherit
	MANAGED_POINTER
		rename
			make as managed_pointer_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_32bits: BOOLEAN)
			-- Allocate item
		local
			l_flags: INTEGER
		do
			managed_pointer_make (structure_size)
			c_set_cb (item, structure_size)
			c_set_major_runtime_version (item, 2)
			c_set_minor_runtime_version (item, 5)

			l_flags := il_only
			if a_32bits then
				l_flags := l_flags | il_32bits
			end
			c_set_flags (item, l_flags)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of `CLI_IMAGE_COR20_HEADER'.
		external
			"C macro use <cli_writer.h>"
		alias
			"sizeof(CLI_IMAGE_COR20_HEADER)"
		end

feature  -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (Current, 0, count)
			l_file.close
		end


feature -- Access

	meta_data_directory: CLI_DIRECTORY
			-- Directory for meta data.
		do
			create Result.make_by_pointer (c_meta_data (item))
		ensure
			meta_data_directory_not_void: Result /= Void
		end

	resources_directory: CLI_DIRECTORY
			-- Directory for resources.
		do
			create Result.make_by_pointer (c_resources (item))
		ensure
			resources_directory_not_void: Result /= Void
		end

	strong_name_directory: CLI_DIRECTORY
			-- Directory for strong name signature.
		do
			create Result.make_by_pointer (c_strong_name_signature (item))
		ensure
			strong_name_directory_not_void: Result /= Void
		end

	flags: INTEGER
			-- Specified flags of header
		do
			Result := c_flags (item)
		end

feature -- Settings

	add_flags (i: INTEGER)
			-- Set `flags' to `i'.
		require
			flags_valid: (i & il_only = il_only) or
				(i & strong_name_signed = strong_name_signed) or
				(i & il_32bits = il_32bits)
		do
			c_set_flags (item, flags | i)
		ensure
			flags_added: (flags & i) = i
		end

	set_entry_point_token (token: INTEGER)
			-- Set `token' as entry point of current CLI image.
		require
			token_not_null: token /= 0
		do
			c_set_entry_point_token (item, token)
		end

feature -- Constants

	il_only: INTEGER = 0x00000001
			-- Should always be set.

	il_32bits: INTEGER = 0x00000002
			-- Should be set for 32bit generated assemblies

	strong_name_signed: INTEGER = 0x00000008
			-- Image has strong name signature.

feature {NONE} -- Implementation

	c_set_cb (an_item: POINTER; i: INTEGER)
			-- Set `cb' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access cb type DWORD use <cli_writer.h>"
		end

	c_set_major_runtime_version (an_item: POINTER; i: INTEGER_16)
			-- Set `MajorRuntimeVersion' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access MajorRuntimeVersion type WORD use <cli_writer.h>"
		end

	c_set_minor_runtime_version (an_item: POINTER; i: INTEGER_16)
			-- Set `MinorRuntimeVersion' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access MinorRuntimeVersion type WORD use <cli_writer.h>"
		end

	c_meta_data (an_item: POINTER): POINTER
			-- Access `MetaData'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access &MetaData use <cli_writer.h>"
		end

	c_set_flags (an_item: POINTER; i: INTEGER)
			-- Set `Flags' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access Flags type DWORD use <cli_writer.h>"
		end

	c_set_entry_point_token (an_item: POINTER; i: INTEGER)
			-- Set `EntryPointToken' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access EntryPointToken type DWORD use <cli_writer.h>"
		end

	c_flags (an_item: POINTER): INTEGER
			-- Access `Flags'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access Flags use <cli_writer.h>"
		end

	c_resources (an_item: POINTER): POINTER
			-- Access `Resources'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access &Resources use <cli_writer.h>"
		end

	c_strong_name_signature (an_item: POINTER): POINTER
			-- Access `StrongNameSignature'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access &StrongNameSignature use <cli_writer.h>"
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

end -- class CLI_HEADER
