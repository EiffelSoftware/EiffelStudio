note
	description: "Summary description for {ES_TEST_RESULT_GRID_ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_RESULT_GRID_ROW

inherit
	ES_TEST_GRID_ROW
		rename
			make as make_row,
			make_attached as make_attached_row
		redefine
			pixmap,
			refresh
		end

	EV_STOCK_PIXMAPS

	EB_SHARED_WINDOW_MANAGER

create
	make, make_attached

feature {NONE} -- Initialization

	make (a_test_name: like test_name; a_result: like test_result; a_row: like row)
			-- Initialize `Current'.
			--
			-- `a_test_name': Name of test displayed by `Current'.
			-- `a_result': Result displayed by `Current'.
			-- `a_row': Grid row.
		require
			a_test_name_attached: a_test_name /= Void
			a_result_attached: a_result /= Void
			a_row_attached: a_row /= Void
		do
			test_result := a_result
			make_row (a_test_name, a_row)
		ensure
			test_name_set: test_name = a_test_name
			test_result_set: test_result = a_result
			row_set: row = a_row
		end

	make_attached (a_test: like test; a_result: like test_result; a_row: like row)
			-- Initialize `Current'.
			--
			-- `a_test_name': Test displayed by `Current'.
			-- `a_result': Result displayed by `Current'.
			-- `a_row': Grid row.
		require
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
			a_row_attached: a_row /= Void
		do
			test_result := a_result
			make_attached_row (a_test, a_row)
		ensure
			is_attached: is_attached
			test_set: test = a_test
			result_set: test_result = a_result
			row_set: row = a_row
		end

feature -- Access

	test_result: EQA_RESULT
			-- Result displayed by current

	pixmap: detachable EV_PIXMAP
			-- <Precursor>
		do
		end

	result_pixmap: EV_PIXMAP
			-- Pixmap shown in first second item or `row'
		local
			l_result: like test_result
		do
			l_result := test_result
			if l_result.is_pass then
				Result := icon_pixmaps.general_tick_icon
			elseif l_result.is_fail then
				Result := icon_pixmaps.general_error_icon
			else
				Result := icon_pixmaps.general_warning_icon
			end
		end

feature {NONE} -- Implementation

	refresh
			-- <Precursor>
		local
			l_eitem, l_label: EB_GRID_EDITOR_TOKEN_ITEM
			l_token_writer: like token_writer
			l_duration: REAL_64
			l_seconds: INTEGER
			l_fine: TIME
			l_tag: STRING_32
		do
			Precursor
			create l_eitem
			l_token_writer := token_writer
			l_tag := test_result.tag.as_string_32
			if not l_tag.is_empty then
				l_token_writer.add_char (' ')
					--| Twin needed as we might change `l_tag' below while the editor token still refers to it
				l_token_writer.process_basic_text (l_tag.twin)
			end
			l_token_writer.add_comment (" [")
			l_duration := test_result.duration.fine_seconds_count
			l_seconds := l_duration.truncated_to_integer
			create l_fine.make_fine (0, 0, l_duration - l_seconds)
			l_token_writer.add_comment (l_seconds.out)
			l_token_writer.add_comment (l_fine.formatted_out (".ff4"))
			l_token_writer.add_comment ("s]")
			l_eitem.set_text_with_tokens (l_token_writer.last_line.content)
			l_eitem.set_pixmap (result_pixmap)
			reset_token_writer
			row.set_item (2, l_eitem)

			if not test_result.information.is_empty then
				l_tag.append ("%N%N")
				l_tag.append (test_result.information.as_string_32)
			end
			if not l_tag.is_empty then
				l_eitem.set_tooltip (l_tag)
				if attached row.item (1) as l_item then
					l_item.set_tooltip (l_tag)
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
