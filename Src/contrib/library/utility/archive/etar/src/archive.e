note
	description: "[
			This class models an archive and allows to
			create new archives and unarchive existing archives

			It supports the following modes:
				- unarchiving (reading)
				- archiving (writing)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ARCHIVE

inherit
	ERROR_HANDLER
		redefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	default_create
			-- (Ab)used for internal initialization.
		do
				-- Header utilities
			create {PAX_HEADER_WRITER} header_writer
			create {PAX_HEADER_PARSER} header_parser

				-- Unarchivers
			create {ARRAYED_LIST [UNARCHIVER]} unarchivers.make (5)

--			unarchiving_finished := False

			Precursor {ERROR_HANDLER}

				-- Add default unarchivers
			add_unarchiver (create {SKIP_UNARCHIVER}) -- Fallback


				-- Error redirections
			header_parser.register_error_callback (agent report_error_with_parent ("Header parser failed", ?))
			storage_backend.register_error_callback (agent report_error_with_parent ("Storage backend failed", ?))
		end

	make (a_storage_backend: STORAGE_BACKEND)
			-- Creat new archive with backend `a_storage_backend'.
		do
			storage_backend := a_storage_backend
			mode := mode_closed

			default_create
		ensure
			storage_backend_set: storage_backend = a_storage_backend
		end

feature -- Status setting

	open_archive
			-- Open for archiving.
		do
			storage_backend.open_write
			mode := mode_archive
		ensure
			correct_mode: is_archiving_mode
		end

	open_unarchive
			-- Open for unarchiving.
		do
			storage_backend.open_read
			mode := mode_unarchive
		ensure
			correct_mode: is_unarchiving_mode
		end

	close
			-- Close archive.
		do
			storage_backend.close
			mode := mode_closed
		ensure
			closed: storage_backend.closed
		end

	enable_absolute_filenames
			-- Set `absolute_filenames'.
		require
			closed: is_closed
		do
			absolute_filenames := True
		ensure
			absolute_filenames_allowed: absolute_filenames
		end

	disable_absolute_filenames
			-- Reset `absolute_filenames'.
		require
			closed: is_closed
		do
			absolute_filenames := False
		ensure
			absolute_filenames_disallowed: not absolute_filenames
		end

feature -- Status

	is_unarchiving_mode: BOOLEAN
			-- Is this archive in unarchiving mode?
		do
			Result := mode = mode_unarchive
		end

	is_archiving_mode: BOOLEAN
			-- Is this archive in archiving mode?
		do
			Result := mode = mode_archive
		end

	is_closed: BOOLEAN
			-- Is this archive closed?
		do
			Result := mode = mode_closed
		end

	absolute_filenames: BOOLEAN
			-- Allow absolute paths / paths containing ".." ?

feature {NONE} -- Status (internal)

	mode: INTEGER
			-- In what mode has this instance been created?

	mode_closed: INTEGER = 0
			-- closed mode.

	mode_unarchive: INTEGER = 1
			-- unarchive (read) mode.

	mode_archive: INTEGER = 2
			-- archive (write) mode.

feature -- Unarchiving

	add_unarchiver (a_unarchiver: UNARCHIVER)
			-- Add unarchiver `a_unarchiver' to `unarchivers'.
		do
			unarchivers.force (a_unarchiver)
			a_unarchiver.register_error_callback (agent report_error_with_parent (a_unarchiver.name + " failed", ?))
		end

	unarchiving_finished: BOOLEAN
			-- Unarchiving finished yet?
		require
			correct_mode: is_unarchiving_mode
		do
			Result := has_error or storage_backend.archive_finished
		end

	unarchive
			-- Unarchive the whole archive.
		require
			correct_mode: is_unarchiving_mode
		do
			from

			until
				unarchiving_finished
			loop
				unarchive_next_entry
			end
			close
		end

	unarchive_next_entry
			-- Unarchives the next entry.
		require
			correct_mode: is_unarchiving_mode
		local
			l_unarchiver: detachable UNARCHIVER
			l_sane_header: TAR_HEADER
		do
			if not unarchiving_finished and not has_error then
					-- parse header
				from
					storage_backend.read_block
					if storage_backend.block_ready then
						header_parser.parse_block (storage_backend.last_block, 0)
					end
				until
					header_parser.parsing_finished or has_error
				loop
					storage_backend.read_block
					if storage_backend.block_ready then
						header_parser.parse_block (storage_backend.last_block, 0)
					end
				end

				if not has_error then
					if attached header_parser.parsed_header as l_header then
						l_sane_header := sanitized_header (l_header)
						l_unarchiver := matching_unarchiver (l_sane_header)
						if l_unarchiver /= Void then
								-- Parse payload
							from
								l_unarchiver.initialize (sanitized_header (l_sane_header))
							until
								has_error or l_unarchiver.unarchiving_finished
							loop
								storage_backend.read_block
								if storage_backend.block_ready then
									l_unarchiver.unarchive_block (storage_backend.last_block, 0)
								end
							end
						else
							report_new_error ("No unarchiver found")
						end
					else
							-- unreachable (TAR_HEADER_PARSER invariant)
						report_new_error ("Failed to parse header")
					end
				end
			end
		end

