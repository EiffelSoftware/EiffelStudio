note
	description: "Summary description for {PE_READER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_READER

create
	make

feature {NONE} -- Initialization

	make
		do
			create objects
			initialize_dnl_tables
			create lib_path.make_empty
			create sizes.make_filled (0, 1, {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes)
		end


	initialize_dnl_tables
		do
			create {ARRAYED_LIST [DNL_TABLE]} tables.make ({PE_TABLE_CONSTANTS}.max_tables)
			across 1 |..| {PE_TABLE_CONSTANTS}.max_tables as  i loop
				tables.force((create {DNL_TABLE}.make))
			end
		end

feature {NONE} -- Implemenation

	input_file: detachable FILE

	num_objects: INTEGER

	cor_rva: NATURAL

	blob_pos: NATURAL

	string_pos: NATURAL

	string_data: detachable ARRAY [NATURAL_8]

	blog_data: detachable ARRAY [NATURAL_8]

	guid_pos: NATURAL

	objects: PE_OBJECT

	tables: LIST [DNL_TABLE]
		-- build with Max_Tables

	sizes: ARRAY [NATURAL_32]
		-- Max_Tables + Extra_Indexes

	lib_path: STRING_32


feature -- Operations

	managed_load (a_name: STRING_32; a_major, a_minor, a_build, a_revision: INTEGER)
		local
			str: STRING_32
		do
			str := search_on_path (a_name + ".dll")
			if str.is_empty then
				str := search_for_managed_file (a_name, a_major, a_minor, a_build, a_revision)
			end

		end


	search_on_path (a_name: STRING_32): STRING_32
		local
			l_dir: DIRECTORY
			l_path: STRING_32
			l_split: LIST [STRING_32]
			l_index: INTEGER
			l_name: STRING_32
			l_found: BOOLEAN
		do
			create Result.make_empty
			create l_dir.make_with_path (create {PATH}.make_current)
			if l_dir.has_entry (a_name) then
				Result := a_name
			else
					--TODO review this algorithm
				l_path := lib_path
				l_index := l_path.index_of (';', 1)
				from
					create {ARRAYED_LIST [STRING_32] }l_split.make (0)
					l_index := l_path.index_of (';', 1)
				until
					l_index = 0
				loop
					l_split.force (l_path.substring(1, l_index ))
					-- TODO double check
					-- the original code seems to be wrong.
					if l_index < l_path.count then
						l_path := l_path.substring (l_index, l_path.count)
					else
						l_path := ""
					end
					l_index := l_path.index_of(';',1)
				end

				if not l_path.is_empty then
					l_split.force(l_path)
				end

				across l_split as s until l_found loop
					l_name := s + {OPERATING_ENVIRONMENT}.directory_separator.out  + a_name
					if (create{FILE_UTILITIES}).file_exists(l_name) then
						l_found := True
						Result := l_name
					end
				end
			end
		end

	search_for_managed_file (a_name: STRING_32; a_major, a_minor, a_build, a_revision: INTEGER): STRING_32
		local
			l_windir: STRING_32
		do
			 -- TODO check this only works on windows.
			l_windir := {EXECUTION_ENVIRONMENT}.item ("windir")
			if attached l_windir then

			end
			create Result.make_empty
		end

feature -- Constants

	ERR_FILE_NOT_FOUND: INTEGER = 1
	ERR_NOT_PE: INTEGER = 2
	ERR_NOT_ASSEMBLY: INTEGER = 3
	ERR_INVALID_ASSEMBLY: INTEGER = 3
	ERR_UNKNOWN_TABLE: INTEGER = 5

end
