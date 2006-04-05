indexing
	description: "Redirects output to COM interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_DEGREE_OUTPUT
	
inherit
	DEGREE_OUTPUT
		redefine
			display_degree_output,
			display_degree,
			put_end_degree_6,
			put_melting_changes_message,
			put_freezing_message,
			put_start_dead_code_removal_message,
			put_string,
			put_dead_code_removal_message,
			put_system_compiled,
			put_header,
			put_degree_1,
			put_degree_2,
			put_degree_3,
			put_degree_4,
			put_degree_5,
			put_degree_6,
			put_degree_minus_1,
			put_degree_minus_2,
			put_degree_minus_3
		end

	SHARED_ERROR_HANDLER
	
create
	make
	
feature {NONE} -- Initialization

	make (com_interface: CEIFFEL_COMPILER_COCLASS) is
			-- Initialize structure.
		require
			com_interface_exists: com_interface /= Void
		do
			interface := com_interface
		end

feature -- Start output features

	put_header (displayed_version_number: STRING) is
		do
			put_string (
				"Eiffel compilation manager (version " + 
				displayed_version_number + ")")
		end

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			put_string ("Processing options")
		end
		
	put_melting_changes_message  is
			-- Put message indicating that melting changes is ocurring.
		do
			put_string (melting_changes_message)
		end

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
			put_string (freezing_system_message)
		end

	put_start_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
			interface.event_output_string (removing_dead_code_message)
		end
		
	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			if should_continue then
				interface.event_output_string (a_message)	
			end
		end				

	put_system_compiled is
			-- Put message indicating that the system has been compiled.
		do
			put_string ("System recompiled.")
		end
		
	put_degree_1 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		do
			interface.event_begin_degree (1)
			Precursor {DEGREE_OUTPUT} (a_class, nbr_to_go)
		end

	put_degree_2 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		do
			interface.event_begin_degree (2)
			Precursor {DEGREE_OUTPUT} (a_class, nbr_to_go)
		end
		
	put_degree_3 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		do
			interface.event_begin_degree (3)
			Precursor {DEGREE_OUTPUT} (a_class, nbr_to_go)
		end
		
	put_degree_4 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		do
			interface.event_begin_degree (4)
			Precursor {DEGREE_OUTPUT} (a_class, nbr_to_go)
		end
		
	put_degree_5 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		do
			interface.event_begin_degree (5)
			Precursor {DEGREE_OUTPUT} (a_class, nbr_to_go)
		end
		
	put_degree_6 (a_name: STRING; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_name' is being
			-- compiled during degree six' clusters to go.
		do
			interface.event_begin_degree (6)
			Precursor {DEGREE_OUTPUT} (a_name, nbr_to_go)
		end
			
	put_degree_minus_1 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		do
			interface.event_begin_degree (-1)
			Precursor {DEGREE_OUTPUT} (a_class, nbr_to_go)
		end

	put_degree_minus_2 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		do
			interface.event_begin_degree (-2)
			Precursor {DEGREE_OUTPUT} (a_class, nbr_to_go)
		end
		
	put_degree_minus_3 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		do
			interface.event_begin_degree (-3)
			Precursor {DEGREE_OUTPUT} (a_class, nbr_to_go)
		end
				
feature -- Output on per class

	put_dead_code_removal_message (total_nbr, nbr_to_go: INTEGER) is
			-- Put message progress the start of dead code removal.
		do
			processed := processed + total_nbr
			put_string ("Features done: " + 
											processed.out + 
											"%TFeatures to go: " + 
											nbr_to_go.out)
		end
		
feature -- Other

	display_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			if should_continue then
				total_number := total
				put_string (percentage_output (to_go) + deg_nbr)
			else
				Error_handler.insert_interrupt_error (True)
			end
		end

feature {NONE} -- Implementation

	interface: CEIFFEL_COMPILER_COCLASS
			-- Entity that handles messages.
			
	display_degree (deg_nbr: STRING; to_go: INTEGER; a_name: STRING) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do		
			if not should_continue then
				Error_handler.insert_interrupt_error (True)
			else
				put_string (percentage_output (to_go) + deg_nbr + a_name)
			end
		end
		
	should_continue: BOOLEAN is
			-- should compilation continue?
		local
			l_should_continue: BOOLEAN_REF
		do
			create l_should_continue
			l_should_continue.set_item (True)
			interface.event_should_continue (l_should_continue)
			Result := l_should_continue.item
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
end -- class COM_DEGREE_OUTPUT
