indexing
	description	: "undo/redo command stack"
	author		: "Christophe Bonnard / Etienne Amodeo"
	date		: "$Date$"
	revision	: "$Revision$"

class
	UNDO_REDO_STACK

create
	make

feature {NONE} -- Initialization

	make (a_text: EDITABLE_TEXT) is
			-- Initialize the stack.
		do
			text := a_text
			initialize
		end

feature {EDITABLE_TEXT} -- Initialization

	initialize is
			-- Reinitialize the stack
		do
			create undo_list.make
			create redo_list.make
			has_mark := False
			marked_cmd := Void
			current_status := move
			mark_enabled := True
			notify_observers
		end

feature {EDITABLE_TEXT} -- Access

	item: UNDO_CMD is
			-- First undo command, Void if none.
		do
			if undo_is_possible then
				Result := undo_list.first
			end
		end

	undo_is_possible: BOOLEAN is
			-- Is the `undo' operation possible?
		do
			Result := not undo_list.is_empty
		end

	redo_is_possible: BOOLEAN is
			-- Is the `undo' operation possible?
		do
			Result := not redo_list.is_empty
		end

feature {EDITABLE_TEXT} -- Element change

	record_move is
			-- Update `Current' state as the cursor as moved.
		do
			current_status := move
		end

	record_insert (c: CHARACTER) is
			-- Update `Current' as `c' is to be inserted at cursor position.
		local
			uic: UNDO_INSERT_CMD
			urc: UNDO_REPLACE_CMD
			udc: UNDO_DELETE_CMD
		do
			inspect current_status

			when insert_char then
				uic ?= item
				check
					uic /= Void
				end
				uic.extend (c)

			when back_delete then
				udc ?= item
				check
					udc /= Void
				end
				create urc.make_from_strings (text.cursor, udc.message, c.out, text)
				if udc.is_bound_to_next then
					urc.bind_to_next
				end
				undo_list.start
				undo_list.replace (urc)
				current_status := back_delete_combo

			when back_delete_combo then
				urc ?= item
				check
					urc /= Void
				end
				urc.extend_new (c)

			else
				create uic.make_from_string (text.cursor, c.out, text)
				put (uic)
				current_status := insert_char
			end

			notify_observers
		end

	record_insert_eol (inserted_indentation: STRING) is
			-- Update `Current' as a new line with indentation `inserted_indentation'
			-- is to be inserted at cursor position.
		local
			uic: UNDO_INSERT_CMD
		do
		--	Commented lines made the editor undo at the same time
		--	the insertion of the new line and of the characters at the end
		-- of the previous line.
--			inspect current_status
--
--			when insert_char then
--				uic ?= item
--				check
--					uic /= Void
--				end
--				uic.extend_string ("%N" + inserted_indentation)
--				current_status := insert_eol
--			else
				create uic.make_from_string	(text.cursor, "%N"  + inserted_indentation, text)
				put (uic)
				current_status := insert_eol
