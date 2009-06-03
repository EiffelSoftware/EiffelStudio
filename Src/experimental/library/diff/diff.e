note
	description: "Compute the difference between two arrays."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DIFF [G -> HASHABLE ]

feature -- Access

	match: detachable LINKED_LIST [DIFF_LINE_MATCH]
			-- The indices of the elements that match in source and destination.

	hunks: detachable LINKED_LIST [LIST [DIFF_LINE]]
			-- The list of hunks.

feature -- Status report

	values_set: BOOLEAN
			-- Are the values to compare set?
		do
			Result := src /= Void and dst /= Void
		ensure
			src_attached: Result implies (src /= Void and dst /= Void)
		end

feature -- Change elements

	set (a_src: ARRAY [G]; a_dst: ARRAY [G])
			-- Set the source array `a_src' and the destination `a_dst'.
		require
			a_src_not_void: a_src /= Void
			a_dst_not_void: a_dst /= Void
		do
			src := a_src
			dst := a_dst
		ensure
			values_set: values_set
		end

	compute_diff
			-- Compute the diff between `src' and `dst'
		require
			values_set: values_set
		local
			i, si, di: INTEGER
			hunk: LINKED_LIST [DIFF_LINE]
			l_all_matches: like all_matches
			l_match: like match
			l_hunks: like hunks
			l_src: like src
			l_dst: like dst
		do
			compute_lcs
			l_all_matches := all_matches
			check l_all_matches_attached: l_all_matches /= Void end

			create l_match.make
			create l_hunks.make
			create hunk.make

			match := l_match
			hunks := l_hunks

			from
				si := 0
				di := 0
				i := 0
			until
				i > l_all_matches.count-1
			loop
				if l_all_matches.has (si+1) then
						-- loop through all the lines that have to be added till we reach the match
					from
					until
						di = l_all_matches.item (si+1)-1
					loop
						hunk.extend (create {DIFF_LINE_ADD}.make (si, di))
						di := di + 1
					end

					l_match.extend (create {DIFF_LINE_MATCH}.make (si, di))
					if hunk.count > 0 then
						l_hunks.extend (hunk)
						create hunk.make
					end
					i := i + 1
					di := di + 1
				else
					hunk.extend (create {DIFF_LINE_DEL}.make (si, di))
				end
				si := si + 1
			end

				-- now we are at the last match and have to handle the differences up to the file end
			l_src := src
			l_dst := dst
			check
				l_src_attached: l_src /= Void
				l_dst_attached: l_dst /= Void
			end
			from
			until
				si > l_src.count-1
				and
				di > l_dst.count-1
			loop
				if si <= l_src.count-1 then
					hunk.extend (create {DIFF_LINE_DEL}.make (si, di))
					si := si + 1
				end
				if di <= l_dst.count-1 then
					hunk.extend (create {DIFF_LINE_ADD}.make (si, di))
					di := di + 1
				end
			end

				-- if needed, add last hunk
			if hunk.count > 0 then
				l_hunks.extend (hunk)
			end
		ensure
			match_not_void: match /= Void
			hunks_not_void: hunks /= Void
		end

