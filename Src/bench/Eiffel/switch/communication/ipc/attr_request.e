-- Request for attributes' value of an object

class ATTR_REQUEST

inherit

	EWB_REQUEST
		rename
			make as old_make
		redefine
			send
		end;
	BEURK_HEXER;
	BASIC_ROUTINES;
	SHARED_EIFFEL_PROJECT

creation

	make

feature -- Initialization

	make (addr: STRING) is
		require
			valid_addr: addr /= Void
		do
			old_make (Rqst_inspect);
			object_address := addr;
		end;

feature -- Properites

	object_address: STRING;
			-- Hector address of object being inspected

	attributes: LINKED_LIST [DEBUG_VALUE];
			-- Attributes of object being inspected (sorted by name)

feature -- Update

	send is
			-- Send inpect request to application.
		local
			dynamic_class_name: STRING;
			type_id: INTEGER;
			obj_addr: STRING;
			l: LINKED_LIST [CLASS_I];
			d_type: INTEGER
		do
			send_rqst_3 (Rqst_sp_lower, 0, 0, sp_lower);
			send_rqst_3 (Rqst_sp_upper, 0, 0, sp_upper);
			send_rqst_3 (request_code, In_h_addr, 0, 
								hex_to_integer (object_address));
			dynamic_class_name := c_tread;
			type_id := c_tread.to_integer + 1;
debug ("DEBUG_RECV")
	io.error.putstring ("Grepping object at address ");
	io.error.putstring (object_address);
	io.error.putstring (".%NDynamic class name is: ");
	io.error.putstring (dynamic_class_name);
	io.error.putstring (".%N And the type id is: ");
	io.error.putint (type_id);
	io.error.putstring (".%N")
end;
			if dynamic_class_name.is_equal ("SPECIAL") then
debug ("DEBUG_RECV")
	io.error.putstring ("Oh oooh. This is a special object...%N")
end;
				is_special := true;
				!! attributes.make;
debug("DEBUG_RECV")
	io.error.putstring ("Getting the attributes from the special object...%N");
	io.error.putstring ("Capacity is ");
	io.error.putint (capacity);
	io.error.putstring (".%N");
	io.error.putstring ("Calling `recv_attributes'.%N")
end
				recv_attributes (attributes, Void);
debug ("DEBUG_RECV")
	io.error.putstring ("And being back again in `send'.%N");
end
			else
				is_special := false;
				!SORTED_TWO_WAY_LIST [DEBUG_VALUE]! attributes.make;

				if Eiffel_system.valid_dynamic_id (type_id) then
					recv_attributes (attributes, 
						Eiffel_system.class_of_dynamic_id (type_id))
				else
					recv_attributes (attributes, Void)
				end;
			end;
				-- Convert the physical addresses received from
				-- the application to hector addresses.
			from
				attributes.start
			until
				attributes.after
			loop
				attributes.item.set_hector_addr;
				attributes.forth
			end
		end;

feature {NONE} -- Implementation

	recv_attributes (attr_list: LINKED_LIST [DEBUG_VALUE]; e_class: E_CLASS) is
			-- Receive `e_class attribute info from application and 
			-- store it in `attr_list'.
		local
			attr_name, type_name: STRING;
			i, attr_nb: INTEGER;
			attr: DEBUG_VALUE;
			exp_attr: EXPANDED_VALUE;
			spec_attr: SPECIAL_VALUE;
			type_id: INTEGER;
			class_type: CLASS_TYPE
			toto: STRING
		do
			attr_nb := c_tread.to_integer;
debug("DEBUG_RECV")
	io.error.putstring ("Getting ");
	io.error.putint (attr_nb);
	io.error.putstring (" attributes...%N")
end
			from
				i := 1
			until
				i > attr_nb
			loop
				attr_name := c_tread;
				type_name := c_tread;
