note
	description: "Summary description for {FILE_SUGGESTION_PROVIDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_SUGGESTION_PROVIDER

inherit
	SUGGESTION_PROVIDER

create
	make

feature {NONE} -- Make

	make (dn: READABLE_STRING_GENERAL)
		do
			create location.make_from_string (dn)
		end

	location: PATH

feature -- Access

	query_with_callback_and_cancellation (a_expression: READABLE_STRING_GENERAL; a_termination: detachable PROCEDURE;
				a_callback: PROCEDURE [SUGGESTION_ITEM]; a_cancel_request: detachable PREDICATE)
			-- Given a query `a_expression', and for each result execute `a_callback' until all results have been
			-- obtained or if `a_cancel_request' returns True.
			-- When list is fully built, `a_termination' will be called regardless of the cancellation of the query.
		local
			l_item: CUSTOM_LABEL_SUGGESTION_ITEM
			d: DIRECTORY
		do
			if a_cancel_request /= Void then
				across data (a_expression) as l_data until a_cancel_request.item (Void) loop
					create l_item.make (l_data.item.text)
					l_item.set_displayed_text (l_data.item.displayed_text)
					a_callback.call ([l_item])
				end
			else
				across data (a_expression) as l_data loop
					create l_item.make (l_data.item.text)
					l_item.set_displayed_text (l_data.item.displayed_text)
					a_callback.call ([l_item])
				end
			end
			if a_termination /= Void then
				a_termination.call (Void)
			end
		end

	data (a_expression: READABLE_STRING_GENERAL): ITERABLE [TUPLE [text, displayed_text: STRING_32]]
		local
			pn: STRING_32
			s: STRING_32
			d: DIRECTORY
			p, dp: PATH
			dn: STRING_32
			lst: ARRAYED_LIST [TUPLE [text, displayed_text: STRING_32]]
			l_entries: LIST [PATH]
			pos: INTEGER
			l_root_count: INTEGER
			l_displayed_text: STRING_32
			tmp_dir: DIRECTORY
		do
			dp := location.canonical_path.absolute_path
			l_root_count := dp.name.count + 1

			create s.make_from_string_general (a_expression)

			pos := s.last_index_of ({OPERATING_ENVIRONMENT}.directory_separator, s.count)
			if pos > 0 then
				dp := dp.extended (s.head (pos - 1))
				s.remove_head (pos)
			end
			dn := dp.name
			create d.make_with_path (dp)
			debug ("suggestive")
				io.put_string_32 (dn)
				io.put_new_line
			end
			if d.exists and d.is_readable then
				d.open_read
				l_entries := d.entries
				d.close
				create lst.make (l_entries.count)
				across
					l_entries as ic
				loop
					p := ic.item
					if p.is_current_symbol or p.is_parent_symbol then
					else
						if s.is_whitespace or else p.name.starts_with_general (s) then
							pn := dp.extended_path (p).name
							if tmp_dir = Void then
								create tmp_dir.make_with_name (pn)
							else
								tmp_dir.make_with_name (pn)
							end
							debug ("suggestive")
								io.put_string ("%T")
								io.put_string_32 (pn)
								io.put_new_line
							end
							pn.remove_head (l_root_count)
							if tmp_dir.exists then
								lst.extend ([pn, {STRING_32} "[DIR] " + pn])
							else
								lst.extend ([pn, pn])
							end
						end
					end
				end
			else
				create lst.make (0)
			end
			Result := lst
		end

feature -- Status Report

	is_concurrent: BOOLEAN
			-- Can `Current' be executed in a different thread/processor?
		do
			Result := True
		end

	is_available: BOOLEAN
			-- Is current able to serve a new query?
		do
			Result := True
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
