indexing
	description	: "Output compilation degree messages into a file."
	date		: "$Date$"
	revision	: "$Revision $"

class
	FILE_DEGREE_OUTPUT

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
			percentage_output,
			degree_message,
			put_system_compiled,
			put_header
		end

create
	make

feature -- Initialization

	make (a_file_name: STRING) is
			-- Initialize
		do
			output_file_name := a_file_name
		end

feature -- Basic operations

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			if not output_file.is_closed then
				open_file
				output_file.put_string ("6%T100%%")
				output_file.new_line
				close_file
			end
		end

	put_melting_changes_message is
			-- Put message indicating that melting changes is ocurring.
		do
		end

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
		end

	put_start_dead_code_removal_message is
			-- Put message indicating the start of dead code removal.
		do
		end

	put_dead_code_removal_message (total_nbr, nbr_to_go: INTEGER) is
			-- Put message progress the start of dead code removal.
		do
		end

	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			open_file
			if not output_file.is_closed then
				output_file.put_string (a_message)
				output_file.new_line
				close_file
			end
		end

	put_system_compiled is
			-- Put message indicating that the system has been compiled.
		do	
				-- Wait for the file to be writable.
			from
			until
				not output_file.is_closed
			loop
				open_file
			end

			output_file.put_string ("finished")
			output_file.new_line
			close_file
		end

	put_header (displayed_version_number: STRING) is
		do
		end

	display_degree (deg_nbr: STRING; to_go: INTEGER; a_name: STRING) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			open_file
			if not output_file.is_closed then
				output_file.put_string (deg_nbr)
				output_file.put_string ("%T")
				output_file.put_string (percentage_output (to_go))
				output_file.new_line
				close_file
			end
		end

feature {NONE} -- Implementation

	output_file: PLAIN_TEXT_FILE
			-- Output file.
	
	output_file_name: STRING
			-- Output file name

	degree_message (a_degree: INTEGER): STRING is
			-- Display the message corresponding to degree `a_degree'.
		do
			create Result.make (2)
			Result.append_integer (a_degree)
		end

	open_file is
			-- Open the output file
		local
			retried: BOOLEAN
		do
			if not retried then
				create output_file.make_open_write (output_file_name)
			end
		rescue
			retried := True
			retry
		end

	close_file is
			-- Close the output file
		local
			retried: BOOLEAN
		do
			if not retried then
				output_file.close
			end
		rescue
			retried := True
			retry
		end

	display_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			total_number := total
			open_file
			if not output_file.is_closed then
				output_file.put_integer (-2)
				output_file.put_string ("%T")
				output_file.putstring (percentage_output (to_go))
				output_file.new_line
				close_file
			end
		end

	percentage_output (nbr_to_go: INTEGER): STRING is
			-- Return percentage based on `nbr_to_go' and
			-- `total_number'
		do
			create Result.make (4)
			Result.append_integer (percentage_calculation (nbr_to_go))
			Result.append_string ("%%")
		end

end -- class FILE_DEGREE_OUTPUT
