note
	description	: "System's root class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_TEST_DICTIONARY

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

	test_dictionary
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
		end

feature {NONE} -- Initialization

	make(t:I18N_DICTIONARY; plural_form,datalength,seed:INTEGER)
			-- Creation procedure.
		do
			set_current_folder(t,plural_form,datalength,seed)
			data_generation(t,datalength,seed)
			data_query(t,datalength,seed)
			data_get(t,datalength,seed)
			if not current_folder.is_closed then
				current_folder.close
			end
		end

	result_file_name (t:I18N_DICTIONARY;plural_form,datalength,seed:INTEGER; a_name: STRING): STRING
			-- This is a hack, since no such facility found in the testing framework, for a file name located in the source class directory.
		do
			Result := environment.get ("ISE_LIBRARY").twin
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("library")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("i18n")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("tests")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("test_files")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("Dictionary")
			Result.append_character (Operating_environment.directory_separator)
			Result.append (directory_name (t, plural_form, datalength, seed))
			Result.append_character (Operating_environment.directory_separator)
			Result.append (a_name)
		end

feature {NONE} -- set current_folder

	directory_name (t:I18N_DICTIONARY;plural_form,datalength,seed:INTEGER): STRING
		do
			Result := t.generating_type + "_TEST_WITH_PLURAL_FORM_"+plural_form.out+"_WITH_DATALENGTH_"+datalength.out+"_WITH_SEED_"+seed.out
		end

	set_current_folder (t:I18N_DICTIONARY;plural_form,datalength,seed:INTEGER)
			-- check the type of t and create new folder in the relevant folder
			-- this class could be extended when a new dictionary structure is added
			-- need plural_form, datalength and seed to make directory uniq
		do
			attr_plural_form := plural_form
			create current_folder.make(current_folder_string
				+directory_name (t, plural_form, datalength, seed))
			if not current_folder.exists then
				current_folder.create_dir
			end
		end

