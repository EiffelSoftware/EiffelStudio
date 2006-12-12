indexing
	description: "String of formatting elements that can be filled at any time."
	author: "Etienne Reichenbach (etienner@ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class I18N_FORMAT_STRING


inherit
	I18N_FORMATTING_ELEMENT

create
	make

feature -- Initialization

	make (a_format_string: STRING_32; a_locale_info: I18N_LOCALE_INFO) is
			-- parse `a_format_string' and put parsed data
			-- in `element_list', this can than be filled
			-- with `filled()'
		local
			parser: I18N_FORMAT_STRING_PARSER
		do
			create parser.make (a_locale_info)
			elements_list := parser.parse (a_format_string)
		end

feature --Output

 	filled (a_date: DATE; a_time: TIME): STRING_32 is
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

end -- Class I18N_FORMATTING_ELEMENT
