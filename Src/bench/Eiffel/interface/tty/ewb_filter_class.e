indexing

	description: 
		"Build a filtered version (troff, ..) of the class text%
		%and display the result in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EWB_FILTER_CLASS

inherit

	EWB_FILTER
	EWB_CLASS
		rename
			make as class_make
		redefine
			process_compiled_class, loop_action
		end

feature -- Initialization

	make (cn, filter: STRING) is
			-- Initialize Current with class_name `cn',
			-- and `filter_name' `filter'.
		require
			cn_not_void: cn /= Void
		do
			class_make (cn)
			init (filter)
		end

feature {NONE} -- Execution

	associated_cmd: E_CLASS_CMD is
			-- Command to be executed after successful
			-- retrieving of the class text.
		deferred
		end

	process_compiled_class (e_class: CLASS_C) is
			-- Execute associated command
		local
			cmd: like associated_cmd
			filter: TEXT_FILTER
		do
			cmd := associated_cmd
			cmd.make (e_class)
			cmd.execute
			if filter_name /= Void and then not filter_name.is_empty then
				create filter.make (filter_name)
				filter.process_text (cmd.structured_text)
				output_window.put_string (filter.image)
			else
				output_window.put_string (cmd.structured_text.image)
			end
			output_window.put_new_line
		end

	loop_action is
			-- Execute Current command from loop.
		do
			command_line_io.get_class_name
			class_name := command_line_io.last_input
			command_line_io.get_filter_name
			filter_name := command_line_io.last_input
			check_arguments_and_execute
		end

invariant

	filter_name_not_void: filter_name /= Void

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

end -- class EWB_FILTER_CLASS
