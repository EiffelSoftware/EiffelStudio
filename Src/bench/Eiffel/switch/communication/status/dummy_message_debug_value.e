indexing
	description: "Dummy debug value, named but no more information"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMMY_MESSAGE_DEBUG_VALUE

inherit
	ABSTRACT_DEBUG_VALUE

create {RECV_VALUE, ATTR_REQUEST, CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make_with_name
	
feature {NONE} -- Initialization

	make_with_name (a_name: STRING) is
			-- Create current
		do
			name := a_name
		end

feature -- change

	set_message (a_msg: STRING) is
		do
			message := a_msg
		end

feature -- Access

	message: STRING 
			-- Information message to display in object tool

	display_message: STRING is
			-- Computed information message to display in object tool
		do
			Result := message
			if Result = Void then
				Result := "Unavailable value"
			end
		end

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		do
			Result := Eiffel_system.any_class.compiled_class
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			create Result.make_manifest_string (display_message, dynamic_class)
		end

feature {ABSTRACT_DEBUG_VALUE} -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
			-- Append type and value of Current to `st'.
		do 
			st.add_string (display_message)
		end

feature {NONE} -- Output

	append_value (st: STRUCTURED_TEXT) is
			-- Append only the value of Current to `st'.
		do
			st.add_string (display_message)
		end

	output_value: STRING is
			-- A STRING representation of the value of `Current'.
		do
			Result := address
		end

	type_and_value: STRING is
			-- Return a string representing `Current'.
		do
			Result := display_message
		end
		
feature -- Output

	is_dummy_value: BOOLEAN is True
			-- Does `Current' represent a object value or for instance an error message
		
	expandable: BOOLEAN is False
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. 
			-- May be void if there are no children.
			-- Generated on demand.
			-- (sorted by name)
		do
			Result := Void
		end
		
	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Error_message_value
		end

end

