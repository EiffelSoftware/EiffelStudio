indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REDO_STACK

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end

-- The following Creation_clause can be removed if you need no other
-- procedure than `default_create':

create
	make

feature -- Initialization

	make is
		do
			create undo_list.make
			create redo_list.make
			current_status := move
		end

feature -- Access

	undo_list : LINKED_LIST [UNDO_COMMAND]

	redo_list : LINKED_LIST [UNDO_COMMAND]

	item: UNDO_COMMAND is
		do
			Result := undo_list.first
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

	record_delete (c: CHARACTER) is
		local
			uic: UNDO_DELETE_COMMAND
		do
			if current_status = delete_char then
				udc ?= item
				check
					udc /= Void
				end
				udc.extend (c)
			else
				create udc.make_from_string (chwin.cursor, c.out, chwin)
				current_status := delete_char
			end
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
			end
		end

	redo is
		local
			uc: UNDO_COMMAND
		do
			if not redo_list.empty then
				redo_list.start
				uc := redo_list.item
				uc.undo
				undo_list.put_front (uc)
				redo_list.remove
			end
		end

	wipe_out is
		do
			undo_list.wipe_out
			redo_list.wipe_out
			current_status := move
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	current_status: INTEGER

invariant
	invariant_clause: -- Your invariant here

end -- class UNDO_REDO_STACK
