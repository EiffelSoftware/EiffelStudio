note
	description: "In memory representation of a PE file for CLI."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLI_PE_FILE

feature -- Status

	is_valid: BOOLEAN
			-- Is Current PE file still valid, i.e. not yet saved to disk?
		deferred
		end

	has_strong_name: BOOLEAN
			-- Does current have a strong name signature?
		deferred
		end

feature -- Access

	codeview_debug_directory: detachable CLI_DEBUG_DIRECTORY
		deferred
		end

	codeview_debug_info: detachable MANAGED_POINTER
			-- Data for storing debug information in PE files.
		deferred
		end


	checksum_debug_directory: detachable CLI_DEBUG_DIRECTORY
		deferred
		end

	checksum_debug_info: detachable MANAGED_POINTER
			-- Data for storing debug information in PE files.	
		deferred
		end

	public_key: detachable MD_PUBLIC_KEY
		deferred
		end

	signing: detachable MD_STRONG_NAME
			-- Hold data for strong name signature.
		deferred
		end

	resources: detachable CLI_RESOURCES
			-- Hold data for resources.
		deferred
		end

	cli_header_has_flag_strong_name_signed: BOOLEAN
			-- Has CLI Header flag "strong_name_signed" ?
		deferred
		end

	method_writer: detachable MD_METHOD_WRITER
			-- To hold IL code.
		deferred
		end

feature -- Settings

	set_method_writer (m: like method_writer)
			-- Set `method_writer' to `m'.
		require
			m_not_void: m /= Void
		deferred
		ensure
			method_writer_set: method_writer = m
		end

	set_entry_point_token (token: INTEGER)
			-- Set `token' as entry point of current CLI image.
		require
			token_not_null: token /= 0
		deferred
		end

	set_codeview_debug_information (a_cli_debug_directory: CLI_DEBUG_DIRECTORY;
			a_debug_info: MANAGED_POINTER)

			-- Set `codeview_debug_directory' to `a_cli_debug_directory' and `debug_info'
			-- to `a_debug_info'.
		require
			a_cli_debug_directory_not_void: a_cli_debug_directory /= Void
			a_debug_info_not_void: a_debug_info /= Void
		deferred
		ensure
			debug_directory_set: codeview_debug_directory = a_cli_debug_directory
			codeview_debug_info_set: codeview_debug_info = a_debug_info
		end

	set_checksum_debug_information (a_cli_debug_directory: CLI_DEBUG_DIRECTORY;
			a_checksum_info: MANAGED_POINTER)

			-- Set `checksum_debug_directory' to `a_cli_debug_directory' and `checksum_info'
			-- to `a_checksum_info'.
		require
			a_cli_debug_directory_not_void: a_cli_debug_directory /= Void
			a_debug_info_not_void: a_checksum_info /= Void
		deferred
		ensure
			checksum_debug_directory_set: a_checksum_info.count /= 0 implies checksum_debug_directory = a_cli_debug_directory
			checksum_debug_info_set: a_checksum_info.count /= 0 implies checksum_debug_info = a_checksum_info
			a_checksum_info.count = 0 implies checksum_debug_directory = Void and checksum_debug_info = Void
		end

	set_public_key (a_key: like public_key; a_signing: like signing)
			-- Set `public_key' to `a_key'.
		require
			key_not_void: a_key /= Void
			key_valid: a_key.item.count > 0
			a_signing_not_void: a_signing /= Void
			a_signing_exists: a_signing.exists
		deferred
		ensure
			public_key_set: public_key = a_key
			has_strong_name_set: has_strong_name
			signing_set: signing = a_signing
			cli_header_flags_set: cli_header_has_flag_strong_name_signed
		end

	set_resources (r: like resources)
			-- Set `resources' with `r'
		require
			r_not_void: r /= Void
		deferred
		ensure
			resources_set: resources = r
		end

feature -- Saving

	save
		deferred
		ensure
			not_is_valid: not is_valid
		end

end
