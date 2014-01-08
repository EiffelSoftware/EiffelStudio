note
	description: "Implementation of DICTIONARY that stores entries in a sorted array and uses binary search to retrieve them"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2006-10-02 09:59:08  (Mon, 02 Oct 2006)$"
	revision: "$Revision$"

class
	I18N_BINARY_SEARCH_ARRAY_DICTIONARY
			--	the `array' should be sorted
			--  the `size' of `array' should be given by its client,which is not the case any more
			--  the index of `array' arranges from 1 to max_index, but which could also be resible
			--  max_index should be >=1
			--  I think there is something wrong with `array.full' in class ARRAY, that is implemation from Eiffel

inherit

	I18N_DICTIONARY
		redefine
			make
		end

create
	make

feature {NONE} --Creation

	make (a_plural_form: INTEGER)
			-- create the datastructure
		do
			Precursor (a_plural_form)
			create array.make_empty
			current_index := 1
		end

feature --Insertion

	extend (a_entry: I18N_DICTIONARY_ENTRY)
			-- a_entry is not duplicated, duplicate is precondition
			-- add an entry to `array' without sorting it
			-- auto resize when the capacity of `array' is filled
			-- without duplicate check, let insertion_sort do it
		do
			array.force (a_entry, current_index)
			current_index := current_index + 1
			search_index_and_insert
		end

feature {NONE} -- help functions

	search_index_and_insert
			-- `array' is sorted except the last  inserted element
			-- after every `insert' is insertion_sort is called
			-- compare with its neighbour recursively until the right_index for it is found
			-- subcopy  `array' from the right_index to current_index-2  to position from right_index-1
			-- put the last_input in `array' with right_index
		local
			left, right, middle: INTEGER
			cur_entry, l_entry1, l_entry2: detachable I18N_DICTIONARY_ENTRY
			mid_entry: detachable I18N_DICTIONARY_ENTRY
			right_index: INTEGER
			l_last_index: INTEGER
		do
				-- one element case will do nothing
			l_last_index := current_index - 1
			if (l_last_index > 1) then
				cur_entry := array.item (l_last_index)
				l_entry1 := array.item (1)
				l_entry2 := array.item (l_last_index - 1)
				if cur_entry < l_entry1 then
					right_index := 1
				elseif cur_entry > l_entry2 then
					right_index := l_last_index
				else
						--cur_entry < array.item (l_last_index-1) and cur_entry > array.item(1)
						-- search the right index for the last inserted elem
						-- with binary search
					from
						left := 2
						right := l_last_index - 2
					until
						left > right
					loop
						middle := ((left + right).as_natural_32 |>> 1).as_integer_32
						mid_entry := array.item (middle)
						if cur_entry < mid_entry then
							right := middle - 1
						else
							left := middle + 1
						end
					end
					right_index := left
				end
					-- put the last inserted elem in the right index
				if right_index /= l_last_index then
					array.subcopy (array, right_index, l_last_index - 1, right_index + 1)
					array.put (cur_entry, right_index)
				end
			end
		end

	has_index (a_id: READABLE_STRING_GENERAL): INTEGER
			-- does the dictionary have this entry?
			-- use binary search algorithm
			-- require `array' is sorted
			-- return the Index of the found item
			-- return -1 if not found
			-- based only on the  `key item', no info about translation items
		require
			original_not_void: a_id /= Void
		local
			left, right, middle: INTEGER
			m_string: STRING_32
			found: BOOLEAN
			l_id: STRING_32
			l_last_index: INTEGER
		do
			from
				l_last_index := current_index - 1
				left := min_index
				right := l_last_index
				l_id := a_id.as_string_32
			invariant
				right < l_last_index
						implies (attached array.item (right + 1) as l_item1 and then attached array.item (l_last_index) as l_item2 and then l_item1 <= l_item2)
				left <= l_last_index and left > min_index
						implies (attached array.item (left - 1) as l_item3 and then attached array.item (l_last_index) as l_item4 and then l_item3 <= l_item4)
			until
				left > right or found
			loop
				middle := ((left + right).as_natural_32 |>> 1).as_integer_32
				if attached array.item (middle) as l_m then
					m_string := l_m.identifier
				else
					check always_has_item: False end
					create m_string.make_empty
				end

				if l_id < m_string then
					right := middle - 1
				elseif l_id > m_string then
					left := middle + 1
						---?? i do not know whether original could be used or not
				else
						--Found
					found := True
					Result := middle
					left := left + 1 -- not nice but required to decrease variant
				end
			variant
				right - left + 1
			end
			if found = False then
				Result := -1
			end
		end

feature -- Query

	has_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Does the dictionary have this entry?
			-- use binary search algorithm
			-- require `array'is sorted
			-- use has_index has a help function
		local
			index: INTEGER
		do
			index := has_index (id_from_original_and_context (original, a_context))
			if index /= -1 then
				Result := True
			end
		end

	singular_in_context (original: READABLE_STRING_GENERAL; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- Singular form
		local
			index: INTEGER
		do
			index := has_index (id_from_original_and_context (original, a_context))
			if index /= -1 and then attached array.item (index) as l_entry then
				Result := l_entry.singular_translation
			end
		end

	plural_in_context (original_singular, original_plural: READABLE_STRING_GENERAL; plural_number: INTEGER; a_context: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- Plural form
		local
			index: INTEGER
		do
			index := has_index (id_from_original_and_context (original_singular, a_context))
			if index /= -1 and then attached array.item (index) as l_entry and then l_entry.has_plural then
				Result := l_entry.plural_translations.item (reduce (plural_number))
			end
		end

feature --Information

	count: INTEGER
		do
			Result := current_index - 1
		end

feature {NONE} -- Implementation

	array: ARRAY [I18N_DICTIONARY_ENTRY]

	min_index: INTEGER = 1

	current_index: INTEGER
			-- the index which is to be filled next

invariant
	count_equal_current_index: count = current_index - 1

note
	library: "Internationalization library"
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
