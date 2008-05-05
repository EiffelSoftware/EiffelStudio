indexing
	description: "Serialize and deserialize objects to and from SED_READER_WRITER instances."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_STORABLE_FACILITIES

feature -- Serialization routines

	session_store (an_object: ANY; a_writer: SED_READER_WRITER; a_optimized_for_retrieval: BOOLEAN) is
			-- Serialization of `an_object' using `a_writer' optimized for retrieval
			-- if `a_optimized_for_retrieval'.
			-- Object stored can only be retrieved during current program execution.
		require
			an_object_not_void: an_object /= Void
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		local
			l_serializer: SED_SESSION_SERIALIZER
		do
			l_serializer := session_serializer (a_writer)
			l_serializer.set_is_for_fast_retrieval (a_optimized_for_retrieval)
			a_writer.write_header
			a_writer.write_natural_32 (eiffel_session_store)
			l_serializer.set_root_object (an_object)
			l_serializer.encode
			a_writer.write_footer
		end

	basic_store (an_object: ANY; a_writer: SED_READER_WRITER; a_optimized_for_retrieval: BOOLEAN) is
			-- Serialization of `an_object' using `a_writer' optimized for retrieval
			-- if `a_optimized_for_retrieval'.
			-- Object stored can only be retrieved by execution of same program executable.
		require
			an_object_not_void: an_object /= Void
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		local
			l_serializer: SED_BASIC_SERIALIZER
		do
			l_serializer := basic_serializer (a_writer)
			l_serializer.set_is_for_fast_retrieval (a_optimized_for_retrieval)
			a_writer.write_header
			a_writer.write_natural_32 (eiffel_basic_store)
			l_serializer.set_root_object (an_object)
			l_serializer.encode
			a_writer.write_footer
		end

	independent_store (an_object: ANY; a_writer: SED_READER_WRITER; a_optimized_for_retrieval: BOOLEAN) is
			-- Serialization of `an_object' using `a_writer' optimized for retrieval
			-- if `a_optimized_for_retrieval'.
			-- Object stored can only be retrieved by programs having the same set of types.
		require
			an_object_not_void: an_object /= Void
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		local
			l_serializer: SED_INDEPENDENT_SERIALIZER
		do
			l_serializer := independent_serializer (a_writer)
			l_serializer.set_is_for_fast_retrieval (a_optimized_for_retrieval)
			a_writer.write_header
			a_writer.write_natural_32 (eiffel_independent_store)
			l_serializer.set_root_object (an_object)
			l_serializer.encode
			a_writer.write_footer
		end

	retrieved (a_reader: SED_READER_WRITER; a_is_gc_enabled: BOOLEAN): ?ANY is
			-- Deserialization of object from `a_reader'.
			-- Garbage collection will be enabled if `a_is_gc_enabled'.
		require
			a_reader_not_void: a_reader /= Void
			a_reader_ready: a_reader.is_ready_for_reading
		local
			l_deserializer: ?SED_SESSION_DESERIALIZER
		do
			a_reader.read_header
			inspect
				a_reader.read_natural_32
			when eiffel_session_store then l_deserializer := session_deserializer (a_reader)
			when eiffel_basic_store then l_deserializer := basic_deserializer (a_reader)
			when eiffel_independent_store then l_deserializer := independent_deserializer (a_reader)
			else
				-- Incorrect type
			end

			if l_deserializer /= Void then
				l_deserializer.decode (a_is_gc_enabled)
				if not l_deserializer.has_error then
					Result := l_deserializer.last_decoded_object
					a_reader.read_footer
				end
			end
		end

feature -- Storable type

	eiffel_session_store: NATURAL_32 is 0x00000001
	eiffel_basic_store: NATURAL_32 is 0x00000002
	eiffel_independent_store: NATURAL_32 is 0x00000003
			-- Various type of storable mechanism.

feature {NONE} -- Access

	session_deserializer (a_reader: SED_READER_WRITER): SED_SESSION_DESERIALIZER is
			-- New instance of `session' based on `a_reader'.
		require
			a_reader_not_void: a_reader /= Void
			a_reader_ready: a_reader.is_ready_for_reading
		do
			Result := internal_session_deserializer (a_reader)
			Result.set_deserializer (a_reader)
		ensure
			session_deserializer_not_void: Result /= Void
		end

	basic_deserializer (a_reader: SED_READER_WRITER): SED_BASIC_DESERIALIZER is
			-- New instance of `session' based on `a_reader'.
		require
			a_reader_not_void: a_reader /= Void
			a_reader_ready: a_reader.is_ready_for_reading
		do
			Result := internal_basic_deserializer (a_reader)
			Result.set_deserializer (a_reader)
		ensure
			basic_deserializer_not_void: Result /= Void
		end

	independent_deserializer (a_reader: SED_READER_WRITER): SED_INDEPENDENT_DESERIALIZER is
			-- New instance of `session' based on `a_reader'.
		require
			a_reader_not_void: a_reader /= Void
			a_reader_ready: a_reader.is_ready_for_reading
		do
			Result := internal_independent_deserializer (a_reader)
			Result.set_deserializer (a_reader)
		ensure
			independent_deserializer_not_void: Result /= Void
		end

	session_serializer (a_writer: SED_READER_WRITER): SED_SESSION_SERIALIZER is
			-- New instance of `session' based on `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		do
			Result := internal_session_serializer (a_writer)
			Result.set_serializer (a_writer)
		ensure
			session_serializer_not_void: Result /= Void
		end

	basic_serializer (a_writer: SED_READER_WRITER): SED_BASIC_SERIALIZER is
			-- New instance of `session' based on `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		do
			Result := internal_basic_serializer (a_writer)
			Result.set_serializer (a_writer)
		ensure
			basic_serializer_not_void: Result /= Void
		end

	independent_serializer (a_writer: SED_READER_WRITER): SED_INDEPENDENT_SERIALIZER is
			-- New instance of `session' based on `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		do
			Result := internal_independent_serializer (a_writer)
			Result.set_serializer (a_writer)
		ensure
			independent_serializer_not_void: Result /= Void
		end