feature {NONE} -- Implementation

	src: detachable ARRAY[G]
			-- The source array.

	dst: detachable ARRAY[G]
			-- The destination array.

	all_matches: detachable HASH_TABLE[INTEGER, INTEGER]
			-- All the matches.

	compute_lcs
			-- Compute the longest common subsequence.
		require
			values_set: values_set
		local
			start_src, end_src, start_dst, end_dst: INTEGER
			hash_dst: HASH_TABLE [LINKED_LIST [INTEGER], G]
			i, h, m, si, di: INTEGER
			matches: detachable LINKED_LIST [INTEGER]
			links: ARRAYED_LIST [DIFF_INDEX_LINK]
			link: detachable DIFF_INDEX_LINK
			work: ARRAYED_LIST [INTEGER]
			l_all_matches: like all_matches
			l_src: like src
			l_dst: like dst
		do
				-- This uses the algorithm described in
				-- A Fast Algorithm for Computing Longest Common Subsequences, CACM, vol.20, no.5, pp.350-353, May 1977
			start_src := 0
			start_dst := 0
			l_src := src
			l_dst := dst
			check
				l_src_attached: l_src /= Void
				l_dst_attached: l_dst /= Void
			end
			end_src := l_src.count - 1
			end_dst := l_dst.count - 1

			create l_all_matches.make (l_src.count)
			all_matches := l_all_matches

				-- prune same lines at the beginning
			from
			until
				start_src > end_src or
				start_dst > end_dst or
				l_src [start_src] /~ l_dst [start_dst]
			loop
				l_all_matches.put (start_dst+1, start_src+1)
				start_src := start_src + 1
				start_dst := start_dst + 1
			end

				-- prune same lines at the end
			from
			until
				start_src > end_src or
				start_dst > end_dst or
				l_src [end_src] /~ l_dst [end_dst]
			loop
				l_all_matches.put (end_dst+1, end_src+1)
				end_src := end_src - 1
				end_dst := end_dst - 1
			end

				-- build hashtable which maps the contents in dst to their lines
			create hash_dst.make (end_dst - start_dst)
			from
				i := start_dst
			until
				i > end_dst
			loop
				if hash_dst.has (l_dst[i]) then
					matches := hash_dst.item (l_dst[i])
					check matches_attached: matches /= Void end
					matches.extend (i)
				else
					create matches.make
					matches.extend (i)
					hash_dst.put (matches, l_dst[i])
				end
				i := i + 1
			end

			create work.make (100)
			create links.make (100)

				-- loop trough the source
			from
				si := start_src
			until
				si > end_src
			loop
					-- do we have matches in dst?
				if hash_dst.has (l_src[si]) then
					matches := hash_dst.item (l_src[si])
					check matches_attached: matches /= Void end
					i := 0

						-- for each match
					from
						matches.finish
					until
						matches.before
					loop
						di := matches.item

							-- OPTIMIZATION: in most cases the further matches replace the last match, so we make a shortcut for this here
						if i > 1 and work[i] > di and work[i-1] < di then
							work[i] := di
						else
								-- add the element into the work list
								-- if the element is already in the list, do nothing and set i to -1
								-- if the place where the element belongs is filled with something else, replace it and set i to the position
								-- if there is no place, add it at the end and set i to the position

								-- OPTIMIZATION: shortcut for the cases that the entry has to be added at the end
							if work.is_empty or else work.last < di then
								work.extend (di)
								i := work.count
							else
								from
									i := 1
									h := work.count
								until
									i = -1 or i > h
								loop
									m := (i + h) // 2
									if work[m] = di then
										i := -1
									elseif work[m] > di then
										h := m - 1
									else
										i := m + 1
									end
								end
								if i > 0 then
									work[i] := di
								end
							end
						end

							-- now if we added the element to the work list, add it as a match into our links list
						if i /= -1 then
							if i > 1 then
								create link.make (links[i-1], si, di)
							else
								create link.make (Void, si, di)
							end
							if links.count < i then
								links.extend (link)
							else
								links.put_i_th (link, i)
							end
						end

						matches.back
					end
				end

				si := si + 1
			end

				-- store the matches
			if links.count > 0 then
				from
					link := links[links.count]
						-- check if the values themselves are also equal (above we worked with hashes)
					if l_src[link.index_src] ~ l_dst[link.index_dst] then
						l_all_matches.put (link.index_dst+1, link.index_src+1)
					end
				until
					link.next = Void
				loop
					link := link.next
					check link_attached: link /= Void end
						-- check if the values themselves are also equal (above we worked with hashes)
					if l_src[link.index_src] ~ l_dst[link.index_dst] then
						l_all_matches.put (link.index_dst+1, link.index_src+1)
					end
				end
			end
		ensure
			all_matches_attached: all_matches /= Void
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
