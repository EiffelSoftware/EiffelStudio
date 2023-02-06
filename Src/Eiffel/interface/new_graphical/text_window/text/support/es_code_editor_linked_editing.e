note
	description: "Get editor tokens and linking tokens from a given text"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_EDITOR_LINKED_EDITING

inherit
	ES_CODE_EDITOR_LINKING
		redefine
			prepare,
			terminate,
			propagate_on_insertion,
			propagate_on_deletion
		end

	TEXT_OBSERVER

create
	make

feature {NONE} -- Initialization

	make (a_text: EDITABLE_TEXT; a_editor: like editor; a_pos_in_text: INTEGER; a_regions: LIST [TUPLE [start_pos,end_pos: INTEGER]]; a_token_text: detachable READABLE_STRING_GENERAL)
			-- Handle linked edit at position `a_pos_in_text' if set, otherwise at editor cursor.
			-- And if `a_regions' is not empty, limit the impact token in those regions.
		do
			editor := a_editor
			text := a_text
			if a_token_text = Void then
				get_cursor_tokens (a_pos_in_text, a_regions)
			else
				get_tokens (a_pos_in_text, a_regions, a_token_text)
			end
		end

feature {ES_CODE_EDITOR_LINKING} -- Internal Access

	editor: EDITABLE_TEXT_PANEL
			-- Associated editor component.
			--| (Mainly used to force the refresh of editor lines).

	text: EDITABLE_TEXT
			-- Associated text component.

feature -- Management

	associated_manager: detachable ES_CODE_EDITOR_LINKED_EDITING_MANAGER assign set_associated_manager

	set_associated_manager (m: like associated_manager)
		do
			associated_manager := m
		end

feature -- Access: UI

	background_color: detachable EV_COLOR
			-- Optional background color to highlight the linked tokens.

	text_color: detachable EV_COLOR
			-- Optional text color to highlight the linked tokens.

feature -- Access: Tokens			

	linked_items: detachable ARRAYED_LIST [ES_CODE_EDITOR_LINKED_ITEM]
			-- Linked tokens and associated data (positions, ...).

	linked_items_count: INTEGER
			-- Number of linked tokens if any.
		do
			if attached linked_items as lst then
				Result := lst.count
			end
		end

	sort_linked_items
			-- Sort `linked_items' by start location.
		local
			l_sorter: QUICK_SORTER [ES_CODE_EDITOR_LINKED_ITEM]
		do
			if attached linked_items as lst then
				create l_sorter.make (create {COMPARABLE_COMPARATOR [ES_CODE_EDITOR_LINKED_ITEM]})
				l_sorter.sort (lst)
			end
		end

feature -- Status report			

	is_active_at (a_pos_in_text: INTEGER): BOOLEAN
		do
			if attached linked_items as lst and then not lst.is_empty then
				across
					lst as ic
				until
					Result
				loop
					if ic.item.is_included (a_pos_in_text) then
						Result := True
					end
				end
			end
		end

	is_always_linked_editing_from_first_occurrence: BOOLEAN = True
			-- Always start linked editing from the first occurence of the token.
			--| For now, always True while waiting to fix behavior when linked-editing
			--| 	from others tokens.

feature -- Element change

	set_background_color (a_color: detachable EV_COLOR)
			-- Set `background_color' to `a_color'.
		do
			background_color := a_color
		end

	set_text_color (a_color: detachable EV_COLOR)
			-- Set `text_color' to `a_color'.
		do
			text_color := a_color
		end

