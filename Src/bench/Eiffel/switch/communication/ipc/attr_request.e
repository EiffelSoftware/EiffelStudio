-- Request for attributes' value of an object

class ATTR_REQUEST

inherit
	DEBUG_VALUE_EXPORTER

	SHARED_ABSTRACT_DEBUG_VALUE_SORTER

	EWB_REQUEST
		rename
			make as old_make
		export 
			{NONE} all
		redefine
			send
		end
		
	BEURK_HEXER
		export 
			{NONE} all
		end
		
	BASIC_ROUTINES
		export 
			{NONE} all
		end
		
	SHARED_EIFFEL_PROJECT
		export 
			{NONE} all
		end

	PLATFORM
		export 
			{NONE} all
		end

	SK_CONST
		export 
			{NONE} all
		end	

	REFACTORING_HELPER
		export
			{NONE} all
		end

create

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

	attributes: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE];
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
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			object_type_id := 0
			send_rqst_3_integer (Rqst_sp_lower, 0, sp_lower, sp_upper)
			send_rqst_3 (request_code, In_h_addr, 0, hex_to_pointer (object_address))
			is_special := to_boolean (c_tread)
			is_tuple := to_boolean (c_tread)
			debug ("DEBUG_RECV")
				io.error.put_string ("Grepping object at address ")
				io.error.put_string (object_address)
				io.error.put_string (".%N")
				io.error.put_string ("Object is a special? ")
				io.error.put_boolean (is_special)
				io.error.put_new_line
				io.error.put_string ("Object is a tuple? ")
				io.error.put_boolean (is_tuple)
				io.error.put_new_line
			end
			object_type_id := to_integer (c_tread) + 1
			if is_special then
				debug ("DEBUG_RECV")
					if is_tuple then
						io.error.put_string ("Oh oooh. This is a TUPLE object...%N")
					else
						io.error.put_string ("Oh oooh. This is a special object...%N")
					end
				end;
				create attributes.make (capacity)
				debug("DEBUG_RECV")
					io.error.put_string ("Getting the attributes from object...%N")
					io.error.put_string ("Capacity is ")
					io.error.put_integer (capacity)
					io.error.put_string (".%N")
					io.error.put_string ("Calling `recv_attributes'.%N")
				end
					-- Even though they are not required in this particular case
					-- where we want to see the special object, we have to retrieve
					-- the address and the count of the special to be consistent
					-- with the way we retrieve a special object in recv_attributes.
				address := to_pointer (c_tread)
				capacity := to_integer (c_tread)
				recv_attributes (attributes, Void)
				debug ("DEBUG_RECV")
					io.error.put_string ("And being back again in `send'.%N")
				end
			else
				create attributes.make (capacity)
				if Eiffel_system.valid_dynamic_id (object_type_id) then
					recv_attributes (attributes, Eiffel_system.class_of_dynamic_id (object_type_id))
				else
					recv_attributes (attributes, Void)
				end;
				sort_debug_values (attributes)
			end
				-- Convert the physical addresses received from
				-- the application to hector addresses.
			from
				l_cursor := attributes.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_cursor.item.set_hector_addr
				l_cursor.forth
			end
		end

