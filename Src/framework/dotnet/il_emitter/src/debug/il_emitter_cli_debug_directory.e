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
		
				 https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-image_debug_directory

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER_CLI_DEBUG_DIRECTORY

inherit
	CLI_DEBUG_DIRECTORY_I

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make,
	make_codeview,
	make_pdbchecksum

feature {NONE} -- Initialization

	make
			-- Allocate `item`
		do
			set_characteristics (0)
			set_major_version (0)
			set_minor_version (0)
			set_dbg_type ({CLI_DEBUG_CONSTANTS}.type_unknown)
		end

	make_codeview
			-- Allocate `item`
		do
			make
			set_time_date_stamp ({CLI_TIME}.time (default_pointer))
			set_major_version (0)
			set_minor_version (0)
			set_dbg_type ({CLI_DEBUG_CONSTANTS}.type_codeview)
		end

	make_pdbchecksum
			-- Allocate `item`
		do
			make
			set_dbg_type ({CLI_DEBUG_CONSTANTS}.type_pdbchecksum)
			set_major_version (1)
			set_minor_version (0)
		end

feature -- Access

	characteristics: INTEGER_32

	time_date_stamp: INTEGER_32
			-- Size

	major_version: INTEGER_16
			-- Size of the structure.

	minor_version: INTEGER_16

	dbg_type: INTEGER_32

	size_of_data: INTEGER_32
			-- characteristics

	address_of_raw_data: INTEGER_32

	pointer_to_raw_data: INTEGER_32

feature -- Element change

	set_characteristics (a_characteristics: like characteristics)
		do
			characteristics := a_characteristics
		ensure
			characteristics_assigned: characteristics = a_characteristics
		end

	set_time_date_stamp (a_time_date_stamp: like time_date_stamp)
		do
			time_date_stamp := a_time_date_stamp
		ensure
			time_date_stamp_assigned: time_date_stamp = a_time_date_stamp
		end

	set_major_version (a_major_version: like major_version)
		do
			major_version := a_major_version
		ensure
			major_version_assigned: major_version = a_major_version
		end

	set_minor_version (a_minor_version: like minor_version)
		do
			minor_version := a_minor_version
		ensure
			minor_version_assigned: minor_version = a_minor_version
		end

	set_dbg_type (a_dbg_type: like dbg_type)
		do
			dbg_type := a_dbg_type
		ensure
			dbg_type_assigned: dbg_type = a_dbg_type
		end

	set_size_of_data (a_size_of_data: like size_of_data)
		do
			size_of_data := a_size_of_data
		ensure
			size_of_data_assigned: size_of_data = a_size_of_data
		end

	set_address_of_raw_data (an_address_of_raw_data: like address_of_raw_data)
		do
			address_of_raw_data := an_address_of_raw_data
		ensure
			address_of_raw_data_assigned: address_of_raw_data = an_address_of_raw_data
		end

	set_pointer_to_raw_data (a_pointer_to_raw_data: like pointer_to_raw_data)
		do
			pointer_to_raw_data := a_pointer_to_raw_data
		ensure
			pointer_to_raw_data_assigned: pointer_to_raw_data = a_pointer_to_raw_data
		end

feature -- Conversion

	item: CLI_MANAGED_POINTER
		do
			create Result.make (size_of);
			Result.put_integer_32 (characteristics);
			Result.put_integer_32 (time_date_stamp);
			Result.put_integer_16 (major_version);
			Result.put_integer_16 (minor_version);
			Result.put_integer_32 (dbg_type);
			Result.put_integer_32 (size_of_data);
			Result.put_integer_32 (address_of_raw_data);
			Result.put_integer_32 (pointer_to_raw_data)
		end

feature -- Measure

	size_of: INTEGER_32
		local
			s: CLI_MANAGED_POINTER_SIZE
		do
			create s.make;
			s.put_integer_32;
			s.put_integer_32;
			s.put_integer_16;
			s.put_integer_16;
			s.put_integer_32;
			s.put_integer_32;
			s.put_integer_32;
			s.put_integer_32
			Result := s.size
		ensure
			Result = 28
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
