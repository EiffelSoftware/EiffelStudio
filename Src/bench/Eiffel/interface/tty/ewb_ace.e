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
			if Eiffel_ace.file_name /= Void then
				text := Eiffel_ace.text
			end

			if text /= Void then
				output_window.put_string (text)
				output_window.new_line
			elseif Eiffel_ace.file_name = Void then
				output_window.put_string ("You must compile a project first%N")
			else
				output_window.put_string ("Cannot open ")
				output_window.put_string (Eiffel_ace.file_name)
				output_window.new_line
			end
		end

end -- class EWB_ACE
