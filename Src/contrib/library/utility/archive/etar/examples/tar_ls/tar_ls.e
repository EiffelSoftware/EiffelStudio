note
	description : "[
			ls for tar files
			
			This demo program lists the contents of a tar
			compressed file.
		]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TAR_LS

inherit
	SHARED_EXECUTION_ENVIRONMENT

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make
			-- List contents of all files given as arguments.
		local
			f: FILE
			i,n: INTEGER
			args: ARGUMENTS_32
		do
			args := execution_environment.arguments
			from
				i := 1
				n := args.argument_count
			until
				i > n
			loop
				create {RAW_FILE} f.make_with_name (args.argument (i))
				if f.exists and then f.is_readable then
					list_contents (f)
				else
					print_error ({STRING_32} "Skipping File %"" + f.path.name + {STRING_32} "%"")
				end
				i := i + 1

			end
		end

feature {NONE} -- Implementation

	list_contents (tar_file: FILE)
			-- List the contents of `file'.
		require
			readable_file: tar_file.is_readable
		local
			l_header_printer: HEADER_PRINT_UNARCHIVER
			l_archive: ARCHIVE
		do
			from
				create l_header_printer
				create l_archive.make (create {FILE_STORAGE_BACKEND}.make_from_file (tar_file))
				l_archive.open_unarchive
				l_archive.add_unarchiver (l_header_printer)

					-- Filename
				localized_print (tar_file.path.name)
				io.put_string (":%N")
			until
				l_archive.unarchiving_finished
			loop
				l_archive.unarchive_next_entry
				if not l_archive.has_error then
					localized_print (l_header_printer.last_header_string)
					localized_print ("%N")
				end
			end
			if l_archive.has_error then
				print_errors (l_archive)
			end
			l_archive.close


		end

feature {NONE} -- Pretty printing

	print_error (msg: READABLE_STRING_GENERAL)
			-- Put `msg' to stderr.
		do
			localized_print_error ("ERROR: ")
			localized_print_error (msg)
			localized_print_error ("%N")
		end


	print_errors (a_archive: ARCHIVE)
			-- Print all errors that occured.
		do
			across a_archive.error_messages as l_error_cursor loop
				print_error (l_error_cursor.item.string_representation)
			end
		end


feature {NONE} -- Utilites

	needed_blocks (n: NATURAL_64): NATURAL_64
			-- How many blocks are needed to represent `n' bytes?
		do
			Result := (n + {TAR_CONST}.tar_block_size.as_natural_64 - 1) // {TAR_CONST}.tar_block_size.as_natural_64
		ensure
			bytes_fit: n <= Result * {TAR_CONST}.tar_block_size.as_natural_64
			smallest_fit: Result * {TAR_CONST}.tar_block_size.as_natural_64 < n + {TAR_CONST}.tar_block_size.as_natural_64
		end

note
	copyright: "2015-2016, Nicolas Truessel, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
