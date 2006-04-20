indexing
	description: "CLI Header. See ECMA Partition II 24.3.2 "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_HEADER

inherit
	WEL_STRUCTURE
		rename
			structure_size as count
		redefine
			make
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Allocate `item'.
		do
			Precursor {WEL_STRUCTURE}
			c_set_cb (item, structure_size)
			c_set_major_runtime_version (item, 2)
			c_set_minor_runtime_version (item, 5)
			c_set_flags (item, il_only)
		end
		
feature -- Measurement

	count: INTEGER is
			-- Size of current.
		do
			Result := structure_size
		end
		
	structure_size: INTEGER is
			-- Size of `CLI_IMAGE_COR20_HEADER'.
		external
			"C macro use <cli_writer.h>"
		alias
			"sizeof(CLI_IMAGE_COR20_HEADER)"
		end

feature -- Access

	meta_data_directory: CLI_DIRECTORY is
			-- Directory for meta data.
		do
			create Result.make_by_pointer (c_meta_data (item))
		ensure
			meta_data_directory_not_void: Result /= Void
		end

	resources_directory: CLI_DIRECTORY is
			-- Directory for resources.
		do
			create Result.make_by_pointer (c_resources (item))
		ensure
			resources_directory_not_void: Result /= Void
		end
		
	strong_name_directory: CLI_DIRECTORY is
			-- Directory for strong name signature.
		do
			create Result.make_by_pointer (c_strong_name_signature (item))
		ensure
			strong_name_directory_not_void: Result /= Void
		end
		
	flags: INTEGER is
			-- Specified flags of header
		do
			Result := c_flags (item)
		end
		
feature -- Settings

	set_flags (i: INTEGER) is
			-- Set `flags' to `i'.
		require
			flags_valid: (i & il_only = il_only) or
				(i & strong_name_signed = strong_name_signed)
		do
			c_set_flags (item, i)
		ensure
			flags_set: flags = i
		end

	set_entry_point_token (token: INTEGER) is
			-- Set `token' as entry point of current CLI image.
		require
			token_not_null: token /= 0
		do
			c_set_entry_point_token (item, token)
		end
		
feature -- Constants

	il_only: INTEGER is 0x00000001
			-- Should always be set.
			
	strong_name_signed: INTEGER is 0x00000008
			-- Image has strong name signature.

feature {NONE} -- Implementation

	c_set_cb (an_item: POINTER; i: INTEGER) is
			-- Set `cb' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access cb type DWORD use <cli_writer.h>"
		end

	c_set_major_runtime_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MajorRuntimeVersion' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access MajorRuntimeVersion type WORD use <cli_writer.h>"
		end

	c_set_minor_runtime_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MinorRuntimeVersion' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access MinorRuntimeVersion type WORD use <cli_writer.h>"
		end

	c_meta_data (an_item: POINTER): POINTER is
			-- Access `MetaData'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access &MetaData use <cli_writer.h>"
		end

	c_set_flags (an_item: POINTER; i: INTEGER) is
			-- Set `Flags' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access Flags type DWORD use <cli_writer.h>"
		end

	c_set_entry_point_token (an_item: POINTER; i: INTEGER) is
			-- Set `EntryPointToken' to `i'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access EntryPointToken type DWORD use <cli_writer.h>"
		end

	c_flags (an_item: POINTER): INTEGER is
			-- Access `Flags'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access Flags use <cli_writer.h>"
		end

	c_resources (an_item: POINTER): POINTER is
			-- Access `Resources'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access &Resources use <cli_writer.h>"
		end

	c_strong_name_signature (an_item: POINTER): POINTER is
			-- Access `StrongNameSignature'.
		external
			"C struct CLI_IMAGE_COR20_HEADER access &StrongNameSignature use <cli_writer.h>"
		end

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

end -- class CLI_HEADER
