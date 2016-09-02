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
			on_editing,
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

feature -- Access: Tokens			

	editing_token: detachable ES_CODE_EDITOR_LINKED_ITEM
			-- Token being edited.

	linked_tokens: detachable ARRAYED_LIST [ES_CODE_EDITOR_LINKED_ITEM]
			-- Linked tokens and associated data (positions, ...).

	sort_linked_tokens
			-- Sort `linked_tokens' by start location.
		local
			l_sorter: QUICK_SORTER [ES_CODE_EDITOR_LINKED_ITEM]
		do
			if attached linked_tokens as lst then
				create l_sorter.make (create {COMPARABLE_COMPARATOR [ES_CODE_EDITOR_LINKED_ITEM]})
				l_sorter.sort (lst)
			end
		end

feature -- Status report			

	is_active_at (a_pos_in_text: INTEGER): BOOLEAN
		do
			if attached linked_tokens as lst and then not lst.is_empty then
				if is_always_linked_editing_from_first_occurrence then
					Result := attached editing_token as e and then e.is_included (a_pos_in_text)
				else
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
		end

	is_always_linked_editing_from_first_occurrence: BOOLEAN = True
			-- Always start linked editing from the first occurence of the token.
			--| For now, always True while waiting to fix behavior when linked-editing
			--| 	from others tokens.

feature -- Element change

	set_background_color (a_col: detachable EV_COLOR)
			-- Set `background_color' to `a_col'.
		do
			background_color := a_col
		end

feature -- Execute

	dbg_print (m: READABLE_STRING_8)
		do
			debug ("editor")
				print (m)
			end
		end

	prepare
			-- <Precursor>
		local
			bgcol: detachable EV_COLOR
			txt: like text
			pos: INTEGER
			l_item: detachable ES_CODE_EDITOR_LINKED_ITEM
		do
			if
				attached linked_tokens as lst and
				attached editing_token as l_editing_token
			then
				debug ("editor")
					dbg_print ("Begin linked editing [nb tokens:" + lst.count.out +", token=%"" + l_editing_token.text + "%"].%N")
				end

				bgcol := background_color
				if bgcol = Void then
						-- Default background-color.
					create bgcol.make_with_8_bit_rgb (210, 255, 210)
					background_color := bgcol
				end

				txt := text
				pos := txt.cursor.pos_in_text
				across
					lst as ic
				loop
					l_item := ic.item
					debug ("editor")
						dbg_print (" - " + l_item.debug_output + " -> %"" + l_item.text + "%"%N")
					end
					across
						l_item.tokens as toks
					loop
						toks.item.set_background_color (bgcol)
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
			if attached linked_tokens as lst and then attached text as txt then
				debug ("editor")
					dbg_print ("Finish linked editing [nb tokens:" + lst.count.out + "].%N")
				end
				if attached txt.cursor as curs then
					pos := curs.pos_in_text
					across
						lst as ic
					loop
						l_item := ic.item
						debug ("editor")
							dbg_print (" - " + l_item.debug_output + " -> %"" + l_item.text + "%"%N")
						end
						across
							l_item.tokens as toks
						loop
							toks.item.set_background_color (l_item.background_color)
						end
					end
					refresh_related_lines (False)
					curs.go_to_position (pos)
				end
			end
			editing_token := Void
		end

	dbg_print_linked_token_infos
			-- Display info about linked tokens.
		local
			pos: INTEGER
			l_item: detachable ES_CODE_EDITOR_LINKED_ITEM
		do
			debug ("editor")
				if attached linked_tokens as lst and then attached text as txt then
					dbg_print ("Linked tokens info [nb tokens:" + lst.count.out + "].%N")
					if attached txt.cursor as curs then
						pos := curs.pos_in_text
						dbg_print (" - cursor position:" + pos.out + "%N")
						across
							lst as ic
						loop
							l_item := ic.item
							if l_item = editing_token then
								dbg_print (" > ")
							else
								dbg_print (" - ")
							end
							dbg_print (l_item.debug_output + " -> %"" + l_item.text + "%"%N")
						end
					end
				end
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
			if attached editing_token as e then
				print ("'")
				print (e.text)
				print ("' ")
				across
					e.tokens as ic
				loop
					ic.item.set_pos_in_text (ic.item.pos_in_text + a_size_diff)
				end
			end
			print ("@" + a_pos_in_text.out + " diff=" + a_size_diff.out + "%N")
			across
				linked_tokens as lst
			loop
				l_item := lst.item
				if l_item.end_pos <= a_pos_in_text then
						-- Ignore
					print ("%%(" + l_item.start_pos.out + "," + l_item.end_pos.out + ") => KEEP.%N")
				else
					print ("%%(" + l_item.start_pos.out + "," + l_item.end_pos.out + ") => ")
					if l_item.start_pos >= a_pos_in_text then
						l_item.start_pos := l_item.start_pos + a_size_diff
					end
					l_item.end_pos := l_item.end_pos + a_size_diff
					print ("%%(" + l_item.start_pos.out + "," + l_item.end_pos.out + ").%N")
				end
			end
		end

