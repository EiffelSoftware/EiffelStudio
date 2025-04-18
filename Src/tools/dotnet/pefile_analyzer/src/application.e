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
			o_explorer, o_printer, o_default: detachable READABLE_STRING_GENERAL
			l_usage: BOOLEAN
		do
			-- Default
			has_analyzer := True
			has_printer := True
			has_explorer := True

			default_output := io.output
			printer_output := default_output
			explorer_output := default_output

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
						has_explorer := False
						is_raw := True
					elseif arg.is_case_insensitive_equal_general ("append") then
						is_appending_output := True

					elseif arg.is_case_insensitive_equal_general ("analyze") then
						has_analyzer := True
					elseif arg.is_case_insensitive_equal_general ("no_analyze") then
						has_analyzer := False
					elseif arg.is_case_insensitive_equal_general ("explore") then
						has_explorer := True
						o_explorer := Void -- Default
					elseif arg.is_case_insensitive_equal_general ("no_explore") then
						has_explorer := False
					elseif arg.is_case_insensitive_equal_general ("print") then
						has_printer := True
						o_printer := Void -- Default
					elseif arg.is_case_insensitive_equal_general ("no_print") then
						has_printer := False
					elseif arg.starts_with_general ("explore=") then
						has_explorer := True
						o_explorer := arg.substring (arg.index_of ('=', 1) + 1,  arg.count)
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
				print ("Usage: path-to-dll {default-output}%N")
				print ("%T --out=output-file%N")
				print ("%T --analyze|--no_analyze : enable/disable the analyzer (to resolve token, indexes, ...)%N")
				print ("%T --print|--no_print     : enable/disable the printer%N")
				print ("%T --print=output-file    : enable the printer and outputs to file or stdout|stderr%N")
				print ("%T --explore|--no_explore : enable/disable the explorer%N")
				print ("%T --explore=output-file  : enable the explorer and outputs to file or stdout|stderr%N")
				print ("%T                        : if output-file starts with a dot such as '.ext' use%N")
				print ("%T                        : the path-to-dll.ext as output%N")
				print ("%T --append               : if output is redirected to a file, append the content%N")
				print ("%T --raw                  : implies no_analyze and no_explorer%N")
				print ("%T --help                 : display this help%N")
				print ("%N")
			else
				if not has_analyzer then
					has_explorer := False
				end

				if o_printer /= Void then
					if o_printer.starts_with (".") then
						o_printer := fn.absolute_path.appended (o_printer).name
					end
					printer_output := output_file (o_printer)
				end
				if o_explorer /= Void then
					if o_explorer.starts_with (".") then
						o_explorer := fn.absolute_path.appended (o_explorer).name
					end

					explorer_output := output_file (o_explorer)
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
	has_printer,
	has_explorer: BOOLEAN


	default_output,
	printer_output,
	explorer_output: FILE

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
			if default_output = explorer_output then
				explorer_output := o
			end
			default_output := o
		end

feature -- Execution

	process_file (fn: PATH)
		local
			pe: PE_FILE
			rt: PE_MD_ROOT
			md_tables: PE_MD_TABLES
			o_dft, o: APP_OUTPUT
			printer: PE_PRINTER
			analyzer: PE_ANALYZER
			explorer: PE_EXPLORER
			resolver: PE_POINTER_RESOLVER
			l_error_count: NATURAL_32
		do
			create pe.make (fn.name)
			if pe.is_access_readable then
				io.error.put_string ("Loading " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (fn.name) + "%N")

				rt := pe.metadata_root

				md_tables := rt.metadata_tables (pe)

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
						create resolver.make (pe)
						pe.accepts (resolver)
					end

					create analyzer.make (pe)
					pe.accepts (analyzer)
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
					pe.accepts (printer)

					if o /= o_dft and then not o.was_opened then
						o.close
					end
				end

				if has_explorer then
					if explorer_output = default_output then
						o := o_dft
					else
						create o.make (explorer_output)
						if not o.was_opened then
							if is_appending_output then
								o.open_append
							else
								o.open_write
							end
						end
					end
					io.error.put_string ("Exploring ...")
					if attached o.output_path as l_path then
						io.error.put_string (" > ")
						io.error.put_string_general (l_path.name)
					end
					io.error.put_string ("%N")

					create explorer.make (o, pe)
					o.put_string ("File: " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (fn.name) + "%N")
					pe.accepts (explorer)

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
