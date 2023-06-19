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
			fn: READABLE_STRING_GENERAL
		do
			if argument_count = 0 then
				print ("Usage: path-to-dll {output-file}%N")
			else
				fn := argument (1)
				if argument_count > 1 then
					create {PLAIN_TEXT_FILE} o.make_with_name (argument (2))
				end
				if o /= Void then
					o.open_write
					process_file (fn, o)
					o.close
				else
					process_file (fn, io.output)
				end
			end
		end

feature -- Execution

	process_file (fn: READABLE_STRING_GENERAL; of: FILE)
		local
			pe: PE_FILE
			rt: PE_MD_ROOT
			md_tables: PE_MD_TABLES
			o: APP_OUTPUT
			printer: PE_PRINTER
			analyzer: PE_ANALYZER
			resolver: PE_RESOLVER
		do
			create pe.make (fn)
			create o.make (of)
			o.put_string ("File: " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (fn) + "%N")


			rt := pe.metadata_root

			md_tables := rt.metadata_tables (pe)
--			create resolver.make (pe)
--			pe.accepts (resolver)

			create analyzer.make (pe)
			pe.accepts (analyzer)

			create printer.make (o)
			pe.accepts (printer)
		end

end
