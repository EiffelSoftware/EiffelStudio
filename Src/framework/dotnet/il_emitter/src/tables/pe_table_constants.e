note
	description: "constants related to the tables in the PE file"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TABLE_CONSTANTS

feature -- Access

	Max_tables: INTEGER = 64
			-- the following are after the tables indexes, these are used to
			-- allow figuring out the size of indexes to 'special' streams
			-- generally if the stream is > 65535 bytes the index fits in a 32 bit DWORD
			-- otherwise the index fits into a 16 bit WORD

	Extra_indexes: INTEGER = 5

	T_string: INTEGER = 65

	T_us: INTEGER = 66

	T_guid: INTEGER = 67

	T_blob: INTEGER = 68

end
