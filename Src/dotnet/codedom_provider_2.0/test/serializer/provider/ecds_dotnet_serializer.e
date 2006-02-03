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
			l_file_name, l_name: STRING
			l_index: INTEGER
		do
			l_file_name := serialized_tree_location
			increment_counter
			if counter > 1 then
				l_index := l_file_name.last_index_of ('.', l_file_name.count)
				if l_index > 0 then
					l_name := l_file_name.substring (1, l_index - 1)
					l_name.append ("_")
					l_name.append (counter.out)
					l_name.append (l_file_name.substring (l_index, l_file_name.count))
					l_file_name := l_name
				else
					l_file_name.append ("_")
					l_file_name.append (counter.out)
				end
			end
			create l_stream.make (l_file_name, {FILE_MODE}.Create_)
			create l_formatter.make
			l_formatter.serialize (l_stream, a_graph)
			l_stream.close
		end

feature {NONE} -- Implementation

	counter: INTEGER is
			-- Counter to change file name 
		do
			Result := internal_counter.item
		end
	
	increment_counter is
			-- Increment `counter' by 1.
		do
			internal_counter.set_item (counter + 1)
		end

	internal_counter: INTEGER_REF is
			-- Counter to change file name 
		once
			create Result
		end

end -- class ECDS_DOTNET_SERIALIZER