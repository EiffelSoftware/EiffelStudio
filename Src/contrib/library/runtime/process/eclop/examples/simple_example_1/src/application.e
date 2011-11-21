note
	description: "Simple example program for ECLOP"
	copyright: "Copyright (c) 2003 Paul Cohen."
	license: "Eiffel Forum License v2 (see license.txt)"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	
class APPLICATION
	
create
	make

feature {NONE} -- Initialization

	make
			-- Run the program.
		local
			cls: COMMAND_LINE_SYNTAX
			clp: COMMAND_LINE_PARSER
			args: ARGUMENTS
		do
                        create cls.make (option_specifications)
                        create clp.make (cls)
                        create args
                        clp.parse (args.argument_array)
			exe_name := clp.executable_without_suffix
			if clp.valid_options.has ("-v") then
				print_version_info
			elseif clp.valid_options.has ("-h") then
				print (cls.program_help (exe_name, Void, Void))
			elseif not clp.invalid_options_found then
				file_names := clp.valid_options @ "-i"
				operate_on_files
			else
				print (clp.error_message)
				print (cls.program_usage (exe_name) + "%N")
				print ("Use -h/--help for more help." + "%N")
			end
		end
	
feature {NONE} -- Implementation

	print_version_info 
			-- Print version information.
		local
			s: STRING
		do
			s := exe_name + " 0.1.0 build 0" + "%N"
			s.append ("Copyright (c) 2003, Foo Software." + "%N")
			s.append ("Send bugs, problems or suggestions to support@foosoft.com" + "%N")
			print (s)
		end
	
	operate_on_files 
			-- Main body of program. Operates on `file_names'. 
		do
			from
				file_names.start
			until
				file_names.after
			loop
				-- Do something with each file!
				print ("Operating on file: " + file_names.item + "%N")
				file_names.forth
			end
		end
	
	option_specifications: ARRAY [STRING]
			-- The recognized options of this program
		once
			Result := <<"-v,--version#Version information.",
				    "-h,--help#Help on using this program.",
				    "-i,--input!=FILE!#Input file(s) to operate on.">>
		end
 
	file_names: LIST [STRING]
			-- Names of the files to operate on

	exe_name: STRING
			-- Name of this executable

end -- class APPLICATION