feature {NONE} -- Implementation

	recv_attributes (attr_list: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]; e_class: CLASS_C) is
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
			p: POINTER			
		do
			attr_nb := to_integer (c_tread)
			if attr_list.capacity <= attr_nb then
				attr_list.resize (attr_nb)
			end
			debug("DEBUG_RECV")
				io.error.put_string ("Getting ")
				io.error.put_integer (attr_nb)
				io.error.put_string (" attributes ...")
				if e_class /= Void then
					io.error.put_string (" (related to e_class = " + e_class.name_in_upper + ") ")
				end
				io.error.put_new_line
			end
			from
				i := 1
			until
				i > attr_nb
			loop
				attr_name := c_tread
				sk_type := to_integer (c_tread)
				debug("DEBUG_RECV")
					io.error.put_string ("Grepping attribute `");
					io.error.put_string (attr_name);
					io.error.put_string ("' of type ");
					io.error.put_string ("0x" + sk_type.to_hex_string)
					io.error.put_new_line
				end
				inspect
					sk_type
				when Sk_bool then
					create {DEBUG_VALUE [BOOLEAN]} attr.make_attribute (sk_type, attr_name, e_class, to_boolean (c_tread))
				when Sk_char then
					create {CHARACTER_VALUE} attr.make_attribute (sk_type, attr_name, e_class, to_character (c_tread))
				when Sk_wchar then
					create {DEBUG_VALUE [WIDE_CHARACTER]} attr.make_attribute (sk_type, attr_name, e_class, to_wide_char (c_tread))
				when Sk_uint8 then
					create {DEBUG_VALUE [NATURAL_8]} attr.make_attribute (sk_type, attr_name, e_class, to_natural_8 (c_tread))
				when Sk_uint16 then
					create {DEBUG_VALUE [NATURAL_16]} attr.make_attribute (sk_type, attr_name, e_class, to_natural_16 (c_tread))
				when Sk_uint32 then
					create {DEBUG_VALUE [NATURAL_32]} attr.make_attribute (sk_type, attr_name, e_class, to_natural_32 (c_tread))
				when Sk_uint64 then
					create {DEBUG_VALUE [NATURAL_64]} attr.make_attribute (sk_type, attr_name, e_class, to_natural_64 (c_tread))
				when Sk_int8 then
					create {DEBUG_VALUE [INTEGER_8]} attr.make_attribute (sk_type, attr_name, e_class, to_integer_8 (c_tread))
				when Sk_int16 then
					create {DEBUG_VALUE [INTEGER_16]} attr.make_attribute (sk_type, attr_name, e_class, to_integer_16 (c_tread))
				when Sk_int32 then
					create {DEBUG_VALUE [INTEGER]} attr.make_attribute (sk_type, attr_name, e_class, to_integer (c_tread))
				when Sk_int64 then
					create {DEBUG_VALUE [INTEGER_64]} attr.make_attribute (sk_type, attr_name, e_class, to_integer_64 (c_tread))
				when Sk_real32 then
					create {DEBUG_VALUE [REAL]} attr.make_attribute (sk_type, attr_name, e_class, to_real (c_tread))
				when Sk_real64 then
					create {DEBUG_VALUE [DOUBLE]} attr.make_attribute (sk_type, attr_name, e_class, to_double (c_tread))
				when Sk_pointer then
					create {DEBUG_VALUE [POINTER]} attr.make_attribute (sk_type, attr_name, e_class, to_pointer (c_tread))
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
					--| FIXME JFIAT: we need to sort it right away to keep same behavior
					sort_debug_values (exp_attr.attributes)
					
				when Sk_ref then
						-- Is this a special object?
					if to_boolean (c_tread) then
							-- Is this a tuple object?
						if to_boolean (c_tread) then
							type_id := to_integer (c_tread) + 1
							create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class, 
								type_id, to_pointer (c_tread).out)
						else
							debug("DEBUG_RECV")
								io.error.put_string ("Creating special object.%N")
							end
							p := to_pointer (c_tread)
							create spec_attr.make_attribute (attr_name, e_class, p.out, to_integer (c_tread))
							debug("DEBUG_RECV")
								io.error.put_string ("Attribute name: ");
								io.error.put_string (attr_name);
								io.error.put_new_line;
								io.error.put_string ("The eiffel class: ");
								io.error.put_string (e_class.name_in_upper);
								io.error.put_new_line
							end;
							if sp_upper = -1 then
								spec_attr.set_sp_bounds (sp_lower, spec_attr.capacity);
							else
								spec_attr.set_sp_bounds (sp_lower, sp_upper);
							end;
							max_capacity := max_capacity.max (spec_attr.capacity);
							attr := spec_attr;
								-- We don't get anymore the special items at this step
						end
					else
							-- Is this a void object?
						if not to_boolean (c_tread) then	
							type_id := to_integer (c_tread) + 1
							create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class, 
														type_id, to_pointer (c_tread).out)
						else
							create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class, 
														0, Void)
						end
					end
				else
						-- We should never go through this path.
					check False end
					debug ("DEBUG_RECV")
						io.error.put_string ("Should never go there!!")
					end
				end
				debug("DEBUG_RECV")
					io.error.put_string ("Putting `attr' in `attr_list'.%N")
				end;
				attr.set_item_number(i-1)
				attr_list.put_last (attr);
--				attr_list.forth
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
			
	is_tuple: BOOLEAN
			-- Is object being inspected of type TUPLE?

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

	to_natural_8 (s: STRING): NATURAL_8 is
			-- Convert binary integer_8 enclosed in `s' into an NATURAL_8.
		require
			s_not_void: s /= Void
			valid_string: s.count = natural_8_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, natural_8_bytes)
		end

	to_natural_16 (s: STRING): NATURAL_16 is
			-- Convert binary integer_16 enclosed in `s' into an NATURAL_16.
		require
			s_not_void: s /= Void
			valid_string: s.count = natural_16_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, natural_16_bytes)
		end

	to_natural_32 (s: STRING): NATURAL_32 is
			-- Convert binary integer enclosed in `s' into an NATURAL.
		require
			s_not_void: s /= Void
			valid_string: s.count = natural_32_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, natural_32_bytes)
		end

	to_natural_64 (s: STRING): NATURAL_64 is
			-- Convert binary integer_64 enclosed in `s' into an NATURAL_64.
		require
			s_not_void: s /= Void
			valid_string: s.count = natural_64_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, natural_64_bytes)
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
