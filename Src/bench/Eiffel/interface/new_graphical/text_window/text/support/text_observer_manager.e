indexing
	description	: "Observer manager for EB_EDITOR"
	author		: "Etienne Amodeo"
	date		: "$Date$"
	revision	: "$Revision$"

class
	TEXT_OBSERVER_MANAGER

inherit
	EB_RECYCLABLE

creation
	make

feature -- Initialization
	
	make is
		-- Initialize `Current'.
		do
			create edition_observer_list.make (10)
			create cursor_observer_list.make (10)
			create selection_observer_list.make (10)
			create lines_observer_list.make (10)
		end

feature -- Status report

	changed: BOOLEAN
			-- Has the text been modified since it was opened?

	is_notifying: BOOLEAN
			-- Is the manager in the process of notifying its observers
			-- of a change ?

	is_removing_block: BOOLEAN

feature -- Status setting

	set_changed (value: BOOLEAN; directly_edited: BOOLEAN) is
			-- Assign `value' to `changed'
		do
			if value and not changed then
				on_text_edited (directly_edited)
			end
			changed := value
		end

feature -- Operations

	add_edition_observer (a_text_observer: TEXT_OBSERVER) is
			-- Add an observer `an_text_observer' to the "edition observers" list.
		require
			not_in_loop: not is_notifying
		do
			if a_text_observer /= Void then
				edition_observer_list.extend (a_text_observer)
				a_text_observer.set_manager (Current)
			end
		end

	add_cursor_observer (a_text_observer: TEXT_OBSERVER) is
			-- Add an observer `an_text_observer' to the "cursor observers" list.
		require
			not_in_loop: not is_notifying
		do
			if a_text_observer /= Void then
				cursor_observer_list.extend (a_text_observer)
				a_text_observer.set_manager (Current)
			end
		end

	add_selection_observer (a_text_observer: TEXT_OBSERVER) is
			-- Add an observer `an_text_observer' to the "selection observers" list.
		require
			not_in_loop: not is_notifying
		do
			if a_text_observer /= Void then
				selection_observer_list.extend (a_text_observer)
				a_text_observer.set_manager (Current)
			end
		end

	add_lines_observer (a_text_observer: TEXT_OBSERVER) is
			-- Add an observer `an_text_observer' to the "lines observers" list.
		require
			not_in_loop: not is_notifying
		do
			if a_text_observer /= Void then
				lines_observer_list.extend (a_text_observer)
				a_text_observer.set_manager (Current)
			end
		end

	remove_observer (a_text_observer: TEXT_OBSERVER) is
		-- Remove the observer 'an_text_observer' from the list.
		require
			not_in_loop: not is_notifying
		local
			found: BOOLEAN
		do
			from 
				edition_observer_list.start
				found := false
			until
				edition_observer_list.after or found
			loop
 				if edition_observer_list.item = a_text_observer then
					found := true
					edition_observer_list.remove
				else
					edition_observer_list.forth
				end 
			end
			from 
				selection_observer_list.start
				found := false
			until
				selection_observer_list.after or found
			loop
 				if selection_observer_list.item = a_text_observer then
					found := true
					selection_observer_list.remove
				else
					selection_observer_list.forth
				end 
			end
			from 
				lines_observer_list.start
				found := false
			until
				lines_observer_list.after or found
			loop
 				if lines_observer_list.item = a_text_observer then
					found := true
					lines_observer_list.remove
				else
					lines_observer_list.forth
				end 
			end
		end


