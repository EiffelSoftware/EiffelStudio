indexing
	description: "Generate a warning for an obsolete syntax."
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_WARNING

inherit
	WARNING
		redefine
			trace
		end
		
	SYNTAX_MESSAGE
		rename
			code as warning_code,
			message as warning_message
		redefine
			make
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end
	
	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: like file_name; c: INTEGER; m: STRING) is
			-- Create a new SYNTAX_WARNING instance.
		do
			Precursor {SYNTAX_MESSAGE} (s, e, f, c, m)
			associated_class := System.current_class
		end

feature -- Properties

	code: STRING is "Syntax warning"
			-- Error code

	associated_class: CLASS_C
			-- Class in which syntax warning occurred.
			
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
		end

	trace (st: STRUCTURED_TEXT) is
			-- Debug purpose
		do
			initialize_output

			st.add (create {ERROR_TEXT}.make (Current, "Obsolete"))
			st.add_string (" syntax used at line ")
			st.add_int (line_number)
				-- Error happened in a class
			st.add_string (" in class ")
			st.add_class_syntax (Current, associated_class, associated_class.class_signature)
			if warning_message /= Void then
				st.add_new_line
				st.add_string (warning_message)
				st.add_new_line
			end
			st.add_new_line
			build_explain (st)
			display_line (st, previous_line)
			display_syntax_line (st, current_line, start_position - start_line_pos)
			display_line (st, next_line)
		end

invariant
	associated_class_not_void: associated_class /= Void

end -- class SYNTAX_WARNING
