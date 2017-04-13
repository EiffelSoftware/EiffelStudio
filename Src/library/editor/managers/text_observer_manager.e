note
	description: "Observer manager for TEXT_PANEL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_OBSERVER_MANAGER

create
	make

feature -- Initialization

	make
		-- Initialize `Current'.
		do
			create edition_observer_list.make (10)
			create cursor_observer_list.make (10)
			create selection_observer_list.make (10)
			create lines_observer_list.make (10)
			create post_notify_actions.make (2)
		end

feature -- Status report

	is_modified: BOOLEAN
			-- Has the text been modified since it was opened?

	is_notifying: BOOLEAN
			-- Is the manager in the process of notifying its observers
			-- of a change ?

	is_removing_block: BOOLEAN

feature -- Status setting

	set_changed (value: BOOLEAN; directly_edited: BOOLEAN)
			-- Assign `value' to `changed'
		do
			if value and not is_modified then
				on_text_edited (directly_edited)
			end
			is_modified := value
		end

feature -- Operations

	add_edition_observer (a_text_observer: TEXT_OBSERVER)
			-- Add an observer `an_text_observer' to the "edition observers" list.
		require
			not_in_loop: not is_notifying
		do
			if a_text_observer /= Void  and then not edition_observer_list.has (a_text_observer) then
				edition_observer_list.extend (a_text_observer)
				a_text_observer.set_manager (Current)
			end
		end

	add_cursor_observer (a_text_observer: TEXT_OBSERVER)
			-- Add an observer `an_text_observer' to the "cursor observers" list.
		require
			not_in_loop: not is_notifying
		do
			if a_text_observer /= Void and then not cursor_observer_list.has (a_text_observer) then
				cursor_observer_list.extend (a_text_observer)
				a_text_observer.set_manager (Current)
			end
		end

	add_selection_observer (a_text_observer: TEXT_OBSERVER)
			-- Add an observer `an_text_observer' to the "selection observers" list.
		require
			not_in_loop: not is_notifying
		do
			if a_text_observer /= Void  and then not selection_observer_list.has (a_text_observer) then
				selection_observer_list.extend (a_text_observer)
				a_text_observer.set_manager (Current)
			end
		end

	add_lines_observer (a_text_observer: TEXT_OBSERVER)
			-- Add an observer `an_text_observer' to the "lines observers" list.
		require
			not_in_loop: not is_notifying
		do
			if a_text_observer /= Void  and then not lines_observer_list.has (a_text_observer) then
				lines_observer_list.extend (a_text_observer)
				a_text_observer.set_manager (Current)
			end
		end

	remove_observer (a_text_observer: TEXT_OBSERVER)
			-- Remove the observer 'an_text_observer' from the list.
		require
			not_in_loop: not is_notifying
		local
			found: BOOLEAN
		do
			from
				edition_observer_list.start
				found := False
			until
				edition_observer_list.after or found
			loop
 				if edition_observer_list.item = a_text_observer then
					found := True
					edition_observer_list.remove
				else
					edition_observer_list.forth
				end
			end
			from
				selection_observer_list.start
				found := False
			until
				selection_observer_list.after or found
			loop
 				if selection_observer_list.item = a_text_observer then
					found := True
					selection_observer_list.remove
				else
					selection_observer_list.forth
				end
			end
			from
				lines_observer_list.start
				found := False
			until
				lines_observer_list.after or found
			loop
 				if lines_observer_list.item = a_text_observer then
					found := True
					lines_observer_list.remove
				else
					lines_observer_list.forth
				end
			end
			from
				cursor_observer_list.start
				found := False
			until
				cursor_observer_list.after or found
			loop
 				if cursor_observer_list.item = a_text_observer then
					found := True
					cursor_observer_list.remove
				else
					cursor_observer_list.forth
				end
			end
		end

	post_notify_actions: ARRAYED_LIST [ROUTINE]
			-- Actions to call after other notifications

	execute_post_notify_actions
			-- Execute actions in `post_notify_acions'
		do
			from
				post_notify_actions.start
			until
				post_notify_actions.after
			loop
				post_notify_actions.item.call ([Current])
				post_notify_actions.forth
			end
		end

feature {NONE} -- Updates

	on_text_edited (directly_edited: BOOLEAN)
			-- Notify observers that some text has been modified.
			-- If `directly_edited', the user has modified the text in the editor,
			-- not via another tool or wizard.
		local
			tmp_is_notifying: BOOLEAN
			l_cur: CURSOR
		do
			tmp_is_notifying := is_notifying
			is_notifying := True
			is_modified := True
			if not edition_observer_list.is_empty then
				l_cur := edition_observer_list.cursor
				from
					edition_observer_list.start
				until
					edition_observer_list.after
				loop
					edition_observer_list.item.on_text_edited (directly_edited)
					edition_observer_list.forth
				end
				check
					cursor_is_valid: edition_observer_list.valid_cursor (l_cur)
				end
				edition_observer_list.go_to (l_cur)
			end
			is_notifying := tmp_is_notifying
		end

	on_text_reset
			-- Notify observers that `reset' was called on the text.
		require
			not_in_loop: not is_notifying
		local
			l_cur: CURSOR
		do
			is_notifying := True
			is_modified := False
			l_cur := edition_observer_list.cursor
			from
				edition_observer_list.start
			until
				edition_observer_list.after
			loop
				edition_observer_list.item.on_text_reset
				edition_observer_list.forth
			end
			edition_observer_list.go_to (l_cur)
			is_notifying := False
			execute_post_notify_actions
		end

	on_cursor_moved
			-- Notify observers that the current cursor has moved.
		local
			l_cur: CURSOR
			old_not: BOOLEAN
		do
			old_not := is_notifying
			is_notifying := True
			l_cur := cursor_observer_list.cursor
			from
				cursor_observer_list.start
			until
				cursor_observer_list.after
			loop
				cursor_observer_list.item.on_cursor_moved
				cursor_observer_list.forth
			end
			cursor_observer_list.go_to (l_cur)
			is_notifying := old_not
		end

	on_text_back_to_its_last_saved_state
			-- Notify observers that text is in the same state as when it
			-- was saved for the last time.
		require
			not_in_loop: not is_notifying
		local
			l_cur: CURSOR
		do
			is_notifying := True
			is_modified := False
			l_cur := edition_observer_list.cursor
			from
				edition_observer_list.start
			until
				edition_observer_list.after
			loop
				edition_observer_list.item.on_text_back_to_its_last_saved_state
				edition_observer_list.forth
			end
			edition_observer_list.go_to (l_cur)
			is_notifying := False
			execute_post_notify_actions
		end

	on_text_loaded
			-- Notify observers that a new text has just been loaded.
		require
			not_in_loop: not is_notifying
		local
			l_cur: CURSOR
		do
			is_notifying := True
			l_cur := edition_observer_list.cursor
			from
				edition_observer_list.start
			until
				edition_observer_list.after
			loop
				edition_observer_list.item.on_text_loaded
				edition_observer_list.forth
			end
			edition_observer_list.go_to (l_cur)
			is_notifying := False
			execute_post_notify_actions
		end

	on_text_fully_loaded
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
			execute_post_notify_actions
		end

	on_text_block_loaded (was_first_block: BOOLEAN)
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
			execute_post_notify_actions
		end

	on_selection_begun
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
			execute_post_notify_actions
		end

	on_selection_finished
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
			execute_post_notify_actions
		end

	on_line_modified (l_num: INTEGER)
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
			execute_post_notify_actions
		end

	on_line_removed (l_num: INTEGER)
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
			execute_post_notify_actions
		end

	on_block_removed
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
			execute_post_notify_actions
		end

	on_line_inserted (l_num: INTEGER)
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
			execute_post_notify_actions
		end

feature -- Memory management

	recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
			-- Not necessary to dereference the container, as they are wiped out.
		do
			edition_observer_list.wipe_out
			selection_observer_list.wipe_out
			lines_observer_list.wipe_out
			cursor_observer_list.wipe_out
		end

feature {TEXT_PANEL} -- Implementation

	edition_observer_list: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of editor observers.

	cursor_observer_list: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of cursor observers.

	selection_observer_list: ARRAYED_LIST [TEXT_OBSERVER]
		-- List of editor observers.

	lines_observer_list: ARRAYED_LIST [TEXT_OBSERVER];
		-- List of editor observers.

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class TEXT_OBSERVER_MANAGER
