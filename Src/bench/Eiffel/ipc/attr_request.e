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
			type_id: INTEGER
		do
			send_rqst_3 (Rqst_sp_lower, 0, 0, sp_lower);
			send_rqst_3 (Rqst_sp_upper, 0, 0, sp_upper);
			send_rqst_3 (request_code, In_h_addr, 0, 
								hex_to_integer (object_address));
			dynamic_class_name := c_tread;
			if dynamic_class_name.is_equal ("SPECIAL") then
				is_special := true;
				!! attributes.make;
				capacity := c_tread.to_integer;
				max_capacity := capacity;
				recv_attributes (attributes, Void)
			else
				is_special := false;
				!SORTED_TWO_WAY_LIST [DEBUG_VALUE]! attributes.make;
				type_id := c_tread.to_integer + 1;
				if Eiffel_system.valid_dynamic_id (type_id) then
					recv_attributes (attributes, Eiffel_system.class_of_dynamic_id (type_id))
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
		do
			attr_nb := c_tread.to_integer;
			from
				i := 1
			until
				i > attr_nb
			loop
				attr_name := c_tread;
				type_name := c_tread;
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
						recv_attributes (exp_attr.attributes, Eiffel_system.class_of_dynamic_id (type_id))
					else
						recv_attributes (exp_attr.attributes, Void)
					end;
				elseif type_name.is_equal ("SPECIAL") then
					!! spec_attr.make_attribute (attr_name, e_class, 
								c_tread, c_tread.to_integer);
					if sp_upper = -1 then
						spec_attr.set_sp_bounds (sp_lower, spec_attr.capacity);
					else
						spec_attr.set_sp_bounds (sp_lower, sp_upper);
					end;
					max_capacity := max_capacity.max (spec_attr.capacity);
					attr := spec_attr;
					recv_attributes (spec_attr.items, Void)
				else
					type_id := c_tread.to_integer + 1;
					!REFERENCE_VALUE! attr.make_attribute (attr_name, e_class, 
													type_id, c_tread)
				end
				attr_list.extend (attr);
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
