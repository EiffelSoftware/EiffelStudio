indexing
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EBENCH_MS_WINDOWS

inherit
	TOOLKIT_IMP
		redefine
			message_loop
		end

	WEL_WINDOW_MANAGER
		
create
	make

feature -- Process message event

	message_loop is
			-- Windows message loop
		local
			msg: WEL_MSG
			accel: WEL_ACCELERATORS
			main_w: WEL_WINDOW
			current_window: WEL_WINDOW
			done: BOOLEAN
			dlg: POINTER
			hwnd: POINTER
		do
			from
				accel := accelerators
				main_w := application_main_window
				create msg.make
			until
				done
			loop
				msg.peek_all
				if msg.last_boolean_result then
					if msg.quit then
						done := True
					else
						current_window := find_current_window (msg.hwnd, main_w) 
						hwnd := current_window.item
						dlg := cwin_get_last_active_popup (hwnd)
						if dlg /= hwnd or is_dialog (hwnd) then
							msg.process_dialog_message (dlg)
							if not msg.last_boolean_result then
								msg.translate
								msg.dispatch
							end
						else
							msg.translate_accelerator (current_window, accel)
							if not msg.last_boolean_result or else not accel.exists then
								msg.translate
								msg.dispatch
							end
						end
					end
				else
					if idle_action_enabled then
						idle_action
					else
						msg.wait
					end
				end
			end
		end

feature {NONE} -- Implementation

	find_current_window (hwnd: POINTER; main_w: WEL_WINDOW): WEL_WINDOW is
		do
			Result := window_of_item (hwnd)
			if Result /= Void then
				Result := find_top_parent (Result)
			else
				Result := main_w
			end
		end

	find_top_parent (a_window: WEL_WINDOW): WEL_WINDOW is
			-- Give the TOP_SHELL_WINDOW corresponding to `a_window'.
		require
			a_window_not_void: a_window /= Void
		local
			parent: WEL_WINDOW
		do
			from
				Result := a_window
				parent := Result.parent
			until
				parent = Void
			loop
				parent := Result.parent
				if parent /= Void then
					Result := parent
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EBENCH_MS_WINDOWS

