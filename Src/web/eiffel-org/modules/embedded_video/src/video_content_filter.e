note
	description: "[
		Quick syntax:
			[video:url]
		Full syntax:
			[video:url width:X height:Y]
	]"
	author: ""
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
			width := 420
			height := 315
		end

feature -- Access

	name: STRING_8 = "video"

	title: STRING_8 = "Video filter"

	description: STRING_8 = "Filter to embed any type of video in your site using a simple token."

	help: STRING = "Embed videos into your web page using the following pattern: [video:url width:X height:Y], width and height are optionals."

feature -- Conversion

	filter (a_text: STRING_8)
			-- [video:url width:X height:Y]
		local
			l_text:  STRING
			l_new:  STRING
			l_result : STRING
			i,n: INTEGER
		do
			create l_result.make_empty
			l_text := a_text.twin
			from
				i := l_text.index_of ('[', 1)
				n := l_text.index_of (']', 1)
				l_new := l_text.substring (i, n)
				filter_line (l_new)
				l_result.append (l_new)
			until
				i = 0 or n > l_text.count
			loop
				i := l_text.index_of ('[', n + 1)
				n := l_text.index_of (']', n + 1)
				l_new := l_text.substring (i , n )
				filter_line (l_new)
				l_result.append (l_new)
			end

			a_text.wipe_out
			a_text.append (l_result)

		end

	filter_line (a_text: STRING_8)
		local
			l_new: STRING_8
			l_text: STRING_8
			l_param: STRING_8
			l_url, l_width, l_height: detachable STRING_8
			i: INTEGER
			n: INTEGER
			j: INTEGER
		do
			create l_new.make_from_string (a_text)
			l_new.adjust
			i := l_new.index_of ('[', 1)
			n := l_new.index_of (']', 1)
			if i > 0 and n > 0 then
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
				if attached l_url as ll_url then
					create l_text.make_from_string (iframe_template)
					l_text.replace_substring_all ("$url", ll_url)
					if attached l_height as ll_height then
						l_text.replace_substring_all ("$height", ll_height)
					else
						l_text.replace_substring_all ("$height", height.out)
					end
					if attached l_width as ll_width then
						l_text.replace_substring_all ("$width", l_width)
					else
						l_text.replace_substring_all ("$width", width.out)
					end
					a_text.wipe_out
					a_text.append (l_text)
				end
			end
		end

feature {NONE} -- Implementation

	width: INTEGER;
		-- Specifies the width of an <iframe> in pixels.

	height: INTEGER
			-- Specifies the height of an <iframe> in pixels.

	iframe_template: STRING = "[
			<iframe width="$width" height="$height"
			src="$url">
			</iframe>
		]"

end
