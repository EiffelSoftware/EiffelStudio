note
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

	put_indexing_keyword
			-- Put "indexing" or "note" keyword depending on configuration.
		require
			stream_valid: is_writing
		local
			l_universe: UNIVERSE_I
			l_target: CONF_TARGET
		do
			l_target := (create {SHARED_EIFFEL_PROJECT}).eiffel_universe.target
			if l_target /= Void and then l_target.options.syntax_level.item = {CONF_OPTION}.syntax_level_obsolete then
					-- Use old syntax
				stream.put_line ({EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword)
			else
					-- Use new syntax
				stream.put_line ({EIFFEL_KEYWORD_CONSTANTS}.note_keyword)
			end
		end

	put_indexing
			-- Append indexing clause.
		require
			stream_valid: is_writing
		do
			put_indexing_keyword
			stream.indent
			stream.put_line ("description: %"Testing tool internal root class%"")
			stream.put_line ("author: %"Testing tool%"")
			stream.dedent
			stream.put_line ("")
		end

	put_class_header
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

	put_class_footer
			-- Append class footer
		require
			stream_valid: is_writing
		do
			stream.put_line ("end")
			stream.put_line ("")
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
