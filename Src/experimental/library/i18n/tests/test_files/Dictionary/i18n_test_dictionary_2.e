note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_TEST_DICTIONARY_2

inherit
	I18N_PLURAL_TOOLS
		undefine
			default_create
		end

	EQA_SYSTEM_TEST_SET

	I18N_TEST_UTILITIES
		undefine
			default_create
		end

feature -- Tests

	test_dictionary_2
		local
			l_dic: I18N_DICTIONARY
		do
			create {I18N_CHARACTER_BASED_DICTIONARY} l_dic.make (two_plural_forms_singular_one)
			make (l_dic, two_plural_forms_singular_one, 1, 100)

			create {I18N_CHARACTER_BASED_DICTIONARY} l_dic.make (two_plural_forms_singular_one)
			make (l_dic, two_plural_forms_singular_one, 50, 100)

			create {I18N_HASH_TABLE_DICTIONARY} l_dic.make (two_plural_forms_singular_one)
			make (l_dic, two_plural_forms_singular_one, 50, 100)

			create {I18N_HASH_TABLE_DICTIONARY} l_dic.make (two_plural_forms_singular_one_zero)
			make (l_dic, two_plural_forms_singular_one_zero, 50, 100)

			create {I18N_BINARY_SEARCH_ARRAY_DICTIONARY} l_dic.make (two_plural_forms_singular_one)
			make (l_dic, two_plural_forms_singular_one, 50, 100)

			create {I18N_BINARY_SEARCH_ARRAY_DICTIONARY} l_dic.make (two_plural_forms_singular_one_zero)
			make (l_dic, two_plural_forms_singular_one_zero, 50, 100)

			-- Set breakpoint here and check outputs in `cached_output'.
		end

feature {NONE} -- Initialization

	make (t:I18N_DICTIONARY; plural_form,datalength,seed:INTEGER)

			-- Creation procedure.
		do
			create ods.make
			faults_counter:=0
			data_generation(datalength,seed)
			data_insert(t,datalength)
			data_query(t,datalength)
			data_get(t,datalength)
			output_string ("There are "+faults_counter.out+" mistakes.%N")
			assert ("Found mistakes.", faults_counter = 0)
		end

feature {NONE}	-- Data generation

	data_generation(datalength,seed:INTEGER)
		-- generate random data and put them in
		--`ods'

		local
			entry:I18N_DICTIONARY_ENTRY
			random:RANDOM
			i:INTEGER
			singular:STRING_GENERAL
			translated_singular, original_plural: STRING_GENERAL

		do
			create random.set_seed (seed)

			-- generate some entries without plural forms

			from
				i:=1
				random.start
			until
				i>(datalength/2).ceiling
			loop
				--generate a `entry' for its first three items
				singular:=random.item.out

				random.forth
				translated_singular:=random.item.out
				random.forth
				original_plural:=random.item.out
				create entry.make (singular, translated_singular)

				--put `entry' in `ods'
				ods.extend (entry)

				-- to continue the loop
				i:=i+1
				random.forth
			end


			-- generate some entries without plural forms
			from
				i:=(datalength/2).ceiling+1

			until
				i > datalength
			loop
				--generate a `entry' for its first three items
				singular:=random.item.out

				random.forth
				translated_singular:=random.item.out
				random.forth
				original_plural:=random.item.out

				create entry.make_with_plural (singular, translated_singular, original_plural)

				--fill a `entry' with plural translations
				-- are added by hand!

				random.forth
				entry.plural_translations.enter (random.item.out, 0) -- plural translation 0
				random.forth
				entry.plural_translations.enter (random.item.out, 1) -- plural translation 1
				random.forth
				entry.plural_translations.enter (random.item.out, 2) -- plural translation 2
				random.forth
				entry.plural_translations.enter (random.item.out, 3) -- plural translation 3


				--put `entry' in `ods'
				ods.extend (entry)
				-- to continue the loop
				i:=i+1
				random.forth
			end

		end

feature {NONE}	-- data insertion

	data_insert(t:I18N_DICTIONARY; datalength:INTEGER)
			-- fill 't' with datalength of `I18N_DICTIONARY_ENTRY' from `ods'
		local
			i:INTEGER
		do
			from
				i:=1
			until
				i>datalength
			loop
				t.extend (ods.i_th (i))
				i:=i+1
			end

		end


