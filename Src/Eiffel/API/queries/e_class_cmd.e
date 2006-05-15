indexing

	description:
		"General notion of an eiffel query command (semantic unity)%
		%for a class. Display output for current command for%
		%associated class to output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class E_CLASS_CMD

inherit

	E_OUTPUT_CMD
		rename
			make as cmd_make
		export
			{NONE} cmd_make
		redefine
			executable, execute
		end

	QL_SHARED

	QL_SHARED_CLASS_RELATION

	QL_UTILITY

feature -- Initialization

	make (a_text_formatter: TEXT_FORMATTER; a_class: CLASS_C) is
			-- Make current command with current_class as
			-- `a_class'.
		require
			valid_a_class_c: a_class /= Void
			compiled_class: a_class.has_feature_table
		do
			current_class := a_class;
			text_formatter := a_text_formatter
		ensure
			class_set: current_class = a_class;
			a_text_formatter_not_void: text_formatter /= Void
		end;

feature -- Property

	current_class: CLASS_C
			-- Class for current action

	executable: BOOLEAN is
			-- Is the Current able to be executed?
		do
			Result := current_class /= Void and then
				text_formatter /= Void
		ensure then
			good_result: Result implies current_class /= Void;
		end

feature -- Execution

	execute is
			-- Execute the current command. Add a before and after
			-- declaration to `text_formatter'
			-- and invoke `work'.
		do
			text_formatter.process_filter_item (f_Class_declaration, true);
			work;
			text_formatter.process_filter_item (f_Class_declaration, false);
		end;

	work is
			-- Perform the command only.
		deferred
		end;

feature {NONE} -- Implementation

	criterion: QL_CRITERION is
			-- Criterion used in current command
		do
		end

	domain_generator: QL_DOMAIN_GENERATOR is
			-- Domain generator used in current command
		do
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

end -- class E_CLASS_CMD
