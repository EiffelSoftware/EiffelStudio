note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_TEST_LOCALE

inherit
	EQA_SYSTEM_TEST_SET
		redefine
			on_prepare
		end

	SHARED_I18N_PLURAL_TOOLS
		undefine
			default_create
		end

	I18N_TEST_UTILITIES
		undefine
			default_create
		end

feature -- Tests

	test_all_locales
			-- test for all locales
		local
			l_list: LINEAR [I18N_LOCALE_ID]
			t: like locale_manager
		do
				-- Uncomment the following line to generate results
			--generate_locale_results

			t := locale_manager
			l_list := t.available_locales
			from
				l_list.start
			until
				l_list.after
			loop
				test_locale (l_list.item_for_iteration, True)
				clean_cache
				l_list.forth
			end
		end

	test_difference_on_platforms
			-- Test indicates that formatting results are different on different platforms.
		do
			assert ("Formatting resuls are different on platforms.",
					has_same_content_as_path (result_file_name ("zh_CN", True), result_file_name ("zh_CN", False)))
		end

feature {NONE} -- Result generation

	generate_locale_results
			-- Generate results of locales available on current machine.
		local
			l_list: LINEAR [I18N_LOCALE_ID]
			t: like locale_manager
		do
			t := locale_manager
			l_list := t.available_locales
			from
				clean_cache
				l_list.start
			until
				l_list.after
			loop
				test_locale (l_list.item_for_iteration, False)
				save_cache_to_file (result_file_name (l_list.item_for_iteration.name, {PLATFORM}.is_unix))
				clean_cache
				l_list.forth
			end
		end

	generated_result_file_name (a_locale_name: STRING): STRING
		do
			Result := Operating_environment.current_directory_name_representation.twin
			Result.append_character (Operating_environment.directory_separator)
			Result.append (a_locale_name)
		end

feature {NONE} -- Preparation

	on_prepare
		do
			create locale_manager.make (Operating_environment.current_directory_name_representation)
		end

