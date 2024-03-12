note
	description: "[
		Interface to create PDB files for CLI images.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DBG_WRITER

feature -- Update

	close (a_pe_file: detachable CLI_PE_FILE)
			-- Stop all processing on current.
		require
			not_is_closed: not is_closed
		deferred
		ensure
			is_closed: is_closed
			is_successful
		end

	close_method
			-- Close current method.
		require
			not_is_closed: not is_closed
		deferred
		ensure
			is_successful
		end

	open_method (a_meth_token: INTEGER)
			-- Open method `a_meth_token'.
		require
			not_is_closed: not is_closed
			valid_token: a_meth_token /= 0
		deferred
		ensure
			is_successful
		end

	open_scope (start_offset: INTEGER)
			-- Create a new scope for defining local variables.
		require
			valid_start_offset: start_offset >= 0
		deferred
		ensure
			is_successful
		end

	close_scope (end_offset: INTEGER)
			-- Close most recently opened scope.
		require
			valid_end_offset: end_offset >= 0
		deferred
		ensure
			is_successful
		end

	open_local_signature (a_doc: DBG_DOCUMENT_WRITER; a_token: INTEGER)
			-- Open Local signature token for the current method token.
		require
			not_is_closed: not is_closed
			valid_token: a_token >= 0
		deferred
		ensure
			is_successful
		end

	close_local_signature (a_doc: DBG_DOCUMENT_WRITER)
			-- Close local signature fo the current Method.
		require
			not_is_closed: not is_closed
		deferred
		ensure
			is_successful
		end

feature -- PE file data

	codeview_debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY): MANAGED_POINTER
			-- Retrieve CodeView debug info required to be inserted in PE file.
		require
			not_is_closed: not is_closed
			a_dbg_directory_not_void: a_dbg_directory /= Void
		deferred
		ensure
			is_successful
		end

	checksum_debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY): MANAGED_POINTER
			-- Retrieve PdbChecksum debug info required to be inserted in PE file.
		require
			a_dbg_directory_not_void: a_dbg_directory /= Void
		deferred
		ensure
			is_successful
		end

feature -- Status report

	is_closed: BOOLEAN
			-- Can further operation be applied on Current?
		deferred
		end

	is_successful: BOOLEAN
			-- Was last call successful?
		deferred
		end

feature -- Definition

	define_document (url: CLI_STRING; language, vendor, doc_type: CIL_GUID): detachable DBG_DOCUMENT_WRITER
			-- Create a new document writer needed to generated debug info.
		require
			not_is_closed: not is_closed
			url_not_void: url /= Void
			language_guid_not_void: language /= Void
			vendor_guid_not_void: vendor /= Void
			doc_type_guid_not_void: doc_type /= Void
		deferred
		ensure
			is_successful
		end

	define_sequence_points (document: DBG_DOCUMENT_WRITER; count: INTEGER; offsets, start_lines,
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
		deferred
		ensure
			is_successful
		end

	define_local_variable (name: CLI_STRING; pos: INTEGER; signature: MD_TYPE_SIGNATURE)
			-- Define local variable `name' at position `pos' in current method using
			-- `signature' of current method.
		require
			name_not_void: name /= Void
			valid_pos: pos >= 0
			signature_not_void: signature /= Void
		deferred
		ensure
			is_successful
		end

	define_parameter (name: CLI_STRING; pos: INTEGER)
			-- Define parameter `name' at position `pos' in current method.
		require
			name_not_void: name /= Void
			valid_pos: pos >= 0
		deferred
		ensure
			is_successful
		end

feature -- Settings

	set_user_entry_point (entry_point_token: INTEGER)
			-- Set `entry_point_token' as entry point.
		require
			not_is_closed: not is_closed
			valid_token:
				entry_point_token & {MD_TOKEN_TYPES}.Md_mask =
					{MD_TOKEN_TYPES}.Md_method_def
		deferred
		ensure
			is_successful
		end

end