feature {NONE} -- Execution		

	execute (a_cursor: EDITOR_CURSOR; a_size_diff: INTEGER)
		local
			tok: detachable EDITOR_TOKEN
			e_diff, diff,off: INTEGER
			txt: like text
			s,cs: STRING_32
			pos, l_old_editing_start_pos, l_old_editing_end_pos, k: INTEGER
			l_item: ES_CODE_EDITOR_LINKED_ITEM
		do
			if
				attached linked_tokens as lst and
			 	attached editing_token as l_editing_token
			then
				txt := text
				l_old_editing_start_pos := l_editing_token.start_pos
				l_old_editing_end_pos := l_editing_token.end_pos
				l_editing_token.end_pos := l_editing_token.end_pos + a_size_diff

				pos := a_cursor.pos_in_text

				debug ("editor")
					dbg_print ("%NEnter-> Cursor at position " + a_cursor.pos_in_text.out + "%N")
				end


				tok := a_cursor.token.previous
				update_pos_in_text (tok)
				if
					tok.pos_in_text <= 0 or else
					not is_valid_editing_position (tok.pos_in_text)
				then
					tok := a_cursor.token
					update_pos_in_text (tok)
					if
						tok.pos_in_text <= 0 or else
						not is_valid_editing_position (tok.pos_in_text)
					then
						tok := Void
					end
				end
				if attached associated_manager as mng then
					mng.on_linked_editing (Current, pos, a_size_diff)
				end

				if tok /= Void then
					cs := tok.wide_image
					k := tok.pos_in_text
					if k = 0 then
						k := l_editing_token.start_pos
					end

					e_diff := tok.length - (l_old_editing_end_pos - l_old_editing_start_pos)
					check e_diff = a_size_diff end
					diff := a_size_diff
					s := cs

					debug ("editor")
						dbg_print ("Execute linked editing [pos=" + pos.out + "].%N")
						dbg_print (" editing token " + l_editing_token.debug_output + " %"" + cs + "%".%N")
						dbg_print (" cursor token:%"" + cs + "%".%N")
					end

					across
						lst as ic
					loop
						l_item := ic.item
						if is_editing_token (l_item) then
							debug ("editor")
								dbg_print ("!" + l_item.debug_output + " [off=" + off.out + ",diff="+diff.out+",pos="+pos.out+"] Editing !!!%N")
							end
								-- l_editing_token already updated with diff, but now offset
							if pos > l_item.end_pos then -- previous `end_pos'!
								pos := pos + diff
							end

							l_item.text := s

							off := off + diff

							debug ("editor")
								dbg_print (" " + l_item.debug_output + " [off=" + off.out + ",diff="+diff.out+",pos="+pos.out+"] %"" + l_item.text + "%" updated.%N")
							end
						else
							l_item.start_pos := l_item.start_pos + off
							l_item.end_pos := l_item.end_pos + off

							check same_diff: diff = s.count - (l_item.end_pos - l_item.start_pos) end

							debug ("editor")
								dbg_print (" " + l_item.debug_output + " [off=" + off.out + ",diff="+diff.out+",pos="+pos.out+"] %"" + l_item.text + "%" replaced with %""+ s +"%".%N")
							end
							txt.replace_for_replace_all (l_item.start_pos, l_item.end_pos, s)
							if attached associated_manager as mng then
								mng.on_linked_editing (Current, l_item.start_pos, diff)
							end
							l_item.text := s

							off := off + diff
							if pos > l_item.end_pos then -- previous `end_pos'!
								pos := pos + diff
							end
							l_item.end_pos := l_item.end_pos + diff
							debug ("editor")
								dbg_print (" " + l_item.debug_output + " [off=" + off.out + ",diff="+diff.out+"] %"" + l_item.text + "%" updated.%N")
							end

							if l_editing_token.start_pos > l_item.start_pos then
								l_editing_token.start_pos := l_editing_token.start_pos + diff
								l_editing_token.end_pos := l_editing_token.end_pos + diff
							end

							l_item.line.update_token_information
						end
					end
					refresh_related_lines (True)
					a_cursor.go_to_position (pos)

					debug ("editor")
						dbg_print ("Exit-> Cursor at position " + a_cursor.pos_in_text.out + "%N")
					end
				else
					debug ("editor")
						dbg_print ("Execute linked editing outside editing token %"" + a_cursor.token.wide_image + "%"!!!%N")
					end
					terminate
				end
			end
			debug ("editor")
				dbg_print_linked_token_infos
			end
		end

	update_pos_in_text (tok: EDITOR_TOKEN)
			-- Try updating `tok.pos_in_text` if missing.
		local
			prev_tok: detachable EDITOR_TOKEN
		do
			if tok.pos_in_text = 0 then
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
			bgcolor: detachable EV_COLOR
		do
			if attached associated_manager as mng then
				across
					mng.items as lnk
				loop
					if attached {ES_CODE_EDITOR_LINKED_EDITING} lnk.item as l_item then
						if attached l_item.linked_tokens as lst then
							if l_is_editing then
								bgcolor := background_color
								create bgcolor.make_with_8_bit_rgb (210, 255, 210)
							else
								bgcolor := Void
							end
							txt := l_item.text
							pos := txt.cursor.pos_in_text
							across
								lst as ic
							loop
								if ic.item.start_pos > 0 then
									txt.cursor.go_to_position (ic.item.start_pos)
									txt.cursor.token.set_background_color (bgcolor)
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

	is_editing_token (a_item: like editing_token): BOOLEAN
			-- Is `a_item' the token being edited in the linked token collection?
		do
			if a_item /= Void and attached editing_token as l_editing_token then
				Result := a_item.start_pos = l_editing_token.start_pos
						--and l_editing_token.end_pos <= a_item.end_pos
				debug ("editor")
					dbg_print (" " + l_editing_token.debug_output + " Check is_editing_token (" + a_item.debug_output + ") ? : " + Result.out + " .%N")
				end
			end
		end

	is_valid_editing_position (a_pos_in_text: INTEGER): BOOLEAN
			-- Is position `a_pos_in_text' inside the token being edited?
		do
			if a_pos_in_text > 0 and attached editing_token as l_editing_token then
				Result := l_editing_token.start_pos <= a_pos_in_text and
							a_pos_in_text <= l_editing_token.end_pos
				debug ("editor")
					dbg_print (" " + l_editing_token.debug_output + " Check is_valid_editing_position (" + a_pos_in_text.out + ") in ["+ l_editing_token.start_pos.out + "-" + l_editing_token.end_pos.out +"] ? : " + Result.out + " .%N")
				end
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
			tok: detachable EDITOR_TOKEN
			l_line: EDITOR_LINE
			l_linked_tokens: like linked_tokens
			txt: like text
			l_item: ES_CODE_EDITOR_LINKED_ITEM
		do
			create l_linked_tokens.make (1)
			linked_tokens := l_linked_tokens

			txt := text
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
					if a_token_text.same_string (tok.wide_image) then
						if tok.previous.wide_image.same_string (".") then
								-- Avoid case like "foo.foo"
						else
							create l_item.make (l_line, <<tok>>, tok.pos_in_text, tok.pos_in_text + tok.length)
							l_linked_tokens.force (l_item)
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
			sort_linked_tokens
			editing_token := l_linked_tokens.first

			if
				is_always_linked_editing_from_first_occurrence and then
				not l_linked_tokens.is_empty and then
				attached l_linked_tokens.first as e
			then
					-- Allow editing only from first token for now!
				editing_token := e
				--				txt.cursor.go_to_position (e.end_pos)
				--				txt.select_region (e.start_pos, e.end_pos)

			end
			txt.cursor.go_to_position (pos)

			if attached {SMART_TEXT} txt as stxt then
--				print (stxt.full_debug_output)
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
--			if
--				is_always_linked_editing_from_first_occurrence and then
--				not l_linked_tokens.is_empty and then
--				attached l_linked_tokens.first as e and then e /= l_editing_token
--			then
--					-- Allow editing only from first token for now!
--				editing_token := e
--				txt.cursor.go_to_position (e.end_pos)
--				txt.select_region (e.start_pos, e.end_pos)
--			end
		end

	is_token_inside_regions (tok: EDITOR_TOKEN; a_regions: detachable ITERABLE [TUPLE [start_pos,end_pos: INTEGER]]): BOOLEAN
			-- Is token `tok' inside the given regions `a_regions'?
			-- If `a_regions' is Void, the scope is the entire class.
		local
			tok_start_pos, tok_end_pos: INTEGER
		do
			if a_regions = Void then
				Result := True
			else
				tok_start_pos := tok.pos_in_text
				tok_end_pos := tok.pos_in_text + tok.length
				across
					a_regions as ic
				until
					Result
				loop
					Result := ic.item.start_pos <= tok_start_pos and tok_end_pos <= ic.item.end_pos
				end
			end
		end

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
