note
	description: "Summary description for {CMS_THEME_INFORMATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_THEME_INFORMATION

create
	make,
	make_default

feature {NONE} -- Initialization

	make_default
		do
			engine := {STRING_32} "default"
			create items.make_caseless (1)
			create regions.make (5)
			across
				(<<"header", "content", "footer", "first_sidebar", "second_sidebar">>) as ic
			loop
				regions.force (ic.item, ic.item)
			end
		end

	make (fn: PATH)
		local
			f: PLAIN_TEXT_FILE
			s: STRING_8
			h,k: STRING_8
			v: STRING_32
			i: INTEGER
			utf: UTF_CONVERTER
			l_engine: detachable READABLE_STRING_32
			done: BOOLEAN
		do
			make_default
			create f.make_with_path (fn)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					done or f.exhausted or f.end_of_file
				loop
					f.read_line_thread_aware
					s := f.last_string
					s.left_adjust
					if
						s.is_empty
						or else s.starts_with_general (";")
						or else s.starts_with_general ("#")
						or else s.starts_with_general ("--")
					then
							-- Ignore
					else
						i := s.index_of ('=', 1)
						if i > 0 then
							h := s.substring (1, i - 1)
							h.left_adjust
							h.right_adjust
							if h.is_case_insensitive_equal_general ("engine") then
								s.remove_head (i)
								s.right_adjust
								v := utf.utf_8_string_8_to_string_32 (s)
								l_engine := v
							elseif h.starts_with_general ("regions[") and h[h.count] = ']' then
								s.remove_head (i)
								s.right_adjust
								v := utf.utf_8_string_8_to_string_32 (s)
								i := h.index_of ('[', 1)
								k := h.substring (i + 1, h.count - 1)
								k.left_adjust
								k.right_adjust
								if k.starts_with_general ("-") then
										--| If name is prefixed by "-"
										--| remove the related region
										--| If name is "-*", clear all regions.
									if k.is_case_insensitive_equal_general ("-*") then
										regions.wipe_out
									else
										k.remove_head (1)
										regions.remove (k)
									end
								else
									regions.force (v, k)
								end
							else
								s.remove_head (i)
								s.right_adjust
								v := utf.utf_8_string_8_to_string_32 (s)
							end
							items.force (v, h)
						end
					end
				end
				f.close
			end
			if l_engine /= Void and then not l_engine.is_empty then
				engine := l_engine
			end
		end

feature -- Access

	engine: STRING_32
			-- Template engine.
			--| Could be: default, smarty, ...

	regions: STRING_TABLE [READABLE_STRING_GENERAL]
			-- Regions available in this theme

	item (k: READABLE_STRING_GENERAL): detachable STRING_32
			-- Item associated with name `k' if any.
		do
			Result := items[k]
		end

	items: STRING_TABLE [STRING_32]
			-- Items indexed by key name.

invariant
	engine_set: not engine.is_empty

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