feature {NONE}	-- Data generation

	data_generation(t:I18N_DICTIONARY; datalength,seed:INTEGER)
			-- generate array of `I18N_DICTIONARY_ENTRY' and fill it in `t'
			-- fill 't' with datalength of `I18N_DICTIONARY_ENTRY'
		local
			entry:I18N_DICTIONARY_ENTRY
			random:RANDOM
			i:INTEGER
			singular:STRING_GENERAL
			translated_singular, original_plural: STRING_GENERAL
			file: PLAIN_TEXT_FILE
			l_name, l_generated_name: STRING
			l_fn: STRING
		do
			l_fn := "data_file"
			create random.set_seed (seed)
			l_generated_name := current_folder.name+Operating_environment.Directory_separator.out+l_fn
			create file.make_create_read_write (l_generated_name)
			from
				i:=1
				random.start
			until
				i>datalength
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


				--put `entry' in datastructure
				t.extend (entry)

				-- fill the `file' with the entry
				file.put_string ("entry "+i.out+": %N%
								 %original_singular: "+entry.original_singular.out+"%N%
								 %original_plural: "+entry.original_plural.out+"%N%
								 %singular_translation: "+entry.singular_translation.out+"%N%
								 %plural_translations: (0) "+entry.plural_translations.item (0)+
								 " (1) "+entry.plural_translations.item (1)+
								 " (2) "+entry.plural_translations.item (2)+
								 " (3) "+entry.plural_translations.item (3)+"%N")

				-- to continue the loop
				i:=i+1
				random.forth
			end
			io.put_string ("data generation is finished")
			io.put_new_line
			file.close

			l_name := result_file_name (t, attr_plural_form, datalength, seed, l_fn)
			assert ("Output does not match!", has_same_content_as_path (l_name, l_generated_name))
		end


data_query(t:I18N_DICTIONARY; datalength,seed:INTEGER)
				-- check all query functions in `I18N_DICTIONARY': `has, has_plural'
				-- check all data for every function
				-- use `random' with same `seed'  to check whether they are in `t', one could also use a `linked_list'
				-- to store the data in `data_generation' then use it here to check
				-- use `random' with another `seed' to check whether they are not in `t'
				-- the data_file could also be used, not try it yet
		local
			i,j: INTEGER
			singular: STRING_GENERAL
			translated_singular, original_plural: STRING_GENERAL
			random: RANDOM
			output_file: PLAIN_TEXT_FILE

			l_name, l_generated_name: STRING
			l_fn: STRING
		do
			l_fn := "query_yes_file"
			create random.set_seed (seed)
			l_generated_name := current_folder.name+Operating_environment.Directory_separator.out+l_fn
			create output_file.make_create_read_write (l_generated_name)
			from
				i:=1
				random.start
			until
				i > datalength
			loop
				singular:=random.item.out
				random.forth
				translated_singular:=random.item.out
				random.forth
				original_plural:=random.item.out
				output_file.put_string ("query "+i.out+": %N")
				if t.has (singular) then
					output_file.put_string ("data structure has("+singular.out+")%N")
				else
					output_file.put_string ("data structure do not has("+singular.out+")%N")
				end

				-- `plural_number'>=0

				from
					j:=0
				until
					j>10
				loop
					if t.has_plural (singular,original_plural, j.as_integer_32) then
						output_file.put_string ("data structure has_plural with plural_number: "+j.out+"%N")
					else
						output_file.put_string ("data structure do not has_plural with plural_number: "+j.out+"%N")
					end
					j:=j+1
				end

				-- to skip the four elements in plural translations
				random.forth
				random.forth
				random.forth
				random.forth

				-- to continue the loop
				random.forth
				i:=i+1
			end
			output_file.close
			l_name := result_file_name (t, attr_plural_form, datalength, seed, l_fn)
			assert ("Output does not match!", has_same_content_as_path (l_name, l_generated_name))

			-- query with its non-existent elems

			l_fn := "query_non_file"
			create random.set_seed (seed+1)
			l_generated_name := current_folder.name+Operating_environment.Directory_separator.out+l_fn
			create output_file.make_create_read_write (l_generated_name)
			from
				i:=1
				random.start
			until
				i > datalength
			loop
				singular:=random.item.out
				random.forth
				translated_singular:=random.item.out
				random.forth
				original_plural:=random.item.out
				output_file.put_string ("query "+i.out+": %N")
				if t.has (singular) then
					output_file.put_string ("data structure has("+singular.out+")%N")
				else
					output_file.put_string ("data structure do not has("+singular.out+")%N")
				end


				-- `plural_number'>=0

				from
					j:=0
				until
					j>10
				loop
					if t.has_plural (singular,original_plural, j.as_integer_32) then
						output_file.put_string ("data structure has_plural with plural_number: "+j.out+"%N")
					else
						output_file.put_string ("data structure do not has_plural with plural_number: "+j.out+"%N")
					end
					j:=j+1
				end

			-- to continue the loop
				random.forth
				i:=i+1
			end
			output_file.close
			l_name := result_file_name (t, attr_plural_form, datalength, seed, l_fn)
			assert ("Output does not match!", has_same_content_as_path (l_name, l_generated_name))
			io.put_string ("data query is finished%N")
		end

