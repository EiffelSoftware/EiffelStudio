indexing
	description: "[
		Represents the abstraction of a Reference value for the debugger
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ABSTRACT_REFERENCE_VALUE
