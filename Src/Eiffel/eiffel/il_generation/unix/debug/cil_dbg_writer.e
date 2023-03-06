note
	description: "[
		Encapsulation of ISymUnmanagedWriter COM interface to create PDB
		files for CLI images.
		Mock interface.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_DBG_WRITER

inherit

	REFACTORING_HELPER
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (emitter: CIL_MD_METADATA_EMIT; name: STRING_32; full_build: BOOLEAN)
			-- Create a new SymUnmanagedWriter object using `emitter' in a file `name'.
		do
			to_implement ("TODO add implementation")
		end

feature -- Update

	close
			-- Stop all processing on current.
		do
			to_implement ("TODO add implementation")
		end

	close_method
			-- Close current method.
		do
			to_implement ("TODO add implementation")
		end

	open_method (a_meth_token: INTEGER)
			-- Open method `a_meth_token'.
		do
			to_implement ("TODO add implementation")
		end

	open_scope (start_offset: INTEGER)
			-- Create a new scope for defining local variables.
		do
			to_implement ("TODO add implementation")
		end

	close_scope (end_offset: INTEGER)
			-- Close most recently opened scope.
		do
			to_implement ("TODO add implementation")
		end

feature -- PE file data

	debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY): MANAGED_POINTER
			-- Retrieve debug info required to be inserted in PE file.

		do
			to_implement ("TODO add implementation")
		end

feature -- Status report

	is_closed: BOOLEAN
			-- Can further operation be applied on Current?

	is_successful: BOOLEAN
			--		

feature -- Definition

	define_document (url: STRING_32; language, vendor, doc_type: CIL_GUID): CIL_DBG_DOCUMENT_WRITER
			-- Create a new document writer needed to generated debug info.
		require
			not_is_closed: not is_closed
			url_not_void: url /= Void
			language_guid_not_void: language /= Void
			vendor_guid_not_void: vendor /= Void
			doc_type_guid_not_void: doc_type /= Void
		do
			to_implement ("TODO Add implementation")
		end

	define_sequence_points (document: CIL_DBG_DOCUMENT_WRITER; count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])

			-- Set sequence points for `document'
		require
			not_is_closed: not is_closed
			document_not_void: document /= Void
			offsets_not_void: offsets /= Void
			start_lines_not_void: start_lines /= Void
			valid_start_lines_count: count <= start_lines.count
			start_columns_not_void: start_columns /= Void
			valid_start_columns_count: count <= start_columns.count
			end_lines_not_void: end_lines /= Void
			valid_end_lines_count: count <= end_lines.count
			end_columns_not_void: end_columns /= Void
			valid_end_columns_count: count <= end_columns.count
		do
			to_implement ("TODO add implementation")
		end

	define_local_variable (name: STRING_32; pos: INTEGER; signature: CIL_MD_TYPE_SIGNATURE)
			-- Define local variable `name' at position `pos' in current method using
			-- `signature' of current method.
			--| Replaced UNI_STRING
		do
			to_implement ("TODO add implementation")
		end

	define_parameter (name: STRING_32; pos: INTEGER)
			-- Define parameter `name' at position `pos' in current method.
			--| Replaced UNI_STRING
		do
			to_implement ("TODO add implementation")
		end

feature -- Settings

	set_user_entry_point (entry_point_token: INTEGER)
			-- Set `entry_point_token' as entry point.
		do
			to_implement ("TODO add implementation")
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class CIL_DBG_WRITER
