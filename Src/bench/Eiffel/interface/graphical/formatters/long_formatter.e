indexing

	description:	
		"This kind of format is long to process. Ask %
			%for a confirmation before executing it."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class LONG_FORMATTER

inherit

	FILTERABLE
		rename
			make as formatter_make
		redefine
			execute
		end;

	FILTERABLE
		redefine
			execute, make
		select
			make
		end;

feature -- Initialization

	make (a_tool: TOOL_W) is
			-- Initialize the format button  with its bitmap.
			-- Set up the mouse click and control-click actions
			-- (click requires a confirmation, control-click doesn't).
		do
			formatter_make (a_tool);
			set_action ("c<Btn1Down>", Current, control_click)
		end;

feature -- Properties

	control_click: ANY is
			-- No confirmation required
		once
			create Result
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Ask for a confirmation before executing the format.
		local
			mp: MOUSE_PTR
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if last_confirmer /= Void and argument = last_confirmer then
					-- The user wants to execute this format,
					-- even though it's a long format.
				if not text_window.changed then
					execute_licensed (formatted);
				else
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				end
			elseif argument = control_click then
					-- No confirmation required.
				formatted ?= tool.stone;
				if not text_window.changed then
					create mp.set_watch_cursor;
					execute_licensed (formatted);
					mp.restore
				else
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				end
			else
				if argument = tool then
					formatted ?= tool.stone
				else
					formatted ?= argument
				end;
				if formatted = Void then
					execute_licensed (Void)
				elseif formatted /= Void and then formatted.clickable then
					confirmer (popup_parent).call (Current, 
						"This format requires exploring the entire%N%
						%system and may take a long time...", "Continue")
				end
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

end -- class LONG_FORMATTER