feature {NONE} -- data query
	data_query(t:I18N_DICTIONARY; datalength:INTEGER)
					-- check all query functions in `I18N_DICTIONARY': `has, has_plural'
					-- check all data for every function
					-- use `random' with same `seed'  to check whether they are in `t', one could also use a `linked_list'
					-- to store the data in `data_generation' then use it here to check
					-- use `random' with another `seed' to check whether they are not in `t'
					-- the data_file could also be used, not try it yet
			local
				i,j: INTEGER
				entry:I18N_DICTIONARY_ENTRY
				singular: STRING_GENERAL
				translated_singular, original_plural: STRING_GENERAL

			do
				output_string ("in feature data_query: %N")
				-- query with its existent elems,check `has'
				from
					i:=1
				until
					i > datalength
				loop
					entry:=ods.i_th (i)
					singular:=entry.original_singular

					translated_singular:=entry.singular_translation

					if t.has (singular) then
						output_string (" has("+singular.out+")---ok--%N")
					else
						output_string ("do not has("+singular.out+")---not ok----%N")
						faults_counter:=faults_counter+1
					end
					i:=i+1
				end
				-- query with its non-existent elems, check `has'
				from
					i:=1
				until
					i > datalength
				loop
					entry:=ods.i_th (i)
					singular:=entry.original_singular+"w"

					translated_singular:=entry.singular_translation

					if t.has (singular) then
						output_string (" has("+singular.out+")---not ok--%N")
						faults_counter:=faults_counter+1
					else
						output_string ("do not has("+singular.out+")--- ok----%N")
					end
					i:=i+1
				end

			-- check `has_plural' function in dictionary
				-- the first half, which do not have plural, e.g has_plural=false
				from
					i:=1
				until
					i > (datalength/2).ceiling
				loop
				entry:=ods.i_th (i)
				singular:=entry.original_singular
				translated_singular:=entry.singular_translation
					if entry.has_plural then
						output_string("entry should not has_plural : mistake in 'test code'--not ok--%N")
						original_plural:=entry.original_plural
						from
							j:=0
						until
							j>10
						loop
							if t.has_plural (singular,original_plural, j.as_integer_32) then
								output_string (" has_plural --not not ok--%N")
								faults_counter:=faults_counter+1
							else
								output_string ("not has_plural --ok--%N")
							end
							j:=j+1
						end
					else
						output_string ("entry should not has_plural --ok---%N")
					end
					i:=i+1
				end

				from
					i:= (datalength/2).ceiling+1
				until
					i > datalength
				loop
				entry:=ods.i_th (i)
				singular:=entry.original_singular
				translated_singular:=entry.singular_translation

					if entry.has_plural then
						output_string("entry should  has_plural --ok--%N")
						original_plural:=entry.original_plural
						from
							j:=0
						until
							j>10
						loop
							if t.has_plural (singular,original_plural, j.as_integer_32) then
								output_string (" has_plural --ok--%N")
							else
								output_string ("should has_plural --not ok--%N")
								faults_counter:=faults_counter+1
							end
							j:=j+1
						end
					else
						output_string ("entry should has_plural: mistake in 'test code' -- not ok---%N")
					end
				i:=i+1
				end

		end

feature {NONE} -- Data access

	data_get(t:I18N_DICTIONARY; datalength:INTEGER)
				-- check data access functions in `I18N_DICTIONARY': `get_plural, get_sigular'

		local
			i,j: INTEGER
			entry:I18N_DICTIONARY_ENTRY
			singular: STRING_GENERAL
			translated_singular, original_plural: STRING_GENERAL

		do
			output_string ("in feature data_get: %N")
			-- get data with its existent elems
			-- check the first half of the entries, which do not have plural form
			from
				i:=1
			until
				i > (datalength/2).ceiling
			loop
				entry:=ods.i_th (i)
				singular:=entry.original_singular

				translated_singular:=entry.singular_translation

				if t.has (singular) and then translated_singular=t.singular (singular) then
					output_string ("get_singular  --ok--%N")
				else
					output_string (" get_singular --not ok--%N")
					faults_counter:=faults_counter+1
				end
				i:=i+1
			end

			-- check the second half of the entries, which have `plural form'
			from
				i:= (datalength/2).ceiling + 1
			until
				i > datalength
			loop
				entry:=ods.i_th (i)
				singular:=entry.original_singular

				translated_singular:=entry.singular_translation

				if t.has (singular) and then translated_singular=t.singular (singular) then
					output_string ("get_singular  --ok--%N")
				else
					output_string (" get_singular --not ok--%N")
					faults_counter:=faults_counter+1
				end

				if entry.has_plural then
					original_plural:=entry.original_plural
					output_string("entry should has_plural--ok-- %N")
						-- actually plural_number >=0
					from
						j:=0
					until
						j>10
					loop
						if t.has_plural (singular,original_plural, j.as_integer_32) then
							original_plural:=entry.original_plural
							if ( t.plural (singular,original_plural, j)/= Void) then
								-- here it depends on j and the constant plural forms
								-- that means, the constant plural forms should be required as correct
								output_string (" get_plural -- ok--%N")
							end
						else
							output_string ("should has_plural -- not ok-- %N ")
							faults_counter:=faults_counter+1
						end
						j:=j+1
					end
				else
					output_string ("entry should has_plural : mistake in test code --not ok-- %N")
				end

				i:=i+1
			end
	end
feature {NONE} -- access

	ods:LINKED_LIST[I18N_DICTIONARY_ENTRY]
		--original_data_set
	faults_counter:INTEGER;

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DICTIONARY_TEST_2
