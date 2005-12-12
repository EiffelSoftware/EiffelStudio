indexing
	description: "Diff class for texts."
	author: "Patrick Ruckstuhl"
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
						block.append ("%N")
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
						block.append ("%N")
					end
					hunks.item.forth
				end

				-- if we had only adds or dels in this block the other start/end position
				-- is not filled and has to be computed with line_diff
				if se = -1 then
					ss := ds-line_diff-1
					se := ss-1
				elseif de = -1 then
					ds := ss+line_diff-1
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
				Result.append (" @@%N")
				Result.append (block)

				line_diff := line_diff + block_line_diff
				hunks.forth
			end
		end


feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_text (a_src_text: STRING; a_dst_text: STRING) is
			-- Set the two texts to compare line by line.
		local
			tmp_lst: LIST [STRING]
			i: INTEGER
		do
			-- convert it into an array because it is faster to access
			tmp_lst := a_src_text.split (' ')
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

			tmp_lst := a_dst_text.split (' ')
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
			values_set := true
		ensure
			values_set: values_set
		end

	set_file (a_src_file: STRING; a_dst_file: STRING) is
			-- Set the two files to compare line by line.
		require
			a_src_file_not_void: a_src_file /= void
			a_dst_file_not_void: a_dst_file /= void
		local
			file_src, file_dst: PLAIN_TEXT_FILE
			i: INTEGER
		do
			create file_src.make_open_read(a_src_file)
			create src.make (0, 0)
			create unified_header.make_empty
			unified_header.append ("--- ")
			unified_header.append (a_src_file)

			unified_header.append ("%N")
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
			unified_header.append ("%N")
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

			values_set := true
		ensure
			values_set
		end



feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	unified_header: STRING
			-- The header for the unified diff.

invariant
	invariant_clause: True -- Your invariant here

end
