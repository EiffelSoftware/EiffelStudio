-- Request for attributes' value of an object

class ATTR_REQUEST

inherit

	EWB_REQUEST
		rename
			make as old_make
		redefine
			send
		end;
	BEURK_HEXER

creation

	make

feature

	make (addr: STRING) is
		require
			valid_addr: addr /= Void
		do
			old_make (Rqst_inspect);
			object_address := addr;
		end;

	object_address: STRING;
			-- Hector address of object being inspected

	dynamic_type: STRING;
			-- Dynamic type of object being inspected

	attributes: LIST [ATTRIBUTE];
			-- Attributes of object being inspected (sorted by name)

	send is
			-- Send inpect request to application.
		local
			obj_addr, dt_lower: STRING;
			c_stone: CLASSC_STONE
		do
			send_rqst_3 (request_code, In_h_addr, 0, 
											hex_to_integer (object_address));
			dynamic_type := clone (c_tread);
			obj_addr := c_tread;
			if dynamic_type.is_equal ("SPECIAL") then
				!LINKED_LIST [ATTRIBUTE]! attributes.make;
				recv_attributes (attributes, Void)
			else
				!SORTED_TWO_WAY_LIST [ATTRIBUTE]! attributes.make;
				dt_lower := clone (dynamic_type);
				dt_lower.to_lower;
				c_stone ?= Universe.class_stone (dt_lower);
				recv_attributes (attributes, c_stone.class_c)
			end
		end;

	recv_attributes (attr_list: LIST [ATTRIBUTE]; class_c: CLASS_C) is
			-- Receive `class_c''s attribute info from application and 
			-- store it in `attr_list'.
		local
			attr_name, type_name: STRING;
			i, attr_nb: INTEGER;
			attr: ATTRIBUTE;
			exp_attr: EXPANDED_ATTR;
			spec_attr: SPECIAL_ATTR;
			c_stone: CLASSC_STONE;
			lower_type_name: STRING
		do
			attr_nb := c_tread.to_integer;
			from
				i := 1
			until
				i > attr_nb
			loop
				attr_name := clone (c_tread);
				type_name := clone (c_tread);
--				if type_name.is_equal ("Void") then
--					!REFERENCE_ATTR!attr.make (attr_name, class_c, Void, "Void")
--				else
				if type_name.is_equal ("BOOLEAN") then
					!BOOLEAN_ATTR!attr.make (attr_name, class_c, clone(c_tread))
				elseif type_name.is_equal ("INTEGER") then
					!INTEGER_ATTR!attr.make (attr_name, class_c, clone(c_tread))
				elseif type_name.is_equal ("REAL") then
					!REAL_ATTR!attr.make (attr_name, class_c, clone (c_tread))
				elseif type_name.is_equal ("DOUBLE") then
					!DOUBLE_ATTR!attr.make (attr_name, class_c, clone (c_tread))
				elseif type_name.is_equal ("CHARACTER") then
					!CHARACTER_ATTR!attr.make (attr_name,class_c,clone(c_tread))
				elseif type_name.is_equal ("POINTER") then
					!POINTER_ATTR!attr.make (attr_name, class_c, clone(c_tread))
				elseif type_name.is_equal ("BIT") then
					!BIT_ATTR!attr.make (attr_name, class_c, clone (c_tread))
				elseif type_name.is_equal ("expanded") then
					type_name := clone (c_tread);
					!EXPANDED_ATTR!attr.make (attr_name, class_c, type_name);
					lower_type_name := clone (type_name);
					lower_type_name.to_lower;
					c_stone ?= Universe.class_stone (lower_type_name);
					exp_attr ?= attr;
					recv_attributes (exp_attr.attributes, c_stone.class_c)
				elseif type_name.is_equal ("SPECIAL") then
					!SPECIAL_ATTR!attr.make (attr_name, class_c,clone(c_tread));
					spec_attr ?= attr;
					recv_attributes (spec_attr.items, Void)
				else
					!REFERENCE_ATTR!attr.make (attr_name, class_c, 
													type_name, clone (c_tread))
				end
				attr_list.extend (attr);
				i := i + 1
			end
		end;

end -- class ATTR_REQUEST
