note
	description: "Diff class for texts."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DIFF_TEXT

inherit
	DIFF [READABLE_STRING_8]
		export
			{NONE} set
		end

feature -- Access

	unified: STRING
			-- Get the diff in unified diff format.
		require
			hunks_not_void: hunks /= void
			values_set: values_set
		local
			ss, se, ds, de: INTEGER --start and end positions in source and destination of this block
			block_line_diff, line_diff: INTEGER -- #lines in destination - #lines in source
			block: STRING_8
			l_hunk: LIST [DIFF_LINE]
			l_line: DIFF_LINE
		do
				-- Per precondition
			check
				attached hunks as l_hunks and
				attached unified_header as l_header and
				attached src as l_src and
				attached dst as l_dst
			then
				create Result.make_from_string (l_header)
				from
					l_hunks.start
				until
					l_hunks.after
				loop
					l_hunk := l_hunks.item
					check l_hunk_attached: l_hunk /= Void end

					create block.make_empty
					ss := ss.Max_value
					se := -1
					ds := ds.Max_value
					de := -1
					block_line_diff := 0
					from
						l_hunk.start
					until
						l_hunk.after
					loop
							-- What kind of line is it (add or remove)
						l_line := l_hunk.item
						check l_line_attached: l_line /= Void end
						if attached {DIFF_LINE_ADD} l_line as l_line_add then
							if ds > l_line_add.dst then
								ds := l_line_add.dst
							end
							if de < l_line_add.dst then
								de := l_line_add.dst
							end
							block_line_diff := block_line_diff + 1
							block.append ("+")
							block.append (l_dst [l_line_add.dst])
							block.append_character (line_delimiter)
						else
							if ss > l_line.src then
								ss := l_line.src
							end
							if se < l_line.src then
								se := l_line.src
							end
							block_line_diff := block_line_diff - 1
							block.append ("-")
							block.append (l_src [l_line.src])
							block.append_character (line_delimiter)
						end
						l_hunk.forth
					end

						-- if we had only adds or dels in this block the other start/end position
						-- is not filled and has to be computed with line_diff
					if se = -1 then
						ss := ds-line_diff
						se := ss-1
					elseif de = -1 then
						ds := ss+line_diff
						de := ds-1
					end

					Result.append ("@@ -")
					Result.append_integer (ss+1)
					if se-ss+1 /= 1  then
						Result.append (",")
						Result.append_integer (se-ss+1)
					end
					Result.append (" +")
					Result.append_integer (ds+1)
					if de-ds+1 /= 1 then
						Result.append (",")
						Result.append_integer (de-ds+1)
					end
					Result.append (" @@")
					Result.append_character (line_delimiter)
					Result.append (block)

					line_diff := line_diff + block_line_diff
					l_hunks.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_text (a_src_text: READABLE_STRING_8; a_dst_text: READABLE_STRING_8)
			-- Set the two texts to compare line by line.
		require
			a_src_text_not_void: a_src_text /= Void
			a_dst_text_not_void: a_dst_text /= Void
		local
			tmp_lst: LIST [READABLE_STRING_8]
			i: INTEGER
			l_src: like src
			l_dst: like dst
		do
				-- convert it into an array because it is faster to access
			tmp_lst := a_src_text.split (line_delimiter)
			create l_src.make_filled ("", 0, tmp_lst.count - 1)
			src := l_src
			from
				tmp_lst.start
				i := 0
			until
				tmp_lst.after
			loop
				l_src[i] := tmp_lst.item
				tmp_lst.forth
				i := i + 1
			end

			tmp_lst := a_dst_text.split (line_delimiter)
			create l_dst.make_filled ("", 0, tmp_lst.count - 1)
			dst := l_dst
			from
				tmp_lst.start
				i := 0
			until
				tmp_lst.after
			loop
				l_dst[i] := tmp_lst.item
				tmp_lst.forth
				i := i + 1
			end

			create unified_header.make_empty
		ensure
			values_set: values_set
			unified_header_attached: unified_header /= Void
		end

	set_file (a_src_file: READABLE_STRING_GENERAL; a_dst_file: READABLE_STRING_GENERAL)
			-- Set the two files to compare line by line.
		require
			a_src_file_not_void: a_src_file /= void
			a_src_file_not_empty: not a_src_file.is_empty
			a_dst_file_not_void: a_dst_file /= void
			a_dst_file_not_empty: not a_dst_file.is_empty
		local
			file_src, file_dst: PLAIN_TEXT_FILE
			line: detachable STRING_8
			i: INTEGER
			l_header: like unified_header
			l_src: like src
			l_dst: like dst
			utf: UTF_CONVERTER
		do
			create file_src.make_with_name (a_src_file)
			file_src.open_read
			create l_src.make_empty
			l_src.rebase (0)
			src := l_src
			create l_header.make_empty
			unified_header := l_header
			l_header.append ("--- ")
			l_header.append (utf.escaped_utf_32_string_to_utf_8_string_8 (file_src.path.name))

			l_header.append_character (line_delimiter)
			from
				i := 0
			until
				file_src.end_of_file
			loop
				file_src.readline
				line := file_src.last_string
				check line_attached: line /= Void end
				l_src.force (line.twin, i)

				i := i + 1
			end
			file_src.close

			create file_dst.make_with_name (a_dst_file)
			file_dst.open_read
			create l_dst.make_empty
			l_dst.rebase (0)
			dst := l_dst
			l_header.append ("+++ ")
			l_header.append (utf.escaped_utf_32_string_to_utf_8_string_8 (file_dst.path.name))
			l_header.append_character (line_delimiter)
			from
				i := 0
			until
				file_dst.end_of_file
			loop
				file_dst.readline
				line := file_dst.last_string
				check line_attached: line /= Void end
				l_dst.force (line.twin, i)
				i := i + 1
			end
			file_dst.close
		ensure
			values_set: values_set
			unified_header_attached: unified_header /= Void
		end

