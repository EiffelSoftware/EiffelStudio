indexing
	description:	"Program to generate word index of help files.  Uses eXML and Gobo Eiffel";
	author: "Parker Abercrombie"
	date: "7/99"

class
	HELP_INDEX_BUILDER
inherit
	EXPAT_ERROR_CODES
	KL_INPUT_STREAM_ROUTINES
	ARGUMENTS
creation

	make

feature -- Initialization

	-- Run time arguments: d:\help\help_index\files -o d:\help\help_index\word_list -b d:\help\help_index\bad_words -p d:\help\help_index\punctuation -g d:\help\help_index\glossary

	make is
		-- Read command line arguements and start processing.
		local
			dir_name: STRING
			error_found: BOOLEAN
		do
			if
			  not error_found
			then
				io.put_string ( "Eiffel Help Index Builder%N" )
				io.new_line

				if
				  ( argument_count > 0 ) and ( argument_count <= 10 )
				  
				then
				  dir_name := clone (argument (1))
				  base_path := clone (dir_name)	

				  if  -- is there a `-o'?
				    index_of_character_option ('o') /= 0
				  then  -- get the name of the file
				    create out_file.make_from_string (argument (index_of_character_option ('o') + 1))
				  else  -- use the default
				    create out_file.make_from_string ("word_list")
				  end		
	
				  if  -- is there a `-b' option?
				    index_of_character_option ('b') /= 0
				  then  -- get the name of the file
				    create bad_words_file_name.make_from_string (argument (index_of_character_option ('b') + 1))
				  else  -- use the default
				    create bad_words_file_name.make_from_string ("bad_words")
				  end	

				  if  -- is there a `-p' option?
				    index_of_character_option ('p') /= 0
				  then  -- get the name of the file
				    create punctuation_file_name.make_from_string (argument (index_of_character_option ('p') + 1))
				  else  -- use the default
				    create punctuation_file_name.make_from_string ("punctuation")
				  end	

				  if  -- is there a `-g' option?
				    index_of_character_option ('g') /= 0
				  then  -- get the name of the file
				    create glossary_file_name.make_from_string (argument (index_of_character_option ('g') + 1))
				  else  -- use the default
				    create glossary_file_name.make_from_string ("glossary")
				  end	

				  if
				    not error_found
				  then
					create index.make
					file_number := 1

					get_bad_words
					get_bad_punctuation
					get_glossary

			 		process_dir ( dir_name )

					io.new_line
					io.new_line
					io.put_string ("Sorting lists.")
					index.liquid_word_list.sort

					index.freeze_index

					index.store_by_name (out_file)

					io.new_line
					io.new_line
					io.put_integer (file_number - 1)
					io.put_string (" files processed%N")
					io.put_integer (index.word_list.count)
					io.put_string (" words added to database%N")
					io.new_line
				 end
			     else
				 print_help
		            end
			else
				io.put_string ( "Execution failed.  Check file names and permissions." )
			end
		rescue
			error_found := TRUE
			retry
		end;

	index: HELP_INDEX
		-- The help index itself.  Includes a `word_list' and a `file_list'.

	base_path: STRING
		-- Path that contains the files to index.

	out_file : FILE_NAME
		-- The name of the output file.

	glossary_file_name: FILE_NAME
		-- The name of the dictionary file.

	bad_words_file_name : FILE_NAME
		-- The name of the bad_words file.

	bad_words : ARRAY [STRING]
		-- The array representation of the bad words.

	punctuation_file_name : FILE_NAME
		-- The name of the punctuation file.

	bad_punctuation: ARRAY [CHARACTER]
		-- The array representation of the bad punctuation.

	file_number : INTEGER
		-- Counter variable, incremented as files are processed.

	parser: XML_TREE_PARSER
		-- The XML parser.

	process_dir (dir_name : STRING) is
			-- Process all the files in directory `dir_name' and all subdirectories.
		require
			name_not_void : dir_name /= Void
		local
			dir : DIRECTORY
			this_file : PLAIN_TEXT_FILE
			file_name : FILE_NAME
		do
			create dir.make_open_read ( dir_name )

			if  -- are there files in the directory?
			  dir.exists
			then

			  from
			    dir.readentry -- skip over `.' and `..'
			    dir.readentry
			    dir.readentry
			  until
			    dir.lastentry = Void
			  loop
			    create file_name.make_from_string ( dir.name)
			    file_name.extend (dir.lastentry)

			    create this_file.make ( file_name )

			    if
			      this_file.is_directory
			    then  -- this is a directory
			      process_dir ( file_name )
			    else -- it is a file
			      process_file ( file_name )
			    end

			    dir.readentry
		  	  end

			else
			  io.put_string ( "No files found in " )
			  io.put_string ( dir_name )
			  io.new_line
			end
		end;

	process_file ( file_name : FILE_NAME ) is
			-- Process file `file_name'.
		require
			name_not_void : file_name /= Void
		local
			temp_name_string: STRING
			temp_name: FILE_NAME
		do
			temp_name_string := clone (file_name)
			temp_name_string.replace_substring_all (base_path, "")
			create temp_name.make_from_string (temp_name_string)

			io.put_string ( "Processing " )
			io.put_string ( temp_name )
			io.put_string ( "%N" )

			index.file_list.force ( temp_name, file_number )

			create parser.make
			get_words ( parse_file ( file_name ) )
			file_number := file_number + 1
		end;

	parse_file (file_name: STRING) : STRING is
			-- Parse `file_name' with eXML and return output.
		require
			file_name_not_void: file_name /= Void
			
		local
			in_file: like INPUT_STREAM_TYPE
			buffer : STRING

		do
			in_file := make_file_open_read (file_name)

			check
				file_open: is_open_read (in_file)
			end

			from
			until
				end_of_input (in_file) or not parser.is_correct
			loop
		
				buffer := read_string (in_file, 10)

				if
					buffer.count > 0
				then
					parser.parse_string (buffer)
				else
					parser.set_end_of_file	
				end

				if
					not parser.is_correct
				then
					print (parser.last_error_extended_description)
				end
			end
			close (in_file)

			Result := parser.out

		end;

	get_bad_words is
			-- Load the `bad_words' array from the file named `bad_words_file_name'.
		local
			bad_words_file : PLAIN_TEXT_FILE
		do
			create bad_words_file.make_open_read ( bad_words_file_name )
			if
			  bad_words_file.exists and bad_words_file.is_readable
			then
			  create bad_words.make ( 1, 1 )

			  from
			  until
			    bad_words_file.exhausted
			  loop
			    bad_words_file.read_line
			    bad_words.grow ( bad_words.upper + 1 )
			    bad_words.enter ( clone ( bad_words_file.last_string ), bad_words.upper )
			  end

			else
			  io.put_string ( "Cannot read from " )
			  io.put_string ( bad_words_file_name )
			  io.new_line
			end

			bad_words_file.close
			bad_words.compare_objects
		end;

	get_glossary is
			-- Load the glossary from the file named `glossary_file_name'.
		local
			glossary_file : PLAIN_TEXT_FILE
			word, definition: STRING
		do
			create glossary_file.make_open_read ( glossary_file_name )
			if
			  glossary_file.exists and glossary_file.is_readable
			then

			  from
			  until
			    glossary_file.exhausted
			  loop
			    glossary_file.read_line
			    word := clone (glossary_file.last_string)

			    word.left_adjust
			    word.right_adjust

			    if
				word.count > 0
			    then
 			       glossary_file.read_line
			       definition := clone (glossary_file.last_string)

			   	 definition.left_adjust
			  	 definition.right_adjust

			       index.glossary.put (definition, word)
			    end

			  end

			else
			  io.put_string ( "Cannot read from " )
			  io.put_string ( glossary_file_name )
			  io.new_line
			end

			glossary_file.close
		end;

	get_bad_punctuation is
			-- Load the `bad_punctuation array from the file named `punctuation_file_name'.
		local
			punctuation_file : PLAIN_TEXT_FILE
		do
			create punctuation_file.make_open_read ( punctuation_file_name )
			if
			  punctuation_file.exists and punctuation_file.is_readable
			then
			  create bad_punctuation.make ( 1, 1 )

			  from
			  until
			    punctuation_file.exhausted
			  loop
			    punctuation_file.read_character
			    bad_punctuation.force (punctuation_file.last_character, bad_punctuation.upper + 1)
			  end

			else
			  io.put_string ( "Cannot read from " )
			  io.put_string ( punctuation_file_name )
			  io.new_line
			end

			punctuation_file.close
		end;

	get_words ( text : STRING ) is
			-- Extract words from `text' and add them to `index'.
		require
			text_not_void : text /= Void
		local
			word : STRING
			next, last, I : INTEGER
		do

			-- trim white space and convert string to lowercase
			text.left_adjust
			text.right_adjust
			text.to_lower

			-- cut puctuation
			from
			  I := 1
			until
			  I > (bad_punctuation.upper)
			loop
			  text.prune_all (bad_punctuation.entry (I))
			  I := I + 1
			end

			text.replace_substring_all ("%N", " ")
			text.replace_substring_all ("%T", " ")

			-- add a space to the end so the loop below will work
			text.append_character (' ')

			-- loop to cut words out of string
		  	last := 1
			from
			  I := 1
			invariant
			  valid_index : I > 0
			variant
			  decreasing_index : (text.occurrences (' ') + 1) - I
			until
			  I > text.occurrences (' ')
			loop
			  next := text.index_of (' ', last)
			  word := text.substring (last, (next - 1))

			  if -- add the word if isn't "" and isn't in the `bad_words' array
			    (word.count > 0) and (not bad_words.has (word))
			  then
			    index.liquid_word_list.put (word, file_number)
			  end

			  last := next + 1
			  I := I + 1
			end

		end;

	print_help is
			-- Print help message.
		do
			io.put_string ("Usage: index start_dir [-g glossary] [-o out_file] [-b bad_words] [-p punctuation]%N")
			io.put_string ("start_dir - directory to index%N")
			io.put_string ("glossary - file that contains the glossary (default: glossary)%N")
			io.put_string ("%Tformat:%N")
			io.put_string ("%Tword%N")
			io.put_string ("%Tdefinition%N")
			io.put_string ("out_file - name to give to created file (default: word_list)%N")
			io.put_string ("bad_words - file that contains words to ignore, 1 per line (default: bad_words)%N")
			io.put_string ("punctuation - file that contains punctuation to exclude, all on 1 line (default: punctuation)")
		end;

end -- class ROOT_CLASS