feature {NONE} -- Data access

	data_get(t:I18N_DICTIONARY; datalength,seed:INTEGER)
				-- check data access functions in `I18N_DICTIONARY': `get_plural, get_sigular'
				-- use 'random' with same `seed' to get them out
				-- use 'random'  with another `seed' get nothing out
				-- again `linked_list' to store the data in `data_generation' could be comfortable
				-- the data_file could also be used, not try it yet
		local
			i,j: INTEGER
			singular: STRING_GENERAL
			translated_singular, original_plural: STRING_GENERAL
			random: RANDOM
			output_file: PLAIN_TEXT_FILE

			l_name, l_generated_name: STRING
			l_fn: STRING
		do
			-- get data with its existent elems
			l_fn := "get_data_file"
			create random.set_seed (seed)
			l_generated_name := current_folder.name+Operating_environment.Directory_separator.out+l_fn
			create output_file.make_create_read_write (l_generated_name)
			from
				i:=1
				random.start
			until
				i > datalength
			loop
				singular:=random.item.out
				random.forth
				translated_singular:=random.item.out
				random.forth
				original_plural:=random.item.out
				output_file.put_string ("get data iteration " + i.out + ": " + "%N")

				if t.has (singular) then
					output_file.put_string ("get_singular(" + singular.as_string_8 + "): "+ t.singular (singular)+"%N")
				else
					output_file.put_string ("not has(" + singular.as_string_8 + "): "+ "%N")
				end


				-- i think `plural_number' could be 0,1,2,3
				-- or 1 2 3 4, i do not know, try them all
				-- actually plural_number >=0
				from
					j:=0
				until
					j>10
				loop
					if t.has_plural (singular,original_plural, j.as_integer_32) then
						output_file.put_string ("get_plural (" + singular.as_string_8 + ","
												+ original_plural.as_string_8 + "," + j.out +"): "
												+ t.plural (singular, original_plural, j.as_integer_32)+"%N")

					else

						output_file.put_string (" not has_plural (" + singular.as_string_8 + ","
												+ original_plural.as_string_8 + "," + j.out +") %N ")
					end
					j:=j+1
				end

				-- to skip the four elements in plural translations
				random.forth
				random.forth
				random.forth
				random.forth

				-- to continue the loop
				random.forth
				i:=i+1
			end
			output_file.close

			l_name := result_file_name (t, attr_plural_form, datalength, seed, l_fn)
			assert ("Output does not match!", has_same_content_as_path (l_name, l_generated_name))

			-- get data  with its non-existent elems
			-- actually we could only get data with its existence

			l_fn := "get_data_non_file"
			create random.set_seed (seed+1)
			l_generated_name := current_folder.name+Operating_environment.Directory_separator.out+l_fn
			create output_file.make_create_read_write (l_generated_name)
			from
				i:=1
				random.start
			until
				i > datalength
			loop
				singular:=random.item.out
				random.forth
				translated_singular:=random.item.out
				random.forth
				original_plural:=random.item.out
				output_file.put_string ("get_data_iteration " + i.out + ": " + "%N")


				if t.has (singular) then
					output_file.put_string ("get_singular(" + singular.as_string_8 + "): "+ t.singular (singular)+"%N")
				else
					output_file.put_string (" not has_singular(" + singular.as_string_8 + ") %N ")
				end

				-- i think `plural_number' could be 0,1,2,3
				-- or 1 2 3 4, i do not know, try them all
				-- actually plural_number >=0
				from
					j:=0
				until
					j>10
				loop
					if t.has_plural (singular,original_plural, j.as_integer_32) then
						output_file.put_string ("get_plural (" + singular.as_string_8 + "," + original_plural.as_string_8 + "," + j.out +"): "
						+ t.plural (singular, original_plural, j.as_integer_32)+"%N")

					else

						output_file.put_string (" not has_plural (" + singular.as_string_8 + "," + original_plural.as_string_8 + "," + j.out +")%N")

					end
					j:=j+1
				end

			-- to continue the loop
				random.forth
				i:=i+1
			end
			output_file.close

			l_name := result_file_name (t, attr_plural_form, datalength, seed, l_fn)
			assert ("Output does not match!", has_same_content_as_path (l_name, l_generated_name))

			io.put_string ("data_get is finished")
		end
feature {NONE} -- access
	attr_plural_form: INTEGER
	current_folder: DIRECTORY
	current_folder_string: STRING_8
		do
			result :=Operating_environment.Current_directory_name_representation+
												Operating_environment.Directory_separator.out
		end


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




end -- class DICTIONARY_TEST