--			end

			notify_observers
		end

	record_paste (s: STRING) is
			-- Update `Current' as `s' is to be inserted at cursor position.
		local
			uic: UNDO_INSERT_CMD
		do
			create uic.make_from_string (text.cursor, s, text)
			put (uic)
			current_status := paste

			notify_observers
		end

	record_delete (c: CHARACTER) is
			-- Update `Current' as `c' is to be deleted at cursor position.
		local
			udc: UNDO_DELETE_CMD
		do
			if current_status = delete_char then
				udc ?= item
				check
					udc /= Void
				end
				udc.extend (c)
			else
				create udc.make_from_string (text.cursor, c.out, text)
				put (udc)
				current_status := delete_char
			end

			notify_observers
		end

	record_delete_selection (s: STRING) is
			-- Update `Current' as `s' has just been deleted at cursor position.
		local
			udc: UNDO_DELETE_CMD
		do
			create udc.make_from_string (text.cursor, s, text)
			put (udc)
			current_status := cut_selection

			notify_observers
		end


	record_replace (c1, c2: CHARACTER) is
		local
			urc: UNDO_REPLACE_CMD
		do
			if current_status = replace then
				urc ?= item
				check
					urc /= Void
				end
				if c1 = '%N' then
					urc.extend_new (c2)
				else
					urc.extend_both (c1, c2)
				end
			else
				if c1 = '%N' then
					create urc.make_from_strings (text.cursor, "", c2.out, text)
				else
					create urc.make_from_strings	 (text.cursor, c1.out, c2.out, text)
				end
				put (urc)
				current_status := replace
			end

			notify_observers
		end

	record_replace_selection (s1, s2: STRING) is
		local
			urc: UNDO_REPLACE_CMD
		do
			create urc.make_from_strings (text.cursor, s1, s2, text)
			put (urc)
			current_status := replace_selection
			notify_observers
		end

	record_replace_all (s1, s2: STRING) is
		local
			urac: UNDO_REPLACE_ALL_CMD
			urc: UNDO_REPLACE_CMD
		do
			if current_status = replace_all then
				urac ?= item
			else
				create urac.make
			end
			create urc.make_from_strings (text.cursor, s1, s2, text)
			urac.add(urc)
			if current_status /= replace_all then
				put (urac)
				current_status := replace_all
			end
			notify_observers
		end

	record_back_delete (c: CHARACTER) is
		local
			udc: UNDO_DELETE_CMD
		do
			if current_status = back_delete then
				udc ?= item
				check
					udc /= Void
				end
				udc.prepend (text.cursor, c)
			else
				create udc.make_from_string (text.cursor, c.out, text)
				put (udc)
				current_status := back_delete
			end

			notify_observers
		end

	record_symbol (begin_selection, end_selection: EDITOR_CURSOR; symbl: STRING) is
		local
			uisc: UNDO_SYMBOL_SELECTION_CMD
		do
			create uisc.make(begin_selection, end_selection, symbl, text)
			put (uisc)
			notify_observers
			current_status := symbol
		end

	record_unsymbol (lines: LINKED_LIST[INTEGER]; symbl:STRING) is
			--| Warning : to be called after `unsymbol_selection'
		local
			uusc: UNDO_UNSYMBOL_SELECTION_CMD
		do
			create uusc.make(lines, symbl, text)
			put (uusc)
			notify_observers
			current_status := unsymbol
		end

feature {EDITABLE_TEXT} -- Basic operations

	undo is
			-- undo command at the beginning of `undo_list'.
			-- update `undo_list' and `redo_list'.
		local
			uc: UNDO_CMD
		do
			if not undo_list.is_empty then
				undo_list.start
				uc := undo_list.item
				uc.undo
				redo_list.put_front (uc)
				undo_list.remove
				from until
					undo_list.is_empty or else not item.is_bound_to_next
				loop
					undo_list.start
					uc := undo_list.item
					uc.undo
					redo_list.put_front (uc)
					undo_list.remove
				end
				current_status := move
				notify_observers
				if undo_list.is_empty then
					uc := Void
				else
					uc := undo_list.first
				end
				if has_mark and then marked_cmd = uc then
					notify_text_of_mark_reached
				end
			end
		end

	redo is
			-- redo command at the beginning of `redo_list'.
			-- update `undo_list' and `redo_list'.
		local
			uc: UNDO_CMD
		do
			if not redo_list.is_empty then
				redo_list.start
				uc := redo_list.item
				uc.redo
				undo_list.put_front (uc)
				redo_list.remove
				from until
					undo_list.is_empty or else not uc.is_bound_to_next
				loop
					redo_list.start
					uc := redo_list.item
					uc.redo
					undo_list.put_front (uc)
					redo_list.remove
				end
				current_status := move
				notify_observers
				if has_mark and then marked_cmd = undo_list.first then
					notify_text_of_mark_reached
				end
			end
		end

	reset is
			-- empty the unde-redo stack.
		do
			undo_list.wipe_out
			redo_list.wipe_out
			current_status := move
			notify_observers
		end

	forget_past is
			-- Destroy past undos. Used by "save" commands.
		do
			undo_list.wipe_out
			current_status := move
			notify_observers
		end


	bind_current_item_to_next is
		do
			if item /= Void then
				item.bind_to_next
			end
		end

	unbind_current_item_to_next is
		do
			if item /= Void then
				item.unbind_to_next
			end
		end

	remove_last_redo is
		do
			redo_list.start
			if redo_list.writable then
				redo_list.remove
			end
		end
		
feature {EDITABLE_TEXT} -- Mark management

	set_mark is
			-- mark current item
		do
			if mark_enabled then
				has_mark := True
				record_move -- to ensure marked command in not modified later
				if undo_list.is_empty then
					marked_cmd := Void
				else
					marked_cmd := undo_list.first
				end
			end
		end

	disable_mark is
			-- Disable marking
		do
			mark_enabled := False
			has_mark := False
			marked_cmd := Void
		end

	enable_mark is
			-- Enable marking
		do
			mark_enabled := True
		end
	
	mark_enabled: BOOLEAN
			-- Is it possible to set a mark?

	has_mark: BOOLEAN
			-- Has a position in the stack been marked?
	
	marked_cmd: UNDO_CMD
			-- Marked command.

	notify_text_of_mark_reached is
			-- Marked position was reached by calling `undo' and `redo'.
		do
			text.on_text_back_to_its_last_saved_state
		end

feature {NONE} -- Implementation

	undo_list : LINKED_LIST [UNDO_CMD]

	redo_list : LINKED_LIST [UNDO_CMD]

	current_status: INTEGER

	text: EDITABLE_TEXT

	put (uc: UNDO_CMD) is
		do
			undo_list.put_front (uc)
			redo_list.wipe_out
			notify_observers
		end

feature {NONE} -- Constants

	move, insert_char, delete_char, insert_eol, 
	replace, replace_selection, replace_all, 
	back_delete, back_delete_combo, cut_selection,
	paste, symbol, unsymbol : INTEGER is unique

feature -- Observer pattern

	add_observer (an_observer: EB_UNDO_REDO_OBSERVER) is
			-- Add `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers = Void then
				create observers.make (2)
			end
			observers.extend (an_observer)
		end

	remove_observer (an_observer: EB_UNDO_REDO_OBSERVER) is
			-- Remove `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers /= Void then
				observers.prune_all (an_observer)
			end
		end

feature {NONE} -- Implementation

	notify_observers is
			-- Notify all observers about the change of Current.
		do
			if observers /= Void then
				from
					observers.start
				until
					observers.after
				loop
					observers.item.on_changed
					observers.forth
				end
			end
		end

	observers: ARRAYED_LIST [EB_UNDO_REDO_OBSERVER]
			-- All observers for Current.

end -- class UNDO_REDO_STACK
