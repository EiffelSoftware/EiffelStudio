indexing
	description: "Displays Ace text in output_window."
	date: "$Date$"
	revision: "$Revision $"

class
	EWB_ACE 

inherit
	EWB_CMD
		rename
			name as ace_cmd_name,
			help_message as ace_loop_help,
			abbreviation as ace_abb
		end

feature {NONE} -- Execution

	execute is
			-- Execute Current batch command.
		local
			text: STRING;
		do
			check
				has_ace_file: Eiffel_ace.file_name /= Void
			end
			text := Eiffel_ace.text

			if text /= Void then
				output_window.put_string (text)
				output_window.new_line
			else
				output_window.put_string (Warning_messages.w_Cannot_read_file (Eiffel_ace.file_name))
				output_window.new_line
			end
		end

end -- class EWB_ACE
