class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests compilation and extraction of embedded peripheral resources
		local
			l_stream: SYSTEM_STREAM
			l_buffer: NATIVE_ARRAY [CHARACTER_8]
			l_read: INTEGER
			l_reader: STREAM_READER
			retried: BOOLEAN
		do
			if not retried then
				l_stream := ({TEST}).to_cil.assembly.get_manifest_resource_stream ("document.dat")
				if l_stream /= Void then
					create l_buffer.make (l_stream.length.to_integer_32)
					create l_reader.make (l_stream)
					l_read := l_reader.read (l_buffer, 0, l_stream.length.to_integer_32)
					if l_read > 0 then
						print (create {SYSTEM_STRING}.make (l_buffer, 0, l_read))
						print ("%N")
					end
				end
			else
				print ({ISE_RUNTIME}.last_exception.message)
			end
		rescue
			retried := True
			retry
		end

end
