indexing

	description:	
		"Retarget the tool with the next target in history."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class NEXT_TARGET

inherit
	TWO_STATE_CMD
		rename
			init as make
		redefine
			execute, inactive_symbol
		end

	WARNER_CALLBACKS
		rename
			execute_warner_ok as save_changes,
			execute_warner_help as loose_changes
		end

create
	make

feature -- Callbacks

	loose_changes is
			-- Useless here
		do
			text_window.disable_clicking;
			execute_licensed (Void)
		end;

	save_changes (argument: ANY) is
			-- The changes will be lost.
		do
			text_window.disable_clicking;
			if tool.save_cmd_holder /= Void then
				tool.save_cmd_holder.associated_command.execute (Void)
			end
			execute_licensed (Void)
		end;

feature -- Properties

	active_symbol: PIXMAP is
			-- Symbol for the button
		once
			Result := Pixmaps.bm_Next_target
		end;

	inactive_symbol: PIXMAP is
			-- Symbol for the button
		once
			Result := Pixmaps.bm_Disabled_next_target
		end
	
	name: STRING is
			-- Name of the command
		do
			Result := Interface_names.f_Next_target
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Next_target
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := "Alt<Key>Right"
		end

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command, with parameter `argument'.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if not text_window.changed then
				execute_licensed (argument)
			else
				warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
					Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
			end
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the tool with the next target in history.
		local
			history: STONE_HISTORY
		do
			history := tool.history;
			if not (history.is_empty or else (history.islast or history.after)) then
				history.forth;
				history.set_do_not_update (True);
				tool.receive (history.item);
				history.set_do_not_update (False)
			end
		end;

indexing
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

end -- class NEXT_TARGET
