indexing

	description: 
		"Error when the creation type of a creation instruction %
		%is an expanded type, a none type, a bits symbol type %
		%or a simple type.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC3 

inherit

	VGCC
		redefine
			subcode,
			print_name
		end;

feature -- Properties

	subcode: INTEGER is 3

	is_symbol: BOOLEAN
		-- Does Current have a non-Void type?

	symbol_name: STRING
		-- String representation of type, when unknown.

feature -- Output

	print_name (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Creation of: ");
			st.add_string (target_name);
			st.add_new_line;
			st.add_string ("Target type: ");
			if is_symbol then
				st.add_string (symbol_name)
			else
				type.append_to (st);
			end
			st.add_new_line;
		end

feature -- Settings

	set_is_symbol is
			-- The error is related to a symbol.
		do
			is_symbol := True
		end
	
	set_symbol_name (s: STRING) is
			-- Set `s' to `symbol_name'.
		require
			s_not_void: s /= Void
		do
			symbol_name := clone (s)
		ensure
			symbol_name_set: symbol_name.is_equal (s)
		end

end -- class VGCC3
