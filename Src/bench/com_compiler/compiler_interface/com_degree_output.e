indexing
	description: "Redirects output to COM interface"
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
			put_header
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
			interface.event_output_string (
				"Eiffel compilation manager (version " + 
				displayed_version_number + ")")
		end

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			interface.event_output_string ("Processing options")
		end
		
	put_melting_changes_message  is
			-- Put message indicating that melting changes is ocurring.
		do
			interface.event_output_string (melting_changes_message)
		end

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
			interface.event_output_string (freezing_system_message)
		end

	put_start_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
			interface.event_output_string (removing_dead_code_message)
		end
		
	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			interface.event_output_string (a_message)
		end				

	put_system_compiled is
			-- Put message indicating that the system has been compiled.
		do
			interface.event_output_string ("System recompiled.")
		end
				
feature -- Output on per class

	put_dead_code_removal_message (total_nbr, nbr_to_go: INTEGER) is
			-- Put message progress the start of dead code removal.
		do
			processed := processed + total_nbr
			interface.event_output_string ("Features done: " + 
											processed.out + 
											"%TFeatures to go: " + 
											nbr_to_go.out)
		end
		
feature -- Other

	display_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER) is
			-- Display degree `deg_nbr' with entity `a_class'.
		local
			b: BOOLEAN_REF
		do
			create b
			b.set_item (True)
			interface.event_should_continue (b)
			if b.item then
				total_number := total
				interface.event_output_string (percentage_output (to_go) + deg_nbr)
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
			interface.event_output_string (percentage_output (to_go) + 
										deg_nbr + a_name)
		end
		
end -- class COM_DEGREE_OUTPUT
