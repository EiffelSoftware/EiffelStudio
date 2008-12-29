note
	description	: "System's root class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DICTIONARY_TEST
inherit
	SHARED_I18N_PLURAL_TOOLS
create
	make

feature -- Initialization

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
feature -- set current_folder
	set_current_folder (t:I18N_DICTIONARY;plural_form,datalength,seed:INTEGER)
			-- check the type of t and create new folder in the relevant folder
			-- this class could be extended when a new dictionary structure is added
			-- need plural_form, datalength and seed to make directory uniq
		local
			t_b: I18N_BINARY_SEARCH_ARRAY_DICTIONAY
			t_h: I18N_HASH_TABLE_DICTIONARY
		do
			t_b	?= t
			t_h ?= t


			if t_h /= Void then

					create current_folder.make(current_folder_string
					+"I18N_HASH_TABLE_DICTIONARY_TEST_WITH_PLURAL_FORM"+plural_form.out+"WITH_DATALENGTH_"+datalength.out+"WITH_SEED_"+seed.out)

			elseif t_b /= Void then
					create current_folder.make(current_folder_string
					+"I18N_BINARY_SEARCH_ARRAY_DICTIONARY_TEST_WITH_PLURAL_FORM"+plural_form.out+"WITH_DATALENGTH_"+datalength.out+"WITH_SEED_"+seed.out)
			else
					create current_folder.make(current_folder_string
					+"NEW_DICTIONARY_TEST_WITH_PLURAL_FORM"+plural_form.out+"WITH_DATALENGTH_"+datalength.out+"WITH_SEED_"+seed.out)
			end

			if not current_folder.exists then
				current_folder.create_dir
			end
	end


feature	-- Data generation

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
		do
			create random.set_seed (seed)
			create file.make_create_read_write (current_folder.name+Operating_environment.Directory_separator.out+"data_file")
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
		do
			-- query with its existent elems
			create random.set_seed (seed)
			create output_file.make_create_read_write (current_folder.name+Operating_environment.Directory_separator.out+"query_yes_file")
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

			-- query with its non-existent elems

			create random.set_seed (seed+1)
			create output_file.make_create_read_write (current_folder.name+Operating_environment.Directory_separator.out+"query_non_file")
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
			io.put_string ("data query is finished%N")
		end

feature -- Data access

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
		do

			-- get data with its existent elems
			create random.set_seed (seed)
			create output_file.make_create_read_write (current_folder.name+Operating_environment.Directory_separator.out+"get_data_file")
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
					output_file.put_string ("get_singular(" + singular.as_string_8 + "): "+ t.get_singular (singular)+"%N")
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
												+ t.get_plural (singular, original_plural, j.as_integer_32)+"%N")

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

			-- get data  with its non-existent elems
			-- actually we could only get data with its existence

			create random.set_seed (seed+1)
			create output_file.make_create_read_write (current_folder.name+Operating_environment.Directory_separator.out+"get_data_non_file")
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
					output_file.put_string ("get_singular(" + singular.as_string_8 + "): "+ t.get_singular (singular)+"%N")
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
						+ t.get_plural (singular, original_plural, j.as_integer_32)+"%N")

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
			io.put_string ("data_get is finished")
		end
feature -- access
	current_folder: DIRECTORY
	current_folder_string: STRING_8
		do
			result :=Operating_environment.Current_directory_name_representation+
												Operating_environment.Directory_separator.out
		end


note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DICTIONARY_TEST
