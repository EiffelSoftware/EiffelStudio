note
	description: "[
			Represents a Debug directory format
			
		 * A debug directory entry has the following format:
		 * Offset	Size	Field		Description
		 * 0		4	Characteristics	Reserved, must be zero.
		 * 4		4	TimeDateStamp	The time and date that the debug data
		 *					was created.
		 * 8		2	MajorVersion	The major version number of the debug
		 *					data format.
		 * 10		2	MinorVersion	The minor version number of the debug
		 *					data format.
		 * 12		4	Type		The format of debugging information.
		 *					This field enables support of multiple
		 *					debuggers. For more information, see
		 *					section 6.1.2, "Debug Type."
		 * 16		4	SizeOfData	The size of the debug data (not
		 *					including the debug directory itself).
		 * 20		4	AddressOfRawData The address of the debug data when
		 *					loaded, relative to the image base.
		 * 24		4	PointerToRawData The file pointer to the debug data.

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMG_DEBUG_DIRECTORY

inherit

	CLI_DEBUG_DIRECTORY_I

feature -- Access

	characteristics: INTEGER_32
			-- Reserved


	time_date_stamp: INTEGER_32
			-- The time and date the debugging information was created.

	major_version: INTEGER_16
			-- The major version number of the debugging information format.

	minor_version: INTEGER_16
			-- he minor version number of the debugging information format.


	dbg_type: INTEGER_32
			-- The format of the debugging information. This member can be one of the following values.
			-- IMAGE_DEBUG_TYPE_UNKNOWN (0)    Unknown value, ignored by all tools.
			-- IMAGE_DEBUG_TYPE_COFF    (1)    COFF debugging information (line numbers, symbol table, and string table).
			--                                 This type of debugging information is also pointed to by fields in the file headers.
			--
			-- IMAGE_DEBUG_TYPE_CODEVIEW (2)   CodeView debugging information.
			--								   The format of the data block is described by the CodeView 4.0 specification.
			-- IMAGE_DEBUG_TYPE_FPO (3)		   Frame pointer omission (FPO) information.
			--                                 This information tells the debugger how to interpret nonstandard stack frames,
			--                                 which use the EBP register for a purpose other than as a frame pointer.
			-- IMAGE_DEBUG_TYPE_MISC (4)       Miscellaneous information.
			-- IMAGE_DEBUG_TYPE_EXCEPTION (5)  Exception information.
			-- IMAGE_DEBUG_TYPE_FIXUP (6)      Fixup information.
			-- IMAGE_DEBUG_TYPE_BORLAND (9)    Borland debugging information.


	size_of_data: INTEGER_32
			-- The size of the debugging information, in bytes. This value does not include the debug directory itself.

	address_of_raw_data: INTEGER_32
			-- The address of the debugging information when the image is loaded, relative to the image base.

	pointer_to_raw_data: INTEGER_32
			-- A file pointer to the debugging information.

feature -- Element change

	set_characteristics (a_characteristics: like characteristics)
			-- Assign `characteristics' with `a_characteristics'.
		do
			characteristics := a_characteristics
		ensure
			characteristics_assigned: characteristics = a_characteristics
		end

	set_time_date_stamp (a_time_date_stamp: like time_date_stamp)
			-- Assign `time_date_stamp' with `a_time_date_stamp'.
		do
			time_date_stamp := a_time_date_stamp
		ensure
			time_date_stamp_assigned: time_date_stamp = a_time_date_stamp
		end

	set_major_version (a_major_version: like major_version)
			-- Assign `major_version' with `a_major_version'.
		do
			major_version := a_major_version
		ensure
			major_version_assigned: major_version = a_major_version
		end

	set_minor_version (a_minor_version: like minor_version)
			-- Assign `minor_version' with `a_minor_version'.
		do
			minor_version := a_minor_version
		ensure
			minor_version_assigned: minor_version = a_minor_version
		end

	set_dbg_type (a_dbg_type: like dbg_type)
			-- Assign `dbg_type' with `a_dbg_type'.
		do
			dbg_type := a_dbg_type
		ensure
			dbg_type_assigned: dbg_type = a_dbg_type
		end

	set_size_of_data (a_size_of_data: like size_of_data)
			-- Assign `size_of_data' with `a_size_of_data'.
		do
			size_of_data := a_size_of_data
		ensure
			size_of_data_assigned: size_of_data = a_size_of_data
		end

	set_address_of_raw_data (an_address_of_raw_data: like address_of_raw_data)
			-- Assign `address_of_raw_data' with `an_address_of_raw_data'.
		do
			address_of_raw_data := an_address_of_raw_data
		ensure
			address_of_raw_data_assigned: address_of_raw_data = an_address_of_raw_data
		end

	set_pointer_to_raw_data (a_pointer_to_raw_data: like pointer_to_raw_data)
			-- Assign `pointer_to_raw_data' with `a_pointer_to_raw_data'.
		do
			pointer_to_raw_data := a_pointer_to_raw_data
		ensure
			pointer_to_raw_data_assigned: pointer_to_raw_data = a_pointer_to_raw_data
		end


feature -- Managed Pointer

	item: CLI_MANAGED_POINTER
			-- write the items to the buffer in little-endian format.
		do
			create Result.make (size_of)
				-- characteristics
			Result.put_integer_32 (characteristics)
				-- time_date_stamp
			Result.put_integer_32 (time_date_stamp)
				-- major_version
			Result.put_integer_16 (major_version)
				-- minor_version
			Result.put_integer_16 (minor_version)
				-- dbg_type
			Result.put_integer_32 (dbg_type)
				-- size_of_data
			Result.put_integer_32 (size_of_data)
				-- address_of_raw_data
			Result.put_integer_32(address_of_raw_data)
				-- pointer_to_raw_data
			Result.put_integer_32 (pointer_to_raw_data)
		end

feature -- Size

	size_of: INTEGER_32
			-- Size of the structure.
		local
			s: CLI_MANAGED_POINTER_SIZE
		do
			create s.make
				-- characteristics
			s.put_integer_32
				-- time_date_stamp
			s.put_integer_32
				-- major_version
			s.put_integer_16
				-- minor_version
			s.put_integer_16
				-- dbg_type
			s.put_integer_32
				-- size_of_data
			s.put_integer_32
				-- address_of_raw_dara
			s.put_integer_32
				-- pointer_to_raw_data
			s.put_integer_32
			Result := s
		ensure
			Result = 28
		end

end
