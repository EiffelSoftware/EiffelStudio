note
	description: "Collects and initializes some data."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TEST_DATA

inherit

	PS_ABEL_EXPORT

create
	make

feature

	people: LIST [TEST_PERSON]
			-- A list of 4 persons

	flat_class: FLAT_CLASS_1
			-- An object containing all basic types

	data_structures_1: DATA_STRUCTURES_CLASS_1
			-- An object containing the most common data structures in EiffelBase.

	reference_to_single_other: REFERENCE_CLASS_1
			-- A reference class object that points to another one of its kind.

	reference_cycle: REFERENCE_CLASS_1
			-- 1 references 2, 2 references 3, 3 references 1 and 2

	void_reference: REFERENCE_CLASS_1
			-- an object containing at least one void reference

	tuple_query: detachable PS_TUPLE_QUERY [ANY]

	array_of_persons: ARRAY [TEST_PERSON]
			-- An array of 4 persons

	special_of_persons: SPECIAL [TEST_PERSON]
			-- A special object of 4 persons

	array_of_integers: ARRAY [INTEGER]
			-- An integer array with numbers from 1 to 10

	reference_chain: CHAIN_HEAD
			-- A chain of objects with one head and exactly 10 tail objects

	escher_test: ESCHER_TEST_CLASS
			-- An ESCHER test object with version = 3

	escher_test_2: ESCHER_TEST_CLASS_2
			-- An ESCHER test object


	evil_object: detachable GENERIC_BOX [
		GENERIC_BOX [REFERENCE_CLASS_1, detachable ANY],
		EXPANDED_GENERIC_BOX [detachable SPECIAL [ANY], detachable SPECIAL [EXPANDED_PERSON]]]


feature {NONE} -- Initialization


	create_evil_object
		local
			first_part: GENERIC_BOX [REFERENCE_CLASS_1, detachable ANY]
			second_part: EXPANDED_GENERIC_BOX [detachable SPECIAL [ANY], detachable SPECIAL [EXPANDED_PERSON]]

			any_special: SPECIAL [ANY]
			person_special: SPECIAL [EXPANDED_PERSON]

			tmp: EXPANDED_GENERIC_BOX [INTEGER, detachable STRING]
			any_special_object: EXPANDED_GENERIC_BOX [INTEGER, EXPANDED_GENERIC_BOX [INTEGER, detachable STRING]]
		do
			create any_special.make_empty (5)

			create tmp.set_item (42, "a_string")
			create any_special_object.set_item (1, tmp)

			any_special.extend (any_special_object)
			any_special.extend (create {CHAIN_TAIL}.make (21))
			any_special.extend ("hello world")
			any_special.extend (123.45)

			create person_special.make_filled (create {EXPANDED_PERSON}, 3)
			person_special [1] := create {EXPANDED_PERSON}.make ("another", "name", 100)

			create second_part.set_item (any_special, person_special)

			create first_part.set_item (
				reference_cycle,
				--create {REFERENCE_CLASS_1}.make (50),
				create {ANY_BOX}.set_item (any_special))

			create evil_object.set_item (first_part, second_part)
		end


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			ref2, ref3: REFERENCE_CLASS_1
			i: INTEGER
			tail: CHAIN_TAIL
		do
			fill_people
			create flat_class.make
			create data_structures_1.make
			create void_reference.make (100)
			create reference_cycle.make (1)
			create ref2.make (2)
			create ref3.make (3)
			reference_cycle.add_ref (ref2)
			ref2.add_ref (ref3)
			ref3.add_ref (reference_cycle)
			reference_cycle.references.extend (ref2)
			ref2.references.extend (ref3)
			ref3.references.extend (reference_cycle)
			ref3.references.extend (ref2)
				--			ref3.references.extend (create {REFERENCE_CLASS_1}.make (5))
				--			reference_1.ref_arrays.grow (1)
				--			reference_1.ref_arrays [1]:= ref2
			create reference_to_single_other.make (1)
			create ref2.make (2)
			reference_to_single_other.add_ref (ref2)
			create special_of_persons.make_empty (5)
			across
				people as p
			loop
				special_of_persons.extend (p.item)
			end
			create array_of_persons.make_from_special (special_of_persons.deep_twin)
			create array_of_integers.make_filled (0, 1, 10)
			from
				i := 1
			until
				i > 10
			loop
				array_of_integers [i] := i
				i := i + 1
			end
			from
				create tail.make (1)
				create reference_chain.make (tail)
				i := 2
			until
				i > 10
			loop
				tail.set_tail (create {CHAIN_TAIL}.make (i))
				tail := tail.next
				i := i + 1
			end
			create escher_test.make ("first", 2143)
			create escher_test_2.make ("first", 23, "24", "25")

--			create_evil_object
		end

	fill_people
			-- Add some persons to `people'
		local
			pe: TEST_PERSON
		do
			create {ARRAYED_LIST [TEST_PERSON]} people.make (4)
			create pe.make ("Albo", "Bitossi", 3)
			people.extend (pe)
			create pe.make ("Berno", "Citrini", 5)
			people.extend (pe)
			create pe.make ("Crispo", "Danesi", 3)
			people.extend (pe)
			create pe.make ("Dumbo", "Ermini", 2)
			people.extend (pe)
		end

end
