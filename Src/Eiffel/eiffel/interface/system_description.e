note
	description: "All the information about the system"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SYSTEM_DESCRIPTION

inherit
	PROJECT_CONTEXT

	SHARED_COMPILATION_MODES

	SHARED_ENCODING_CONVERTER

feature -- Access

	name: STRING
			-- System name

	c_file_names: LIST [STRING];
			-- C file names to include

	assembly_names: LIST [STRING]
			-- Assembly names needed by IL generation to find types

	has_cpp_externals: BOOLEAN
			-- Did system included a C++ external at some point.

	debug_clauses_32: SEARCH_TABLE [STRING_32]
			-- List of all debug clauses in Eiffel code.
		do
			if attached debug_clauses as l_clauses then
				create Result.make (l_clauses.count)
				from
					l_clauses.start
				until
					l_clauses.after
				loop
					Result.force (encoding_converter.utf8_to_utf32 (l_clauses.item_for_iteration))
					l_clauses.forth
				end
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	debug_clauses: SEARCH_TABLE [STRING]
			-- List of all debug clauses in Eiffel code.

feature -- Access for precompilation configuration

	compilation_id: INTEGER
			-- Precompilation identifier

	is_precompiled: BOOLEAN;
			-- Is the Current system from a precompilation?

	uses_precompiled: BOOLEAN;
			-- Does current system use a precompiled library?

	has_precompiled_preobj: BOOLEAN;
			-- Does a `preobj' file exist for the current precompiled project?
			-- This file might not exist as a result of merging precompilations

feature -- Update

	set_name (s: STRING)
			-- Assign `s' to `system_name'.
		do
			name := s
		end

	set_c_file_names (l: like c_file_names)
			-- Assign `l' to `c_file_names'.
		do
			c_file_names := l
		end

	set_assembly_names (l: like assembly_names)
			-- Assign `l' to `assembly_names'.
		do
			assembly_names := l
		ensure
			assembly_names_set: assembly_names = l
		end

	set_has_cpp_externals (v: BOOLEAN)
			-- Set `has_cpp_externals' to `v'.
		require
			only_true: v
		do
			has_cpp_externals := v
		ensure
			has_cpp_externals_set: has_cpp_externals = v
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Update

	add_new_debug_clause (a_text_formatter: STRING)
			-- Add `a_text_formatter' to list of existing debug clauses.
		require
			st_not_void: a_text_formatter /= Void
		do
			if debug_clauses = Void then
				create debug_clauses.make (10)
			end
			debug_clauses.put (a_text_formatter)
		ensure
			extended: debug_clauses.has (a_text_formatter)
		end

feature -- Update for the precompilation

	set_compilation_id (i: INTEGER)
			-- Set `compilation_id' value.
		do
			compilation_id := i
		ensure
			compilation_id_set: compilation_id = i
		end

	set_precompilation (b: BOOLEAN)
		do
			is_precompiled := b
		end

	set_has_precompiled_preobj (b: BOOLEAN)
			-- Set `has_precompiled_preobj' to `b'.
		do
			has_precompiled_preobj := b
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class SYSTEM_DESCRIPTION
