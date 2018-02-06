note
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_METAFILE_HEADER

inherit
	WEL_STRUCTURE

create
	make

feature -- Access

	itype: NATURAL_32
			-- Record type EMR_HEADER
		require
			exists: exists
		do
			Result := c_itype (item)
		end

	nsize: NATURAL_32
			-- Size in bytes of Current.
		require
			exists: exists
		do
			Result := c_nsize (item)
		end

	rcl_bounds: WEL_RECT
			-- Bounding rectangle, in device units, for the image stored in the metafile.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_rcl_bounds (item))
		end

	rcl_frame: WEL_RECT
			-- Rectangle, in 0.01 millimeter units, that surrounds the image stored in the metafile
		require
			exists: exists
		do
			create Result.make_by_pointer (c_rcl_frame (item))
		end

	signature: NATURAL_32
			-- Must be ENHMETA_SIGNATURE
		require
			exists: exists
		do
			Result := c_signature (item)
		end

	version: NATURAL_32
			-- Version number of the metafile format. The current version is 0x10000. 	
		require
			exists: exists
		do
			Result := c_version (item)
		end

	bytes: NATURAL_32
			-- Size in bytes of the metafile.
		require
			exists: exists
		do
			Result := c_bytes (item)
		end

	records: NATURAL_32
			-- Number of records in metafile.
		require
			exists: exists
		do
			Result := c_records (item)
		end

	handles: NATURAL_32
			-- Number of handles in the metafile handle table. Handle index zero is reserved.
		require
			exists: exists
		do
			Result := c_handles (item)
		end

	reserved: NATURAL_32
			-- Reserved. Must be zero.
		require
			exists: exists
		do
			Result := c_reserved (item)
		end

	description: NATURAL_32
			-- Number of characters in the string that contains the description of the metafile's contents.
			-- This member is 0 if the metafile does not have a description string.
		require
			exists: exists
		do
			Result := c_description (item)
		end

	off_description: NATURAL_32
			-- Offset from the beginning of the ENHMETAHEADER3 structure to the string that contains the description
			-- of the metafile's contents. This member is 0 if the metafile does not have a description string.
		require
			exists: exists
		do
			Result := c_off_description (item)
		end

	pal_entries: NATURAL_32
			-- Number of entries in the metafile palette.
		require
			exists: exists
		do
			Result := c_pal_entries (item)
		end

	szl_device: WEL_SIZE
			-- Resolution in pixels of the reference device.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_szl_device (item))
		end

	szl_millimeters: WEL_SIZE
			-- Resolution in millimeters of the reference device.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_szl_millimeters (item))
		end

feature -- Measurements

	structure_size: INTEGER
			-- <Precursor>
		do
			Result := c_structure_size
		end

feature {NONE} -- C externals

	c_structure_size: INTEGER
			-- Implementation of `c_structure_size`.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return sizeof(ENHMETAHEADER3);"
		end

	c_itype (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->iType;"
		end

	c_nsize (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->nSize;"
		end

	c_rcl_bounds (a_ptr: POINTER): POINTER
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return &((ENHMETAHEADER3 *) $a_ptr)->rclBounds;"
		end

	c_rcl_frame (a_ptr: POINTER): POINTER
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return &((ENHMETAHEADER3 *) $a_ptr)->rclFrame;"
		end


	c_signature (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->dSignature;"
		end

	c_version (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->nVersion;"
		end

	c_bytes (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->nBytes;"
		end

	c_records (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->nRecords;"
		end

	c_handles (a_ptr: POINTER): NATURAL_16
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->nHandles;"
		end

	c_reserved (a_ptr: POINTER): NATURAL_16
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->sReserved;"
		end

	c_description (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->nDescription;"
		end

	c_off_description (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->offDescription;"
		end

	c_pal_entries (a_ptr: POINTER): NATURAL_32
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return ((ENHMETAHEADER3 *) $a_ptr)->nPalEntries;"
		end

	c_szl_device (a_ptr: POINTER): POINTER
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return &((ENHMETAHEADER3 *) $a_ptr)->szlDevice;"
		end

	c_szl_millimeters (a_ptr: POINTER): POINTER
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"return &((ENHMETAHEADER3 *) $a_ptr)->szlMillimeters;"
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
