indexing
	description: "Word list for help index, including files and occurences"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	MODIFIABLE_WORD_HASH

inherit
	HASH_TABLE [WORD_OCCURRENCE_LIST, STRING]
		rename
			put as put_hash
		end

creation
	make

feature -- Element change

	put (word: STRING; file: INTEGER) is
			-- Add `word' to the table if it is not already there.  Otherwise add this file to the file list.
		local
			new_occurrence_list: WORD_OCCURRENCE_LIST
		do
			create new_occurrence_list.make
			new_occurrence_list.put (file)
			put_hash (new_occurrence_list, word)

			item (word).put (file)
		end;

feature -- Transformation

	sort is
			-- Sort the occurrence list attached to each word.
		do
			from
			  start
			  compare_objects
			until
			  off
			loop

			  if  -- Is this list sorted?
			    not item_for_iteration.sorted
			  then
			    item_for_iteration.sort
			  end

			  forth
			end
		end;

feature -- Conversion

	freeze_list: HASH_TABLE [ARRAY [INTEGER], STRING] is
			-- create a frozen version of hash table
		do
			from
			  start
			  create Result.make (count)
			until
			  off
			loop
			  Result.put (item_for_iteration.array_representation, key_for_iteration)
			  forth
			end
		ensure
			result_not_void: Result /= Void
		end;

end -- class MODIFIABLE_WORD_LIST
