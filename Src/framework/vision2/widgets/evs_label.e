indexing
	description: "[
		An EiffelVision2 label extension that supports text wrapping and text ellipsing.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVS_LABEL

inherit
	EV_LABEL
		rename
			set_text as set_label_text,
			set_minimum_height as set_label_minimum_height,
			reset_minimum_height as reset_label_minimum_height
		redefine
			set_font,
			set_minimum_size,
			remove_text
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			default_create
			align_text_left
			resize_actions.extend (agent (a,b,c,d: INTEGER_32)
				do
					resize_actions.block
					resize_text
					resize_actions.resume
				end)
		end

feature {NONE} -- Access

	ellipsed_minimum_height: INTEGER
			-- Minimum height for ellipsed text

feature -- Element change

	set_text (a_text: like text)
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		local
			l_lines: LIST [STRING_32]
			l_text_lines: ARRAYED_LIST [ARRAY [STRING_32]]
			l_text_sizes: ARRAYED_LIST [ARRAY [INTEGER]]
			l_words: like split_words
			l_sizes: like measure_words
			l_cache: HASH_TABLE [INTEGER, STRING_32]
		do
			l_lines := a_text.split ('%N')
			create l_cache.make (13)
			create l_text_lines.make (1)
			create l_text_sizes.make (1)
			from l_lines.start until l_lines.after loop
				l_words := split_words (l_lines.item)
				l_text_lines.extend (l_words)
				l_sizes := measure_words (l_words, l_cache)
				l_text_sizes.extend (l_sizes)
				l_lines.forth
			end

			text_lines := l_text_lines
			text_sizes := l_text_sizes
			if is_displayed then
				resize_text
			end
		end

	set_font (a_font: like font) is
			-- Assign `a_font' to `font'.
		do
			Precursor {EV_LABEL} (a_font)
			if is_displayed then
				resize_text
			end
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set `a_minimum_height' in pixels to `minimum_height'.
			-- If `height' is less than `a_minimum_height', resize.
			-- From now, `minimum_height' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_destroyed: not is_destroyed
			a_minimum_height_positive: a_minimum_height >= 0
		do
			set_label_minimum_height (a_minimum_height)
			ellipsed_minimum_height := a_minimum_height
		ensure
			minimum_height_assigned: (a_minimum_height > 0 implies minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (minimum_height <= 1))
			minimum_height_set_by_user_set: minimum_height_set_by_user
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Assign `a_minimum_height' to `minimum_height'
			-- and `a_minimum_width' to `minimum_width' in pixels.
			-- If `width' or `height' is less than minimum size, resize.
			-- From now, minimum size is fixed and will not be changed
			-- dynamically by the application anymore.
		do
			set_minimum_width (a_minimum_width)
			set_minimum_height (a_minimum_height)
		end

feature -- Removal

	remove_text is
			-- Make `text' `is_empty'.
		do
			text_lines := Void
			text_sizes := Void
			if is_displayed then
				resize_text
			end
		ensure then
			text_lines_detached: text_lines = Void
			text_sizes_detached: text_sizes = Void
		end

feature {EV_BUILDER} -- Removal

	reset_minimum_height
			-- Reset minimum_height_set_by_user.
		do
			reset_label_minimum_height
			ellipsed_minimum_height := 0
		ensure
			minimum_height_set_by_user_reset: not minimum_height_set_by_user
			ellipsed_minimum_height_set_by_user_reset: not ellipsed_minimum_height_set_by_user
		end

feature -- Status report

	is_text_wrapped: BOOLEAN assign set_is_text_wrapped
			-- Indicates if text wrapping should occur

	is_text_ellipsed: BOOLEAN assign set_is_text_ellipsed
			-- Indicates if text should be ellipsed if it does not fit
			-- The designated space.

feature {EV_BUILDER} -- Status report

	ellipsed_minimum_height_set_by_user: BOOLEAN
			-- Indicates if the ellipsed miniumu width has been set
		do
			Result := ellipsed_minimum_height > 0
		end

