note
	description: "Test program for ECLOP"
	copyright: "Copyright (c) 2003 Paul Cohen."
	license: "Eiffel Forum License v2 (see license.txt)"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	
class APPLICATION
	
inherit
	ANY
		redefine
			print
		end
	
	EXCEPTIONS
		export
			{NONE} all
		redefine
			print
		end
	
create
	make
	
feature {NONE} -- Initialization
	
	make
			-- Start the program.
		local
			test_results: LINKED_LIST [BOOLEAN]
			verbose: BOOLEAN
			-- TEST
			args: ARGUMENTS
			a: ARRAY [STRING]
			s: STRING
			i: INTEGER
		do
			open_log
			print_test_info
			
			-- TEST
			create args
			a := args.argument_array
			from 
				s := ""
				i := a.lower
			until
				i > a.upper
			loop
				s := s + "a [" + i.out + "]: %"" + a @ i + "%"%N"
				i := i + 1
			end
			print ("Command line arguments:%N")
			print (s + "%N")
			-- END TEST		
			
			verbose := False
			
			create test_results.make
			test_results.extend (test_suite_1 (verbose))
			test_results.extend (test_suite_2 (verbose))
			test_results.extend (test_suite_3 (verbose))
			test_results.extend (test_suite_4 (verbose))
			test_results.extend (test_suite_5 (verbose))
			test_results.extend (test_suite_6 (verbose))
			test_results.extend (test_suite_7 (verbose))
			test_results.extend (test_suite_8 (verbose))
			test_results.extend (test_suite_9 (verbose))
			test_results.extend (test_suite_10 (verbose))
			test_results.extend (test_suite_11 (verbose))
			test_results.extend (test_suite_12 (verbose))
			test_results.extend (test_suite_13 (verbose))
			test_results.extend (test_suite_14 (verbose))
			test_results.extend (test_suite_15 (verbose))
			test_results.extend (test_suite_16 (verbose))
			test_results.extend (test_suite_17 (verbose))
			test_results.extend (test_suite_18 (verbose))
			
			print ("%N" + double_dashed_line + "%N")
			print ("TEST RESULT SUMMARY:%N")
			from
				test_results.start
			until
				test_results.after
			loop
				if test_results.item then
					print ("  Test suite " + test_results.index.out + ": passed!%N")
				else
					print ("  Test suite " + test_results.index.out + ": failed. (See above for more details)%N")
				end
				test_results.forth
			end

			close_log
		end
	
