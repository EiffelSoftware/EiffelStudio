indexing

	description: 
		"Undoable command to set class data as a root class.";
	date: "$Date$";
	revision: "$Revision $"

class APPLY_TEXT_COMMAND 

inherit
	
	EV_COMMAND

creation
	make

feature -- Creation

	make (t: like text_area) is
		do
			text_area := t
		end

feature -- Property

	name: STRING is
		do
		end

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
		end;

	undo is
			-- Cancel effect of executing the command.
		do
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			eiffel_parser: CLASS_PARSER

			text_file: PLAIN_TEXT_FILE
		
		do
			if text_area /= Void then
				text_area.set_editable (false)

				!! eiffel_parser	
				--!! text_file.make_open_write ("code.tmp")		
				--text_file.put_string (text_area.text)
				--text_file.close

				!! text_file.make ("/boston/kolli/CASE5/case_compilation/code.tmp")
				eiffel_parser.parse (text_file)
			end
		end

feature -- Properties

	text_area : EV_TEXT 

end -- class SET_ROOT_U
