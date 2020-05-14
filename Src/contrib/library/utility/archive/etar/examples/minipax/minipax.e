note
	description : "[
			minimal pax implementation (lacking many features, different usage, different behavior)
		]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	MINIPAX

inherit
	SHARED_EXECUTION_ENVIRONMENT

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make
			-- Run minitar.
		do
			default_create

			create options
			options.parse (execution_environment.arguments)

			inspect options.mode
			when {OPTIONS}.mode_usage then
				print_usage
			when {OPTIONS}.mode_list then
				list
			when {OPTIONS}.mode_unarchive then
				unarchive
			when {OPTIONS}.mode_archive then
				archive
			else
					-- Unreachable
			end
		end

feature {NONE} -- Implementation

	print_error (a_error: ERROR)
			-- Print error to stderr.
		do
			localized_print_error ({STRING_32} "ERROR: " + a_error.string_representation)
		end

	print_warning (a_message: READABLE_STRING_GENERAL)
			-- Print warning to stderr.
		do
			localized_print_error ({STRING_32} "WARNING: " + a_message.to_string_32 + "%N")
		end

	print_info (a_message: READABLE_STRING_GENERAL)
			-- Print info to stderr.
		do
			localized_print_error ({STRING_32} "INFO: " + a_message.to_string_32 + "%N")
		end

	options: OPTIONS
			-- Program options.

	list
			-- List contents of the archive stored at `a_archive_filename'.
		local
			l_archive: ARCHIVE
			l_header_save_unarchiver: HEADER_SAVE_UNARCHIVER
			l_pp: HEADER_LIST_PRETTY_PRINTER
			l_header_pp: LIST [READABLE_STRING_GENERAL]
		do
			l_archive := new_archive
			create l_header_save_unarchiver
			l_archive.add_unarchiver (l_header_save_unarchiver)
			l_archive.open_unarchive
			l_archive.unarchive

			create l_pp
			l_header_pp := l_pp.pretty_print (l_header_save_unarchiver.headers)
			across
				l_header_pp as l_cur
			loop
				localized_print (l_cur.item)
				localized_print ("%N")
			end
		end

	archive
			-- Archive `a_filenames' to the archive stored at `a_archive_filename' (creating it if it does not exist, overwriting otherwise).
		local
			l_archive: ARCHIVE
			l_file: FILE
			l_dir: DIRECTORY
			l_to_archive: QUEUE [PATH]
		do
			l_archive := new_archive
			l_archive.open_archive

			create {ARRAYED_QUEUE [PATH]} l_to_archive.make (options.file_list.count)
			across
				options.file_list as ic
			loop
				l_to_archive.force (create {PATH}.make_from_string (ic.item))
			end
			from
			until
				l_to_archive.is_empty
			loop
				create {RAW_FILE} l_file.make_with_path (l_to_archive.item)
				if l_file.exists then
					if l_file.is_directory then
						l_archive.add_directory (l_file)

						create l_dir.make_with_path (l_to_archive.item)
						across
							l_dir.entries as l_cur
						loop
							if not l_cur.item.is_current_symbol and not l_cur.item.is_parent_symbol then
								l_to_archive.force (l_to_archive.item + l_cur.item)
							end
						end
					elseif l_file.is_plain then
						if l_file.path.canonical_path.same_as ((create {PATH}.make_from_string (options.archive_name)).canonical_path) then
							print_info ({STRING_32} "Skipping file %"" + l_file.path.name + {STRING_32} "%", is same file as output file")
						else
							l_archive.add_file (l_file)
						end
					else
							--| FIXME: place to change in order to support other filetypes.
						print_warning ({STRING_32} "Skipping file %"" + l_file.path.name + {STRING_32} "%", unsupported filetype")
					end
				else
					print_warning ("File %"" + l_file.path.name + "%" does not exist")
				end
				l_to_archive.remove
			end
			l_archive.finalize
		end

	unarchive
			-- Unarchive contents of the archive stored at `options.archive_name'.
		local
			l_archive: ARCHIVE
		do
			l_archive := new_archive
			l_archive.add_unarchiver (create {FILE_UNARCHIVER})
			l_archive.add_unarchiver (create {DIRECTORY_UNARCHIVER})
			l_archive.open_unarchive
			l_archive.unarchive
		end

	new_archive: ARCHIVE
			-- Build archive according to `options'.
		do
			create Result.make (create {FILE_STORAGE_BACKEND}.make_from_filename (options.archive_name))

			if options.absolute_paths_enabled then
				Result.enable_absolute_filenames
			end

			Result.register_error_callback (agent print_error (?))
		ensure
			no_error: not Result.has_error
		end

	print_usage
			-- Print usage of this utility.
		do
			localized_print (
			"[
Usage: 
    - minipax [-A] -f archive
        List mode: minipax prints the contents of the specified archive
    - minipax [-A] -r -f archive
        Read mode: minipax unarchives the contents of the specified archive
    - minipax [-A] -w -f archive file...
        Write mode: minipax archives the given list of files, creating the
                    archive if it does not exist, overriding it otherwise
Options
    -A      Allow absolute paths and parent directory identifiers in filenames

			]")
		end

note
	copyright: "2015-2020, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
