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
		do
			if current_status = insert_char then
				uic ?= item
				check
					uic /= Void
				end
				uic.extend (c)
			else
				create uic.make_from_string	(chwin.cursor, c.out, chwin)
				put (uic)
				current_status := insert_char
			end
		end

	record_insert_eol is
		do
			record_insert ('%N')
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

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Constants

	move, insert_char, delete_char, insert_eol, back_delete, replace,
		cut_selection, paste, replace_selection : INTEGER is unique

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
