indexing
	description: "Diff class for texts."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DIFF_TEXT

inherit
	DIFF [STRING]
		export
			{NONE} set
		end

feature -- Access

	unified: STRING is
			-- Get the diff in unified diff format.
		require
			hunks_not_void: hunks /= void
		local
			ss, se, ds, de: INTEGER --start and end positions in source and destination of this block
			block_line_diff, line_diff: INTEGER -- #lines in destination - #lines in source
			line_add: DIFF_LINE_ADD
			block: STRING
		do
			create Result.make_empty
			Result.append (unified_header)
			from
				hunks.start
			until
				hunks.after
			loop
				create block.make_empty
				ss := ss.Max_value
				se := -1
				ds := ds.Max_value
				de := -1
				block_line_diff := 0
				from
					hunks.item.start
				until
					hunks.item.after
				loop
						-- What kind of line is it (add or remove)
					line_add ?= hunks.item.item
					if line_add /= void then
						if ds > hunks.item.item.dst then
							ds := hunks.item.item.dst
						end
						if de < hunks.item.item.dst then
							de := hunks.item.item.dst
						end
						block_line_diff := block_line_diff + 1
						block.append ("+")
						block.append (dst[hunks.item.item.dst])
						block.append_character (line_delimiter)
					else
						if ss > hunks.item.item.src then
							ss := hunks.item.item.src
						end
						if se < hunks.item.item.src then
							se := hunks.item.item.src
						end
						block_line_diff := block_line_diff - 1
						block.append ("-")
						block.append (src[hunks.item.item.src])
						block.append_character (line_delimiter)
					end
					hunks.item.forth
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
				hunks.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_text (a_src_text: STRING; a_dst_text: STRING) is
			-- Set the two texts to compare line by line.
		require
			a_src_text_not_void: a_src_text /= Void
			a_dst_text_not_void: a_dst_text /= Void
		local
			tmp_lst: LIST [STRING]
			i: INTEGER
		do
				-- convert it into an array because it is faster to access
			tmp_lst := a_src_text.split (line_delimiter)
			create src.make(0, tmp_lst.count-1)
			from
				tmp_lst.start
				i := 0
			until
				tmp_lst.after
			loop
				src[i] := tmp_lst.item
				tmp_lst.forth
				i := i + 1
			end

			tmp_lst := a_dst_text.split (line_delimiter)
			create dst.make(0, tmp_lst.count-1)
			from
				tmp_lst.start
				i := 0
			until
				tmp_lst.after
			loop
				dst[i] := tmp_lst.item
				tmp_lst.forth
				i := i + 1
			end

			create unified_header.make_empty
		ensure
			values_set: values_set
		end

	set_file (a_src_file: STRING; a_dst_file: STRING) is
			-- Set the two files to compare line by line.
		require
			a_src_file_not_void: a_src_file /= void
			a_src_file_not_empty: not a_src_file.is_empty
			a_dst_file_not_void: a_dst_file /= void
			a_dst_file_not_empty: not a_dst_file.is_empty
		local
			file_src, file_dst: PLAIN_TEXT_FILE
			i: INTEGER
		do
			create file_src.make_open_read(a_src_file)
			create src.make (0, 0)
			create unified_header.make_empty
			unified_header.append ("--- ")
			unified_header.append (a_src_file)

			unified_header.append_character (line_delimiter)
			from
				i := 0
			until
				file_src.end_of_file
			loop
				file_src.readline
				src.force (create {STRING}.make_from_string (file_src.last_string), i)
				i := i + 1
			end
			file_src.close

			create file_dst.make_open_read(a_dst_file)
			create dst.make (0, 0)
			unified_header.append ("+++ ")
			unified_header.append (a_dst_file)
			unified_header.append_character (line_delimiter)
			from
				i := 0
			until
				file_dst.end_of_file
			loop
				file_dst.readline
				dst.force (create {STRING}.make_from_string (file_dst.last_string), i)
				i := i + 1
			end
			file_dst.close
		ensure
			values_set
		end

feature -- Basic operations

	patch (a_text:STRING; a_patch: STRING; reversed: BOOLEAN): STRING is
			-- Apply `a_patch' (in unified patch format) to `a_text'. If the patch was created from destination to source set `reversed'.
		require
			a_text_not_void: a_text /= void
			a_patch_not_void: a_patch /= void
		local
			commands: LIST [STRING]
			lines: LIST [STRING]
			tmp: STRING
			add_char, del_char, match_char: CHARACTER
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
					if commands.item.count > 4 and then ("@@ ").is_equal(commands.item.substring (1, 3)) then
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
							lines.index >= tmp.to_integer
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
							lines.forth
						elseif commands.item.item (1) = match_char then
							Result.append (lines.item)
							lines.forth
							if not lines.after then
								Result.append_character (line_delimiter)
							end
						end
					end
					commands.forth
				else
					Result.append (lines.item)
					lines.forth
					if not lines.after then
						Result.append_character (line_delimiter)
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	line_delimiter: CHARACTER is
			-- The line delimiter to use
		do
			Result := '%N'
		end

	unified_header: STRING;
			-- The header for the unified diff.
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