feature -- Status setting

	set_is_text_wrapped (a_wrap: like is_text_wrapped)
			-- Set text wrapping ability to `a_wrap'
		require
			minimum_width_set: minimum_width > 0
		local
			l_changed: BOOLEAN
		do
			l_changed := a_wrap /= is_text_wrapped
			is_text_wrapped := a_wrap
			if is_displayed and l_changed then
				resize_text
			end
		ensure
			is_text_wrapped_set: is_text_wrapped = a_wrap
		end

	set_is_text_ellipsed (a_ellipse: like is_text_ellipsed)
			-- Set text ellipsing ability to `a_ellipse'
		require
			is_text_wrapped: is_text_wrapped
			minimum_height_set: minimum_height > 0
		local
			l_changed: BOOLEAN
		do
			l_changed := a_ellipse /= is_text_ellipsed
			is_text_ellipsed := a_ellipse
			if is_displayed and l_changed then
				resize_text
			end
		ensure
			is_text_ellipsed_set: is_text_ellipsed = a_ellipse
		end

feature {NONE} -- Line analysis

	split_words (a_line: STRING_32): ARRAY [STRING_32]
			-- Splits a line of text into words and whitespace
			--
			-- `a_line': A line of text to split into words
			-- `Result': An array of words (non-whitespace) and whitespace character sequences.
		require
			a_line_attached: a_line /= Void
		local
			l_words: ARRAYED_LIST [STRING_32]
			l_word: STRING_32
			l_count, i: INTEGER
			l_old_c, c: CHARACTER_32
		do
			create l_words.make (0)
			if not a_line.is_empty then
				create l_word.make (24)
				from
					i := 1
					l_count := a_line.count
				until
					l_count < i
				loop
					l_old_c := c
					c := a_line.item (i)
					if i > 1 and then c.is_space /= l_old_c.is_space then
						l_words.extend (l_word)
						create l_word.make (24)
					end
					l_word.append_character (c)
					i := i + 1
				end
				l_words.extend (l_word)
			end
			Result := l_words
		ensure
			result_attached: Result /= Void
			not_result_is_empty: a_line.is_empty = Result.is_empty
			result_contains_attached_items: not Result.has (Void)
			result_contains_valid_items: Result.for_all (agent (a_str: STRING_32): BOOLEAN do Result := not a_str.is_empty end)
		end

	measure_words (a_words: like split_words; a_cache: HASH_TABLE [INTEGER, STRING_32]): ARRAY [INTEGER]
			-- Calculates the size of all words in `a_words'.
			--
			-- `a_words': An array of words to determines pixel lenghts for.
			-- `a_cache': A cached of pixel lengths indexed by their text.
			-- `Result': An array with a matching count to `a_words' containing the pixel lengths of each word in `a_words'.
		require
			a_words_attached: a_words /= Void
			not_a_words_is_empty: not a_words.is_empty
			a_words_contains_attached_items: not a_words.has (Void)
			a_words_contains_valid_items: a_words.for_all (agent (a_str: STRING_32): BOOLEAN do Result := not a_str.is_empty end)
			a_cache_attached: a_cache /= Void
		local
			l_count, i: INTEGER
			l_word: STRING_32
			l_len: INTEGER
			l_font: like font
		do
			create Result.make (1, a_words.count)

			l_font := font
			from
				i := 1
				l_count := a_words.count
			until
				i > l_count
			loop
				l_word := a_words.item (i)
				l_len := a_cache.item (l_word)
				if l_len = 0 then
					l_len := l_font.string_width (l_word)
					a_cache.put (l_len, l_word)
				end

				Result.put (l_len, i)
				i := i + 1
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent (a_len: INTEGER): BOOLEAN do Result := a_len > 0 end)
		end

feature {NONE} -- Line rendering

	text_lines: LIST [ARRAY [STRING_32]]
			-- Original lines, split into words

	text_sizes: LIST [ARRAY [INTEGER]]
			-- Sizes of text fragments

	resize_text
			-- Sizes the text set by the user to fit on screen label dimensions specified.
		local
			l_text_lines: like text_lines
			l_text_sizes: like text_sizes
			l_words: ARRAY [STRING_32]
			l_sizes: ARRAY [INTEGER]
			l_word: STRING_32
			l_small_word: STRING_32
			l_width: INTEGER
			l_eval_width: INTEGER
			l_text: STRING_32
			l_count, i, j: INTEGER
			l_stop: BOOLEAN
			l_len: INTEGER
			l_size: TUPLE [width, height, left, right: INTEGER]
		do
			reset_label_minimum_height
			if is_text_ellipsed or is_text_wrapped then
				l_text_lines := text_lines
				l_text_sizes := text_sizes
				if l_text_lines /= Void and l_text_sizes /= Void then
					if minimum_width_set_by_user then
						create l_text.make (text.count)
						l_width := minimum_width.max (width)
						from l_text_sizes.start until l_text_sizes.after loop
							l_sizes := l_text_sizes.item
							l_words := l_text_lines.i_th (l_text_sizes.index)
							l_eval_width := 0
							from
								i := 1
								l_count := l_sizes.count
							until
								i > l_count
							loop
								l_len := l_sizes.item (i)
								l_word := l_words.item (i)
								if not is_text_wrapped or l_eval_width + l_len <= l_width then
									l_eval_width := l_eval_width + l_len
									l_text.append (l_word)
								else
									l_text.append ("%N")
									l_eval_width := l_len
									if l_eval_width > l_width then
											-- The word is too long for the width, split the word up
										from until l_word.is_empty loop
											from
												l_stop := False
												j := l_word.count
											until
												j = 0 or l_stop
											loop
												l_small_word := l_word.substring (1, j)
												if j = 1 or else font.string_width (l_small_word) <= l_width then
													l_text.append (l_small_word)
													l_text.append_character ('%N')

													l_word := l_word.substring (j + 1, l_word.count)
													l_len := font.string_width (l_word)
													l_eval_width := l_len
													l_stop := True
												else
													j := j - 1
												end
											end
											if font.string_width (l_word) <= l_width then
												l_text.append (l_word)
												l_word.wipe_out
											end
										end
									else
										if l_word.item (1) = ' ' then
												-- Remove a single space as we just replace it with a new line character.
												-- Note: If the first character is a tab, it's preserved.
											l_word := l_word.substring (2, l_word.count)
										end
										if not l_word.is_empty then
											l_text.append (l_words.item (i))
										end
									end
								end

								i := i + 1
							end

							if not l_text_sizes.islast then
								l_text.append ("%N")
							end
							l_text_sizes.forth
						end
						l_size := font.string_size (l_text)
						if is_text_ellipsed then
							if l_size.height > ellipsed_minimum_height then
									-- Remove lines that are too high
								from until i <= 1 or l_size.height <= ellipsed_minimum_height loop
									i := l_text.last_index_of ('%N', l_text.count)
									if i > 1 then
										l_text.keep_head (i - 1)
										l_size := font.string_size (l_text)
									end
								end
								if l_text.count > 3 then
										-- Add ellipses
									i := l_text.last_index_of ('%N', l_text.count)
									if i > 0 then
										l_size := font.string_size (l_text.substring (i + 1, l_text.count))
									else
										i := l_text.count
									end
									if l_size.width > minimum_width and i > 3 then
										l_text.keep_head (l_text.count - 3)
										l_text.append ("...")
									end
								end
							end

								-- Set hieght
							l_size := font.string_size (l_text)
							if ellipsed_minimum_height_set_by_user then
								set_label_minimum_height (l_size.height.min (ellipsed_minimum_height))
							else
								set_label_minimum_height (l_size.height)
							end
						else
							set_label_minimum_height (l_size.height)
						end

						set_label_text (l_text)
					end
				end
			end
		end


invariant
	text_lines_and_text_sizes_synced: (text_lines = Void) = (text_sizes = Void) and then
			text_lines /= Void implies text_lines.count = text_sizes.count

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
