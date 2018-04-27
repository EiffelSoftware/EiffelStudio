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

	default_width: INTEGER;
		-- Specifies the width of an <iframe> in pixels.

	default_height: INTEGER
			-- Specifies the height of an <iframe> in pixels.

	template: detachable READABLE_STRING_8
			-- Optional template using $url, $att .
			-- For instance:
			-- <iframe src="$url" $att></iframe>"

feature -- Settings change

	set_default_width (w: like default_width)
		do
			default_width := w
		end

	set_default_height (h: like default_height)
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
			l_new: detachable STRING_GENERAL
			i,p,q,diff: INTEGER
		do
			from
				i := 1
			until
				i > a_text.count
			loop
				p := a_text.substring_index ("[video:", i)
				if p > 0 then
					q := a_text.index_of (']', p + 1)
					l_new := to_embedded_video_code (a_text, p, q)
					if l_new /= Void then
						diff := l_new.count - (q - p + 1)
						i := i + diff
						replace_substring (a_text, l_new, p, q)
					else
						i := q + 1
					end
				else
					i := a_text.count
				end
				i := i + 1
			end
		end

	to_embedded_video_code (a_text: STRING_GENERAL; a_lower, a_upper: INTEGER): detachable STRING_GENERAL
		require
			a_lower < a_upper
			a_text.substring (a_lower, a_lower + 6).same_string ("[video:")
			a_text.ends_with ("]")
		local
			i,j,n: INTEGER
			s,k,v: STRING_GENERAL
			l_url, l_att: STRING_GENERAL
			l_width, l_height, l_extra: detachable STRING_GENERAL
		do
			s := a_text.substring (a_lower + 7, a_upper - 1)
			s.left_adjust
			i := next_space_position (s, 1)
			if i > 0 then
				l_url := s.head (i - 1)
				remove_head (s, i)
				s.left_adjust
				from
					n := s.count
					i := 1
				until
					i > n
				loop
					j := s.index_of (':', i)
					if j > 0 then
						k := s.head (j - 1)
						k.left_adjust
						k.right_adjust
						remove_head (s, j)
						s.left_adjust
						i := 1
						n := s.count
						j := next_space_position (s, 1)
						if j > 0 then
							v := s.head (j - 1)
							v.left_adjust
							v.right_adjust
							remove_head (s, j)
							s.left_adjust
						else
							v := s.substring (i, n)
							v.left_adjust
							v.right_adjust
							wipe_out (s)
						end
						n := s.count
						i := 1
						if k.is_case_insensitive_equal ("width") then
							l_width := v
						elseif k.is_case_insensitive_equal ("height") then
							l_height := v
						else
								-- Ignore
						end
					else
						s.left_adjust
						s.right_adjust
						if not s.is_whitespace then
							l_extra := s
						end
						i := n + 1
					end
				end
			else
				l_url := s
			end
			if not l_url.is_whitespace then
				if l_width = Void then
					if default_width > 0 then
						l_width := default_width.out
					end
				end
				if l_height = Void then
					if default_height > 0 then
						l_height := default_height.out
					end
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
				if l_extra /= Void and then not l_extra.is_empty then
					if not l_att.is_empty and not l_extra[1].is_space then
						append_character (l_att, ' ')
					end
					l_att.append (l_extra)
				end

				if attached {STRING_8} a_text then
					create {STRING_8} Result.make_empty
				else
					create {STRING_32} Result.make_empty
				end

				if attached template as tpl then
					Result.append (tpl)
					replace_substring_all (Result, "$url", l_url)
					replace_substring_all (Result, "$att", l_att)
				else
					Result.append ("<iframe src=%"")
					Result.append (l_url)
					append_character (Result, '%"')
					if not l_att.is_empty then
						append_character (Result, ' ')
					end
					Result.append (l_att)
					Result.append ("></iframe>")
				end
			end
		end

	next_space_position (a_text: READABLE_STRING_GENERAL; a_start_index: INTEGER): INTEGER
		local
			n: INTEGER
		do
			from
				Result := a_start_index
				n := a_text.count
			until
				a_text[Result].is_space or Result > n
			loop
				Result := Result + 1
			end
			if Result > n then
				Result := 0
			end
		end

feature {NONE} -- Implementation

	replace_substring (a_text: STRING_GENERAL; s: READABLE_STRING_GENERAL; start_index, end_index: INTEGER_32)
		do
			if attached {STRING_8} a_text as s8 then
				s8.replace_substring (s.to_string_8, start_index, end_index)
			elseif attached {STRING_32} s as s32 then
				s32.replace_substring (s.as_string_32, start_index, end_index)
			end
		end

	replace_substring_all (s: STRING_GENERAL; a_old: READABLE_STRING_8; a_new: STRING_GENERAL)
		local
			utf: UTF_CONVERTER
		do
			if attached {STRING_8} s as s8 then
				if a_new.is_valid_as_string_8 then
					s8.replace_substring_all (a_old, a_new.to_string_8)
				else
					check a_new_is_string_8: False end
						-- Use UTF-8 for now.
					s8.replace_substring_all (a_old, utf.utf_32_string_to_utf_8_string_8 (a_new))
				end
			elseif attached {STRING_32} s as s32 then
				s32.replace_substring_all (a_old.to_string_32, a_new)
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