feature -- Basic operations
	
	test_suite_1 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 1: A single correctly specified option.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-v,--version#Program version">>
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
				
				args := <<"C:\bin\foo", "-v">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-v") 
				Result := Result and test_parsed_options (opts, verbose)
				
				args := <<"C:\bin\foo", "-v", "-v">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-v") 
				Result := Result and test_parsed_options (opts, verbose)
				
				args := <<"C:\bin\foo", "--version">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-v") 
				Result := Result and test_parsed_options (opts, verbose)
				
				if verbose then
					print ("Example of program behavior for the %"-v%"/%"--version%" option:%N%N")
					print_command_line (args)			
					print (command_line_parser.executable + " 1.3.5 build 163 (May 16, 2003)%N")
					print ("Copyright (c) 2003, Foo Software.%N")
					print ("Report bugs to <support@foosoft.com>%N%N")
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_2 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 2: Three correctly specified options.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-a#Option A",
				  "-b#Option B",
				  "-c#Option C">>
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then
				Result := Result and test_create_command_line_parser (verbose)
				
				args := <<"C:\bin\foo", "-a", "-b", "-c">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-a") 
				opts.put (Valid_option, "-b") 
				opts.put (Valid_option, "-c") 
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "-abc">>
				Result := Result and test_command_line_parsing (args, verbose)
				Result := Result and test_parsed_options (opts, verbose)
				
				args := <<"C:\bin\foo", "-cba">>
				Result := Result and test_command_line_parsing (args, verbose)
				Result := Result and test_parsed_options (opts, verbose)
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_3 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 3: A single correctly specified option with an optional argument.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-a=#Some option">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "-a">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_without_arguments, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "-a", "bar">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-a", <<"bar">>, verbose)
				end
			
				args := <<"C:\bin\foo", "-a", "bar1", "bar2", "bar3">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-a", <<"bar1", "bar2", "bar3">>, verbose)
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_4 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 4: A single correctly specified option with a required argument.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-a=!#Some option">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "-a">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Option_argument_missing, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "-a", "bar">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-a", <<"bar">>, verbose)
				end
			
				args := <<"C:\bin\foo", "-a", "bar1", "bar2", "bar3">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-a", <<"bar1", "bar2", "bar3">>, verbose)
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_5 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 5: A single correctly specified option with an optional argument%N" +
			       "and two correctly specified options without arguments.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-a=#Option A",
				  "-b#Option B",
				  "-c#Option C">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "-a">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "-a", "bar">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-a", <<"bar">>, verbose)
				end
			
				args := <<"C:\bin\foo", "-a", "bar1", "bar2", "bar3">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-a", <<"bar1", "bar2", "bar3">>, verbose)
				end
			
				args := <<"C:\bin\foo", "-a", "bar1", "bar2", "bar3", "-b", "-c">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-a") 
				opts.put (Valid_option, "-b")
				opts.put (Valid_option, "-c")
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-a", <<"bar1", "bar2", "bar3">>, verbose)
				end
				
				args := <<"C:\bin\foo", "-abc", "bar">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-a") 
				opts.put (Not_valid_option, "-b") 
				opts.put (Not_valid_option, "-c") 
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-a", <<"bc", "bar">>, verbose)
				end
				
				args := <<"C:\bin\foo", "-cba", "bar">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Invalidly_grouped_option, "-a") 
				opts.put (Valid_option, "-b") 
				opts.put (Valid_option, "-c") 
				Result := Result and test_parsed_options (opts, verbose)
				
				if verbose then
					print ("%N")
					print ("command_line_parser.error_message:%N")
					print (command_line_parser.error_message)
					print ("%N")
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_6 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 6: Two correctly specified mutually exclusive options.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-a#Use algorithm A",
				  "-b#Use algorithm B",
				  "(-a|-b)">>
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			
				args := <<"C:\bin\foo", "-a">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "-b">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-b") 
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "-a", "-b">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (2)
				opts.put (Mutually_exclusive_option, "-a") 
				opts.put (Mutually_exclusive_option, "-b") 
				Result := Result and test_parsed_options (opts, verbose)
			
				if verbose then
					print ("%N")
					print ("command_line_parser.error_message:%N")
					print (command_line_parser.error_message)
					print ("%N")
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_7 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 7: Specifying mutually exclusive options before the options are specified.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"(-a|-b)",
				  "-a#Use algorithm A",
				  "-b#Use algorithm B">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "-a">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-a") 
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "-b">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "-b") 
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "-a", "-b">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Not_valid_option, "-a")
				opts.put (Not_valid_option, "-b")
				Result := Result and test_parsed_options (opts, verbose)
				create opts.make (1)
				opts.put (Mutually_exclusive_option, "-a")
				opts.put (Mutually_exclusive_option, "-b")
				Result := Result and test_parsed_options (opts, verbose)
			
				if verbose then
					print ("%N")
					print ("command_line_parser.error_message:%N")
					print (command_line_parser.error_message)
					print ("%N")
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_8 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 8: Two sets of correctly specified mutually exclusive options.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-a#Use algorithm A",
				  "-b#Use algorithm B",
				  "(-a|-b)",
				  "-c#Use compact format",
				  "-e#Use exetended format",
				  "(-c|-e)">>
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			
				args := <<"C:\bin\foo", "-a", "-b", "-c", "-e">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (4)
				opts.put (Mutually_exclusive_option, "-a") 
				opts.put (Mutually_exclusive_option, "-b") 
				opts.put (Mutually_exclusive_option, "-c") 
				opts.put (Mutually_exclusive_option, "-e") 
				Result := Result and test_parsed_options (opts, verbose)
			
				if verbose then
					print ("%N")
					print ("command_line_parser.error_message:%N")
					print (command_line_parser.error_message)
					print ("%N")
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_9 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 9: Using %"--%" on the command line to parse operands.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-a#Some option",
				  "-b#Another option">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "-a", "-b", "--", "foo", "bar">>				
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (4)
				opts.put (Valid_option, "-a") 
				opts.put (Valid_option, "-b") 
				opts.put (Operand, "foo") 
				opts.put (Operand, "bar") 
				Result := Result and test_parsed_options (opts, verbose)
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
			
	test_suite_10 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 10: One long option abbreviated on the command line.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"--compile#Compile">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "--comp">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option, "--compile") 
				Result := Result and test_parsed_options (opts, verbose)
			
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_11 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 11: Two long options with ambigous abbreviation on the command line.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"--compile#Compile",
				  "--complete#Complete">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "--comp">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Ambigous_option, "--comp")
				Result := Result and test_parsed_options (opts, verbose)
				
				if verbose then
					print ("%N")
					print ("command_line_parser.error_message:%N")
					print (command_line_parser.error_message)
					print ("%N")
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_12 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 12: One long option with optional argument.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"--compile=#Compile">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "--compile">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_without_arguments, "--compile")
				Result := Result and test_parsed_options (opts, verbose)
			
				args := <<"C:\bin\foo", "--compile=eiffel">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "--compile")
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("--compile", <<"eiffel">>, verbose)
				end
			
				args := <<"C:\bin\foo", "--comp=eiffel">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "--compile")
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("--compile", <<"eiffel">>, verbose)
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_13 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 13: Mixed use of short and long name for same option with option arguments.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-f,--file=FILE#File(s) to operate on">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "-f", "one", "two">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-f")
				Result := Result and test_parsed_options (opts, verbose)
				Result := Result and test_option_has_arguments ("-f", <<"one", "two">>, verbose)
				
				args := <<"C:\bin\foo", "--file", "one", "two">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-f")
				Result := Result and test_parsed_options (opts, verbose)
				Result := Result and test_option_has_arguments ("-f", <<"one", "two">>, verbose)
			
				args := <<"C:\bin\foo", "-f", "one", "two", "--file", "three">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
				opts.put (Valid_option_with_arguments, "-f")
				Result := Result and test_parsed_options (opts, verbose)
				if Result then
					Result := Result and test_option_has_arguments ("-f", <<"one", "two", "three">>, verbose)
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_14 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 14: Specifying option argument names.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"--compile=LANGUAGE#Compile">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				if verbose then
					print ("%N")
					print ("command_line_parser.program_usage (%"foo%"):%N")
					print (command_line_syntax.program_usage ("foo"))
					print ("%N%N")
					print ("command_line_parser.program_help (%"foo%", Void, Void):%N")
					print (command_line_syntax.program_help ("foo", Void, Void))
					print ("%N%N")
				end
			end
			
			spec := <<"--compile!=LANGUAGE#Compile">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				if verbose then
					print ("%N")
					print ("command_line_parser.program_usage (%"foo%"):%N")
					print (command_line_syntax.program_usage ("foo"))
					print ("%N%N")
					print ("command_line_parser.program_help (%"foo%", Void, Void):%N")
					print (command_line_syntax.program_help ("foo", Void, Void))
					print ("%N%N")
				end
			end
			
			spec := <<"--compile=LANGUAGE!#Compile">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				if verbose then
					print ("%N")
					print ("command_line_parser.program_usage (%"foo%"):%N")
					print (command_line_syntax.program_usage ("foo"))
					print ("%N%N")
					print ("command_line_parser.program_help (%"foo%", Void, Void):%N")
					print (command_line_syntax.program_help ("foo", Void, Void))
					print ("%N%N")
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_15 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 15: Testing the single dash operand.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-v#Print version information.">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				Result := Result and test_create_command_line_parser (verbose)
			       
				args := <<"C:\bin\foo", "-">>
				Result := Result and test_command_line_parsing (args, verbose)
				create opts.make (1)
                                Result := Result and test_for_single_dash (verbose)
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_16 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
			s: STRING
		do
			print (dashed_line + "%N")
			print ("Test suite 16: Test that the help for the GNU %"ls%" command can be created.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-a,--all#do not hide entries starting with .",
				  "-A,--almost-all#do not list implied . and ..",
				  "--author#print the author of each file",
				  "-b,--escape#print octal escapes for nongraphic characters",
				  "--block-size=SIZE!#use SIZE-byte blocks",
				  "-B,--ignore-backups#do not list implied entries ending with ~",
				  "-c#with -lt: sort by, and show, ctime (time of last%Nmodification of file status information)%Nwith -l: show ctime and sort by name%Notherwise: sort by ctime",
				  "-C#list entries by columns",
				  "--color=WHEN#control whether color is used to distinguish file%Ntypes. WHEN may be `never', `always', or `auto'",
				  "-d,--directory#list directory entries instead of contents,%Nand do not dereference symbolic links",
				  "-D,--dired#generate output designed for Emacs' dired mode",
				  "-f#do not sort, enable -aU, disable -lst",
				  "-F,--classify#append indicator (one of */=@|) to entries",
				  "--format=WORD!#across -x, commas -m, horizontal -x, long -l,%Nsingle-column -1, verbose -l, vertical -C",
				  "--full-time#like -l --time-style=full-iso",
				  "-g#like -l, but do not list owner",
				  "-G,--no-group#inhibit display of group information",
				  "-h,--human-readable#print sizes in human readable format (e.g., 1K 234M 2G)",
				  "--si#likewise, but use powers of 1000 not 1024",
				  "-H,--dereference-command-line#follow symbolic links listed on the command line",
				  "--dereference-command-line-symlink-to-dir#follow each command line symbolic link%Nthat points to a directory",
				  "--indicator-style=WORD!#append indicator with style WORD to entry names:%Nnone (default), classify (-F), file-type (-p)",
				  "-i,--inode#print index number of each file",
				  "-I,--ignore=PATTERN!#do not list implied entries matching shell PATTERN",
				  "-k#like --block-size=1K",
				  "-l#use a long listing format",
				  "-L,--dereference#when showing file information for a symbolic%Nlink, show information for the file the link%Nreferences rather than for the link itself",
				  "-m#fill width with a comma separated list of entries",
				  "-n,--numeric-uid-gid#like -l, but list numeric UIDs and GIDs",
				  "-N,--literal#print raw entry names (don't treat e.g. control%Ncharacters specially)",
				  "-o#like -l, but do not list group information",
				  "-p,--file-type#append indicator (one of /=@|) to entries",
				  "-q,--hide-control-chars#print ? instead of non graphic characters",
				  "--show-control-chars#show non graphic characters as-is (default%Nunless program is `ls' and output is a terminal)",
				  "-Q,--quote-name#enclose entry names in double quotes",
				  "--quoting-style=WORD!#use quoting style WORD for entry names:%Nliteral, locale, shell, shell-always, c, escape",
				  "-r,--reverse#reverse order while sorting",
				  "-R,--recursive#list subdirectories recursively",
				  "-s,--size#print size of each file, in blocks",
				  "-S#sort by file size",
				  "--sort=WORD!#extension -X, none -U, size -S, time -t,%Nversion -v, status -c, time -t, atime -u, access -u, use -u",
				  "--time=WORD!#show time as WORD instead of modification time:%Natime, access, use, ctime or status; use%Nspecified time as sort key if --sort=time",
				  "--time-style=STYLE!#show times using style STYLE:%Nfull-iso, long-iso, iso, locale, +FORMAT%NFORMAT is interpreted like `date'; if FORMAT is%NFORMAT1<newline>FORMAT2, FORMAT1 applies to%Nnon-recent files and FORMAT2 to recent files;%Nif STYLE is prefixed with `posix-', STYLE%Ntakes effect only outside the POSIX locale",
				  "-t#sort by modification time",
				  "-T,--tabsize=COLS!#assume tab stops at each COLS instead of 8",
				  "-u#with -lt: sort by, and show, access time%Nwith -l: show access time and sort by name%Notherwise: sort by access time",
				  "-U#do not sort; list entries in directory order",
				  "-v#sort by version",
				  "-w,--width=COLS!#assume screen width instead of current value",
				  "-x#list entries by lines instead of by columns",
				  "-X#sort alphabetically by entry extension",
				  "-1#list one file per line">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				if verbose then
					print ("%N")
					print ("command_line_parser.program_usage (%"ls%"):%N")
					print (command_line_syntax.program_usage ("ls"))
					print ("%N%N")
					s := "List information about the FILEs (the current directory by default).%N" +
						"Sort entries alphabetically if none of -cftuSUX nor --sort.%N"
					print ("command_line_parser.program_help (%"ls%", , Void, s):%N")
					print (command_line_syntax.program_help ("ls", Void, s))
					print ("%N%N")
				end
			end
			
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_17 (verbose: BOOLEAN): BOOLEAN
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
		do
			print (dashed_line + "%N")
			print ("Test suite 17: Test of usage and help messages.%N")
			if verbose then
				print ("%N")
			end
			
			spec := <<"-v,--version#Print version information.",
				  "-h,--help#Print help on how to use the program.",
				  "-a#Use algorithm A. Can't be used with -b.",
				  "-b#Use algorithm B. Can't be used with -a.",
				  "(-a|-b)",
				  "-i!=INPUTFILE!#Use INPUTFILE as input.",
				  "-o=OUTPUTFILE!#Use OUTPUTFILE as ouput. Default is stdout.">>
			
			Result := test_create_command_line_syntax (spec, verbose)
				
			Result := Result and test_validity_of_command_line_syntax (verbose)
			if Result then				
				if verbose then
					print ("%N")
					print ("command_line_parser.program_usage (%"foo%"):%N")
					print (command_line_syntax.program_usage ("foo"))
					print ("%N%N")
					print ("command_line_parser.program_help (%"foo%", Void, %"Does foo on a file.%"):%N")
					print (command_line_syntax.program_help ("foo", Void, "Does foo on a file."))
					print ("%N%N")
					print ("command_line_parser.program_help (%"foo%", %"foo [OPTIONS]%", Void):%N")
					print (command_line_syntax.program_help ("foo", "foo [OPTIONS]", Void))
					print ("%N%N")
					
					Result := Result and test_create_command_line_parser (verbose)
					
					args := <<"C:\bin\foo", "-i">>
					Result := Result and test_command_line_parsing (args, verbose)
					print ("command_line_parser.error_message:%N")
					print (command_line_parser.error_message)
				end
			end
						
			if not verbose and then Result then
				print ("... OK%N")
			elseif not verbose then
				print ("Failed.%N")
			end
		end
	
	test_suite_18 (verbose: BOOLEAN): BOOLEAN
			-- Test to verify bugfix (ECLOP 0.1.0) when having at
			-- least one long option and at least one short option
			-- with no synonym long option
		local
			spec: ARRAY [STRING]
			args: ARRAY [STRING]
			opts: HASH_TABLE [INTEGER, STRING]
			failed: BOOLEAN
		do
			if not failed then
				print (dashed_line + "%N")
				print ("Test suite 18: Verify bugfix (ECLOP 0.1.0) when:%N% 
				       %  1) specifying at least one long option%N%
                                       %  2) specifying at least one short option with no synonym long option%N%
			               %  3) invoking parse with at least one long option%N")
				if verbose then
					print ("%N")
				end
			
				spec := <<"--compile#Compile",
					  "-h">>
			
				Result := test_create_command_line_syntax (spec, verbose)
				
				Result := Result and test_validity_of_command_line_syntax (verbose)
				if Result then				
					Result := Result and test_create_command_line_parser (verbose)
			       
					args := <<"C:\bin\foo", "--compile">>
					Result := Result and test_command_line_parsing (args, verbose)
