indexing
	description: "Serialize Codedom passed as argument to be reused in tests"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_DOTNET_SERIALIZER

inherit
	ECDS_SHARED_SETTINGS
		export
			{NONE} all
		end

feature -- Basic Operations

	serialize (a_graph: SYSTEM_OBJECT) is
			-- Serialize object graph `a_graph'.
		require
			non_void_graph: a_graph /= Void
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
			l_file_name, l_name, l_root, l_extension: STRING
			l_index, i: INTEGER
			l_exists: BOOLEAN
		do
			l_file_name := serialized_tree_location
			l_index := l_file_name.last_index_of ('.', l_file_name.count)
			if l_index > 0 then
				l_root := l_file_name.substring (1, l_index - 1)
				l_extension := l_file_name.substring (l_index, l_file_name.count)
			else
				l_root := l_file_name.twin
				l_extension := ""
			end
			from
				l_exists := (create {RAW_FILE}.make (l_file_name)).exists
				i := 1
			until
				not l_exists
			loop
				i := i + 1
				l_file_name := l_root + "_" + i.out + l_extension
				l_exists := (create {RAW_FILE}.make (l_file_name)).exists
			end
			create l_stream.make (l_file_name, {FILE_MODE}.Create_)
			create l_formatter.make
			l_formatter.serialize (l_stream, a_graph)
			l_stream.close
		end

end -- class ECDS_DOTNET_SERIALIZER