feature {NONE} -- Updates

	on_text_edited (directly_edited: BOOLEAN) is
			-- Notify observers that some text has been modified.
			-- If `directly_edited', the user has modified the text in the editor,
			-- not via another tool or wizard.
		local
			tmp_is_notifying: BOOLEAN
			index: INTEGER
		do
			tmp_is_notifying := is_notifying
			is_notifying := True
			changed := True
			if not edition_observer_list.is_empty then
				if edition_observer_list.after then
					index := -1
				else
					index := edition_observer_list.index
				end
				from 
					edition_observer_list.start
				until
					edition_observer_list.after
				loop
					edition_observer_list.item.on_text_edited (directly_edited)
					edition_observer_list.forth
				end
				if index /= -1 then
					check
						index_is_valid: edition_observer_list.valid_index (index)
					end
					edition_observer_list.go_i_th (index)
				end
			end
			is_notifying := tmp_is_notifying
		end

	on_text_reset is
			-- Notify observers that `reset' was called on the text.
		require
			not_in_loop: not is_notifying
		do
			is_notifying := True
			changed := False
			from 
				edition_observer_list.start
			until
				edition_observer_list.after
			loop
				edition_observer_list.item.on_text_reset
				edition_observer_list.forth
			end
			is_notifying := False
		end

	on_cursor_moved is
			-- Notify observers that the current cursor has moved.
		local
			cur: CURSOR
			old_not: BOOLEAN
		do
			old_not := is_notifying
			is_notifying := True
			from
				cur := cursor_observer_list.cursor
				cursor_observer_list.start
			until
				cursor_observer_list.after
			loop
				cursor_observer_list.item.on_cursor_moved
				cursor_observer_list.forth
			end
			cursor_observer_list.go_to (cur)
			is_notifying := old_not
		end

	on_text_back_to_its_last_saved_state is
			-- Notify observers that text is in the same state as when it
			-- was saved for the last time.
		require
			not_in_loop: not is_notifying
		do
			is_notifying := True
			changed := False
			from 
				edition_observer_list.start
			until
				edition_observer_list.after
			loop
				edition_observer_list.item.on_text_back_to_its_last_saved_state
				edition_observer_list.forth
			end
			is_notifying := False
		end

	on_text_loaded is
			-- Notify observers that a new text has just been loaded.
		require
			not_in_loop: not is_notifying
		do
			is_notifying := True
			from 
				edition_observer_list.start
			until
				edition_observer_list.after
			loop
				edition_observer_list.item.on_text_loaded
				edition_observer_list.forth
			end
			is_notifying := False
		end

	on_text_fully_loaded is
			-- Notify observers that a new text has just finished loading.
			--| FIXME XR: This is necessary because on_text_loaded is called when
			--| `text_being_processed' is still True.
			--| I don't want to break everything so I just add this event.
		local
			cur: CURSOR
		do
			is_notifying := True
			cur := edition_observer_list.cursor
			from 
				edition_observer_list.start
			until
				edition_observer_list.after
			loop
				edition_observer_list.item.on_text_fully_loaded
				edition_observer_list.forth
			end
			edition_observer_list.go_to (cur)
			is_notifying := False
		end


	on_text_block_loaded (was_first_block: BOOLEAN) is
			-- Notify observers that a new block of text has just been loaded.
			-- `first_block' is True if the block was the first one
		do
			is_notifying := True
			from 
				lines_observer_list.start
			until
				lines_observer_list.after
			loop
				lines_observer_list.item.on_text_block_loaded (was_first_block)
				lines_observer_list.forth
			end
			is_notifying := False
		end

	on_selection_begun is
			-- Notify observers that a selection has just begun.
		do
			is_notifying := True
			from 
				selection_observer_list.start
			until
				selection_observer_list.after
			loop
				selection_observer_list.item.on_selection_begun
				selection_observer_list.forth
			end
			is_notifying := False
		end

	on_selection_finished is
			-- Notify observers that the selection has just been disabled.
		do
			is_notifying := True
			from 
				selection_observer_list.start
			until
				selection_observer_list.after
			loop
				selection_observer_list.item.on_selection_finished
				selection_observer_list.forth
			end
			is_notifying := False
		end

	on_line_modified (l_num: INTEGER) is
			-- Notify observers that a line has just been modified.
		do
			is_notifying := True
			from 
				lines_observer_list.start
			until
				lines_observer_list.after
			loop
				lines_observer_list.item.on_line_modified (l_num)
				lines_observer_list.forth
			end
			is_notifying := False
		end

	on_line_removed (l_num: INTEGER) is
			-- Notify observers that a line has just been removed.
		do
			is_notifying := True
			from 
				lines_observer_list.start
			until
				lines_observer_list.after
			loop
				lines_observer_list.item.on_line_removed (l_num)
				lines_observer_list.forth
			end
			is_notifying := False
		end

	on_block_removed is
			-- Notify observers that a line has just been removed.
		do
			is_notifying := True
			from 
				lines_observer_list.start
			until
				lines_observer_list.after
			loop
				lines_observer_list.item.on_block_removed
				lines_observer_list.forth
			end
			is_notifying := False
		end

	on_line_inserted (l_num: INTEGER) is
			-- Notify observers that a line has just been inserted.
		do
			is_notifying := True
			from 
				lines_observer_list.start
			until
				lines_observer_list.after
			loop
				lines_observer_list.item.on_line_inserted (l_num)
				lines_observer_list.forth
			end
			is_notifying := False
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			edition_observer_list.wipe_out
			edition_observer_list := Void
			selection_observer_list.wipe_out
			selection_observer_list := Void
			lines_observer_list.wipe_out
			lines_observer_list := Void
		end

feature {NONE} -- Implementation

	edition_observer_list: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of editor observers.

	cursor_observer_list: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of cursor observers.

	selection_observer_list: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of editor observers.

	lines_observer_list: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of editor observers.

end -- class TEXT_OBSERVER_MANAGER