create opts.make (1)
				        opts.put (Valid_option, "--compile") 
				        Result := Result and test_parsed_options (opts, verbose)
				end
			
				if not verbose and then Result then
					print ("... OK%N")
				elseif not verbose then
					print ("Failed.%N")
				end
			else
				Result := False
				if not verbose then
					print ("Failed.%N")
				end
			end
		rescue
			failed := True
			print (exception_trace)
			retry
		end
	
feature	{NONE} -- Basic operations (atomic operations)
	
	test_create_command_line_syntax (spec: ARRAY [STRING]; verbose: BOOLEAN): BOOLEAN
			-- Create a new `command_line_syntax'. Returns True if
			-- succesful and False if not. 
		require
			spec_not_void: spec /= Void
		do
			if verbose then
				print ("%NTest: Creating a COMMAND_LINE_SYNTAX with the following specification:%N")
				print_specification (spec)
			end
			create command_line_syntax.make (spec)
			if command_line_syntax /= Void then
				Result := True
				if verbose then
					print ("... OK%N")
				end
			else
				Result := False
				print_test_failure ("Failed to create a COMMAND_LINE_SYNTAX.")  
			end
		end
	
	test_validity_of_command_line_syntax (verbose: BOOLEAN): BOOLEAN
			-- Test the validity of `command_line_syntax'. Returns
			-- True if succesful and False if not.
		do
			if verbose then
				print ("%NTest: Checking that the COMMAND_LINE_SYNTAX is valid ...%N")
			end
			if command_line_syntax.is_valid then
				Result := True
				if verbose then
					print ("... OK%N")
				end
			else
				print_test_failure ("Invalid COMMAND_LINE_SYNTAX:")
				print_invalid_specifications (command_line_syntax.invalid_specifications)
				Result := False
			end
		end
	
	test_create_command_line_parser (verbose: BOOLEAN): BOOLEAN
			-- Create a new `command_line_parser'. Returns True if
			-- succesful and False if not. 
		require
			command_line_syntax_not_void: command_line_syntax /= Void
		        command_line_syntax_is_valid: command_line_syntax.is_valid
		do
			if verbose then
				print ("%NTest: Creating a COMMAND_LINE_PARSER ...%N")
			end
			create command_line_parser.make (command_line_syntax)
			if command_line_parser /= Void then
				Result := True
				if verbose then
					print ("... OK%N")
				end
			else
				Result := False
				print_test_failure ("Failed to create a COMMAND_LINE_PARSER.")  
			end
		end
	
	test_command_line_parsing (args: ARRAY [STRING]; verbose: BOOLEAN): BOOLEAN
			-- Test parsing the command line arguments `args'. 
			-- Returns True if succesful and False if not.   
		require
			command_line_syntax_not_void: command_line_syntax /= Void
		        command_line_syntax_is_valid: command_line_syntax.is_valid
			command_line_parser_not_void: command_line_parser /= Void
			args_not_void: args /= Void
		do
			if verbose then
				print ("%NTest: Parsing the following command line arguments:%N")
				print_command_line (args)
			end
			command_line_parser.parse (args)
			Result := True
			if verbose then
				print ("... OK%N")
			end
		end
	
	test_parsed_options (opts: HASH_TABLE [INTEGER, STRING]; verbose: BOOLEAN): BOOLEAN
			-- Test that the option names in `opts' were parsed
			-- correctly. `opts' is a table where the hash keys
			-- areoption names and the items are the expected
			-- status of that option. See the features (Option
			-- states). Returns True if succesful and False if not.
		require
			command_line_syntax_not_void: command_line_syntax /= Void
		        command_line_syntax_is_valid: command_line_syntax.is_valid
			command_line_parser_not_void: command_line_parser /= Void
			opts_not_void: opts /= Void
		local
			s, s2: STRING
			b: BOOLEAN
			popts: HASH_TABLE [BOOLEAN, STRING]
		do
			from 
				Result := True
				s := ""
				create popts.make (opts.count)
				opts.start
			until
				opts.after
			loop
				-- Check the option according to the given
				-- directive
				inspect opts.item_for_iteration
				when Valid_option then
					b := command_line_parser.valid_options.has (opts.key_for_iteration)
					if b then
						popts.put (b, opts.key_for_iteration + " is valid")
					else
						popts.put (b, opts.key_for_iteration + " is not valid")
					end
					Result := Result and b
				when Valid_option_with_arguments then
					b := command_line_parser.valid_options.has (opts.key_for_iteration) 
					if b then
						if command_line_parser.valid_options @ opts.key_for_iteration /= Void and then
							(command_line_parser.valid_options @ opts.key_for_iteration).count > 0 then
							popts.put (b, opts.key_for_iteration + " is valid and has at least one argument")
						else
							popts.put (b, opts.key_for_iteration + " is valid but lacks arguments")
							b := False
						end
					end
					Result := Result and b
				when Valid_option_without_arguments then
					b := command_line_parser.valid_options.has (opts.key_for_iteration) 
					if b then
						if command_line_parser.valid_options @ opts.key_for_iteration /= Void and then
							(command_line_parser.valid_options @ opts.key_for_iteration).count > 0 then
							popts.put (b, opts.key_for_iteration + " is valid and but has arguments")
							b := False
						else
							popts.put (b, opts.key_for_iteration + " is valid and has no arguments")
						end
					end
					Result := Result and b
				when Not_valid_option then
					b := not command_line_parser.valid_options.has (opts.key_for_iteration) 
					popts.put (b, opts.key_for_iteration + " is not valid")
					Result := Result and b
				when Required_option_missing then
					b := not command_line_parser.missing_options.has (opts.key_for_iteration) 
					popts.put (b, opts.key_for_iteration + " is missing (required option)")
					Result := Result and b
				when Option_argument_missing then
					b := not command_line_parser.options_with_missing_arguments.has (opts.key_for_iteration) 
					popts.put (b, opts.key_for_iteration + " lacks required option argument")
					Result := Result and b
				when Mutually_exclusive_option then
					b := command_line_parser.mutually_exclusive_options.has (opts.key_for_iteration)
					if b then
						s2 := opts.key_for_iteration + " is mutually exclusive with " + 
							command_line_parser.mutually_exclusive_options @ opts.key_for_iteration
					else
						s2 := opts.key_for_iteration + " is not mutually exclusive"
					end
					popts.put (b, s2)
					Result := Result and b
				when Ambigous_option then
					command_line_parser.ambigous_options.compare_objects
					b := command_line_parser.ambigous_options.has (opts.key_for_iteration)
					if b then
						popts.put (b, opts.key_for_iteration + " is an ambigous long option")
					else
						popts.put (b, opts.key_for_iteration + " is not an ambigous long option")
					end
					Result := Result and b
				when Invalidly_grouped_option then
					command_line_parser.invalidly_grouped_options.compare_objects
					b := command_line_parser.invalidly_grouped_options.has (opts.key_for_iteration)
					if b then
						popts.put (b, opts.key_for_iteration + " is an invalidly grouped option")
					else
						popts.put (b, opts.key_for_iteration + " is not an invalidly grouped option")
					end
					Result := Result and b
				when Operand then
					command_line_parser.operands.compare_objects
					b := command_line_parser.operands.has (opts.key_for_iteration)
					if b then
						popts.put (b, opts.key_for_iteration + " is recognized as an operand")
					else
						popts.put (b, opts.key_for_iteration + " is not recognized as an operand")
					end
					Result := Result and b
				end
				if verbose then
					s := s + "%"" + opts.key_for_iteration + "%""
				end
				opts.forth
				if verbose and then not opts.after then
					s := s + ", "
				end
			end
			if verbose then
