note
	description: "[
		An EiffelVision2 label extension that supports text wrapping and text ellipsing.
		Make sure to call `calculate_size' before it is shown to ensure a more realistic display,
		that is to say, if you create the label and then show it, no text will be visible unless
		you call `calculate_size' or that a resizing occurred.
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
			text as label_text,
			set_text as set_label_text,
			make_with_text as make_with_label_text
		export
			{NONE} label_text, set_label_text, set_minimum_height, set_minimum_width, set_minimum_size
		redefine
			set_font,
			remove_text,
			create_interface_objects,
			initialize,
			is_in_default_state
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	REFACTORING_HELPER
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	default_create, make, make_with_text

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create text.make_empty
		end

	initialize
			-- <Precursor>
		do
			align_text_left
			resize_actions.extend (agent (a,b,c,d: INTEGER_32)
				do
					resize_actions.block
					resize_text (True)
					resize_actions.resume
				end)
			dpi_changed_actions.extend (agent (a_dpi: NATURAL_32; a,b,c,d: INTEGER_32)
						do
							dpi_changed_actions.block
							resize_text (True)
							dpi_changed_actions.resume
						end)
			maximum_height := -1
			maximum_width := -1
		end

	make
			-- Initialize new wrappable label.
		obsolete
			"Use `default_create' or `make_with_text' instead."
		do
			default_create
		end

	make_with_text (a_text: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			default_create
			set_text (a_text)
		end

	is_in_default_state: BOOLEAN
			-- <Precursor>
		do
			Result := is_left_aligned
		end

feature -- Access

	text: STRING_32
			-- The orginally set text, not the actual text display.
			-- Note: for the rendered text see `label_text'.

feature {NONE} -- Access

	maximum_width: INTEGER
			-- Maximum width for text wrapping

	maximum_height: INTEGER
			-- Maximum height for text ellipsing

feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		local
			l_lines: LIST [STRING_32]
			l_text_lines: ARRAYED_LIST [ARRAYED_LIST [STRING_32]]
			l_text_sizes: ARRAYED_LIST [ARRAY [INTEGER]]
			l_words: like split_words
			l_sizes: like measure_words
			l_cache: HASH_TABLE [INTEGER, STRING_32]
		do
			text := a_text.as_string_32

			l_lines := text.split ('%N')
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
				resize_text (False)
			end
		ensure
			text_set: text = a_text
		end

	set_font (a_font: like font)
			-- Assign `a_font' to `font'.
		do
			Precursor {EV_LABEL} (a_font)
			if is_displayed then
				resize_text (False)
			end
		end

	set_maximum_width (a_width: INTEGER)
			-- Set maximum size for text wrapping.
		require
			not_destroyed: not is_destroyed
			a_width_positive: a_width >= 0
		do
			maximum_width := a_width
			if is_displayed then
				resize_text (False)
			end
		ensure
			maximum_width_set: maximum_width = a_width
			is_maximum_width_set_by_user: is_maximum_width_set_by_user
		end

	set_maximum_height (a_height: INTEGER)
			-- Set maximum size for text ellipsing.
		require
			not_destroyed: not is_destroyed
			a_height_positive: a_height >= 0
		do
			maximum_height := a_height
			if is_displayed then
				resize_text (False)
			end
		ensure
			maximum_height_set: maximum_height = a_height
			is_maximum_height_set_by_user: is_maximum_height_set_by_user
		end

	set_maximum_size (a_width, a_height: INTEGER)
			-- Set maximum size for text wrapping and text ellipsing.
		require
			not_destroyed: not is_destroyed
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			set_maximum_width (a_width)
			set_maximum_height (a_height)
		ensure
			maximum_height_set: maximum_height = a_height
			is_maximum_height_set_by_user: is_maximum_height_set_by_user
			maximum_width_set: maximum_width = a_width
			is_maximum_width_set_by_user: is_maximum_width_set_by_user
		end

feature -- Removal

	remove_text
			-- Make `text' `is_empty'.
		do
			text_lines := Void
			text_sizes := Void
			if is_displayed then
				resize_text (False)
			end
		ensure then
			text_lines_detached: text_lines = Void
			text_sizes_detached: text_sizes = Void
		end

feature -- Status report

	is_text_wrapped: BOOLEAN assign set_is_text_wrapped
			-- Indicates if text wrapping should occur

	is_text_ellipsed: BOOLEAN assign set_is_text_ellipsed
			-- Indicates if text should be ellipsed if it does not fit
			-- The designated space.

feature {EV_BUILDER} -- Status report

	is_maximum_height_set_by_user: BOOLEAN
			-- Indicates if the ellipsed miniumu width has been set
		do
			Result := maximum_height >= 0
		end

	is_maximum_width_set_by_user: BOOLEAN
		do
			Result := maximum_width >= 0
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
				resize_text (False)
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
				resize_text (False)
			end
		ensure
			is_text_ellipsed_set: is_text_ellipsed = a_ellipse
		end

feature -- Basic operations

	calculate_size
			-- Calculates the size of the label.
			-- Note: You must call this prior to a show to get the correct size information
		do
			resize_text (False)
		end

feature {NONE} -- Line analysis

	split_words (a_line: STRING_32): ARRAYED_LIST [STRING_32]
			-- Splits a line of text into words and whitespace
			--
			-- `a_line': A line of text to split into words
			-- `Result': An array of words (non-whitespace) and whitespace character sequences.
		require
			a_line_attached: a_line /= Void
		local
			l_word: STRING_32
			l_count, i: INTEGER
			c: CHARACTER_32
			l_last_is_space: BOOLEAN
		do
			create Result.make (0)
			if not a_line.is_empty then
				create l_word.make (24)
				from
					i := 1
					l_count := a_line.count
				until
					l_count < i
				loop
						-- We take code > 255 as non space.
						-- This needs to improve when Unicode `is_space' is ready.
					l_last_is_space := (c.is_character_8 and then c.is_space)
					c := a_line.item (i)
					if i > 1 and then (c.is_character_8 and then c.is_space) /= l_last_is_space then
						Result.extend (l_word)
						create l_word.make (24)
					end
					l_word.append_character (c)
					i := i + 1
				end
				Result.extend (l_word)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: a_line.is_empty = Result.is_empty
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
				l_word := a_words.i_th (i)
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
			not_result_is_empty: not a_words.is_empty implies not Result.is_empty
			result_contains_valid_items: Result.for_all (agent (a_len: INTEGER): BOOLEAN do Result := a_len > 0 end)
		end

feature {NONE} -- Line rendering

	text_lines: detachable LIST [ARRAYED_LIST [STRING_32]]
			-- Original lines, split into words

	text_sizes: detachable LIST [ARRAY [INTEGER]]
			-- Sizes of text fragments

	version: NATURAL_32
			-- Current version of label.
			-- Because some label updates are done during idle actions, we do not want them to update
			-- the label with the old content in the case a new text was set after the idle action was
			-- added but before the idle action has been executed.

	resize_text (a_resizing: BOOLEAN)
			-- Sizes the text set by the user to fit on screen label dimensions specified.
		local
			l_text_lines: like text_lines
			l_text_sizes: like text_sizes
			l_max_width: like maximum_width
			l_max_height: like maximum_height
			l_wrapped: like is_text_wrapped
			l_ellipsed: like is_text_ellipsed
			l_font: like font
			l_words: like split_words
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
				-- Reset `minimum_height' since it might have been set previously
				-- and with resizing it will have to be recomputed.
			reset_minimum_height

			l_wrapped := is_text_wrapped
			l_ellipsed := is_text_ellipsed
			if l_wrapped or l_ellipsed  then
				l_text_lines := text_lines
				l_text_sizes := text_sizes
				l_font := font

				if l_text_lines /= Void and l_text_sizes /= Void then
						-- Reorganize text to ensure text fits to set maximum width
					l_max_width := maximum_width
					create l_text.make (text.count)
					l_width := l_max_width.max (width)
					from l_text_sizes.start until l_text_sizes.after loop
							-- Retrieve words and word pixel lengths
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
							l_word := l_words.i_th (i)

							if not l_wrapped or l_eval_width + l_len <= l_width then
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
											if j = 1 or else l_font.string_width (l_small_word) <= l_width then
												l_text.append (l_small_word)
												l_text.append_character ('%N')

												l_word := l_word.substring (j + 1, l_word.count)
												l_len := l_font.string_width (l_word)
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
										l_text.append (l_words.i_th (i))
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
					if l_ellipsed then
							-- Ellipse text if the wrapped text extends beyond the maximum set height.
						l_max_height := maximum_height
						if l_size.height > l_max_height then
								-- Remove lines that are too high
							from until i <= 1 or l_size.height <= l_max_height loop
								i := l_text.last_index_of ('%N', l_text.count)
								if i > 1 then
									l_text.keep_head (i - 1)
									l_size := l_font.string_size (l_text)
								end
							end
							if l_text.count > 3 then
									-- Add ellipses
								i := l_text.last_index_of ('%N', l_text.count)
								if i > 0 then
									l_size := l_font.string_size (l_text.substring (i + 1, l_text.count))
								else
									i := l_text.count
								end
								if l_size.width > l_max_width and i > 3 then
									l_text.keep_head (l_text.count - 3)
									l_text.append ("...")
								end
							end
						end

							-- Set height of label accordingly to
						l_size := l_font.string_size (l_text)
						if is_maximum_height_set_by_user then
								-- Because user requested a maximum height, we
								-- need to ensure it.
							set_minimum_height (l_size.height.min (l_max_height))
						end
					end

					version := version + 1
					if a_resizing then
							-- Cannot do `set_label_text' during resizing events.
							-- If we do so, somehow in an EV_VERTICAL_BOX_IMP,
							-- {EV_VERTICAL_BOX_IMP}.ev_apply_new_size might trigger
							-- resize action twice upon inner EV_HORIZONTAL_BOX.
							-- The first time `width' returns correct,
							-- the second time `width' is wrong (much bigger)
							-- The reason seems to be that {EV_HORIZONTAL_BOX_IMP}.set_children_width
							-- is using an old value of `children_width' rather than the one
							-- updated here in resize action. But later `litem.minimum_width' in
							-- {EV_HORIZONTAL_BOX_IMP}.set_children_width uses the updated minimum value.
							-- The consequence is the text wrapping is incorrectly computed
							-- according to a wrong `width'.
						ev_application.do_once_on_idle (agent update_label_text (l_text, version))
					else
						update_label_text (l_text, version)
					end
				end
			end
		end

	update_label_text (a_text: STRING_32; a_version: NATURAL_32)
			-- If `a_version' matches `version' update current with `a_text'.
		do
			if version = a_version then
				set_label_text (a_text)
			end
		end


invariant
	text_attached: text /= Void
	text_lines_and_text_sizes_synced: (text_lines = Void) = (text_sizes = Void) and then
			(attached text_sizes as inv_text_sizes and
			attached text_lines as inv_text_lines) implies inv_text_lines.count = inv_text_sizes.count

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