debug("DEBUG_RECV")
	io.error.putstring ("Grepping attribute `");
	io.error.putstring (attr_name);
	io.error.putstring ("' of type ");
	io.error.putstring (type_name);
	io.error.putstring (".%N")
end
				if type_name.is_equal ("BOOLEAN") then
					!BOOLEAN_VALUE! attr.make_attribute (attr_name, 
							e_class, c_tread.to_boolean)
				elseif type_name.is_equal ("INTEGER") then
					!INTEGER_VALUE! attr.make_attribute (attr_name, 
							e_class, c_tread.to_integer)
				elseif type_name.is_equal ("REAL") then
					!REAL_VALUE! attr.make_attribute (attr_name, 
							e_class, c_tread.to_real)
				elseif type_name.is_equal ("DOUBLE") then
					!DOUBLE_VALUE! attr.make_attribute (attr_name, 
							e_class, c_tread.to_double)
				elseif type_name.is_equal ("CHARACTER") then
					!CHARACTER_VALUE! attr.make_attribute (attr_name, 
							e_class, charconv (c_tread.to_integer))
				elseif type_name.is_equal ("POINTER") then
					!POINTER_VALUE! attr.make_attribute (attr_name, e_class, c_tread)
				elseif type_name.is_equal ("BIT") then
					!BITS_VALUE! attr.make_attribute (attr_name, e_class, c_tread)
				elseif type_name.is_equal ("expanded") then
					type_id := c_tread.to_integer + 1;
					!! exp_attr.make_attribute (attr_name, e_class, type_id);
					attr := exp_attr;
					if Eiffel_system.valid_dynamic_id (type_id) then
						recv_attributes (exp_attr.attributes,
							Eiffel_system.class_of_dynamic_id (type_id))
					else
						recv_attributes (exp_attr.attributes, Void)
					end;
				elseif type_name.is_equal ("SPECIAL") then
debug("DEBUG_RECV")
	io.error.putstring ("Creating special object.%N")
end
					!! spec_attr.make_attribute (attr_name, e_class, 
								c_tread, c_tread.to_integer);
debug("DEBUG_RECV")
	io.error.putstring ("Attribute name: ");
	io.error.putstring (attr_name);
	io.error.new_line;
	io.error.putstring ("The eiffel class: ");
	io.error.putstring (e_class.name_in_upper);
	io.error.new_line
end;
					if sp_upper = -1 then
						spec_attr.set_sp_bounds (sp_lower, spec_attr.capacity);
					else
						spec_attr.set_sp_bounds (sp_lower, sp_upper);
					end;
					max_capacity := max_capacity.max (spec_attr.capacity);
					attr := spec_attr;
debug("DEBUG_RECV")
	io.error.putstring ("Receiving attributes in the special object.%N")
end;
					recv_attributes (spec_attr.items, Void);
debug("DEBUG_RECV")
	io.error.putstring ("Done receiving attributes in the special object.%N")
end
				else
					if not type_name.is_equal ("Void") then	
						type_id := c_tread.to_integer + 1;
					end;
					!REFERENCE_VALUE! attr.make_attribute (attr_name, e_class, 
													type_id, c_tread)
				end
debug("DEBUG_RECV")
	io.error.putstring ("Putting `attr' in `attr_list'.%N")
end;
				attr_list.extend (attr);
				attr_list.forth
				i := i + 1
			end
		end;

feature -- Special object properties

	sp_lower, sp_upper: INTEGER;
			-- Bounds for special object inspection
			-- A negative value for `sp_upper' stands for the
			-- upper bound of the inspected special object

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			sp_lower := l;
			sp_upper := u
		end;

	capacity: INTEGER;
			-- Capacity of the object in case it is SPECIAL

	max_capacity: INTEGER
			-- Maximum capacity if the object or its
			-- attributes are SPECIAL

	is_special: BOOLEAN;
			-- Is the object being inspected SPECIAL?

end -- class ATTR_REQUEST
