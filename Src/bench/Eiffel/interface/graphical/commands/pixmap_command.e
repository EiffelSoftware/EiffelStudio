indexing
	description	: "Command with an associated icon."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date		: "$Date$";
	revision	: "$Revision$"

deferred class PIXMAP_COMMAND

inherit
	TOOL_COMMAND
		redefine
			execute
		end

	NAMER

	BENCH_LICENSED_COMMAND
		rename
			parent_window as Project_tool
		end

feature -- Callbacks

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Useless here.
		do
		end

feature -- Properties

	symbol: PIXMAP is
			 -- Icon for current command
		deferred
		end;

feature -- Execute

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into
			-- watch shape.
		do
			if last_warner /= Void and then
					not last_warner.destroyed then
				last_warner.popdown
			end;
			execute_licensed (argument);
		end;
	
invariant

	text_window_not_void: text_window /= Void

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

end -- class PIXMAP_COMMAND
