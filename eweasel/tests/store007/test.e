indexing
	description: "System's root class"
--	assembly_metadata: create {DEBUGGABLE_ATTRIBUTE}.make (True, True) end

class
	TEST

create
	make, default_create

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_obj: ANY
			l_mem: MEMORY
		do
			create l_mem
			l_obj := (create {STORABLE_TEST}.make)

				-- Eiffel versions
			l_mem.collect
			l_mem.full_collect
			l_mem.full_coalesce
			store_new_session (l_obj)

			l_mem.collect
			l_mem.full_collect
			l_mem.full_coalesce
			store_new_basic (l_obj)

			l_mem.collect
			l_mem.full_collect
			l_mem.full_coalesce
			store_new_independent (l_obj)

				-- C versions
			l_mem.collect
			l_mem.full_collect
			l_mem.full_coalesce
			store_old_basic (l_obj)

			l_mem.collect
			l_mem.full_collect
			l_mem.full_coalesce
			store_old_independent (l_obj)
		end

feature -- Access

	is_gc_enabled: BOOLEAN is False
		-- Is GC enabled for retrieving?

	is_for_fast_retrieval: BOOLEAN is True
		-- Is data stored in an optimized way for retrieval?

feature {NONE} -- Implementation

	store_new_session (an_object: ANY) is
			-- Store using new storable mechanism.
		local
			l_serializer: SED_STORABLE_FACILITIES
			l_med: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
			l_obj: ANY
			date1, date2: DATE_TIME
		do
			create l_serializer

			if {PLATFORM}.is_dotnet then
				create l_file.make ("output.session.dotnet.data")
			else
				create l_file.make ("output.session.data")
			end
			create l_med.make (l_file)

			l_file.open_write
			l_med.set_is_pointer_value_stored (True)
			l_med.set_for_writing
			create date1.make_now
			l_serializer.session_store (an_object, l_med, is_for_fast_retrieval)
			create date2.make_now
			l_file.close
			print ("New session storing time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			l_file.open_read
			l_med.set_for_reading
			create date1.make_now
			l_obj := l_serializer.retrieved (l_med, is_gc_enabled)
			create date2.make_now
			l_file.close
			print ("New session retrieving time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			check
				deep_equal (an_object, l_obj)
			end
		end

	store_new_basic (an_object: ANY) is
			-- Store using new storable mechanism.
		local
			l_serializer: SED_STORABLE_FACILITIES
			l_med: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
			l_obj: ANY
			date1, date2: DATE_TIME
		do
			create l_serializer

			if {PLATFORM}.is_dotnet then
				create l_file.make ("output.basic.dotnet.data")
			else
				create l_file.make ("output.basic.data")
			end
			create l_med.make (l_file)

			l_file.open_write
			l_med.set_is_pointer_value_stored (True)
			l_med.set_for_writing
			create date1.make_now
			l_serializer.basic_store (an_object, l_med, is_for_fast_retrieval)
			create date2.make_now
			l_file.close
			print ("New basic storing time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			l_file.open_read
			l_med.set_for_reading
			create date1.make_now
			l_obj := l_serializer.retrieved (l_med, is_gc_enabled)
			create date2.make_now
			l_file.close
			print ("New basic retrieving time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			check
				deep_equal (an_object, l_obj)
			end
		end

	store_new_independent (an_object: ANY) is
			-- Store using new storable mechanism.
		local
			l_serializer: SED_STORABLE_FACILITIES
			l_med: SED_MEDIUM_READER_WRITER
			l_file: RAW_FILE
			l_obj: ANY
			date1, date2: DATE_TIME
		do
			create l_serializer

			if {PLATFORM}.is_dotnet then
				create l_file.make ("output.independent.dotnet.data")
			else
				create l_file.make ("output.independent.data")
			end
			create l_med.make (l_file)

			l_file.open_write
			l_med.set_is_pointer_value_stored (True)
			l_med.set_for_writing
			create date1.make_now
			l_serializer.store (an_object, l_med)
			create date2.make_now
			l_file.close
			print ("New independent storing time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			l_file.open_read
			l_med.set_for_reading
			create date1.make_now
			l_obj := l_serializer.retrieved (l_med, is_gc_enabled)
			create date2.make_now
			l_file.close
			print ("New independent retrieving time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			check
				equal: deep_equal (an_object, l_obj)
			end
		end

	store_old_basic (an_object: ANY) is
			-- Store using old storable mechanism.
		local
			l_file: RAW_FILE
			l_obj: ANY
			date1, date2: DATE_TIME
		do
			if {PLATFORM}.is_dotnet then
				create l_file.make ("output.basic.old.dotnet.data")
			else
				create l_file.make ("output.basic.old.data")
			end

			l_file.open_write
			create date1.make_now
			l_file.basic_store (an_object)
			create date2.make_now
			l_file.close
			print ("Old basic storing time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			l_file.open_read
			create date1.make_now
			l_obj := l_file.retrieved
			create date2.make_now
			l_file.close
			print ("Old basic retrieving time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			check
				deep_equal (an_object, l_obj)
			end
		end

	store_old_independent (an_object: ANY) is
			-- Store using old storable mechanism.
		local
			l_file: RAW_FILE
			l_obj: ANY
			date1, date2: DATE_TIME
			l_storable: STORABLE
		do
			if {PLATFORM}.is_dotnet then
				create l_file.make ("output.independent.old.dotnet.data")
			else
				create l_storable
				l_storable.set_discard_pointers (False)
				create l_file.make ("output.independent.old.data")
			end

			l_file.open_write
			create date1.make_now
			l_file.independent_store (an_object)
			create date2.make_now
			l_file.close
			print ("Old independent storing time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			l_file.open_read
			create date1.make_now
			l_obj := l_file.retrieved
			create date2.make_now
			l_file.close
			print ("Old independent retrieving time: " + date2.relative_duration (date1).fine_seconds_count.out + "%N")

			check
				deep_equal (an_object, l_obj)
			end
		end

end