feature -- Execute

	dbg_print (m: READABLE_STRING_GENERAL)
		do
			debug ("editor_linked_editing")
				print (m)
			end
		end

	prepare
			-- <Precursor>
		local
			bgcol, fgcol: detachable EV_COLOR
			txt: like text
			pos: INTEGER
			l_item: detachable ES_CODE_EDITOR_LINKED_ITEM
		do
			if
				attached linked_items as lst and then
				not lst.is_empty
			then
				debug ("editor_linked_editing")
					dbg_print ({STRING_32} "Begin linked editing [nb tokens:" + lst.count.out +", token=%"" + lst.first.initial_text + "%"].%N")
				end

				bgcol := background_color
				fgcol := text_color

				txt := text
				pos := txt.cursor.pos_in_text
				across
					lst as ic
				loop
					l_item := ic.item
					debug ("editor_linked_editing")
						dbg_print ({STRING_32} " - " + l_item.debug_output + " -> %"" + l_item.initial_text + "%"%N")
					end
					across
						l_item.tokens as toks
					loop
						toks.item.set_background_color (bgcol)
						toks.item.set_text_color (fgcol)
					end
				end
				refresh_related_lines (True)
				txt.cursor.go_to_position (pos)
				text.add_edition_observer (Current)
			end
		end

	terminate
			-- <Precursor>
		local
			pos: INTEGER
			l_item: detachable ES_CODE_EDITOR_LINKED_ITEM
		do
			text.remove_observer (Current)
			if
				attached linked_items as lst and then
				attached text as txt
			then
				debug ("editor_linked_editing")
					dbg_print ("Finish linked editing [nb tokens:" + lst.count.out + "].%N")
				end
				if attached txt.cursor as curs then
					pos := curs.pos_in_text
					across
						lst as ic
					loop
						l_item := ic.item
						debug ("editor_linked_editing")
							dbg_print ({STRING_32} " - " + l_item.debug_output + " -> %"" + l_item.initial_text + "%"%N")
						end
						across
							l_item.tokens as toks
						loop
							toks.item.set_background_color (l_item.background_color)
							toks.item.set_text_color (l_item.text_color)
						end
					end
					refresh_related_lines (False)
					curs.go_to_position (pos)
				end
			end
		end

	dbg_print_linked_token_infos
			-- Display info about linked tokens.
		local
			l_item: detachable ES_CODE_EDITOR_LINKED_ITEM
		do
			debug ("editor_linked_editing")
				if attached linked_items as lst and then attached text as txt then
					dbg_print ("Linked tokens info [nb tokens:" + lst.count.out + "].%N")
					if attached txt.cursor as curs then
						dbg_print (" - cursor position:" + curs.pos_in_text.out + "%N")
						across
							lst as ic
						loop
							l_item := ic.item
							dbg_print ({STRING_32} " - " + l_item.debug_output + " -> %"" + l_item.initial_text + "%"%N")
						end
					end
				end
			end
		end

	dbg_text_positions (a_text: like text): STRING_32
		local
			ln: VIEWER_LINE
			tok: EDITOR_TOKEN
			s: STRING_32
		do
			create Result.make_empty
			from
				ln := a_text.first_line
			until
				ln = Void
			loop
				Result.append ("#" + ln.index.out)
				create s.make_from_string (ln.wide_image)
				s.replace_substring_all ("%T", "%%T")
				s.keep_head (60)
				if attached ln.first_token as ftok then
					Result.append_string_general (" @<" + ftok.pos_in_text.out)
				end
				if attached ln.eol_token as eoltok then
					Result.append_string_general (" @>" + eoltok.pos_in_text.out)
				end
				Result.append ({STRING_32} " '" + s + "'%N")
				from
					tok := ln.first_token
				until
					tok = Void
				loop
					Result.append_string_general (" @" + tok.pos_in_text.out)

					Result.append_string_general ("[" + tok.length.out + "]")

					create s.make_from_string (tok.wide_image)
					s.replace_substring_all ("%T", " ")
					s.keep_head (6)
					Result.append ({STRING_32} "/" + s + "/")
					if attached {EDITOR_TOKEN_EOL} tok then
						tok := Void
					else
						tok := tok.next
					end
				end
				Result.append_string_general ("%N")
				ln := ln.next
			end
		end


	propagate_on_insertion (a_cursor: EDITOR_CURSOR; a_size_diff: INTEGER)
			-- <Precursor>
		do
			execute	(a_cursor, a_size_diff)
		end

	propagate_on_deletion (a_cursor: EDITOR_CURSOR; a_size_diff: INTEGER)
			-- <Precursor>
		do
			execute	(a_cursor, a_size_diff)
		end

	on_editing (a_pos_in_text: INTEGER; a_size_diff: INTEGER)
			-- <Precursor>
		local
			l_item: ES_CODE_EDITOR_LINKED_ITEM
		do
			debug ("editor_linked_editing")
				dbg_print ("on editing #" + a_pos_in_text.out + " diff=" + a_size_diff.out + "%N")
			end
			across
				linked_items as lst
			loop
				l_item := lst.item
				if l_item.end_pos + a_size_diff = a_pos_in_text then
						-- Add a char to the wanted token.
					l_item.end_pos := l_item.end_pos + a_size_diff
				elseif l_item.end_pos < a_pos_in_text then
						-- Ignore
					debug ("editor_linked_editing")
						dbg_print ("%%(" + l_item.start_pos.out + "," + l_item.end_pos.out + ") => KEEP.%N")
					end
				else
					debug ("editor_linked_editing")
						dbg_print ("%%(" + l_item.start_pos.out + "," + l_item.end_pos.out + ") => ")
					end
					if l_item.start_pos > a_pos_in_text then
						l_item.start_pos := l_item.start_pos + a_size_diff
					end
					l_item.end_pos := l_item.end_pos + a_size_diff
					debug ("editor_linked_editing")
						dbg_print ("%%(" + l_item.start_pos.out + "," + l_item.end_pos.out + ").%N")
					end
				end
			end
		end

