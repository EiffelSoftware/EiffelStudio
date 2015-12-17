note
	description: "Basic tests of DICTIONARY_"
	author: "JSO"
	date: "$21 Dec.2004$"
	revision: "$1.0$"

class
	DICTIONARY_TESTS_BASIC
inherit
	ES_TEST
		redefine
			setup, teardown
		end
create
	make
feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			pred: attached PREDICATE [attached TUPLE]
		do
			pred := agent create_empty_dictionary
			add_boolean_case (pred)
			add_boolean_case (agent add_students_to_dictionary)
			add_boolean_case (agent add_five_students_to_dictionary)
			add_violation_case(agent crash_with_student_not_in_dictionary)
			add_boolean_case (agent test_has)
			add_boolean_case (agent remove_a_student_from_dictionary)
			add_boolean_case (agent remove_last_and_first_student_from_dictionary)
			add_boolean_case (agent insert_people_in_dictionary)
			add_boolean_case (agent defensive_put_void)
			add_boolean_case (agent defensive_put_already_existing_item)
		end

feature -- Tests

	create_empty_dictionary: BOOLEAN
			-- Forces us to choose some implementation
			-- Of course we could fake it and just set `count' to zero
			-- However, subsequent tests will catch this fake.
		local
			d: DICTIONARY_[CHARACTER, STRING]
		do
			comment("create_empty_dictionary%N   forces us to add some implementation for dictionary")
			create d.make
			Result := (d.count = 0) and d.is_empty
		end

	add_students_to_dictionary: BOOLEAN
			-- Add students such as "Snoopy" with grade `64' to dictionary
			-- Forces us to implement `put' and `@'
		local
			d: DICTIONARY_[REAL_64, STRING]
		do
			comment("add_students_to_dictionary%N   forces implemenation of `put' and `@'")
			create d.make
			d.put(64.5, "Snoopy")
			Result := d.count = 1 and d @ "Snoopy" = 64.5
			check Result end
			d.put(87, "Lucy")
			Result  := d.count = 2 and d @ "Snoopy" = 64.5 and d @ "Lucy" = 87
		end

		add_five_students_to_dictionary: BOOLEAN
				-- Tests `setup' and `teardown'
			do
				comment("add_five_students_to_dictionary%N   uses `setup' to add 5 students")
				Result := a_dictionary.count = 5 and a_dictionary @ "Mahalalel" = 65
			end

		crash_with_student_not_in_dictionary
				do
					-- uses `setup'
					comment("*crash_with_student_not_in_dictionary%N  indicates need for precondition `has(k)' in `@'")
					check a_dictionary @ "NoPerson" = 100 end
					-- above should fail and raise an exception
					-- there is no student in `a_dictionary' called "NoPerson"
				end

		test_has: BOOLEAN
			do
				-- uses `setup'
				comment("	test_has%N   checks query `has'")
				Result := a_dictionary.has("Adam")
					and a_dictionary.has("Mahalalel")
					and not a_dictionary.has("NoPerson")
			end

		remove_a_student_from_dictionary: BOOLEAN
				do
					-- uses `setup'
					comment("remove_a_student_from_dictionary")
					a_dictionary.remove("Enosh")
					Result := (a_dictionary.count =  4)
						and a_dictionary @ "Adam" = 99
						and not a_dictionary.has("Enosh")
						and a_dictionary @ "Mahalalel" = 65
				end

		remove_last_and_first_student_from_dictionary: BOOLEAN
				do
					-- uses `setup'
					comment("remove_last_and_first_student_from_dictionary")
					a_dictionary.remove("Adam")
					a_dictionary.remove ("Mahalalel")
					Result := (a_dictionary.count =  3)
						and a_dictionary @ "Seth" = 85
						and a_dictionary @ "Kenan" = 73
						and a_dictionary @ "Enosh" = 80
						and not a_dictionary.has("Adam")
						and  not a_dictionary.has ("Mahalalel")
				end

feature -- Person tests

		insert_people_in_dictionary: BOOLEAN
				--
			local
				d1: DICTIONARY_[PERSON, STRING]
				p1,p2,p3: PERSON
			do
				comment("insert_people_in_dictionary")
				create d1.make
				create p1.make ("Arthur", 24)
				create p2.make("Martha", 23)
				create p3.make("Baby", 1)
				d1.put (p1, "Arthur")
				d1.put (p2, "Martha")
				d1.put (p3,"Baby")
				check
					d1.count = 3
				end
				d1.remove("Arthur")
				d1.remove("Martha")
				Result := not d1.has("Arthur")
					and d1.count = 1
					and d1.has("Baby") and (d1 @ "Baby") = p3
			end

feature -- Defensive put tests

			defensive_put_void: BOOLEAN
					local
						d: like a_dictionary
					do
						comment("defensive_put_void")
						d := a_dictionary.deep_twin
						a_dictionary.put_defensive(0, Void)
						Result := deep_equal(a_dictionary, d)
					end

				defensive_put_already_existing_item: BOOLEAN
						do
							comment("defensive_put_already_existing_item")
							a_dictionary.put_defensive(85, "Seth")
							Result := a_dictionary.count = 5
							check Result end
							a_dictionary.put_defensive(85, "Seth-2")
							Result := a_dictionary.count = 6 and a_dictionary @ "Seth-2" = 85 and a_dictionary @ "Seth" = 85
						end

feature -- Setup & Teardown

	a_dictionary : DICTIONARY_[INTEGER, STRING]

	setup		-- add five students resused in various tests
		local
				k : STRING
				v : INTEGER
		do
				create a_dictionary.make
				k := "Adam"
				v := 99
				a_dictionary.put(v,k)
				k := "Seth"
				v := 85
				a_dictionary.put(v,k)
				k := "Enosh"
				v := 80
				a_dictionary.put(v,k)
				k := "Kenan"
				v := 73
				a_dictionary.put(v,k)
				k := "Mahalalel"
				v :=65
				a_dictionary.put(v,k)
		end

		teardown
				-- delete `a_di	ctionary' thereby restoring the original state
				-- not strictly necessary in this case
			do
				a_dictionary := Void
			end



end -- class DICTIONARY__TESTS_BASIC
