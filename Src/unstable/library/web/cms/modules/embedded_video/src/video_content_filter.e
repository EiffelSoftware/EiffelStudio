note
	description: "[
		Quick syntax:
			[video:url]
		Full syntax:
			[video:url width:X height:Y]
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	VIDEO_CONTENT_FILTER

inherit

	CONTENT_FILTER
		redefine
			help,
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			default_width := 420
			default_height := 315
		end

feature -- Access

	name: STRING_8 = "video"

	title: STRING_8 = "Embedded video"

	description: STRING_8 = "Embed any video using pattern [video:url width:X height:Y], width and height are optionals."

	help: STRING = "Embed video using the following pattern: [video:url width:X height:Y], width and height are optionals."

feature -- Settings

	default_width: INTEGER assign set_default_width
			-- Specifies the width of an <iframe> in pixels.

	default_height: INTEGER assign set_default_height
			-- Specifies the height of an <iframe> in pixels.

	template: detachable READABLE_STRING_8
			-- Optional template using $url, $att .
			-- For instance:
			-- <iframe src="$url" $att></iframe>"

feature -- Settings change

	set_default_width (w: like default_width)
			-- Set `default_width` to `w`.
		do
			default_width := w
		end

	set_default_height (h: like default_height)
			-- Set `default_height` to `h`.	
		do
			default_height := h
		end

	set_template (tpl: like template)
		do
			template := tpl
		end