--				print ("%NTest: Checking that the options " + s + " was/were parsed correctly ...%N")
				from
					popts.start
				until
					popts.after
				loop
					print ("Test: Option " + popts.key_for_iteration + " ... ")
					if popts.item_for_iteration then
						print ("OK%N")
					else
						print ("FAILED%N")
					end
					popts.forth
				end
			end
			if not Result then
				print_test_failure ("Failed to parse all options and operands as expected.%N")
			end
		end
	
	test_option_has_arguments (opt: STRING; args: ARRAY [STRING]; verbose: BOOLEAN): BOOLEAN
			-- Test that the option named `opt' has the arguments
			-- listed in `args'. Returns True if succesful and
			-- False if not. 
		require
			command_line_syntax_not_void: command_line_syntax /= Void
		        command_line_syntax_is_valid: command_line_syntax.is_valid
			command_line_parser_not_void: command_line_parser /= Void
			opt_not_void: opt /= Void
			args_not_void: args /= Void
		local
			found: BOOLEAN
			i: INTEGER
			s: STRING
			pargs: LIST [STRING]
		do
			if verbose then
--				print ("%NTest: Checking that option " + opt + "has the following arguments ..." + "%N")
			end
			if command_line_parser.valid_options.has (opt) then
				if command_line_parser.valid_options @ opt /= Void then
					pargs := command_line_parser.valid_options @ opt
					from 
						Result := True
						s := ""
						i := args.lower
					until
						i > args.upper
					loop
						from
							found := False
							pargs.start
						until
							found or else pargs.after
						loop
							found := (args @ i).is_equal (pargs.item)
							pargs.forth
						end
						Result := Result and found
						if found then
							if s.count = 0 then
								s := "%"" + args @ i + "%""
							else
								s := s + ", %"" + args @ i + "%""
							end
						end
						i := i + 1
					end
				else
					Result := False
				end
			else
				Result := False
			end
			if Result then
				if verbose then
					print ("Test: Found all the arguments " + s + " for the option " + opt + " ... OK%N")
				end
			else
				print_test_failure ("Found only the following arguments for option " + opt + ": " + s + ".%N")
			end
		end
		
	test_for_single_dash (verbose: BOOLEAN): BOOLEAN
			-- Test that a single dash has been parsed. Returns True
			-- if succesful and False if not. 
		require
			command_line_syntax_not_void: command_line_syntax /= Void
		        command_line_syntax_is_valid: command_line_syntax.is_valid
			command_line_parser_not_void: command_line_parser /= Void
		do
			Result := command_line_parser.single_dash_encountered
			if Result then
				if verbose then
					print ("Test: Single dash encountered ... OK%N")
				end
			else
				print_test_failure ("No single dash encountered.%N")
			end
		end

