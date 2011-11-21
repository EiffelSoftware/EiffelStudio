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
			bad_options: BOOLEAN
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
				input_file_names := clp.valid_options @ "-i"
				if clp.valid_options.has ("-o") then
					if (clp.valid_options @ "-o").count > 1 then
						print (exe_name + ": Only one output file allowed" + "%N")
						bad_options := True
					else
						output_file := (clp.valid_options @ "-o").first
					end
				end
				if not bad_options then
					if clp.valid_options.has ("-a") then
						algorithm_a_chosen := True
					elseif clp.valid_options.has ("-b") then
						algorithm_a_chosen := False
					else
						print ("Defaulting to use algorithm A!" + "%N")
						algorithm_a_chosen := True
					end
					operate_on_files
				end
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
			if output_file = Void then
				print ("Sending output to standard output." + "%N")
			else
				print ("Sending output to %"" + output_file + "%"%N")
			end
			from
				input_file_names.start
			until
				input_file_names.after
			loop
				-- Do something with each file!
				print ("Operating on file %"" + input_file_names.item + "%"") 
				if algorithm_a_chosen then
					print (" using algorithm A" + "%N")
				else
					print (" using algorithm B" + "%N")
				end
				input_file_names.forth
			end
		end
	
	option_specifications: ARRAY [STRING]
			-- The recognized options of this program
		once
			Result := <<"-v,--version#Print version information.",
				    "-h,--help#Print help on how to use the program.",
				    "-a#Use algorithm A. Can't be used with -b.",
				    "-b#Use algorithm B. Can't be used with -a.",
				    "(-a|-b)",
				    "-i!=INPUTFILE!#Use INPUTFILE as input.",
				    "-o=OUTPUTFILE!#Use OUTPUTFILE as ouput. Default is stdout.">>
		end
	
	input_file_names: LIST [STRING]
			-- Names of the files to operate on
	
	output_file: STRING
			-- Name of the output file
	
	algorithm_a_chosen: BOOLEAN
			-- Is algorithm A chosen? If not assume B!
	
	exe_name: STRING
			-- Name of this executable

end -- class APPLICATION


