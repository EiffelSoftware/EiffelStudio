indexing

	description: 
		"General notion of an eiffel command with output%
		%appended to `structured_text'."
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

feature -- Properties

	structured_text: STRUCTURED_TEXT;
			-- Structured text for command.

feature -- Access

	executable: BOOLEAN is
			-- Is Current command executable?
		do
			Result := structured_text /= Void 
		end

feature -- Setting

	make is
			-- Create `structured_text' to `st'.
		do
			create structured_text.make
		ensure
			struct_text_not_void: structured_text /= Void
		end;

feature -- Execution

	execute is
			-- Execute the current command. Add a before and after
			-- declaration (cluster declaration by default) to `structured_text'
			-- and invoke `work'.
		do
			structured_text.add (ti_Before_cluster_declaration);
			work;
			structured_text.add (ti_After_cluster_declaration);
		end;

	work is
			-- Perform the command only.
		deferred
		end;

feature {NONE} -- Implementation

	add_tabs (st:STRUCTURED_TEXT; i: INTEGER) is
			-- Add `i' tabs to `structured_text'.
		local
			j: INTEGER
		do
			from
				j := 1;
			until
				j > i
			loop
				st.add_indent;
				j := j + 1
			end;
		end;

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

end -- class E_OUTPUT_CMD
