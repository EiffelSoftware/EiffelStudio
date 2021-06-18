note
	description: "Set of features to store/retrieve using all the various possibilities."
	date: "$Date$"
	revision: "$Revision$"

class
	SERIALIZATION_HELPER

inherit
	SED_STORABLE_FACILITIES

	STORABLE
		rename
			basic_store as c_basic_store,
			general_store as c_general_store,
			independent_store as c_independent_store,
			retrieved as c_retrieved
		end

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

				-- Discard pointers or not for the C mechanism.
			set_discard_pointers (not is_pointer_value_stored)

				-- 1- C Basic store
			create l_file.make_with_path (l_path.appended_with_extension (c_basic_extension))
			l_file.open_write
			l_file.basic_store (a_obj)
			l_file.close

				-- 2- C Independent store
			create l_file.make_with_path (l_path.appended_with_extension (c_independent_extension))
			l_file.open_write
			l_file.independent_store (a_obj)
			l_file.close

				-- 3- SED Session store
			create l_file.make_with_path (l_path.appended_with_extension (sed_session_extension))
			l_file.open_write
			create l_writer.make_for_writing (l_file)
			l_writer.set_is_pointer_value_stored (is_pointer_value_stored)
			session_store (a_obj, l_writer, True)
			l_file.close

				-- 4- SED Basic store
			create l_file.make_with_path (l_path.appended_with_extension (sed_basic_extension))
			l_file.open_write
			create l_writer.make_for_writing (l_file)
			l_writer.set_is_pointer_value_stored (is_pointer_value_stored)
			basic_store (a_obj, l_writer, True)
			l_file.close

				-- 5- SED Recoverable store
			create l_file.make_with_path (l_path.appended_with_extension (sed_recoverable_extension))
			l_file.open_write
			create l_writer.make_for_writing (l_file)
			l_writer.set_is_pointer_value_stored (is_pointer_value_stored)
			store (a_obj, l_writer)
			l_file.close
		end

	retrieved_objects (a_file_name: STRING): HASH_TABLE [ANY, STRING]
			-- Using `a_file_name' tries all the possible serialization mechanisms
			-- and associate the retrieved object with the type of serialization.
		do
			Result := retrieved_objects_ex (a_file_name, True)
		end

	retrieved_objects_ex (a_file_name: STRING; a_append_extension: BOOLEAN): HASH_TABLE [ANY, STRING]
			-- Using `a_file_name' tries all the possible serialization mechanisms
			-- and associate the retrieved object with the type of serialization.
		local
			l_reader: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
			l_path: PATH
			l_obj: detachable ANY
		do
			create Result.make (7)
			create l_path.make_from_string (a_file_name)

			across c_storable_types as l_type loop
				if a_append_extension then
					create l_file.make_with_path (l_path.appended_with_extension (l_type))
				else
					create l_file.make_with_path (l_path)
				end
				if l_file.exists then
					l_file.open_read
					l_obj := safe_c_retrieved (l_file)
					if l_obj /= Void then
						Result.put (l_obj, l_type)
					end
					l_file.close
				end
			end

			across sed_storable_types as l_type loop
				if a_append_extension then
					create l_file.make_with_path (l_path.appended_with_extension (l_type))
				else
					create l_file.make_with_path (l_path)
				end
				if l_file.exists then
					l_file.open_read
					create l_reader.make_for_reading (l_file)
					retrieved_errors := Void
					l_obj := safe_sed_retrieved (l_reader, True)
					if l_obj /= Void then
						Result.put (l_obj, l_type)
					end
					l_file.close
				end
			end
		end

	retrieved_recoverable_objects (a_file_name: STRING): HASH_TABLE [ANY, STRING]
			-- Using `a_file_name' tries all the possible serialization mechanisms
			-- that supports recovarability features and associate the retrieved
			-- object with the type of serialization.
		local
			l_reader: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
			l_path: PATH
			l_obj: detachable ANY
		do
			create Result.make (2)
			create l_path.make_from_string (a_file_name)

			create l_file.make_with_path (l_path.appended_with_extension (c_independent_extension))
			if l_file.exists then
				l_file.open_read
				l_obj := safe_c_retrieved (l_file)
				if l_obj /= Void then
					Result.put (l_obj, c_independent_extension)
				end
				l_file.close
			end

			create l_file.make_with_path (l_path.appended_with_extension (sed_recoverable_extension))
			if l_file.exists then
				l_file.open_read
				create l_reader.make_for_reading (l_file)
				retrieved_errors := Void
				l_obj := safe_sed_retrieved (l_reader, True)
				if l_obj /= Void then
					Result.put (l_obj, sed_recoverable_extension)
				end
				l_file.close
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

	recoverable_types: ARRAYED_LIST [STRING]
			-- List of all possible serializations
		once
			create Result.make (10)
			Result.extend (c_independent_extension)
			Result.extend (sed_recoverable_extension)
		end

	is_pointer_value_stored: BOOLEAN
			-- Is value of a POINTER stored?

	is_safe_retrieval: BOOLEAN
			-- Is retrieval protected with rescue clauses?

feature -- Settings

	set_is_pointer_value_stored (v: like is_pointer_value_stored)
			-- Set `is_pointer_value_stored' with `v'.
		do
			is_pointer_value_stored := v
		ensure
			is_pointer_value_stored_set: is_pointer_value_stored = v
		end

	set_is_safe_retrieval (v: like is_safe_retrieval)
			-- Set `is_safe_retrieval' with `v'.
		do
			is_safe_retrieval := v
		ensure
			is_safe_retrieval_set: is_safe_retrieval = v
		end

feature -- C serializations

	c_basic_extension: STRING = "c_basic"
	c_independent_extension: STRING = "c_independent"
	c_storable_types: ARRAYED_LIST [STRING]
			-- List of C serializations
		once
			create Result.make (3)
			Result.extend (c_basic_extension)
			Result.extend (c_independent_extension)
		end

	safe_c_retrieved (a_file: RAW_FILE): detachable ANY
			-- Ensure C retrieval without a crash if `is_safe_retrieval' is enabled.
		require
			a_file_is_open_read: a_file.is_open_read
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := a_file.retrieved
			end
		rescue
			if is_safe_retrieval then
				retried := True
				retry
			end
		end

	safe_sed_retrieved (a_reader: SED_READER_WRITER; a_is_gc_enabled: BOOLEAN): detachable ANY
			-- Ensure SED retrieval without a crash if `is_safe_retrieval' is enabled.
		require
			a_file_is_open_read: a_reader.is_ready_for_reading
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := retrieved (a_reader, a_is_gc_enabled)
			end
		rescue
			if is_safe_retrieval then
				retried := True
				retry
			end
		end

feature -- SED serializations

	sed_session_extension: STRING = "sed_session"
	sed_basic_extension: STRING = "sed_basic"
	sed_recoverable_extension: STRING = "sed_recoverable"
	sed_storable_types: ARRAYED_LIST [STRING]
			-- List of SED serializations
		once
			create Result.make (3)
			Result.extend (sed_session_extension)
			Result.extend (sed_basic_extension)
			Result.extend (sed_recoverable_extension)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