feature -- Basic operations

	patch (a_text: READABLE_STRING_8; a_patch: READABLE_STRING_8; reversed: BOOLEAN): STRING_8
			-- Apply `a_patch' (in unified patch format) to `a_text'. If the patch was created from destination to source set `reversed'.
		require
			a_text_not_void: a_text /= void
			a_patch_not_void: a_patch /= void
		local
			commands: LIST [READABLE_STRING_8]
			lines: LIST [READABLE_STRING_8]
			tmp: READABLE_STRING_8
			add_char, del_char, match_char: CHARACTER_8
		do
			match_char := ' '
			if reversed then
				add_char := '-'
				del_char := '+'
			else
				add_char := '+'
				del_char := '-'
			end

			create Result.make_empty
			commands := a_patch.split (line_delimiter)
			lines := a_text.split (line_delimiter)

			from
				commands.start
				lines.start
			until
				commands.after
				and
				lines.after
			loop
				if not commands.after then
						-- block header?
					if commands.item.count > 4 and then ("@@ ").same_string (commands.item.substring (1, 3)) then
						if reversed then
							tmp := commands.item.substring (commands.item.index_of (' ', 6)+2, commands.item.count-3)
						else
							tmp := commands.item.substring (5, commands.item.index_of (' ', 6)-1)
						end
						if tmp.index_of (',', 1) > 0 then
							tmp := tmp.substring (1, tmp.index_of (',', 1)-1)
						end
						from
						until
							lines.after or lines.index >= tmp.to_integer
						loop
							Result.append (lines.item)

							lines.forth
							if not lines.after then
								Result.append_character (line_delimiter)
							end
						end
						-- block data
					elseif commands.item.count > 0 then
						if commands.item.item (1) = add_char then
							Result.append (commands.item.substring (2, commands.item.count))
							Result.append_character (line_delimiter)
						elseif commands.item.item (1) = del_char then
							if not lines.after then
								lines.forth
							end
						elseif commands.item.item (1) = match_char then
							if not lines.after then
								Result.append (lines.item)
								lines.forth
								if not lines.after then
									Result.append_character (line_delimiter)
								end
							end
						end
					end
					commands.forth
				else
					Result.append (lines.item)
					if not lines.after then
						lines.forth
					end
					if not lines.after then
						Result.append_character (line_delimiter)
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	line_delimiter: CHARACTER_8
			-- The line delimiter to use
		do
			Result := '%N'
		end

	unified_header: detachable STRING_8
			-- The header for the unified diff.

;note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