feature -- Archiving

	add_entry (a_entry: ARCHIVABLE)
			-- Add `a_entry' to the archive.
		require
			correct_mode: is_archiving_mode
		local
			l_block: MANAGED_POINTER
		do
			create l_block.make ({TAR_CONST}.tar_block_size)

			from
				header_writer.set_active_header (sanitized_header (a_entry.header))
			until
				header_writer.finished_writing
			loop
				header_writer.write_block_to_managed_pointer (l_block, 0)
				storage_backend.write_block (l_block, 0)
			end

			from

			until
				a_entry.finished_writing
			loop
				a_entry.write_block_to_managed_pointer (l_block, 0)
				storage_backend.write_block (l_block, 0)
			end
		end

	finalize
			-- Write archive delimiter.
		do
			storage_backend.finalize
			mode := mode_closed
		end

feature -- Archiving helpers		

	add_directory (a_dir: FILE)
			-- Add directory file to archive.
		require
			exists: a_dir.exists
			readable: a_dir.is_access_readable
		do
			add_entry (create {DIRECTORY_ARCHIVABLE}.make (a_dir))
		end

	add_file (a_file: FILE)
			-- Add regular file to archive.
		require
			exists: a_file.exists and then a_file.is_plain
			readable: a_file.is_access_readable
		do
			add_entry (create {FILE_ARCHIVABLE}.make (a_file))
		end

	add_location (a_location: PATH)
			-- Add a node entry at location `a_location'.
			-- note: it can be file or directory, ..
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_location)
			if f.exists and then f.is_access_readable then
				if f.is_directory then
					add_directory (f)
				elseif f.is_plain then
					add_file (f)
				else
					report_new_error ({STRING_32} "Unsupported type of node at %"" + a_location.name + {STRING_32} "%".")
				end
			else
				report_new_error ({STRING_32} "Can not read file or directory at %"" + a_location.name + {STRING_32} "%".")
			end
		end

	add_directory_location (a_location: PATH)
			-- Add a directory entry at location `a_location'.
		require
			correct_mode: is_archiving_mode
		local
			d: RAW_FILE
		do
			create d.make_with_path (a_location)
			if
				d.exists and then
				d.is_access_readable and then
				d.is_directory
			then
				add_directory (d)
			else
				report_new_error ({STRING_32} "Can not add directory at %"" + a_location.name + {STRING_32} "%".")
			end
		end

	add_plain_file_location (a_location: PATH)
			-- Add a plain file entry at location `a_location'.
		require
			correct_mode: is_archiving_mode
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_location)
			if f.exists and then f.is_access_readable and then f.is_plain then
				add_file (f)
			else
				report_new_error ({STRING_32} "Can not add file at %"" + a_location.name + {STRING_32} "%".")
			end
		end

feature {NONE} -- Implementation

	storage_backend: STORAGE_BACKEND
			-- Storage backend to use, set on initialization.

	unarchivers: LIST [UNARCHIVER]
			-- List of all registered unarchivers.

	matching_unarchiver (a_header: TAR_HEADER): detachable UNARCHIVER
			-- Unarchiver being able to unarchive `a_header', Void if none.
		do
			across
				unarchivers.new_cursor.reversed as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not Result.unarchivable (a_header) then
					Result := Void
				end
			end
		end

	header_parser: TAR_HEADER_PARSER
			-- Parser to use for header parsing.

	header_writer: TAR_HEADER_WRITER
			-- Writer to use for header writing.

	sanitized_header (a_header: TAR_HEADER): TAR_HEADER
			-- Remove dangerous values from `a_header'.
			-- Currently only removes absolute filenames and parent directories.
		local
			l_safe_path: PATH
			p: PATH
		do
			Result := a_header
			if not absolute_filenames then
				create l_safe_path.make_empty
				across
					Result.filename.components as ic
				loop
					p := ic.item
					if p.has_root or p.is_current_symbol or p.is_parent_symbol then
						create l_safe_path.make_empty
					else
						l_safe_path := l_safe_path + p
					end
				end
				Result.set_filename (l_safe_path)
			end
		ensure
			relative_filename: not absolute_filenames implies Result.filename.is_relative
			no_parent_or_current_symbols: not absolute_filenames implies
					across Result.filename.components as ic all not ic.item.is_current_symbol and not ic.item.is_parent_symbol end
		end

invariant
	only_one_mode: is_archiving_mode xor is_unarchiving_mode xor is_closed
	closed_iff_backend_closed_or_error: is_closed = storage_backend.closed or has_error

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
