indexing
	description: "undo/redo command stack"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REDO_STACK

inherit
	ANY

create
	make

feature -- Initialization

	make (w: CHILD_WINDOW) is
		do
			create undo_list.make
			create redo_list.make
			current_status := move
			chwin := w
		end

feature -- Access

	undo_list : LINKED_LIST [UNDO_COMMAND]

	redo_list : LINKED_LIST [UNDO_COMMAND]

	item: UNDO_COMMAND is
		do
			Result := undo_list.first
		end

	nothing_has_been_done: BOOLEAN is
			-- Has a change been done (and not undone after)?
		do
			Result := undo_list.empty
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put (uc: UNDO_COMMAND) is
		do
			undo_list.put_front (uc)
			redo_list.wipe_out
		end

	record_move is
		do
			current_status := move
		end

	record_insert (c: CHARACTER) is
		local
			uic: UNDO_INSERT_COMMAND
			urc: UNDO_REPLACE_COMMAND
			udc: UNDO_DELETE_COMMAND
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
				create urc.make_from_strings (chwin.cursor, udc.message, c.out, chwin)
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
				create uic.make_from_string	(chwin.cursor, c.out, chwin)
				put (uic)
				current_status := insert_char
			end
		end

	record_insert_eol is
		local
			uic: UNDO_INSERT_COMMAND
		do
			inspect current_status

			when insert_char then
				uic ?= item
				check
					uic /= Void
				end
				uic.extend ('%N')

			else
				create uic.make_from_string	(chwin.cursor, "%N", chwin)
				put (uic)
				current_status := insert_eol
			end
		end

	record_paste (s: STRING) is
		local
			uic: UNDO_INSERT_COMMAND
		do
			create uic.make_from_string (chwin.cursor, s, chwin)
			put (uic)
			current_status := paste
		end

	record_delete (c: CHARACTER) is
		local
			udc: UNDO_DELETE_COMMAND
		do
			if current_status = delete_char then
				udc ?= item
				check
					udc /= Void
				end
				udc.extend (c)
			else
				create udc.make_from_string (chwin.cursor, c.out, chwin)
				put (udc)
				current_status := delete_char
			end
		end

	record_delete_selection (s: STRING) is
		local
			udc: UNDO_DELETE_COMMAND
		do
			create udc.make_from_string (chwin.cursor, s, chwin)
			put (udc)
			current_status := cut_selection
		end

	record_replace (c1, c2: CHARACTER) is
		local
			urc: UNDO_REPLACE_COMMAND
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
					create urc.make_from_strings (chwin.cursor, "", c2.out, chwin)
				else
					create urc.make_from_strings	 (chwin.cursor, c1.out, c2.out, chwin)
				end
				put (urc)
				current_status := replace
			end
		end

	record_back_delete (c: CHARACTER) is
		local
			udc: UNDO_DELETE_COMMAND
		do
			if current_status = back_delete then
				udc ?= item
				check
					udc /= Void
				end
				udc.prepend (chwin.cursor, c)
			else
				create udc.make_from_string (chwin.cursor, c.out, chwin)
				put (udc)
				current_status := back_delete
			end
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Constants

	move, insert_char, delete_char, insert_eol, replace, back_delete,
		back_delete_combo, cut_selection, paste : INTEGER is unique

feature -- Basic operations

	undo	is
		local
			uc: UNDO_COMMAND
		do
			if not undo_list.empty then
				undo_list.start
				uc := undo_list.item
				uc.undo
				redo_list.put_front (uc)
				undo_list.remove
				current_status := move
			end
		end

	redo is
		local
			uc: UNDO_COMMAND
		do
			if not redo_list.empty then
				redo_list.start
				uc := redo_list.item
				uc.redo
				undo_list.put_front (uc)
				redo_list.remove
				current_status := move
			end
		end

	wipe_out is
		do
			undo_list.wipe_out
			redo_list.wipe_out
			current_status := move
		end

	forget_past is
			-- Destroy past undos. Used by "save" commands.
		do
			undo_list.wipe_out
			current_status := move
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	current_status: INTEGER

	chwin: CHILD_WINDOW

invariant
	invariant_clause: -- Your invariant here

end -- class UNDO_REDO_STACK
