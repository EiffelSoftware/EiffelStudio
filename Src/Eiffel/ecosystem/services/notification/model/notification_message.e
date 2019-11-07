note
	description: "Summary description for {ES_NOTIFICATION_MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_MESSAGE

create
	make

create {NOTIFICATION_MESSAGE}
	make_with_date

feature {NONE} -- Creation

	make (txt: READABLE_STRING_GENERAL; a_category: READABLE_STRING_GENERAL)
		do
			make_with_date (txt, a_category, create {DATE_TIME}.make_now)
		end

	make_with_date (txt: READABLE_STRING_GENERAL; a_category: detachable READABLE_STRING_GENERAL; dt: like date)
		do
			create text.make_from_string_general (txt)
			create category.make_from_string_general (a_category.as_lower)
			date := dt
		end

feature -- Access

	date: DATE_TIME

	text: IMMUTABLE_STRING_32

	category: IMMUTABLE_STRING_32

	is_acknowledged: BOOLEAN
			-- Message acknowledged?
			-- i.e either dismissed by user, or action taken by user.
			-- if auto dismissed, then not acknowledged.

feature -- Element change

	mark_acknowledged
		do
			is_acknowledged := True
		end

feature -- Conversion

	to_archive: NOTIFICATION_MESSAGE
			-- Copy of Current message for archiving.
		do
			create Result.make_with_date (text, category, date.twin)
			if is_acknowledged then
				Result.mark_acknowledged
			end
		end

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
