indexing
	description: "Redirects output to specified pipe"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_PIPED_DEGREE_OUTPUT
	
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
create
	make
	
feature {NONE} -- Initialization

	make (a_pipe: WEL_PIPE) is
			-- Initialize structure.
		require
			non_void_pipe: a_pipe /= Void
			pipe_writable: not a_pipe.output_closed
		do
			output_pipe := a_pipe
		end

feature -- Start output features

	put_header (displayed_version_number: STRING) is
		do
			output_pipe.put_string (
				"Eiffel compilation manager (version " + 
				displayed_version_number + ")")
		end

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			output_pipe.put_string ("Processing options")
		end
		
	put_melting_changes_message  is
			-- Put message indicating that melting changes is ocurring.
		do
			output_pipe.put_string (melting_changes_message)
		end

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
			output_pipe.put_string (freezing_system_message)
		end

	put_start_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
			output_pipe.put_string (removing_dead_code_message)
		end
		
	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			output_pipe.put_string (a_message)
		end				

	put_system_compiled is
			-- Put message indicating that the system has been compiled.
		do
			output_pipe.put_string ("System recompiled.")
		end
				
feature -- Output on per class

	put_dead_code_removal_message (total_nbr, nbr_to_go: INTEGER) is
			-- Put message progress the start of dead code removal.
		do
			processed := processed + total_nbr
			output_pipe.put_string ("Features done: " + 
											processed.out + 
											"%TFeatures to go: " + 
											nbr_to_go.out)
		end
		
feature -- Other

	display_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			total_number := total
			output_pipe.put_string (percentage_output (to_go) + deg_nbr)
		end

feature {NONE} -- Implementation

	output_pipe: WEL_PIPE
			-- Pipe to send output to
			
	display_degree (deg_nbr: STRING; to_go: INTEGER; a_name: STRING) is
			-- Display degree `deg_nbr' with entity `a_class'.
		local
			should_continue: BOOLEAN_REF
		do
			output_pipe.put_string (percentage_output (to_go) + 
										deg_nbr + a_name)
		end
		
end -- class COM_PIPED_DEGREE_OUTPUT
