indexing
	description: "[
		Represents the abstraction of a Reference value for the debugger
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	ABSTRACT_REFERENCE_VALUE

inherit

	ABSTRACT_DEBUG_VALUE
		redefine
			address
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		undefine
			is_equal
		end;

feature -- Properties

	address: STRING;
			-- Address of referenced object (Void if no object)

	string_value: STRING;
			-- Value if the reference object is a STRING

	is_null: BOOLEAN
			-- Value represents Void element

feature {ABSTRACT_DEBUG_VALUE} -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
		local
			ec: CLASS_C;
			status: APPLICATION_STATUS
		do 
			if is_null then
				st.add_string ("NONE = Void")
			else
				ec := dynamic_class;
				if ec /= Void then
					ec.append_name (st);
					st.add_string (" [");
					status := Application.status;
					if status /= Void and status.is_stopped then
						st.add_address (address, name, ec)
					else
						st.add_string (address)
					end;
					st.add_string ("]");
					if string_value /= Void then
						st.add_string (" = ");
						st.add_string (string_value)
					end
				else
					Any_class.append_name (st);
					st.add_string (" = Unknown")
				end
			end
		end;

feature {NONE} -- Output

	append_value (st: STRUCTURED_TEXT) is 
		local
			ec: CLASS_C;
			status: APPLICATION_STATUS
		do 
			if address = Void then
				st.add_string ("Void")
			else
				ec := dynamic_class;
				if ec /= Void then
					st.add_string ("[");
					status := Application.status;
					if status /= Void and status.is_stopped then
						st.add_address (address, name, ec)
					else
						st.add_string (address)
					end;
					st.add_string ("]");
					if string_value /= Void then
						st.add_new_line
						st.add_string (string_value)
					end
				else
					Any_class.append_name (st);
					st.add_string ("Unknown")
				end
			end
		end;		

	output_value: STRING is
			-- Return a string representing `Current'.
		do
			if is_null then
				Result := "Void"
			else
				Result := "[" + address + "]"
			end
		end

feature -- Output

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? 
			-- (Is it a non void reference, a special object, ...)
		do
--			Result := address /= Void
			Result := not is_null
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			if not is_null then
				Result := Reference_value
			else
				Result := Void_value
			end
		end

end -- class ABSTRACT_REFERENCE_VALUE