feature -- Conversion

	filter (a_text: STRING_GENERAL)
			-- [video:url width:X height:Y]
		local
			l_new: STRING_8
			i,j,k: INTEGER
		do
			from
				i := 1
			until
				i > a_text.count
			loop
				j := a_text.index_of ('[', i)
				if j = 0 then
					j := i
					k := a_text.count
					i := k + 1 -- Exit
				else
					k := a_text.index_of (']', j + 1)
					if k = 0 then
						k := a_text.count
						i := k + 1
					else
						l_new := to_embedded_video_code (a_text, j, k)
						if l_new = Void then
							i := k + 1
						else
							replace_substring (a_text, l_new, j, k)
							i := i + l_new.count
						end
					end
				end
			end
		end

	to_embedded_video_code (a_text: STRING_GENERAL; a_lower, a_upper: INTEGER): detachable STRING_8
			-- Filtered `a_text [a_lower:a_upper]` if pattern detected, otherwise Void.
		require
			a_lower < a_upper
			a_text[a_lower] = '['
			a_text[a_upper] = ']'
		local
			l_line, s: STRING_8
			l_param: STRING_8
			l_url, l_att, l_width, l_height: detachable STRING_8
			l_ext: detachable ARRAYED_LIST [TUPLE [name: STRING_8; value: detachable STRING_8]]
			t: TUPLE [name: STRING_8; value: detachable STRING_8]
			i: INTEGER
			j: INTEGER
			utf_conv: UTF_CONVERTER
		do
			l_line := utf_conv.utf_32_string_to_utf_8_string_8 (a_text.substring (a_lower + 1, a_upper - 1))
			l_line.left_adjust
			l_line.right_adjust
			from
				i := l_line.index_of (':', 1)
				l_param := l_line.substring (1, i - 1)
				remove_head (l_line, i)
				l_line.adjust
				l_param.adjust
			until
				i = 0 or i > l_line.count
			loop
				j := next_space_position (l_line, 1)
				if j > 0 then
					s := l_line.substring (1, j - 1)
					remove_head (l_line, j)
				else
					s := l_line.twin
					wipe_out (l_line)
					i := l_line.count + 1
				end
				s.left_adjust
				s.right_adjust

				if l_param.is_case_insensitive_equal ("video") then
					l_url := s
				elseif l_param.is_case_insensitive_equal ("width") then
					l_width := s
				elseif l_param.is_case_insensitive_equal ("height") then
					l_height := s
				elseif not l_param.is_whitespace then
					if l_ext = Void then
						create l_ext.make (1)
					end
					l_ext.force ([l_param, s])
				end
				if i < l_line.count then
					l_line.adjust
					i := l_line.index_of (':', 1)
					if i > 0 then
						l_param := l_line.substring (1, i - 1)
						remove_head (l_line, i)
						i := 1
						l_line.adjust
						l_param.adjust
					else
						s := l_line.twin
						wipe_out (l_line)
						if l_ext = Void then
							create l_ext.make (1)
						end
						l_ext.force ([s, Void])
						i := 1
					end
				end
			end
			if l_url /= Void and then not l_url.is_whitespace then
				if l_width = Void and then default_width > 0 then
					l_width := default_width.out
				end
				if l_height = Void and then default_height > 0 then
					l_height := default_height.out
				end

				create {STRING_8} l_att.make_empty
				if l_width /= Void then
					if not l_att.is_empty then
						append_character (l_att, ' ')
					end
					l_att.append ("width=%"")
					l_att.append (l_width)
					append_character (l_att, '%"')
				end
				if l_height /= Void then
					if not l_att.is_empty then
						append_character (l_att, ' ')
					end
					l_att.append ("height=%"")
					l_att.append (l_height)
					append_character (l_att, '%"')
				end
				if l_ext /= Void then
					across
						l_ext as ic
					loop
						t := ic.item
						if not l_att.is_empty then
							append_character (l_att, ' ')
						end
						l_att.append (t.name)
						if attached t.value as val then
							l_att.append_character ('=')
							l_att.append_character ('%"')
							l_att.append (val)
							l_att.append_character ('%"')
						end
					end
				end

				create Result.make_empty

				if attached template as tpl then
					Result.append (tpl)
					replace_substring_all (Result, "$url", l_url)
					replace_substring_all (Result, "$att", l_att)
				else
					Result.append ("<iframe src=%"")
					Result.append (l_url)
					append_character (Result, '%"')
					if not l_att.is_whitespace then
						append_character (Result, ' ')
						Result.append (l_att)
					end
					Result.append ("></iframe>")
				end
			end
		end

feature {NONE} -- Helpers

	next_space_position (a_text: READABLE_STRING_GENERAL; a_start_index: INTEGER): INTEGER
		local
			n: INTEGER
		do
			from
				Result := a_start_index
				n := a_text.count
			until
				Result > n or else a_text[Result].is_space
			loop
				Result := Result + 1
			end
			if Result > n then
				Result := 0
			end
		end

	replace_substring (a_text: STRING_GENERAL; s: READABLE_STRING_GENERAL; start_index, end_index: INTEGER_32)
		do
			if attached {STRING_8} a_text as s8 then
				s8.replace_substring (s.to_string_8, start_index, end_index)
			elseif attached {STRING_32} a_text as s32 then
				s32.replace_substring (s.as_string_32, start_index, end_index)
			else
				-- TODO
			end
		end

	replace_substring_all (s: STRING_GENERAL; a_old: READABLE_STRING_GENERAL; a_new: READABLE_STRING_GENERAL)
		local
			utf: UTF_CONVERTER
		do
			if attached {STRING_8} s as s8 then
					-- Use UTF-8 for now.
				s8.replace_substring_all (utf.utf_32_string_to_utf_8_string_8 (a_old), utf.utf_32_string_to_utf_8_string_8 (a_new))
			elseif attached {STRING_32} s as s32 then
				s32.replace_substring_all (a_old.to_string_32, a_new.to_string_32)
			end
		end

	append_character (s: STRING_GENERAL; c: CHARACTER)
		do
			s.append_code (c.natural_32_code)
		end

	wipe_out (s: STRING_GENERAL)
		do
			if attached {STRING_8} s as s8 then
				s8.wipe_out
			elseif attached {STRING_32} s as s32 then
				s32.wipe_out
			else
				s.keep_tail (0)
			end
		end

	remove_head (s: STRING_GENERAL; n: INTEGER)
		do
			if attached {STRING_8} s as s8 then
				s8.remove_head (n)
			elseif attached {STRING_32} s as s32 then
				s32.remove_head (n)
			else
				s.keep_tail (s.count - n)
			end
		end

end
