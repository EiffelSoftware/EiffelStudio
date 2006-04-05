indexing
	description	: "Commands applicable to the context diagram."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_CONTEXT_DIAGRAM_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_TARGET_COMMAND
		rename
			target as tool
		redefine
			tool,
			make
		end

feature {NONE} -- Initialization

	make (a_target: like tool) is
			-- Initialize the command with target `a_target'.
		do
			Precursor (a_target)
			history := tool.history
			disable_sensitive
		end

feature -- Access

	tool: EB_CONTEXT_EDITOR
			-- Associated with `Current'.

	history: EB_HISTORY_DIALOG
			-- History of undoable commands.
	
	menu_name: STRING is
			-- Name on corresponding menu items
		do
			Result := "Diagram command"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := tooltip
		end
	
	shortcut_string: STRING is
			-- String discribing shortcut combination for `Current'.
		do
			if accelerator = Void then
				Result := ""
			else
				Result := " (" + accelerator.out + ")"
			end
		ensure
			Result_exists: Result /= Void
		end
		

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

end -- class EB_CONTEXT_DIAGRAM_COMMAND


