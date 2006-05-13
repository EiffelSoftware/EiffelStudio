indexing

	description:
		"General notion of an eiffel command with output%
		%appended to `text_formatter'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_OUTPUT_CMD

inherit

	E_CMD
		redefine
			executable
		end

	SHARED_TEXT_ITEMS

	E_SHARED_OUTPUT_INTERFACE_NAMES

feature -- Properties

	text_formatter: TEXT_FORMATTER;
			-- Structured text for command.

feature -- Access

	executable: BOOLEAN is
			-- Is Current command executable?
		do
			Result := text_formatter /= Void
		end

feature -- Setting

	make (a_text_formatter: TEXT_FORMATTER) is
			-- Create `a_text_formatter' to `text_formatter'.
		require
			a_text_formatter_attached: a_text_formatter /= Void
		do
			set_text_formatter (a_text_formatter)
		end;

	set_text_formatter (a_text_formatter: TEXT_FORMATTER) is
			-- Set `text_formatter' with `a_text_formatter'
		do
			text_formatter := a_text_formatter
		end

feature -- Execution

	execute is
			-- Execute the current command. Add a before and after
			-- declaration (cluster declaration by default) to `text_formatter'
			-- and invoke `work'.
		do
			text_formatter.process_filter_item (f_cluster_declaration, true);
			work;
			text_formatter.process_filter_item (f_cluster_declaration, false);
		end;

	work is
			-- Perform the command only.
		deferred
		end;

feature {NONE} -- Implementation

	add_tabs (a_text_formatter: TEXT_FORMATTER; i: INTEGER) is
			-- Add `i' tabs to `text_formatter'.
		do
			a_text_formatter.add_indents (i)
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

end -- class E_OUTPUT_CMD
