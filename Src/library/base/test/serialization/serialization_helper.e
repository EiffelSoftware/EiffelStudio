note
	description: "Set of features to store/retrieve using all the various possibilities."
	date: "$Date$"
	revision: "$Revision$"

class
	SERIALIZATION_HELPER

inherit
	SED_STORABLE_FACILITIES

feature -- Operations

	store_object (a_obj: ANY; a_file_name: STRING)
			-- Store `an_obj' in `a_file_name' using all possible kind of Eiffel serialization
			-- mechanisms. For each kind of storable mechanism the stored file is `a_file_name.storable_type'
			-- where `storable_type' is one of the `storable_types'.
		require
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_writer: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
			l_path: PATH
		do
			create l_path.make_from_string (a_file_name)

				-- 1- C Basic store
			create l_file.make_with_path (l_path.appended_with_extension (c_basic_extension))
			l_file.open_write
			l_file.basic_store (a_obj)
			l_file.close

				-- 2- C General store
			create l_file.make_with_path (l_path.appended_with_extension (c_general_extension))
			l_file.open_write
			l_file.general_store (a_obj)
			l_file.close

				-- 3- C Independent store
			create l_file.make_with_path (l_path.appended_with_extension (c_independent_extension))
			l_file.open_write
			l_file.general_store (a_obj)
			l_file.close

				-- 4- SED Session store
			create l_file.make_with_path (l_path.appended_with_extension (sed_session_extension))
			l_file.open_write
			create l_writer.make_for_writing (l_file)
			session_store (a_obj, l_writer, True)
			l_file.close

				-- 5- SED Basic store
			create l_file.make_with_path (l_path.appended_with_extension (sed_basic_extension))
			l_file.open_write
			create l_writer.make_for_writing (l_file)
			basic_store (a_obj, l_writer, True)
			l_file.close

				-- 6- SED Independent store
			create l_file.make_with_path (l_path.appended_with_extension (sed_independent_extension))
			l_file.open_write
			create l_writer.make_for_writing (l_file)
			sed_independent_store (a_obj, l_writer)
			l_file.close

				-- 7- SED Recoverable store
			create l_file.make_with_path (l_path.appended_with_extension (sed_recoverable_extension))
			l_file.open_write
			create l_writer.make_for_writing (l_file)
			store (a_obj, l_writer)
			l_file.close
		end

	retrieve_object (a_file_name: STRING): HASH_TABLE [detachable ANY, STRING]
			-- Using `a_file_name' tries all the possible serialization mechanisms
			-- and associate the retrieved object with the type of serialization.
		local
			l_reader: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
			l_path: PATH
		do
			create Result.make (7)
			create l_path.make_from_string (a_file_name)

			across c_storable_types as l_type loop
				create l_file.make_with_path (l_path.appended_with_extension (l_type.item))
				if l_file.exists then
					l_file.open_read
					Result.put (l_file.retrieved, l_type.item)
					l_file.close
				end
			end

			across sed_storable_types as l_type loop
				create l_file.make_with_path (l_path.appended_with_extension (l_type.item))
				if l_file.exists then
					l_file.open_read
					create l_reader.make_for_reading (l_file)
					Result.put (retrieved (l_reader, True), l_type.item)
					l_file.close
				end
			end
		end

feature -- Access

	storable_types: ARRAYED_LIST [STRING]
			-- List of all possible serializations
		once
			create Result.make (10)
			Result.append (c_storable_types)
			Result.append (sed_storable_types)
		end

feature -- C serializations

	c_basic_extension: STRING = "c_basic"
	c_general_extension: STRING = "c_general"
	c_independent_extension: STRING = "c_independent"
	c_storable_types: ARRAYED_LIST [STRING]
			-- List of C serializations
		once
			create Result.make (3)
			Result.extend (c_basic_extension)
			Result.extend (c_general_extension)
			Result.extend (c_independent_extension)
		end

feature -- SED serializations

	sed_session_extension: STRING = "sed_session"
	sed_basic_extension: STRING = "sed_basic"
	sed_independent_extension: STRING = "sed_independent"
	sed_recoverable_extension: STRING = "sed_recoverable"
	sed_storable_types: ARRAYED_LIST [STRING]
			-- List of SED serializations
		once
			create Result.make (3)
			Result.extend (sed_session_extension)
			Result.extend (sed_basic_extension)
			Result.extend (sed_independent_extension)
			Result.extend (sed_recoverable_extension)
		end

feature {NONE} -- Implementation

	sed_independent_store (an_object: ANY; a_writer: SED_READER_WRITER)
			-- Serialization of `an_object' using `a_writer' in the independent format.
			-- Object stored can only be retrieved by programs having the same set of types.
		require
			an_object_not_void: an_object /= Void
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		local
			l_serializer: SED_INDEPENDENT_SERIALIZER
		do
			l_serializer := independent_serializer (a_writer)
			a_writer.write_header
			a_writer.write_natural_32 (eiffel_independent_store)
			l_serializer.set_root_object (an_object)
			l_serializer.encode
			a_writer.write_footer
		end

end