feature {NONE} -- Data

	internal_session_deserializer (a_reader: SED_READER_WRITER): SED_SESSION_DESERIALIZER is
			-- New instance of `session' based on `a_reader'.
		require
			a_reader_not_void: a_reader /= Void
			a_reader_ready: a_reader.is_ready_for_reading
		once
			create Result.make (a_reader)
		ensure
			session_deserializer_not_void: Result /= Void
		end

	internal_basic_deserializer (a_reader: SED_READER_WRITER): SED_BASIC_DESERIALIZER is
			-- New instance of `session' based on `a_reader'.
		require
			a_reader_not_void: a_reader /= Void
			a_reader_ready: a_reader.is_ready_for_reading
		once
			create Result.make (a_reader)
		ensure
			basic_deserializer_not_void: Result /= Void
		end

	internal_independent_deserializer (a_reader: SED_READER_WRITER): SED_INDEPENDENT_DESERIALIZER is
			-- New instance of `session' based on `a_reader'.
		require
			a_reader_not_void: a_reader /= Void
			a_reader_ready: a_reader.is_ready_for_reading
		once
			create Result.make (a_reader)
		ensure
			independent_deserializer_not_void: Result /= Void
		end

	internal_session_serializer (a_writer: SED_READER_WRITER): SED_SESSION_SERIALIZER is
			-- New instance of `session' based on `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		once
			create Result.make (a_writer)
		ensure
			session_serializer_not_void: Result /= Void
		end

	internal_basic_serializer (a_writer: SED_READER_WRITER): SED_BASIC_SERIALIZER is
			-- New instance of `session' based on `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		once
			create Result.make (a_writer)
		ensure
			basic_serializer_not_void: Result /= Void
		end

	internal_independent_serializer (a_writer: SED_READER_WRITER): SED_INDEPENDENT_SERIALIZER is
			-- New instance of `session' based on `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_writer_ready: a_writer.is_ready_for_writing
		once
			create Result.make (a_writer)
		ensure
			independent_serializer_not_void: Result /= Void
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