feature {NONE} -- Implementation (Basic attributes)
	
	command_line_syntax: COMMAND_LINE_SYNTAX
	
	command_line_parser: COMMAND_LINE_PARSER
	
	dashed_line: STRING = "-------------"
	
	double_dashed_line: STRING = "===================="

feature {NONE} -- Implementation (Option states)
	
	Valid_option: INTEGER = 1
	
	Valid_option_with_arguments: INTEGER = 2
	
	Valid_option_without_arguments: INTEGER = 3
	
	Not_valid_option: INTEGER = 4
	
	Required_option_missing: INTEGER = 5
	
	Option_argument_missing: INTEGER = 6
	
	Mutually_exclusive_option: INTEGER = 7
	
	Ambigous_option: INTEGER = 8
	
	Invalidly_grouped_option: INTEGER = 9
	
	Operand: INTEGER = 10
	
feature {NONE} -- Implementation (useful features)
	
	print_test_info
			-- Print some info about this program.
		do
			print ("This program tests ECLOP.%NECLOP is a POSIX/GNU compliant command line parser written in Eiffel.%N%N")
		end
	
	print_command_line (args: ARRAY [STRING])
			-- Print the strings in `args' as if they constitute a
			-- command line invokation of an executable. 
		require
			args_not_void: args /= Void
		local
			i: INTEGER
		do
			print (">")
			from
				i := args.lower
			until
				i > args.upper
			loop
				print (args @ i + " ")
				i := i + 1
			end
			print ("%N")
		end
	
	print_specification (spec: ARRAY [STRING])
			-- Pretty print of the specification `spec'. 
		require
			spec_not_void: spec /= Void
		local
			i: INTEGER
			s: STRING
		do
			s := "<<"
			from
				i := spec.lower
			until
				i > spec.upper
			loop
				s := s + "%"" + spec @ i + "%""
				i := i + 1
				if i > spec.upper then
			    	        s := s + ">>%N"
			        else
					s := s + ",%N  "
				end
			end
			print (s)
		end
	
	print_invalid_specifications (inv_spec: HASH_TABLE [STRING, STRING])
			-- Pretty print of the invalid specifications `inv_spec'.
		require
			inv_spec_not_void: inv_spec /= Void
		local
			s: STRING
		do
			s := ""
			from
				inv_spec.start
			until
				inv_spec.after
			loop
				s := s + inv_spec.item_for_iteration + "%N"
				
				inv_spec.forth
			end
			print (s)
		end
	
	print_test_failure (s: STRING)
			-- Print information about a test failure.
		require
			s_not_void: s /= Void
		do
			print ("TEST FAILED. " + s + "%N")
		end
		
feature -- Implementation (Logging of output)
	
	output_file: PLAIN_TEXT_FILE
			-- The log file for all ouput
	
	open_log
		do
			create output_file.make_open_write ("eclop_out.txt")
		end
	
	close_log
		do
			output_file.close
		end
	
	print (s: STRING)
			-- Print `s' to output and log.
		do
			output_file.put_string (s)
		        precursor (s)
		end
	
end -- class APPLICATION
