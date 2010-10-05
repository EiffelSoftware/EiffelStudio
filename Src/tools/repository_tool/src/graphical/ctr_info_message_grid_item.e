note
	description: "Summary description for {CTR_INFO_MESSAGE_GRID_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_INFO_MESSAGE_GRID_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			create_interface_objects,
			set_text,
			required_width
		end

create
	make_with_text

feature -- Status Setting

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			Precursor (a_text)
			original_text := text.twin
		end

feature {NONE} -- Implementation		

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			original_text := ""
		end

feature -- Access

	original_text: like text

	required_height_after_update: INTEGER

	update
		local
			t: like original_text
			l_wrapped_text: like text
			w: like width
			tw: INTEGER
			pos, i_space: INTEGER
			l_line: detachable STRING_32
			l_txt: detachable STRING_32
			ft: detachable EV_FONT
			av: REAL_64
			h: INTEGER
			cst_inter_line: INTEGER
		do
			t := original_text --| Saved original text

			cst_inter_line := 3
			ft := font
			if ft = Void then
				create ft
			end 

			w := width
			from
				h := cst_inter_line + ft.height
				l_txt := t.twin
				create l_wrapped_text.make (t.count)
			until
				l_txt = Void
			loop
				from
					pos := l_txt.index_of ('%N', 1)
					if pos > 0 then
						l_line := l_txt.substring (1, pos - 1)
						l_line.append_character (' ')
						l_txt := l_txt.substring (pos + 1, l_txt.count)
					else
						l_line := l_txt
						l_txt := ""
					end
					tw := ft.string_width (l_line)
				until
					tw <= w
				loop
--print ("line=%N  [" + l_line + "]%N")
--print ("txt =%N  [" + l_txt + "]%N")
					av := (l_line.count * w) / tw
					pos := av.truncated_to_integer
					if pos > 0 then
						l_txt.prepend_string (l_line.substring (pos + 1, l_line.count))
						l_line := l_line.substring (1, pos)

						tw := ft.string_width (l_line)
					else
						tw := -1
					end
				end
				if l_line.count > 0 and then l_txt.count > 0 and then l_txt.item (1) /= ' ' then
					i_space := l_line.last_index_of (' ', l_line.count)
					if i_space > l_line.count / 2 + 1 then
						l_txt.prepend_string (l_line.substring (i_space + 1, l_line.count))
						l_line := l_line.substring (1, i_space)
--l_line.append_character ('#') -- DEBUG

					end
				else
--l_line.append_character ('#') -- DEBUG
				end

				if l_txt.is_empty then
					l_txt := Void
				end

				h := h + ft.height
				if l_txt /= Void then
					h := h + cst_inter_line
				end
				l_wrapped_text.append_string_general (l_line)
				l_wrapped_text.append_character ('%N')
				l_line := Void
			end

			set_text (l_wrapped_text)
			original_text := t
			required_height_after_update := h
		ensure
			same_original_text: original_text ~ old original_text
		end

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
			-- Note that in some descendents such as EV_GRID_DRAWABLE_ITEM, this
			-- returns 0. For such items, `set_required_width' is available.
		do
			Result := 10
		end

end
