indexing
	description: "A list of word occurences, sorted by occurrence"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	WORD_OCCURRENCE_LIST

inherit
	SORTED_TWO_WAY_LIST [WORD_OCCURRENCE]
		rename
			put as put_list
		end
creation
	make

feature -- Access

	put (file_ref: INTEGER) is
			-- Record one occurrence of a word
		require
			file_ref_not_void: file_ref /= Void
		local
			this_occurrence: WORD_OCCURRENCE
		do
			create this_occurrence.make (file_ref)

			search_list (file_ref)
			if -- has this word already been found in this file?
			  exhausted
			then -- this is the first appearance
			  put_front (this_occurrence)

			else -- word has been found, increment the occurrence counter
			  item.increment
			end
		end

	search_list (file_ref: INTEGER) is
			-- Move to first position (at or after current
			-- position) where `item.file_reference' and `v' are equal.
			-- If structure does not include `v' ensure that
			-- `exhausted' will be true.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- (variation on version from BILINEAR)
		require
			file_ref_not_void: file_ref /= Void
		do
			if before and not empty then
				forth
			end
			from
				start
				compare_objects
			until
				exhausted or else (item /= void and then item.file_reference.is_equal (file_ref))
			loop
				forth
			end
		ensure -- from LINEAR
			object_found: (not exhausted and object_comparison) implies equal (file_ref, item.file_reference);
		end;

feature -- Conversion

	set_representation: LINKED_SET [INTEGER] is
			-- Representation of file numbers as a set (no occurrences).
		local
			I: INTEGER
		do
			from
			  start
			  create Result.make
			until
			  off
			loop
			  Result.put_right (item.file_reference)
			  forth
			end
		ensure
			result_not_void: Result /= Void
		end;

end -- class WORD_OCCURRENCE_LIST