feature {NONE} -- Execution		

	execute (a_cursor: EDITOR_CURSOR; a_size_diff: INTEGER)
		local
			tok: detachable EDITOR_TOKEN
			txt: like text
			idx: INTEGER
			l_new_item_text, cs: STRING_32
			pos, k: INTEGER
			l_item: ES_CODE_EDITOR_LINKED_ITEM
		do
				-- When the text is modified (insertion, deletion, replacement),
				-- and if the current cursor position is on a linked token,
				-- the `execute' feature is called with `a_size_diff' precising the size difference result of the operation.
				-- Note the operation (insertion, ...) already occurred,
				-- so the text has already the updated token under the current cursor.
				-- And the various token pos_in_text are already updated!
				--
				-- The current feature will update the other linked tokens.
			if
				attached linked_items as lst and then not lst.is_empty and then
				attached editing_item (a_cursor.pos_in_text) as l_editing_item
			then
				txt := text
				pos := a_cursor.pos_in_text

				if attached associated_manager as mng then
						-- Update linked token informations.
					mng.on_linked_editing (Current, pos, a_size_diff)
				end



				debug ("editor_linked_editing")
					dbg_print ("%NEnter-> Cursor at position " + a_cursor.pos_in_text.out + "%N")
				end

				tok := a_cursor.token
				update_pos_in_text (tok)
				idx := l_editing_item.token_index_for_pos_in_text (tok.pos_in_text)
				if idx = 0 then
					tok := tok.previous
					update_pos_in_text (tok)
					idx := l_editing_item.token_index_for_pos_in_text (tok.pos_in_text)
					if idx = 0 then
						tok := Void
					end
				end

				if tok /= Void then
					cs := tok.wide_image
					k := tok.pos_in_text
					if k = 0 then
						k := l_editing_item.start_pos
					end

					debug ("editor_linked_editing")
						dbg_print ("Execute linked editing [pos=" + pos.out + "].%N")
						dbg_print ({STRING_32} " editing item " + l_editing_item.debug_output + {STRING_32} " %"" + cs + {STRING_32} "%".%N")
						dbg_print ({STRING_32} " cursor token:%"" + cs + {STRING_32} "%".%N")
					end
					l_new_item_text := txt.string_between_pos_in_text (l_editing_item.start_pos, l_editing_item.end_pos)

					across
						lst as ic
					loop
						l_item := ic.item
						if l_item = l_editing_item then
							debug ("editor_linked_editing")
								dbg_print ({STRING_32} "!" + l_item.debug_output + {STRING_32} " [diff="+a_size_diff.out+ ",pos="+pos.out+ "] Editing !!!%N")
							end
								-- l_editing_item already updated with diff, but now offset
							if pos > l_item.end_pos then -- previous `end_pos'!
								pos := pos + a_size_diff
							end

							debug ("editor_linked_editing")
								dbg_print ({STRING_32} " " + l_item.debug_output + " [diff="+a_size_diff.out+",pos="+pos.out+"] %"" + l_item.initial_text + "%" updated.%N")
							end
						else
							debug ("editor_linked_editing")
								dbg_print ({STRING_32} " " + l_item.debug_output + " [diff="+a_size_diff.out+",pos="+pos.out+"] %"" + l_item.initial_text + "%" replaced with %""+ cs +"%".%N")
							end

							replace_for_replace_all (txt, l_item.start_pos, l_item.end_pos, l_new_item_text) -- FIXME: replace tokens in l_item!
							if attached associated_manager as mng then
								mng.on_linked_editing (Current, l_item.start_pos, a_size_diff)
							end

							if pos > l_item.end_pos then -- previous `end_pos'!
								pos := pos + a_size_diff
							end

							debug ("editor_linked_editing")
								dbg_print ({STRING_32} " " + l_item.debug_output + " [diff="+a_size_diff.out+"] %"" + l_item.initial_text + "%" updated.%N")
							end

							l_item.line.update_token_information
						end
					end
					refresh_related_lines (True)
					a_cursor.go_to_position (pos)

					debug ("editor_linked_editing")
						dbg_print ("Exit-> Cursor at position " + a_cursor.pos_in_text.out + "%N")
					end
				else
					debug ("editor_linked_editing")
						dbg_print ({STRING_32} "Execute linked editing outside editing token %"" + a_cursor.token.wide_image + "%"!!!%N")
					end
					terminate
				end
			else
				terminate
			end
			debug ("editor_linked_editing")
				dbg_print_linked_token_infos
			end
		end

	replace_for_replace_all (a_text: like text; a_start_pos, a_end_pos: INTEGER; a_new_string: READABLE_STRING_GENERAL)
		local
			p: INTEGER
		do
			debug ("editor_linked_editing")
				dbg_print ({STRING_32} "Replace [" + a_start_pos.out + "," + a_end_pos.out + "] %"" + a_text.string_between_pos_in_text (a_start_pos, a_end_pos) + "%" by %"" + a_new_string.to_string_32 + "%"%N")
			end
			if a_start_pos = a_end_pos then
				p := a_text.cursor.pos_in_text
				a_text.cursor.go_to_position (a_start_pos)
				a_text.insert_string (a_new_string)
				if p >= a_start_pos then
					p := p + a_new_string.count
				end
				a_text.cursor.go_to_position (p)
			else
				a_text.replace_for_replace_all (a_start_pos, a_end_pos, a_new_string)
			end
		end

	update_pos_in_text (tok: EDITOR_TOKEN)
			-- Try updating `tok.pos_in_text` if missing.
		local
			prev_tok: detachable EDITOR_TOKEN
		do
			if tok.pos_in_text = 0 then
				debug ("editor_linked_editing")
					dbg_print ("Updated token pos_in_text: #" + tok.pos_in_text.out + "%N")
				end
				prev_tok := tok.previous
				if prev_tok /= Void and then prev_tok.pos_in_text > 0 then
					tok.set_pos_in_text (prev_tok.pos_in_text + prev_tok.length)
				end
			end
		end

