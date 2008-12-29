note
	description: "Handler for right pointer click when ctrl pressed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTROL_PICK_HANDLER

inherit
	ANY

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_BENCH_NAMES
		export
			{NONE} all
		end

create
	default_create

feature -- Basic operations

	launch_stone (st: STONE)
			-- Send `st' to the default control-right-click receiver.
		require
			valid_stone: st /= Void and then st.is_valid
		local
			pref: STRING
			cv_cst: CLASSI_STONE
		do
			if st.is_storable then
				pref := chosen_receiver
				if pref.is_equal (names.co_new_window) then
					window_manager.create_window
					window_manager.last_created_window.force_stone (st)
				elseif pref.is_equal (names.co_editor) then
					window_manager.last_focused_development_window.set_stone (st)
				elseif pref.is_equal (names.co_context) then
					window_manager.last_focused_development_window.tools.set_stone (st)
				elseif pref.is_equal (names.co_external_editor) then
					cv_cst ?= st
					if cv_cst /= Void then
						process_class (cv_cst)
					else
						window_manager.last_focused_development_window.force_stone (st)
					end
				elseif pref.is_equal (names.co_new_tab_editor) then
					window_manager.last_focused_development_window.commands.new_tab_cmd.execute_with_stone (st)
				end
			else
					-- The stone is not storable (breakable stone, error stone,...).
					-- We mustn't create a window in this case (it would remain empty!)
				window_manager.last_focused_development_window.set_stone (st)
			end
		end

feature {NONE} -- Implementation

	chosen_receiver: STRING
			-- Where the stones should be sent (look up in the preferences).
		do
			Result := preferences.development_window_data.ctrl_right_click_receiver.as_lower
		ensure
			not_void: Result /= Void
			lower_case: Result.is_equal (Result.as_lower)
		end

	process_class (cs: CLASSI_STONE)
			-- Process class stone.
		local
			req: COMMAND_EXECUTOR
			conv_f: FEATURE_STONE
		do
			conv_f ?= cs
			if conv_f = Void then
				create req
				req.execute (preferences.misc_data.external_editor_cli (cs.file_name, 1))
			else
				process_feature (conv_f)
			end
		end

	process_feature (fs: FEATURE_STONE)
			-- Process feature stone.
		local
			req: COMMAND_EXECUTOR
		do
				-- feature text area
			create req
			req.execute (preferences.misc_data.external_editor_cli (
				fs.class_i.file_name, fs.line_number))
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_CONTROL_PICK_HANDLER
