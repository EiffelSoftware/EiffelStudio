indexing
	description: "Command to search word database."
	author: "Parker Abercrombie"
	date: "$Date$"

class
	SEARCH_COMMAND

inherit
	EV_COMMAND

feature -- Basic Operations

	execute (arg: EV_TUPLE_ARGUMENT; data: EV_EVENT_DATA) is
			-- Search the database for the words in `arg'
		require else
			arg_not_void: arg /= Void
			correct_arg_count: arg.count = 5
		do
			search_field ?= arg.item (1)
			search_mode ?= arg.item (2)
			results_list ?= arg.item (3)
			index ?= arg.item (4)
			target_display ?= arg.item (5)

			-- Clear the results list
			results_list.clear_items

			search (search_field.text, search_mode.selected_item.text)
		end;

feature -- Access 

	search_field: EV_TEXT_FIELD
		-- The words to search for.

	search_mode: EV_COMBO_BOX
		-- The selected search mode, may be "all words" or "any word".

	results_list: EV_LIST
		-- The results of the search.

	index: HELP_INDEX
		-- The help index.

	target_display: HELP_DOCUMENT_DISPLAY
		-- The text area that will display the documents.

	search (words, mode: STRING) is
			-- Search `index' for the contents of `search_field'. `Mode' specifies method of searching ("all words" or "any word").
		require
			words_not_void : words /= Void
			valid_mode: (mode.is_equal ("any word")) or (mode.is_equal ("all words"))
		local
			word: STRING
			next, last, I: INTEGER
			files: LINKED_SET [INTEGER]
			this_file: STRING
			results_entry: EV_LIST_ITEM

			display_cmd: DISPLAY_COMMAND
			display_arg: EV_ARGUMENT3 [STRING, EV_LIST, HELP_DOCUMENT_DISPLAY]
		do
			create files.make

			-- trim white space and convert string to lowercase
			words.left_adjust
			words.right_adjust
			words.to_lower

			-- add a space to the end so the loop below will work
			words.append_character ( ' ' )

			-- loop to cut words out of string
			from
			  I := 1
		  	  last := 1
			invariant
			  valid_index: I > 0
			variant
			  decreasing_index: ( words.occurrences ( ' ' ) + 1 ) - I
			until
			  I > words.occurrences ( ' ' )
			loop
			  next := words.index_of ( ' ', last )
			  word := words.substring ( last, ( next - 1 ) )

			  if -- add the word if isn't ""
			    (word.count > 0) and index.word_list.has (word)
			  then

				if  -- Is this the first word in the string?
				  not files.empty
				then

					if
					  mode.is_equal ("all words")
					then
				         files.intersect (index.word_list.item (word))
					else
					   files.merge (index.word_list.item (word))
					end

				else
				  files := deep_clone (index.word_list.item (word))
				end

			  else -- The word is not in the table.

			    if  -- Are we matching all words?
				mode.is_equal ("all words")
			    then -- Yes, so clear anything we've found so far.
			       files.wipe_out
			    end

			  end

			  last := next + 1
			  I := I + 1
			end

			-- Add the search results to `results_list'
			from
			  files.start
			until
			  files.exhausted
			loop
			  create results_entry.make_with_text (results_list, document_title (index.file_list.item (files.item)))
			  results_entry.set_data (index.file_list.item (files.item))

			  create display_cmd
			  create display_arg.make (index.base_path, results_list, target_display)
			  results_entry.add_double_click_command (display_cmd, display_arg)

			  files.forth
			end

		end;

	document_title (path: STRING): STRING is
			-- Extract the file name from `path' and convert underscores to spaces to create a readable title.
			-- Note: `path' must not include both `/' and `\'.
		require
			path_not_void: path /= Void
			one_separator: path.has ('/') xor path.has ('\')
		local
			path_separator: CHARACTER
		do
			if
			   path.has ('/')
			then
			   path_separator := '/'
			else
			   path_separator := '\'
			end

			-- Remove path
			Result := path.substring (path.last_index_of (path_separator, path.count) + 1, path.count)

			-- Remove extension
			Result := Result.substring (2, Result.last_index_of ('.', Result.count) - 1)

			-- Replace underscores with spaces
			Result.replace_substring_all ("_", " ")

		ensure
			title_found: Result /= Void
		end;

end -- class SEARCH_COMMAND
