class

	SPECIAL_VALUE

inherit

	DEBUG_VALUE
		redefine
			set_hector_addr, append_to
		end;
	OBJECT_ADDR
		undefine
			is_equal
		end;
	SHARED_DEBUG
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

	items: LINKED_LIST [DEBUG_VALUE];
			-- List of SPECIAL items

	capacity: INTEGER;
			-- Number of items that SPECIAL object may hold

	address: STRING;
			-- Address of object
			-- (Because the socket is already busy we can not ask the 
			-- application for the hector address during the object
			-- inspection. This should be done latter with `set_hector_addr'.)

feature -- Access

	dynamic_class: E_CLASS is
		do
			Result := Eiffel_system.special_class.compiled_eclass
		end;

feature -- Output

	append_to (cw: CLICK_WINDOW; indent: INTEGER) is
			-- Append `Current' to `cw' with `indent' tabs the left margin.
		local
			o_stone: OBJECT_STONE;
			sp_lower, sp_upper: INTEGER;
			object_text: OBJECT_TEXT
		do
			object_text ?= cw;
			if object_text /= Void then
				sp_lower := object_text.sp_lower;
				sp_upper := object_text.sp_upper;
				object_text.set_sp_capacity (capacity)
			end;
			append_tabs (cw, indent);
			cw.put_clickable_string (feature_stone, name)
			cw.put_string (": ");
			dynamic_class.append_clickable_name (cw);
			cw.put_string (" [");
			if Run_info.is_running and Run_info.is_stopped then
				!! o_stone.make (address, dynamic_class);
				cw.put_clickable_string (o_stone, address)
			else
				cw.put_string (address)
			end
			cw.put_string ("]");
			cw.new_line;
			append_tabs (cw, indent + 1);
			cw.put_string ("-- begin special object --");
			cw.new_line;
			if sp_lower > 0 then
				append_tabs (cw, indent + 2);
				cw.put_string ("... Items skipped ...");
				cw.new_line
			end;
			from
				items.start
			until
				items.after
			loop
				items.item.append_to (cw, indent + 2);
				items.forth
			end;
			if 0 <= sp_upper and sp_upper < capacity - 1 then
				append_tabs (cw, indent + 2);
				cw.put_string ("... More items ...");
				cw.new_line
			end;
			append_tabs (cw, indent + 1);
			cw.put_string ("-- end special object --");
			cw.new_line
		end;

	append_type_and_value (cw: CLICK_WINDOW) is
		local
			os: OBJECT_STONE;
			ec: E_CLASS
		do
			if address = Void then
				cw.put_string ("NONE = Void")
			else
				ec := dynamic_class;
				if ec /= Void then
					ec.append_clickable_name (cw);
					cw.put_string (" [");
					if Run_info.is_running and Run_info.is_stopped then
						!! os.make (address, ec);
						cw.put_clickable_string (os, address)
					else
						cw.put_string (address)
					end;
					cw.put_string ("]");
				else
					Any_class.append_clickable_name (cw);
					cw.put_string (" = Unknown")
				end
			end
		end;

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

invariant
 
	items_exists: items /= Void;
	address_not_void: address /= Void;
	is_attribute: is_attribute

end -- class SPECIAL_VALUE
