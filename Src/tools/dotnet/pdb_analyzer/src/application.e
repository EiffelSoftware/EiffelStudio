note
	description: "[
			Enter class description here!
		]"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Instantiate Current object.
		local
			o: FILE
			fn: PATH
			arg: STRING_32
			i,n: INTEGER
			o_printer, o_default: detachable READABLE_STRING_GENERAL
			l_usage: BOOLEAN
		do
			-- Default
			has_analyzer := True
			has_printer := True

			default_output := io.output
			printer_output := default_output

			from
				i := 1
				n := argument_count
			until
				i > n
			loop
				arg := argument (i)
				if arg.starts_with_general ("--") then
					arg.remove_head (2)
					if arg.is_case_insensitive_equal_general ("out") then
						o_default := argument (i + 1)
						i := i + 1
					elseif arg.is_case_insensitive_equal_general ("help") then
						l_usage := True
						i := i + 1
					elseif arg.is_case_insensitive_equal_general ("debug") then
						is_debug := True
						i := i + 1

					elseif arg.is_case_insensitive_equal_general ("raw") then
						has_analyzer := False
						is_raw := True
					elseif arg.is_case_insensitive_equal_general ("append") then
						is_appending_output := True

					elseif arg.is_case_insensitive_equal_general ("analyze") then
						has_analyzer := True
					elseif arg.is_case_insensitive_equal_general ("no_analyze") then
						has_analyzer := False
					elseif arg.is_case_insensitive_equal_general ("print") then
						has_printer := True
						o_printer := Void -- Default
					elseif arg.is_case_insensitive_equal_general ("no_print") then
						has_printer := False
					elseif arg.starts_with_general ("print=") then
						has_printer := True
						o_printer := arg.substring (arg.index_of ('=', 1) + 1,  arg.count)
					elseif arg.starts_with_general ("out=") then
						o_default := arg.substring (arg.index_of ('=', 1) + 1,  arg.count)
					else
						io.error.put_string_32 ({STRING_32} "Ignore argument %"--" + arg + "%"%N")
						l_usage := True
					end
				elseif fn = Void then
					create fn.make_from_string (arg)
				elseif o_default = Void then
					o_default := arg
				else
					-- Ignoring ...
					io.error.put_string_32 ({STRING_32} "Ignore argument %"" + arg + "%"%N")
					l_usage := True
				end
				i := i + 1
			end
			if fn = Void or l_usage then
				print ("Usage: path-to-pdb {default-output}%N")
				print ("%T --out=output-file%N")
				print ("%T --analyze|--no_analyze : enable/disable the analyzer (to resolve token, indexes, ...)%N")
				print ("%T --print|--no_print     : enable/disable the printer%N")
				print ("%T --print=output-file    : enable the printer and outputs to file or stdout|stderr%N")
				print ("%T --append               : if output is redirected to a file, append the content%N")
				print ("%T --raw                  : implies no_analyze%N")
				print ("%T --help                 : display this help%N")
				print ("%N")
			else
				if o_printer /= Void then
					if o_printer.starts_with (".") then
						o_printer := fn.absolute_path.appended (o_printer).name
					end
					printer_output := output_file (o_printer)
				end
				if o_default /= Void then
					if o_default.starts_with (".") then
						o_default := fn.absolute_path.appended (o_default).name
					end
					set_default_output (output_file (o_default))
				end
				process_file (fn.absolute_path)
			end
		end

	is_debug: BOOLEAN

	is_raw,
	is_appending_output,
	has_analyzer,
	has_printer: BOOLEAN


	default_output,
	printer_output: FILE

feature -- Helper

	output_file (a_name: READABLE_STRING_GENERAL): FILE
		do
			if a_name.is_case_insensitive_equal ("stdout") then
				Result := io.output
			elseif a_name.is_case_insensitive_equal ("stderr") then
				Result := io.error
			else
				create {PLAIN_TEXT_FILE} Result.make_with_path ((create {PATH}.make_from_string (a_name)).absolute_path)
			end
		end

feature -- Element change

	set_default_output (o: FILE)
		do
			if default_output = printer_output then
				printer_output := o
			end
			default_output := o
		end

feature -- Execution

	process_file (fn: PATH)
		local
			pdb: PDB_FILE
			rt: PDB_ROOT
			md_tables: PDB_MD_TABLES
			o_dft, o: APP_OUTPUT
			printer: PDB_PRINTER
			analyzer: PDB_ANALYZER
			resolver: PE_POINTER_RESOLVER
			l_error_count: NATURAL_32
		do
			create pdb.make (fn.name)
			if pdb.is_access_readable then
				io.error.put_string ("Loading " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (fn.name) + "%N")

				rt := pdb.metadata_root

				md_tables := rt.metadata_tables (pdb)

				create o_dft.make (default_output)
				if not o_dft.was_opened then
					if is_appending_output then
						o_dft.open_append
					else
						o_dft.open_write
					end
				end

				if has_analyzer then
						-- Resolve FieldPointer and MethodPointer
					if not is_raw then
						create resolver.make (pdb)
						pdb.accepts (resolver)
					end

					create analyzer.make (pdb)
					pdb.accepts (analyzer)
					l_error_count := analyzer.error_count
					if l_error_count > 0 then
						io.error.put_string ("ERROR: " + l_error_count.out + " error(s) detected%N")
					else
						debug ("pe_analyze")
							io.error.put_string ("No error detected%N")
						end
					end
				end

				if has_printer then
					if printer_output = default_output then
						o := o_dft
					else
						create o.make (printer_output)
						if not o.was_opened then
							if is_appending_output then
								o.open_append
							else
								o.open_write
							end
						end
					end
					io.error.put_string ("Printing ...")
					if attached o.output_path as l_path then
						io.error.put_string (" > ")
						io.error.put_string_general (l_path.name)
					end
					io.error.put_string ("%N")

					create printer.make (o)
					o.put_string ("File: " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (fn.name) + "%N")
					pdb.accepts (printer)

					if o /= o_dft and then not o.was_opened then
						o.close
					end
				end

				if not o_dft.was_opened then
					o_dft.close
				end
				io.error.put_string ("Completed.%N")
			else
				io.error.put_string ("Error: can not load the file!%N")
			end
		end

end
