indexing
	description: "CLI Header. See ECMA Partition II 24.3.2 "
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
			c_set_minor_runtime_version (item, 0)
			c_set_flags (item, il_only)
		end
		
feature -- Measurement

	count: INTEGER is
			-- Size of current.
		do
			Result := structure_size
		end
		
	structure_size: INTEGER is
			-- Size of `IMAGE_COR20_HEADER'.
		external
			"C macro use <windows.h>"
		alias
			"sizeof(IMAGE_COR20_HEADER)"
		end

feature -- Access

	meta_data_directory: CLI_DIRECTORY is
			-- Directory for meta data.
		do
			create Result.make_by_pointer (c_meta_data (item))
		end
		
feature -- Settings

	set_flags (i: INTEGER) is
			-- Set `flags' to `i'.
		do
			c_set_flags (item, i)
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
			"C struct IMAGE_COR20_HEADER access cb type DWORD use <windows.h>"
		end

	c_set_major_runtime_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MajorRuntimeVersion' to `i'.
		external
			"C struct IMAGE_COR20_HEADER access MajorRuntimeVersion type WORD use <windows.h>"
		end

	c_set_minor_runtime_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MinorRuntimeVersion' to `i'.
		external
			"C struct IMAGE_COR20_HEADER access MinorRuntimeVersion type WORD use <windows.h>"
		end

	c_meta_data (an_item: POINTER): POINTER is
			-- Access `MetaData'.
		external
			"C struct IMAGE_COR20_HEADER access &MetaData use <windows.h>"
		end

	c_set_flags (an_item: POINTER; i: INTEGER) is
			-- Set `Flags' to `i'.
		external
			"C struct IMAGE_COR20_HEADER access Flags type DWORD use <windows.h>"
		end

	c_set_entry_point_token (an_item: POINTER; i: INTEGER) is
			-- Set `EntryPointToken' to `i'.
		external
			"C struct IMAGE_COR20_HEADER access EntryPointToken type DWORD use <windows.h>"
		end

	c_resources (an_item: POINTER): POINTER is
			-- Access `Resources'.
		external
			"C struct IMAGE_COR20_HEADER access &Resources use <windows.h>"
		end

	c_strong_name_signature (an_item: POINTER): POINTER is
			-- Access `StrongNameSignature'.
		external
			"C struct IMAGE_COR20_HEADER access &StrongNameSignature use <windows.h>"
		end

end -- class CLI_HEADER
