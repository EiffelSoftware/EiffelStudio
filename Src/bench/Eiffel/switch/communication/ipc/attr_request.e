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

	PLATFORM

	SK_CONST

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

	attributes: LINKED_LIST [ABSTRACT_DEBUG_VALUE];
			-- Attributes of object being inspected (sorted by name)

	object_type_id: INTEGER
			-- Type ID of the inspected object.
			-- 0 if the object is special.

feature -- Update

	send is
			-- Send inpect request to application.
		local
			count: INTEGER
			address: POINTER
		do
			object_type_id := 0
			send_rqst_3 (Rqst_sp_lower, 0, sp_lower, sp_upper)
			send_rqst_3 (request_code, In_h_addr, 0, hex_to_integer (object_address))
			is_special := to_boolean (c_tread)
			debug ("DEBUG_RECV")
				io.error.putstring ("Grepping object at address ")
				io.error.putstring (object_address)
				io.error.putstring (".%N")
			end
			object_type_id := to_integer (c_tread) + 1
			if is_special then
				debug ("DEBUG_RECV")
					io.error.putstring ("Oh oooh. This is a special object...%N")
				end;
				create attributes.make
				debug("DEBUG_RECV")
					io.error.putstring ("Getting the attributes from the special object...%N")
					io.error.putstring ("Capacity is ")
					io.error.putint (capacity)
					io.error.putstring (".%N")
					io.error.putstring ("Calling `recv_attributes'.%N")
				end
					-- Even though they are not required in this particular case
					-- where we want to see the special object, we have to retrieve
					-- the address and the count of the special to be consistent
					-- with the way we retrieve a special object in recv_attributes.
				address := to_pointer (c_tread)
				count := to_integer (c_tread)
				recv_attributes (attributes, Void)
				debug ("DEBUG_RECV")
					io.error.putstring ("And being back again in `send'.%N")
				end
			else
				create {SORTED_TWO_WAY_LIST [ABSTRACT_DEBUG_VALUE]} attributes.make

				if Eiffel_system.valid_dynamic_id (object_type_id) then
					recv_attributes (attributes, Eiffel_system.class_of_dynamic_id (object_type_id))
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
				attributes.item.set_hector_addr
				attributes.forth
			end
		end

