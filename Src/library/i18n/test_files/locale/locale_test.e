note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOCALE_TEST

	inherit
		SHARED_I18N_PLURAL_TOOLS
create
	make

feature -- Initialization

	make
			-- Creation procedure.
		do
			io.put_string ("%N###############%N")
			io.put_string ("%NTest:%N")
--			interactive
			test_all_locales
			io.put_string ("%N###############%N")
		end


feature --Tests

	test_all_locales
			-- test for all locales
		local
			l_list: LINEAR[I18N_LOCALE_ID]
			t : I18N_LOCALE_MANAGER
		do
			create t.make (Operating_environment.current_directory_name_representation)
			l_list := t.available_locales
			from
				l_list.start
			until
				l_list.after
			loop
				io.put_string ("Test of locale: "+t.get_locale (l_list.item).info.id.name+"%N")
				test_day_months_names (t.get_locale (l_list.item))
				test_date_time_formatter ("local_date_time: &c, day: &A%N", t.get_locale (l_list.item).info)
				test_currency_info (t.get_locale (l_list.item))
				test_currency_formatter (1324539.234, t.get_locale (l_list.item).info)
				test_value_info (t.get_locale (l_list.item))
				test_value_formatter (123559.234, t.get_locale (l_list.item).info)
				l_list.forth
			end
		end


	interactive
			-- Test with interaction
		local
			t : I18N_LOCALE_MANAGER
			l : I18N_LOCALE_ID
		do
			from
				io.put_string ("Press ENTER")
				io.read_line
			until
				io.last_string.is_equal("q")
			loop
				io.put_string ("usage:%N%
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
						test_day_months_names (t.get_locale (l))
						test_date_time_formatter ("local_date_time: &c, day: &A%N", t.get_locale (l).info)
						test_currency_info (t.get_locale (l))
						test_currency_formatter (32765139.234, t.get_locale (l).info)
						test_value_info (t.get_locale (l))
						test_value_formatter (9.234, t.get_locale (l).info)
					else
						io.put_string ("%NNot available%N")
					end
				end
			end
			io.put_string ("Bye :-)")
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
				io.put_string (t_l.item.name+"%N")
				t_l.forth
			end
		end

	test_currency_formatter (a_value: DOUBLE;locale: I18N_LOCALE_INFO)
			-- test the currency formatter with `a_value'
		local
			currency_formatter: I18N_CURRENCY_FORMATTER
		do
			io.put_string ("CURRENCY FORMATTER TEST%N")
			create currency_formatter.make (locale)
			io.put_string ("    Original value: "+a_value.out+"%N")
			io.put_string ("    Formatted: "+currency_formatter.format_currency (a_value))
			io.new_line
		end

	test_value_formatter (a_value: DOUBLE;locale: I18N_LOCALE_INFO)
			-- test the currency formatter with `a_value'
		local
			value_formatter: I18N_VALUE_FORMATTER
		do
			io.put_string ("VALUE FORMATTER TEST%N")
			create value_formatter.make (locale)
			io.put_string ("    Original value: "+a_value.out+"%N")
			io.put_string ("    Formatted: "+value_formatter.format_real_64 (a_value))
			io.new_line
		end

	test_date_time_formatter (a_format_string: STRING_32;locale: I18N_LOCALE_INFO)
			-- test date/time formatter with the format string  `a_format_string'
			-- and the current time
		local
			time: TIME
			date: DATE
			ll: I18N_FORMAT_STRING
		do
			io.put_string ("DATE TIME FORMATTER TEST%N")
			create time.make_now
			create date.make_now
			create ll.make (a_format_string,locale)
			io.put_string ("    Original string: "+a_format_string+"%N")
			io.put_string ("    formatted string: "+ll.filled (date,time)+"%N")
		end


	test_day_months_names (locale : I18N_LOCALE)
			-- print to `io' all day/month names
		do
			io.put_string ("DAY/MONTH NAMES TEST%N")
			io.put_string ("    Abbreviated day names:%N")
			locale.info.abbreviated_day_names.do_all (agent print_string (?))
			io.put_string ("    Full day names:%N")
			locale.info.day_names.do_all (agent print_string (?))
			io.put_string ("    Abbreviated month names:%N")
			locale.info.abbreviated_month_names.do_all (agent print_string (?))
			io.put_string ("    Full month names:%N")
			locale.info.month_names.do_all (agent print_string (?))
		end

	test_value_info  (locale : I18N_LOCALE)
			-- print to `io' all value related fields
		do
			io.put_string ("VALUE INFO TEST%N")
			io.put_string ("    value dec separator: '"+locale.info.value_decimal_separator+"'%N")
			io.put_string ("    value numb after dec. sep: '"+locale.info.value_numbers_after_decimal_separator.out+"'%N")
			io.put_string ("    value gr. sep.: '"+locale.info.value_group_separator+"'%N")
			io.put_string ("    value nr list sep.: '"+locale.info.value_number_list_separator+"'%N")
			io.put_string ("    Grouping: ")
			locale.info.value_grouping.do_all (agent io.put_integer (?))
			io.put_new_line
		end

	test_currency_info (locale : I18N_LOCALE)
			-- print to `io' all currency related fields
		do
			io.put_string ("CURRENCY INFO TEST%N")
			io.put_string("    cur dec sep: '"+locale.info.currency_decimal_separator+"'%N")
			io.put_string("    cur gr.sep: '"+locale.info.currency_group_separator+"'%N")
			io.put_string ("    Grouping: ")
			locale.info.currency_grouping.do_all (agent io.put_integer (?))
			io.put_new_line
			io.put_string("    cur nr list sep: '"+locale.info.currency_number_list_separator+"'%N")
			io.put_string("    cur num after dec: '"+locale.info.currency_numbers_after_decimal_separator.out+"'%N")
			io.put_string("    currency symbol:'"+locale.info.currency_symbol+"'%N")
			io.put_string ("    symbol location: "+locale.info.currency_symbol_location.out+"%N")

			io.put_string("    INT cur dec sep: '"+locale.info.currency_international_decimal_separator+"'%N")
			io.put_string("    INT cur gr.sep: '"+locale.info.currency_international_group_separator+"'%N")
			io.put_string ("    INT Grouping: ")
			locale.info.currency_international_grouping.do_all (agent io.put_integer (?))
			io.put_new_line
			io.put_string("    INT cur nr list sep: '"+locale.info.currency_international_number_list_separator+"'%N")
			io.put_string("    INT cur num after dec: '"+locale.info.currency_international_numbers_after_decimal_separator.out+"'%N")
			io.put_string("    INT currency symbol:'"+locale.info.currency_international_symbol+"'%N")
			io.put_string ("    INT symbol location: "+locale.info.currency_international_symbol_location.out+"%N")
		end



feature {NONE} -- Help function

	print_string (a_string: STRING_32)
			--
		do
			io.put_string ("  "+a_string+"%N")
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




end
