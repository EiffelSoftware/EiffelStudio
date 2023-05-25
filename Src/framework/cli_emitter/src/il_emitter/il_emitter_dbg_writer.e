note
	description: "Summary description for {DBG_WRITER}."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER_DBG_WRITER

inherit
	DBG_WRITER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (emitter: MD_EMIT; name: CLI_STRING; full_build: BOOLEAN)
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

feature -- Update

	close
			-- Stop all processing on current.
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

	close_method
			-- Close current method.
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

	open_method (a_meth_token: INTEGER)
			-- Open method `a_meth_token'.
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

	open_scope (start_offset: INTEGER)
			-- Create a new scope for defining local variables.
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

	close_scope (end_offset: INTEGER)
			-- Close most recently opened scope.
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

feature -- PE file data

	debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY): MANAGED_POINTER
			-- Retrieve debug info required to be inserted in PE file.
		do
			-- FIXME
			create Result.make (0)
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

feature -- Status report

	is_closed: BOOLEAN
			-- Can further operation be applied on Current?
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

	is_successful: BOOLEAN
			-- Was last call successful?
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

feature -- Definition

	define_document (url: CLI_STRING; language, vendor, doc_type: CIL_GUID): detachable DBG_DOCUMENT_WRITER
			-- Create a new document writer needed to generated debug info.
		do
			debug ("refactor_fixme")
				to_implement ("TODO: DBG_DOCUMENT_WRITER")
			end
		ensure then
			not_yet_implemented: False
		end

	define_sequence_points (document: DBG_DOCUMENT_WRITER; count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])

			-- Set sequence points for `document'
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

	define_local_variable (name: CLI_STRING; pos: INTEGER; signature: MD_TYPE_SIGNATURE)
			-- Define local variable `name' at position `pos' in current method using
			-- `signature' of current method.
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

	define_parameter (name: CLI_STRING; pos: INTEGER)
			-- Define parameter `name' at position `pos' in current method.
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

feature -- Settings

	set_user_entry_point (entry_point_token: INTEGER)
			-- Set `entry_point_token' as entry point.
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
