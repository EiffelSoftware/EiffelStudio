indexing
	description: "Generate a warning for an obsolete syntax."
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_WARNING

inherit
	WARNING
		redefine
			trace, file_name
		end
		
	SYNTAX_MESSAGE

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

	make (s, e: INTEGER; f: like file_name; m: STRING) is
			-- Create a new SYNTAX_WARNING instance.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			set_position (s, e)
			warning_message := m
			file_name := f
			associated_class := System.current_class
		ensure
			line_set: line = s
			column_set: column = e
			warning_message_set: warning_message = m
			file_name_set: file_name = f
		end

feature -- Properties

	warning_message: STRING
			-- Specify syntax issue message.

	file_name: STRING
			-- Path to file where syntax issue happened

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
			st.add_int (line)
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
			display_syntax_line (st, current_line)
			display_line (st, next_line)
		end

invariant
	associated_class_not_void: associated_class /= Void

end -- class SYNTAX_WARNING
