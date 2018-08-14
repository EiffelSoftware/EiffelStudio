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

	title: STRING_8 = "Video filter"

	description: STRING_8 = "Filter to embed any type of video in your site using a simple token."

	help: STRING = "Embed videos into your web page using the following pattern: [video:url width:X height:Y], width and height are optionals."

feature -- Settings

	default_width: INTEGER assign set_default_width
		-- Specifies the width of an <iframe> in pixels.

	default_height: INTEGER assign set_default_height
			-- Specifies the height of an <iframe> in pixels.

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

feature -- Conversion

	filter (a_text: STRING_GENERAL)
			-- [video:url width:X height:Y]
		local
			l_new: STRING_8
			i,j,k: INTEGER
			sg: detachable STRING_GENERAL
			s32: detachable STRING_32
			s8: detachable STRING_8
		do
			if attached {STRING_32} a_text as a_text_32 then
				s32 := a_text_32
			elseif attached {STRING_8} a_text as a_text_8 then
				s8 := a_text_8
			else
				sg := a_text.substring (1, 0) -- Same string type, but empty.
			end
			from
				i := 1
			until
				i > a_text.count
			loop
				j := a_text.index_of ('[', i)
				if j = 0 then
					j := i
					k := a_text.count
					if sg /= Void then
						sg.append (a_text.substring (j, k))
					end
					i := k + 1 -- Exit
				else
					if sg /= Void and j > i then
						sg.append (a_text.substring (i, j - 1))
					end
					k := a_text.index_of (']', j + 1)
					if k = 0 then
						k := a_text.count
						if sg /= Void then
							sg.append (a_text.substring (j, k))
						end
						i := k + 1
					else
						l_new := filtered_line (a_text.substring (j, k))
						if l_new = Void then
							if sg /= Void then
								sg.append (a_text.substring (j, k))
							-- else keep a_text substring unchanged.
							end
							i := k + 1
						else
							if s8 /= Void then
								s8.replace_substring (l_new, j, k)
							elseif s32 /= Void then
								s32.replace_substring (l_new, j, k)
							end
							i := i + l_new.count
						end
					end
				end
			end
			if sg /= Void then
				a_text.wipe_out
				a_text.append (sg)
			else
				check s8 /= Void or s32 /= Void end
			end
		end

	filtered_line (a_line: STRING_GENERAL): detachable STRING_8
			-- Filtered `a_line` if pattern detected, otherwise Void.
		require
			a_line.starts_with ("[")
			a_line.ends_with ("]")
		local
			l_new: STRING_8
			l_param: STRING_8
			l_url, l_width, l_height: detachable STRING_8
			i: INTEGER
			n: INTEGER
			j: INTEGER
			utf_conv: UTF_CONVERTER
		do
			i := a_line.index_of ('[', 1)
			n := a_line.index_of (']', 1)
			if i > 0 and n > 0 then
				create Result.make_empty
				l_new := utf_conv.utf_32_string_to_utf_8_string_8 (a_line)
				l_new := l_new.substring (i + 1, n - 1)
				l_new.adjust
				from
					i := l_new.index_of (':', 1)
					l_param := l_new.substring (1, i - 1)
					l_new := l_new.substring (i + 1, l_new.count)
					l_new.adjust
					l_param.adjust
				until
					i = 0 or i > l_new.count
				loop
					if l_param.same_string ("video") then
						j := l_new.index_of (' ', 1)
						if j > 0 then
							l_url := l_new.substring (1, j - 1)
							l_new := l_new.substring (j + 1, l_new.count)
						else
							l_url := l_new.substring (1, l_new.count)
							l_url.adjust
							i := n + 1
						end
					elseif l_param.same_string ("width") then
						j := l_new.index_of (' ', 1)
						if j > 0 then
							l_width := l_new.substring (1, j - 1)
							l_new := l_new.substring (j + 1, l_new.count)
						else
							l_width := l_new.substring (1, l_new.count)
							i := n + 1
						end
					elseif l_param.same_string ("height") then
						j := l_new.index_of (' ', 1)
						if j > 0 then
							l_height := l_new.substring (1, j - 1)
							l_new := l_new.substring (j + 1, l_new.count)
						else
							l_height := l_new.substring (1, l_new.count)
							i := n + 1
						end
					else
							-- Wrong attribute
						j := l_new.index_of (' ', 1)
						if j > 0 then
							l_new := l_new.substring (j + 1, l_new.count)
						else
							i := n + 1
						end
					end
					if i < l_new.count then
						l_new.adjust
						i := l_new.index_of (':', 1)
						l_param := l_new.substring (1, i - 1)
						l_new := l_new.substring (i + 1, l_new.count)
						i := 1
						l_new.adjust
						l_param.adjust
					end
				end
				if l_url /= Void then
					Result.append ("<iframe src=%"")
					Result.append (l_url)
					Result.append ("%" width=%"")
					if l_width /= Void then
						Result.append (l_width)
					else
						Result.append (default_width.out)
					end
					Result.append ("%" height=%"")
					if l_height /= Void then
						Result.append (l_height)
					else
						Result.append (default_height.out)
					end
					Result.append ("%"></iframe>")
				else
					Result := Void
				end
			end
		end

end
