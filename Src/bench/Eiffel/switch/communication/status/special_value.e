indexing

	description: 
		"Run time value representing of a special object.";
	date: "$Date$";
	revision: "$Revision $"

class SPECIAL_VALUE

inherit

	ABSTRACT_DEBUG_VALUE
		redefine
			set_hector_addr, append_to, address
		end;
	OBJECT_ADDR
		undefine
			is_equal
		end;
	SHARED_DEBUG
		undefine
			is_equal
		end;

	CHARACTER_ROUTINES
		undefine
			is_equal
		end;

creation {ATTR_REQUEST}

	make_attribute

feature {NONE} -- Initialization

	make_attribute (attr_name: like name; a_class: like e_class; 
						addr: like address; cap: like capacity) is
		require
			not_attr_name_void: attr_name /= Void;
			not_addr_void: addr /= Void
		do
			name := attr_name;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			address := addr;
			capacity := cap;
			!! items.make
		end;

feature -- Properties

	items: LINKED_LIST [ABSTRACT_DEBUG_VALUE];
			-- List of SPECIAL items

	capacity: INTEGER;
			-- Number of items that SPECIAL object may hold

	sp_lower, sp_upper: INTEGER;
			-- Bounds for special object inspection

	address: STRING;
			-- Address of object
			--| Because the socket is already busy we cannot ask the 
			--| application for the hector address during the object
			--| inspection. This should be done latter with `set_hector_addr'.)

feature -- Access

	dynamic_class: CLASS_C is
		do
			Result := Eiffel_system.special_class.compiled_class
		end;

	string_value: STRING is
			-- If `Current' represents a string then return its value.
			-- Else return Void.
		local
			char_value: CHARACTER_VALUE
		do
			if items.count /= 0 then
				char_value ?= items.first
				if char_value /= Void then
					create Result.make (items.count + 4)
					if sp_lower > 0 then
						Result.append ("...")
					end
					Result.append ("%"")
					from
						items.start
					until
						items.after
					loop
						char_value ?= items.item
						Result.append (char_text (char_value.value))
						items.forth
					end;
					Result.append ("%"")
					if sp_upper <= capacity - 1 then
						Result.append ("...")
					end
				end
			end
		end

feature -- Output

	append_to (st: STRUCTURED_TEXT; indent: INTEGER) is
			-- Append `Current' to `st' with `indent' tabs the left margin.
		local
			status: APPLICATION_STATUS
			is_special_of_char: BOOLEAN
			char_value: CHARACTER_VALUE
		do
			append_tabs (st, indent);
			st.add_feature_name (name, e_class);
			st.add_string (": ");
			dynamic_class.append_name (st);
			st.add_string (" [");
			status := Application.status;
			if status /= Void and status.is_stopped then
				st.add_address (address, name, dynamic_class)
			else
				st.add_string (address)
			end
			st.add_string ("]");
			st.add_new_line;
			append_tabs (st, indent + 1);
			st.add_string ("-- begin special object --");
			st.add_new_line;
			if sp_lower > 0 then
				append_tabs (st, indent + 2);
				st.add_string ("... Items skipped ...");
				st.add_new_line
			end;
			if items.count /= 0 then
				items.start
				char_value ?= items.item
				is_special_of_char := char_value /= Void
			end 
			if not is_special_of_char then
				from
					items.start
				until
					items.after
				loop
					items.item.append_to (st, indent + 2);
					items.forth
				end;
			else
				st.add_string ("%"")
				from
					items.start
				until
					items.after
				loop
					char_value ?= items.item
					check
						valid_character_element: char_value /= Void
					end
					st.add_char (char_value.value)
					items.forth
				end;
				st.add_string ("%"")
				st.add_new_line
			end
			if 0 <= sp_upper and sp_upper < capacity - 1 then
				append_tabs (st, indent + 2);
				st.add_string ("... More items ...");
				st.add_new_line
			end;
			append_tabs (st, indent + 1);
			st.add_string ("-- end special object --");
			st.add_new_line
		end;

	append_type_and_value (st: STRUCTURED_TEXT) is
		local
			ec: CLASS_C
		do
			if address = Void then
				st.add_string ("NONE = Void")
			else
				ec := dynamic_class;
				if ec /= Void then
					ec.append_name (st);
					st.add_string (" [");
					if Application.is_running and Application.is_stopped then
						st.add_address (address, name, ec)
					else
						st.add_string (address)
					end;
					st.add_string ("]");
				else
					Any_class.append_name (st);
					st.add_string (" = Unknown")
				end
			end
		end;

	append_value (st: STRUCTURED_TEXT) is
			-- Append `Current' to `st' with `indent' tabs the left margin.
		local
			is_special_of_char: BOOLEAN
			char_value: CHARACTER_VALUE
		do
			st.add_string ("-- begin special object --");
			st.add_new_line;
			if sp_lower > 0 then
				append_tabs (st, 1);
				st.add_string ("... Items skipped ...");
				st.add_new_line
			end;
			if items.count /= 0 then
				items.start
				char_value ?= items.item
				is_special_of_char := char_value /= Void
			end 
			if not is_special_of_char then
				from
					items.start
				until
					items.after
				loop
					items.item.append_to (st, 1);
					items.forth
				end;
			else
				st.add_string ("%"")
				from
					items.start
				until
					items.after
				loop
					char_value ?= items.item
					check
						valid_character_element: char_value /= Void
					end
					st.add_char (char_value.value)
					items.forth
				end;
				st.add_string ("%"%N")
			end
			if 0 <= sp_upper and sp_upper < capacity - 1 then
				append_tabs (st, 1);
				st.add_string ("... More items ...");
				st.add_new_line
			end;
			st.add_string ("-- end special object --");
			st.add_new_line
		end;

	output_value: STRING is
			-- Return a string representing `Current'.
		local
			str: STRING
		do
			if address = Void then
				Result := NONE_representation
			else
				Result := "[" + address + "]"
				str := string_value 
				if str /= Void then
					Result.append (" = " + str)
				end
			end
		end

	type_and_value: STRING is
			-- Return a string representing `Current'.
		local
			ec: CLASS_C;
			str: STRING
		do
			if address = Void then
				Result := NONE_representation
			else
				ec := dynamic_class;
				if ec /= Void then
					create Result.make (60)
					Result.append (ec.name_in_upper)
					Result.append (Left_square_bracket)
					Result.append (address)
					Result.append (Right_square_bracket)
					str := string_value 
					if str /= Void then
						Result.append (Equal_sign_str)
						Result.append (str)
					end
				else
					create Result.make (15)
					Result.append (Any_class.name_in_upper)
					Result.append (Is_unknown)
				end
			end
		end

	NONE_representation: STRING is "NONE = Void"

	Left_square_bracket: STRING is " ["

	Right_square_bracket: STRING is "]"

	Equal_sign_str: STRING is " = "

	Is_unknown: STRING is " = Unknown"

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		do
			Result := address /= Void
		end

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := items
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Special_value
		end

feature {NONE} -- Implementation
 
	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
			address := hector_addr (address);
			from
				items.start
			until
				items.after
			loop
				items.item.set_hector_addr;
				items.forth
			end
		end;

feature {ATTR_REQUEST} -- Implentation

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			sp_lower := l;
			sp_upper := u
		end;

invariant
 
	items_exists: items /= Void;
	address_not_void: address /= Void;
	is_attribute: is_attribute

end -- class SPECIAL_VALUE