feature {NONE} -- Implementation

	recv_attributes (attr_list: LINKED_LIST [ABSTRACT_DEBUG_VALUE]; e_class: CLASS_C) is
			-- Receive `e_class attribute info from application and 
			-- store it in `attr_list'.
		local
			attr_name: STRING;
			sk_type: INTEGER
			i, attr_nb: INTEGER;
			attr: ABSTRACT_DEBUG_VALUE;
			exp_attr: EXPANDED_VALUE;
			spec_attr: SPECIAL_VALUE;
			type_id: INTEGER;
		do
			attr_nb := to_integer (c_tread)
			debug("DEBUG_RECV")
				io.error.putstring ("Getting ")
				io.error.putint (attr_nb)
				io.error.putstring (" attributes...%N")
			end
			from
				i := 1
			until
				i > attr_nb
			loop
				attr_name := c_tread
				sk_type := to_integer (c_tread)
				debug("DEBUG_RECV")
					io.error.putstring ("Grepping attribute `");
					io.error.putstring (attr_name);
					io.error.putstring ("' of type ");
					io.error.putint (sk_type);
					io.error.putstring (".%N")
				end
				inspect
					sk_type
				when Sk_bool then
					create {DEBUG_VALUE [BOOLEAN]} attr.make_attribute (attr_name, e_class, to_boolean (c_tread))
				when Sk_char then
					create {CHARACTER_VALUE} attr.make_attribute (attr_name, e_class, to_character (c_tread))
				when Sk_wchar then
					create {DEBUG_VALUE [WIDE_CHARACTER]} attr.make_attribute (attr_name, e_class, to_wide_char (c_tread))
				when Sk_int8 then
					create {DEBUG_VALUE [INTEGER_8]} attr.make_attribute (attr_name, e_class, to_integer_8 (c_tread))
				when Sk_int16 then
					create {DEBUG_VALUE [INTEGER_16]} attr.make_attribute (attr_name, e_class, to_integer_16 (c_tread))
				when Sk_int32 then
					create {DEBUG_VALUE [INTEGER]} attr.make_attribute (attr_name, e_class, to_integer (c_tread))
				when Sk_int64 then
					create {DEBUG_VALUE [INTEGER_64]} attr.make_attribute (attr_name, e_class, to_integer_64 (c_tread))
				when Sk_float then
					create {DEBUG_VALUE [REAL]} attr.make_attribute (attr_name, e_class, to_real (c_tread))
				when Sk_double then
					create {DEBUG_VALUE [DOUBLE]} attr.make_attribute (attr_name, e_class, to_double (c_tread))
				when Sk_pointer then
					create {DEBUG_VALUE [POINTER]} attr.make_attribute (attr_name, e_class, to_pointer (c_tread))
				when Sk_bit then
					create {BITS_VALUE} attr.make_attribute (attr_name, e_class, c_tread)
				when Sk_exp then
					type_id := to_integer (c_tread) + 1;
					create exp_attr.make_attribute (attr_name, e_class, type_id);
					attr := exp_attr;
					if Eiffel_system.valid_dynamic_id (type_id) then
						recv_attributes (exp_attr.attributes,
							Eiffel_system.class_of_dynamic_id (type_id))
					else
						recv_attributes (exp_attr.attributes, Void)
					end;
				when Sk_ref then
						-- Is this a special object?
					if to_boolean (c_tread) then
						debug("DEBUG_RECV")
							io.error.putstring ("Creating special object.%N")
						end
						create spec_attr.make_attribute (attr_name, e_class, to_pointer (c_tread).out, to_integer (c_tread))
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
							-- Is this a void object?
						if not to_boolean (c_tread) then	
							type_id := to_integer (c_tread) + 1
							create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class, 
														type_id, to_pointer (c_tread).out)
						else
							create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class, 
														type_id, Void)
						end
					end
				else
						-- We should never go through this path.
					check False end
				end
				debug("DEBUG_RECV")
					io.error.putstring ("Putting `attr' in `attr_list'.%N")
				end;
				attr.set_item_number(i-1)
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

feature {NONE} -- Implementation

	to_boolean (s: STRING): BOOLEAN is
			-- Convert binary boolean enclosed in `s' into an BOOLEAN.
		require
			s_not_void: s /= Void
			valid_string: s.count = Boolean_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Boolean_bytes)
		end

	to_character (s: STRING): CHARACTER is
			-- Convert binary character enclosed in `s' into an CHARACTER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Character_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Character_bytes);
		end

	to_wide_char (s: STRING): WIDE_CHARACTER is
			-- Convert binary wide_char enclosed in `s' into an WIDE_CHARACTER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Wide_character_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Wide_character_bytes)
		end

	to_integer_8 (s: STRING): INTEGER_8 is
			-- Convert binary integer_8 enclosed in `s' into an INTEGER_8.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_8_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_8_bytes)
		end

	to_integer_16 (s: STRING): INTEGER_16 is
			-- Convert binary integer_16 enclosed in `s' into an INTEGER_16.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_16_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_16_bytes)
		end

	to_integer (s: STRING): INTEGER is
			-- Convert binary integer enclosed in `s' into an INTEGER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_bytes)
		end

	to_integer_64 (s: STRING): INTEGER_64 is
			-- Convert binary integer_64 enclosed in `s' into an INTEGER_64.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_64_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_64_bytes)
		end

	to_pointer (s: STRING): POINTER is
			-- Convert binary pointer enclosed in `s' into a POINTER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Pointer_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Pointer_bytes)
		end

	to_real (s: STRING): REAL is
			-- Convert binary double enclosed in `s' into a DOUBLE.
		require
			s_not_void: s /= Void
			valid_string: s.count = Real_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Real_bytes)
		end

	to_double (s: STRING): DOUBLE is
			-- Convert binary double enclosed in `s' into a DOUBLE.
		require
			s_not_void: s /= Void
			valid_string: s.count = Double_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Double_bytes)
		end

end -- class ATTR_REQUEST