feature {ES_CODE_EDITOR_LINKED_EDITING} -- Implementation

	refresh_related_lines (l_is_editing: BOOLEAN)
			-- Refresh related lines.
			-- If `l_is_editing' is True, the linked behavior is active,
			-- otherwise it is discarded or being discard.
		local
			txt: like text
			pos: INTEGER
			fgcolor, bgcolor: detachable EV_COLOR
		do
			if attached associated_manager as mng then
				across
					mng.items as lnk
				loop
					if attached {ES_CODE_EDITOR_LINKED_EDITING} lnk.item as l_item then
						if attached l_item.linked_items as lst then
							if l_is_editing then
								bgcolor := background_color
								fgcolor := text_color
							else
								bgcolor := Void
								fgcolor := Void
							end
							txt := l_item.text
							pos := txt.cursor.pos_in_text
							across
								lst as ic
							loop
								if ic.item.start_pos > 0 then
									txt.cursor.go_to_position (ic.item.start_pos)
									txt.cursor.token.set_background_color (bgcolor)
									txt.cursor.token.set_text_color (fgcolor)
									l_item.editor.redraw_current_line
								elseif attached ic.item.line as l_line and then l_line.is_valid then
									txt.go_i_th (l_line.index)
									l_item.editor.redraw_current_line
								else
									l_item.editor.redraw_current_screen
								end
							end
							txt.cursor.go_to_position (pos)
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	editing_item (a_pos_in_text: INTEGER): detachable ES_CODE_EDITOR_LINKED_ITEM
		do
			across
				linked_items as lst
			until
				Result /= Void
			loop
				Result := lst.item
				if Result.start_pos <= a_pos_in_text and a_pos_in_text <= Result.end_pos + 1 then -- +1 to allow cursor to be just after the wanted token.
						-- Found!
				else
					Result := Void
				end
			end
		end

	is_valid_editing_position (a_pos_in_text: INTEGER): BOOLEAN
			-- Is position `a_pos_in_text' inside the token being edited?
		do
			if
				a_pos_in_text > 0 and then
				attached editing_item (a_pos_in_text) as i
			then
				Result := i.start_pos <= a_pos_in_text and a_pos_in_text <= i.end_pos + 1 -- +1 to allow cursor to be just after the wanted token.
			end
		end

	get_tokens (a_pos_in_text: INTEGER; a_regions: LIST [TUPLE [start_pos,end_pos: INTEGER]]; a_token_text: READABLE_STRING_GENERAL)
			-- Get linked token from `a_pos_in_text' if set, or from `cursor'.
			-- If `a_regions' is set and not empty, only take into account token inside those regions.
		require
			a_token_text_provided: a_token_text /= Void and then not a_token_text.is_whitespace
			a_regions /= Void and then not a_regions.is_empty
		local
			pos: INTEGER
			l_curr_line: EDITOR_LINE
			l_curr_token: EDITOR_TOKEN
			tok, l_next_tok: detachable EDITOR_TOKEN
			l_tok_list: ARRAYED_LIST [EDITOR_TOKEN]
			l_line: EDITOR_LINE
			l_linked_tokens: like linked_items
			txt: like text
			l_item: ES_CODE_EDITOR_LINKED_ITEM
			l_tok_image: READABLE_STRING_32
			s: STRING_32
		do
			create l_linked_tokens.make (1)
			linked_items := l_linked_tokens

			txt := text

			debug ("editor_linked_editing")
				dbg_print (dbg_text_positions (txt))
			end


			pos := txt.cursor.pos_in_text
			l_curr_line := txt.cursor.line
			l_curr_token := txt.cursor.token

			if l_curr_token.pos_in_text + l_curr_token.length > a_pos_in_text then
					-- Select previous!
				l_curr_token := l_curr_token.previous
			end

			across
				a_regions as ic
			loop
				txt.cursor.go_to_position (ic.item.start_pos)
				from
					l_line := txt.cursor.line
					l_line.update_token_information
					tok := txt.cursor.token
					update_pos_in_text (tok)
				until
					tok = Void or l_line = Void or else tok.pos_in_text > ic.item.end_pos
				loop
					l_tok_image := tok.wide_image
					if a_token_text.same_string (l_tok_image) then
						if tok.previous.wide_image.same_string (".") then
								-- Avoid case like "foo.foo"
						else
							create l_item.make (l_line, <<tok>>, tok.pos_in_text, tok.pos_in_text + tok.length)
							l_linked_tokens.force (l_item)
						end
					elseif a_token_text.starts_with (l_tok_image) then
							-- Probably a_token_text is not a single token text (more like `arr.lower').
							-- Check if following tokens are matching `a_token_text'.
						if tok.previous.wide_image.same_string (".") then
								-- Avoid case like "foo.foo"
						else
							from
								create l_tok_list.make (3)
								create s.make (a_token_text.count)
								s.append (l_tok_image)
								l_tok_list.extend (tok)
								l_next_tok := tok.next
							until
								l_next_tok = Void or else (a_token_text.same_string (s) or not a_token_text.starts_with (s))
							loop
								l_tok_list.extend (l_next_tok)
								s.append (l_next_tok.wide_image)
								l_next_tok := l_next_tok.next
							end
							if a_token_text.same_string (s) then
									-- Found a match!
								create l_item.make (l_line, l_tok_list, tok.pos_in_text, tok.pos_in_text + s.count)
								l_linked_tokens.force (l_item)

								tok := l_tok_list.last
							else
							end
						end
					end
					tok := tok.next
					if tok = Void then
						if l_line /= Void then
							l_line := l_line.next
							if l_line /= Void then
								l_line.update_token_information
								tok := l_line.first_token
							end
						end
					end
					if tok /= Void then
						update_pos_in_text (tok)
					end
				end
			end
			sort_linked_items
			txt.cursor.go_to_position (pos)

			debug ("editor_linked_editing")
				if attached {SMART_TEXT} txt as stxt then
					across
						l_linked_tokens as ic
					loop
						print ("[")
						print (a_token_text.out)
						print ("] ===> ")
						print (ic.item.debug_output)
						print ("%N")
					end

				end
			end
		end

	get_cursor_tokens (a_pos_in_text: INTEGER; a_regions: detachable LIST [TUPLE [start_pos,end_pos: INTEGER]])
			-- Get linked token from `a_pos_in_text' if set, or from `cursor'.
			-- If `a_regions' is set and not empty, only take into account token inside those regions.
		local
			l_curr_token: EDITOR_TOKEN
		do
			l_curr_token := text.cursor.token
			if l_curr_token.pos_in_text + l_curr_token.length > a_pos_in_text then
					-- Select previous!
				l_curr_token := l_curr_token.previous
			end
			if
				l_curr_token.is_text and then
				attached l_curr_token.wide_image as l_varname
			then
				get_tokens (a_pos_in_text, a_regions, l_varname)
			end
		end


note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