feature {NONE} -- Obselete interaction

	interactive
			-- Test with interaction
		local
			t : I18N_LOCALE_MANAGER
			l : I18N_LOCALE_ID
		do
			from
				output_string ("Press ENTER")
				io.read_line
			until
				io.last_string.is_equal("q")
			loop
				output_string ("usage:%N%
								% q: quit%N%
								% l: list of locales%N%
								% locale name to test it%N%
								%type your choice: ")
				io.read_line
				io.new_line
				create l.make_from_string (io.last_string)
				if io.last_string.is_equal ("l") then
					list_locales
				elseif not io.last_string.is_equal ("q") then
					create t.make (Operating_environment.current_directory_name_representation)
					if t.has_locale (l) then
						test_day_months_names (t.locale (l))
						test_date_time_formatter ("local_date_time: &c, day: &A%N", t.locale (l).info)
						test_currency_info (t.locale (l))
						test_currency_formatter (32765139.234, t.locale (l).info)
						test_value_info (t.locale (l))
						test_value_formatter (9.234, t.locale (l).info)
					else
						output_string ("%NNot available%N")
					end
				end
			end
			output_string ("Bye :-)")
		end

	list_locales
			--
		local
			l: I18N_LOCALE_MANAGER
			t_l : LINEAR[I18N_LOCALE_ID]
		do
			create l.make (Operating_environment.current_directory_name_representation)
			t_l := l.available_locales
			from
				t_l.start
			until
				t_l.after
			loop
				print_line (t_l.item.name)
				t_l.forth
			end
		end

feature {NONE} -- Implementation

	test_locale (a_id: I18N_LOCALE_ID; a_compare_out: BOOLEAN)
		local
			t: like locale_manager
			l_locale: I18N_LOCALE
		do
			t := locale_manager
			l_locale := t.locale (a_id)
			output_string ("%N%NTest of locale: ") output_string (l_locale.info.id.name) output_string ("%N")
			test_day_months_names (l_locale)
			test_date_time_formatter ("local_date_time: &c, day: &A%N", l_locale.info)
			test_currency_info (l_locale)
			test_currency_formatter (1324539.234, l_locale.info)
			test_value_info (l_locale)
			test_value_formatter (123559.234, l_locale.info)

				-- Compare the cache with the output file
			if a_compare_out then
				--save_cache_to_file (generated_result_file_name (l_locale.info.id.name))
				if not l_locale.info.id.name.is_empty then
					if attached cached_output as l_output then
						assert ({STRING_32} "Output did not match when testing locale '" + l_locale.info.id.name + "'",
							has_same_content_as_string (result_file_name (l_locale.info.id.name, {PLATFORM}.is_windows), {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_output)))
					else
						assert ("No output", False)
					end
				end
			end
		end

	result_file_name (a_locale_name: READABLE_STRING_GENERAL; a_windows: BOOLEAN): STRING_32
			-- This is a hack, since no such facility found in the testing framework, for a file name located in the source class directory.
		do
			if attached env.item ("ISE_LIBRARY") as l_env then
				Result := l_env.twin
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("library")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("i18n")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("tests")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("test_files")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("locale")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("results")
				Result.append_character (Operating_environment.directory_separator)
				if a_windows then
					Result.append ("windows")
				else
					Result.append ("unix")
				end
				Result.append_character (Operating_environment.directory_separator)
				Result.append_string_general (a_locale_name)
			else
				assert ("ISE_LIBRARY not defined", False)
				create Result.make_empty
			end
		end

	test_currency_formatter (a_value: DOUBLE;locale: I18N_LOCALE_INFO)
			-- test the currency formatter with `a_value'
		local
			currency_formatter: I18N_CURRENCY_FORMATTER
		do
			output_string ("CURRENCY FORMATTER TEST%N")
			create currency_formatter.make (locale)
			output_string ("    Original value: ") output_string (a_value.out) output_string ("%N")
			output_string ("    Formatted: ") output_string (currency_formatter.format_currency (a_value))
			print_line ("")
		end

	test_value_formatter (a_value: DOUBLE;locale: I18N_LOCALE_INFO)
			-- test the currency formatter with `a_value'
		local
			value_formatter: I18N_VALUE_FORMATTER
		do
			output_string ("VALUE FORMATTER TEST%N")
			create value_formatter.make (locale)
			output_string ("    Original value: ") output_string (a_value.out) output_string ("%N")
			output_string ("    Formatted: ") output_string (value_formatter.format_real_64 (a_value))
			print_line ("")
		end

	test_date_time_formatter (a_format_string: STRING_32;locale: I18N_LOCALE_INFO)
			-- test date/time formatter with the format string  `a_format_string'
			-- and the current time
		local
			time: TIME
			date: DATE
			ll: I18N_FORMAT_STRING
		do
			output_string ("DATE TIME FORMATTER TEST%N")
			create time.make (11, 45, 30)
			create date.make (2009, 2, 19)
			create ll.make (a_format_string,locale)
			output_string ("    Original string: ") output_string (a_format_string) output_string ("%N")
			output_string ("    formatted string: ") output_string (ll.filled (date,time)) output_string ("%N")
		end

	test_day_months_names (locale : I18N_LOCALE)
			-- print to `io' all day/month names
		do
			output_string ("DAY/MONTH NAMES TEST%N")
			output_string ("    Abbreviated day names:%N")
			locale.info.abbreviated_day_names.do_all (agent print_string_indented_line (?))
			output_string ("    Full day names:%N")
			locale.info.day_names.do_all (agent print_string_indented_line (?))
			output_string ("    Abbreviated month names:%N")
			locale.info.abbreviated_month_names.do_all (agent print_string_indented_line (?))
			output_string ("    Full month names:%N")
			locale.info.month_names.do_all (agent print_string_indented_line (?))
		end

	test_value_info  (locale : I18N_LOCALE)
			-- print to `io' all value related fields
		do
			output_string ("VALUE INFO TEST%N")
			output_string ("    value dec separator: '") output_string (locale.info.value_decimal_separator) output_string ("'%N")
			output_string ("    value numb after dec. sep: '") output_string (locale.info.value_numbers_after_decimal_separator.out) output_string ("'%N")
			output_string ("    value gr. sep.: '") output_string (locale.info.value_group_separator) output_string ("'%N")
			output_string ("    value nr list sep.: '") output_string (locale.info.value_number_list_separator) output_string ("'%N")
			output_string ("    Grouping: ")
			locale.info.value_grouping.do_all (agent output_integer (?))
			print_line ("")
		end

	test_currency_info (locale : I18N_LOCALE)
			-- print to `io' all currency related fields
		do
			output_string ("CURRENCY INFO TEST%N")
			output_string ("    cur dec sep: '") output_string (locale.info.currency_decimal_separator) output_string ("'%N")
			output_string ("    cur gr.sep: '") output_string (locale.info.currency_group_separator) output_string ("'%N")
			output_string ("    Grouping: ")
			locale.info.currency_grouping.do_all (agent output_integer (?))
			print_line ("")
			output_string ("    cur nr list sep: '") output_string (locale.info.currency_number_list_separator) output_string ("'%N")
			output_string ("    cur num after dec: '") output_string (locale.info.currency_numbers_after_decimal_separator.out) output_string ("'%N")
			output_string ("    currency symbol:'") output_string (locale.info.currency_symbol) output_string ("'%N")
			output_string ("    symbol location: ") output_string (locale.info.currency_symbol_location.out) output_string ("%N")

			output_string ("    INT cur dec sep: '") output_string (locale.info.currency_international_decimal_separator) output_string ("'%N")
			output_string ("    INT cur gr.sep: '") output_string (locale.info.currency_international_group_separator) output_string ("'%N")
			output_string ("    INT Grouping: ")
			locale.info.currency_international_grouping.do_all (agent output_integer (?))
			print_line ("")
			output_string ("    INT cur nr list sep: '") output_string (locale.info.currency_international_number_list_separator) output_string ("'%N")
			output_string ("    INT cur num after dec: '") output_string (locale.info.currency_international_numbers_after_decimal_separator.out) output_string ("'%N")
			output_string ("    INT currency symbol:'") output_string (locale.info.currency_international_symbol) output_string ("'%N")
			output_string ("    INT symbol location: ") output_string (locale.info.currency_international_symbol_location.out) output_string ("%N")
		end

feature {NONE} -- Implementation

	locale_manager: I18N_LOCALE_MANAGER;

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
