indexing
	description: "[
					This is the managet of MEMORY_STATE which can save/open states from file

																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_MEMORY_STATE_MANAGER

inherit
	MA_SINGLETON_FACTORY

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- creation method
		do
			create memory_states.make (1)

		end


feature -- Access

	states: like memory_states is
			-- Get the MEMORY_STATE's ARRAYED_LIST
		do
			Result := memory_states
		ensure
			result_not_void: Result /= Void
		end

	extend (a_state: MA_MEMORY_STATE) is
			-- Add a memory state to the array_list
		do
			memory_states.extend (a_state)
		end

	i_th alias "[]" (i: INTEGER): MA_MEMORY_STATE is
			-- The i_th memory state of the memory_states current hold.
		do
			Result := memory_states [i]
		end


feature -- Status report

	count: INTEGER is
			-- The memory states already contorl by the memory manager
		do
			Result := memory_states.count
		end


--	is_user_click_ok: BOOLEAN is
--			-- Whether user click ok button on Open/Save file dialog.
--		do
--			Result := user_click_ok
--		end

feature -- Open/Save States

	save_states is
			-- Save current states to a disk file.
		local
			l_dialog: EV_FILE_SAVE_DIALOG
		do
--			user_click_ok := False
			create l_dialog
			l_dialog.filters.extend (state_file_suffix)
			l_dialog.save_actions.extend (agent save_states_2_file (l_dialog))
			l_dialog.show_modal_to_window (main_window)
		end

	open_states  is
			-- Retreive the states from a disk file.
		require
			main_window_not_void: main_window /= Void
		local
			l_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_dialog
			l_dialog.filters.extend (state_file_suffix)
			l_dialog.open_actions.extend (agent open_states_from_file (l_dialog))
			l_dialog.show_modal_to_window (main_window)
		end

feature {NONE} -- Implementation

	save_states_2_file (a_dialog: EV_FILE_SAVE_DIALOG) is
			-- Save memory analyzer's datas to a file.
		local
			l_data_file: RAW_FILE
			l_suffix: STRING
		do
			l_suffix := state_file_suffix.filter
			l_suffix := l_suffix.substring (2, l_suffix.count)
			create l_data_file.make_create_read_write (a_dialog.file_name + l_suffix)
			memory_states.basic_store (l_data_file)
		end

	open_states_from_file (a_dialog: EV_FILE_OPEN_DIALOG) is
			-- Open memory analyzer's datas from a file
		do
			memory_states ?= memory_states.retrieve_by_name (a_dialog.file_name)
		ensure
			states_not_void: memory_states /= Void
		end

	memory_states: MA_ARRAYED_LIST_STORABLE [MA_MEMORY_STATE]
			-- The memory states this managers hold.
invariant
	memory_states_not_void: memory_states /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
