indexing
	description: "Encapsulation of ASSEMBLYMETADATA C structure"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ASSEMBLY_INFO

inherit
	WEL_STRUCTURE
		rename
			structure_size as size
		end

create
	make

feature -- Settings

	set_major_version (m: INTEGER_16) is
			-- Set `major_version' to `m'.
		require
			valid_version: m >= 0
		do
			c_set_major_version (item, m)
		end

	set_minor_version (m: INTEGER_16) is
			-- Set `minor_version' to `m'.
		require
			valid_version: m >= 0
		do
			c_set_minor_version (item, m)
		end

	set_build_number (m: INTEGER_16) is
			-- Set `build_number' to `m'.
		require
			valid_version: m >= 0
		do
			c_set_build_number (item, m)
		end

	set_revision_number (m: INTEGER_16) is
			-- Set `revision_number' to `m'.
		require
			valid_version: m >= 0
		do
			c_set_revision_number (item, m)
		end
		
feature -- Measurement

	size: INTEGER is
			-- Size of current.
		do
			Result := structure_size
		end
		
	structure_size: INTEGER is
			-- Size of ASSEMBLYMETADATA structure.
		external
			"C macro use <cor.h>"
		alias
			"sizeof(ASSEMBLYMETADATA)"
		end
		
feature {NONE} -- Implementation

	c_set_major_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `usMajorVersion' to `i'.
		external
			"C++ struct ASSEMBLYMETADATA access usMajorVersion type USHORT use <cor.h>"
		end

	c_set_minor_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `usMinorVersion' to `i'.
		external
			"C++ struct ASSEMBLYMETADATA access usMinorVersion type USHORT use <cor.h>"
		end

	c_set_build_number (an_item: POINTER; i: INTEGER_16) is
			-- Set `usBuildNumber' to `i'.
		external
			"C++ struct ASSEMBLYMETADATA access usBuildNumber type USHORT use <cor.h>"
		end

	c_set_revision_number (an_item: POINTER; i: INTEGER_16) is
			-- Set `usRevisionNumber' to `i'.
		external
			"C++ struct ASSEMBLYMETADATA access usRevisionNumber type USHORT use <cor.h>"
		end

	c_set_locale (an_item: POINTER; locale: POINTER) is
			-- Set `szLocale' to `locale'.
		external
			"C++ struct ASSEMBLYMETADATA access szLocale type LPWSTR use <cor.h>"
		end

	c_set_locale_count (an_item: POINTER; nb: INTEGER) is
			-- Set `cbLocale' to `nb'.
		external
			"C++ struct ASSEMBLYMETADATA access cbLocale type ULONG use <cor.h>"
		end

end -- class MD_ASSEMBLY_INFO
