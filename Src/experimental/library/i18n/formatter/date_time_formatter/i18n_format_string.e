note
	description: "String of formatting elements that can be filled at any time."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_FORMAT_STRING

inherit
	I18N_FORMATTING_ELEMENT

create
	make

feature {NONE} -- Initialization

	make (a_format_string: READABLE_STRING_GENERAL; a_locale_info: I18N_LOCALE_INFO)
			-- parse `a_format_string' and put parsed data
			-- in `element_list', this can than be filled
			-- with `filled()'
		require
			a_format_string_not_void: a_format_string /= Void
			a_locale_info_not_void: a_locale_info /= Void
		local
			parser: I18N_FORMAT_STRING_PARSER
		do
			create parser.make (a_locale_info)
			elements_list := parser.parse (a_format_string)
		end

feature --Output

 	filled (a_date: DATE; a_time: TIME): STRING_32
 			-- fill `elemets_list' with the data in `a_date'
 			-- and `a_time'
 		do
 			create Result.make_empty
			from
				elements_list.start
			until
				elements_list.after
			loop
				Result.append (elements_list.item.filled (a_date, a_time))
				elements_list.forth
			end
 		end

feature {NONE} -- Actions

	elements_list: LINKED_LIST[I18N_FORMATTING_ELEMENT]
		-- list that contains all formatting elements
		-- extracted by a format string

invariant
	correct_element_list: elements_list /= Void

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

end
