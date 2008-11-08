indexing
	description: "[
		Objects that write class text to file.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CLASS_SOURCE_WRITER

feature -- Access

	class_name: !STRING
			-- Name of class
		deferred
		end

	ancestor_names: !ARRAY [!STRING]
			-- Name of ancestor classes
		do
			Result := << >>
		end

	root_feature_name: !STRING
			-- Name for root feature
		deferred
		end

feature {NONE} -- Access

	stream: ?TEST_INDENTING_SOURCE_WRITER

feature -- Status report

	is_writing: BOOLEAN
			-- Is `stream' attached and writable?
		do
			Result := stream /= Void and then stream.is_open_write
		ensure
			result_implies_attached: Result implies stream /= Void
			result_implies_open_write: Result implies stream.is_open_write
		end

feature {NONE} -- Output

	put_indexing is
			-- Append indexing clause.
		require
			stream_valid: is_writing
		do
			stream.put_line ("indexing%N")
			stream.indent
			stream.put_line ("description: %"Testing tool internal root class%"")
			stream.put_line ("author: %"Testing tool%"")
			stream.dedent
			stream.put_line ("")
		end

	put_class_header is
			-- Append cdd interpreter class header.
		require
			stream_valid: is_writing
		local
			l_ancs: ARRAY [!STRING]
			l_root: ?STRING
			i: INTEGER
		do
			stream.put_line ("class")
			stream.indent
			stream.put_line (class_name)
			stream.put_line ("")
			stream.dedent

			l_ancs := ancestor_names
			if not l_ancs.is_empty then
				stream.put_line ("inherit")
				from
					i := l_ancs.lower
				until
					i > l_ancs.upper
				loop
					stream.indent
					stream.put_line (l_ancs.item (i))
					stream.dedent
					stream.put_line ("")
					i := i + 1
				end
			end

			l_root := root_feature_name
			if not l_root.is_empty then
				stream.put_line ("create")
				stream.indent
				stream.put_line (l_root)
				stream.dedent
				stream.put_line ("")
				stream.put_line ("feature {NONE} -- Initialization")
				stream.put_line ("")
			else
				stream.put_line ("feature -- Test routines")
				stream.put_line ("")
			end
		end

	put_class_footer is
			-- Append class footer
		require
			stream_valid: is_writing
		do
			stream.put_line ("end")
			stream.put_line ("")
		end

end
