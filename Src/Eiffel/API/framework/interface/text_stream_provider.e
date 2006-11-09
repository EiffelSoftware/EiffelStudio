indexing
	description: "[
		Provides access to text streams used for compiler output.
		
		If a compiler package wants to provide and extend the available streams be sure to add a type stream
		identifier (`my_type_stream_type') and redefine `is_known_stream' to ensure the runtime instance is 
		aware of the custom type stream type.
		
		If is then the reponsibility of the descendent to return a specialized {TEXT_STREAM} from `create_stream' base
		on the `my_type_stream_type' id, when requested.
		
		Note: There should always be at least two output streams `output_stream_type' and `error_stream_type'.
		Descendents are responsibile for creating the stream in `create_stream' when requested. The `output_stream_type'
		referes to general output where as `error_stream_type' is used for all erronous output.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	TEXT_STREAM_PROVIDER

feature -- Query

	typed_stream (a_type: UUID): TEXT_STREAM is
			-- Retrieve a text stream for a given text stream type.
		require
			is_known_stream: is_known_stream (a_type)
		local
			l_table: like stream_table
		do
			l_table := stream_table
			if l_table.has (a_type) then
				Result := l_table [a_type]
			else
				Result := create_stream (a_type)
				l_table.put (Result, a_type)
			end
		ensure
			result_attached: Result /= Void
			stream_table_has_a_type: stream_table.has (a_type)
		end

feature -- Query

	is_known_stream (a_type: UUID): BOOLEAN is
			-- Determines if `a_type' is a known type of text stream
		do
			Result := (a_type = output_stream_type) or (a_type = error_stream_type)
		end

feature {NONE} -- Factory

	create_stream (a_type: UUID): TEXT_STREAM is
			-- Creates a new text stream given a text stream type `a_type'
		require
			is_known_stream: is_known_stream (a_type)
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Steam types

	output_stream_type: UUID is
			-- UUID of output text stream
		once
				-- Use static UUIDs. It's not necessary but it is consistent.
			create Result.make_from_string ("FEEAB479-07A9-425A-A831-A8D15BBF5B99")
		ensure
			result_attached: Result /= Void
		end

	error_stream_type: UUID is
			-- UUID of error stream
		once
				-- Use static UUIDs. It's not necessary but it is consistent.
			create Result.make_from_string ("BDC9506F-0AB4-4F4D-95A6-B1664B8B030E")
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	stream_table: HASH_TABLE [TEXT_STREAM, UUID] is
			-- Table of text streams indexed by a unique UUID
			-- Key: UUID
			-- Value: A TEXT_STREAM
		do
			Result := internal_stream_table
			if Result = Void then
				create Result.make (3)
				internal_stream_table := Result
			end
		ensure
			result_attached: Result /= Void
			internal_stream_table_set: internal_stream_table = Result
		end

feature {NONE} -- Internal implementation cache

	internal_stream_table: HASH_TABLE [TEXT_STREAM, UUID]
			-- Table of text streams indexed by a unique UUID
			-- Key: UUID
			-- Value: A TEXT_STREAM

;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {TEXT_STREAM_PROVIDER}
