indexing

	description: 
		"Run time value representing of a special object.";
	date: "$Date$";
	revision: "$Revision $"

class SPECIAL_VALUE

inherit

	ABSTRACT_SPECIAL_VALUE
		redefine
			set_hector_addr
		end;

	OBJECT_ADDR
		export
			{NONE} all
		undefine
			is_equal
		end;

	CHARACTER_ROUTINES
		export
			{NONE} all	
		undefine
			is_equal
		end;

create {DEBUG_VALUE_EXPORTER}

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
			is_null := (address = Void)
			capacity := cap;
			create items.make
		end;

feature -- Access

	dynamic_class: CLASS_C is
		once
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
					create Result.make (items.count + 8)
					if sp_lower > 0 then
						Result.append ("...")
					end
					Result.append_character ('%"')
					Result.append (eiffel_string (raw_string_value))
					Result.append_character ('%"')
					if sp_upper <= capacity - 1 then
						Result.append ("...")
					end
				end
			end
		end

	raw_string_value: STRING is
			-- If `Current' represents a string then return its value.
			-- Else return Void.
			-- Do not convert special characters to an Eiffel representation.
		local
			char_value: CHARACTER_VALUE
		do
			if items.count /= 0 then
				char_value ?= items.first
				if char_value /= Void then
					create Result.make (items.count + 4)
					from
						items.start
					until
						items.after
					loop
						char_value ?= items.item
						Result.append_character (char_value.value)
						items.forth
					end;
				end
			end
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			create Result.make_object (address, dynamic_class)
		end

feature {ABSTRACT_DEBUG_VALUE} -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is
		local
			ec: CLASS_C
		do
			if address = Void then
				st.add_string (NONE_representation)
			else
				ec := dynamic_class;
				if ec /= Void then
					ec.append_name (st);
					st.add_string (Left_square_bracket);
					if Application.is_running and Application.is_stopped then
						st.add_address (address, name, ec)
					else
						st.add_string (address)
					end;
					st.add_string (Right_square_bracket);
				else
					Any_class.append_name (st);
					st.add_string (Is_unknown)
				end
			end
		end;

feature {NONE} -- Output

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

feature -- Output

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := items
		end

feature {NONE} -- Implementation
	
	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
			address := hector_addr (address);
			is_null := (address = Void)
			from
				items.start
			until
				items.after
			loop
				items.item.set_hector_addr;
				items.forth
			end
		end;

invariant
 
	items_exists: items /= Void;
	address_not_void: address /= Void;
	is_attribute: is_attribute

end -- class SPECIAL_VALUE
