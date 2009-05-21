note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			{RECV_VALUE} reset_recv_value
		redefine
			send
		end

	HEXADECIMAL_STRING_CONVERTER
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

	SK_CONST
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	COMPILER_EXPORTER

create

	make

feature -- Initialization

	make (addr: like object_address)
		require
			valid_addr: addr /= Void and then not addr.is_void
		do
			old_make (Rqst_inspect)
			object_address := addr
		end;

feature -- Properites

	object_address: DBG_ADDRESS;
			-- Hector address of object being inspected

	attributes: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE];
			-- Attributes of object being inspected (sorted by name)

	object_type_id: INTEGER
			-- Type ID of the inspected object.
			-- 0 if the object is special.

feature -- Update

	send
			-- Send inpect request to application.
		local
			address: POINTER
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			object_type_id := 0
			send_rqst_3_integer (Rqst_sp_lower, 0, sp_lower, sp_upper)
			send_rqst_3 (request_code, In_h_addr, 0, object_address.as_pointer)
			is_special := to_boolean (c_tread)
			is_tuple := to_boolean (c_tread)
			object_type_id := to_integer_32 (c_tread) + 1
			if object_type_id <= 0 then
					--| Error occurred
				debug ("DEBUG_RECV")
					io.error.put_string ("Grepping object at address ")
					io.error.put_string (object_address.output)
					io.error.put_string (".%N")
					io.error.put_string ("Error occurred !")
					io.error.put_string (" object_type_id=" + object_type_id.out)
					io.error.put_new_line
				end
				create attributes.make (0)
			else
				debug ("DEBUG_RECV")
					io.error.put_string ("Grepping object at address ")
					io.error.put_string (object_address.output)
					io.error.put_string (".%N")
					io.error.put_string ("Object is a special? ")
					io.error.put_boolean (is_special)
					io.error.put_new_line
					io.error.put_string ("Object is a tuple? ")
					io.error.put_boolean (is_tuple)
					io.error.put_new_line
				end
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
					capacity := to_integer_32 (c_tread) --| Count
					max_capacity := to_integer_32 (c_tread) --| Capacity
					recv_attributes (attributes, Void, True)
					debug ("DEBUG_RECV")
						io.error.put_string ("And being back again in `send'.%N")
					end
				else
					create attributes.make (capacity)
					if Eiffel_system.valid_dynamic_id (object_type_id) then
						recv_attributes (attributes, Eiffel_system.class_of_dynamic_id (object_type_id, False), False)
					else
						recv_attributes (attributes, Void, False)
					end
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
		end

feature {NONE} -- Implementation

	recv_attributes (attr_list: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]; e_class: CLASS_C; container_is_special: BOOLEAN)
			-- Receive `e_class attribute info from application and
			-- store it in `attr_list'.
		local
			s: STRING
			attr_name: STRING
			sk_type: INTEGER
			i, attr_nb: INTEGER
			attr: ABSTRACT_DEBUG_VALUE
			exp_attr: EXPANDED_VALUE
			spec_attr: SPECIAL_VALUE
			type_id: INTEGER
			p: POINTER
			i1,i2: INTEGER
		do
			s := c_tread
			if is_valid_integer_32_string (s) then
				attr_nb := to_integer_32 (s)
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
					s := c_tread
					if is_valid_integer_32_string (s) then
						sk_type := to_integer_32 (s)
					else
						sk_type := 0
					end

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
						create {DEBUG_BASIC_VALUE [BOOLEAN]} attr.make_attribute (sk_type, attr_name, e_class, to_boolean (c_tread))
					when Sk_char then
						create {CHARACTER_VALUE} attr.make_attribute (sk_type, attr_name, e_class, to_character_8 (c_tread))
					when Sk_wchar then
						create {CHARACTER_32_VALUE} attr.make_attribute (sk_type, attr_name, e_class, to_character_32 (c_tread))
					when Sk_uint8 then
						create {DEBUG_BASIC_VALUE [NATURAL_8]} attr.make_attribute (sk_type, attr_name, e_class, to_natural_8 (c_tread))
					when Sk_uint16 then
						create {DEBUG_BASIC_VALUE [NATURAL_16]} attr.make_attribute (sk_type, attr_name, e_class, to_natural_16 (c_tread))
					when Sk_uint32 then
						create {DEBUG_BASIC_VALUE [NATURAL_32]} attr.make_attribute (sk_type, attr_name, e_class, to_natural_32 (c_tread))
					when Sk_uint64 then
						create {DEBUG_BASIC_VALUE [NATURAL_64]} attr.make_attribute (sk_type, attr_name, e_class, to_natural_64 (c_tread))
					when Sk_int8 then
						create {DEBUG_BASIC_VALUE [INTEGER_8]} attr.make_attribute (sk_type, attr_name, e_class, to_integer_8 (c_tread))
					when Sk_int16 then
						create {DEBUG_BASIC_VALUE [INTEGER_16]} attr.make_attribute (sk_type, attr_name, e_class, to_integer_16 (c_tread))
					when Sk_int32 then
						create {DEBUG_BASIC_VALUE [INTEGER]} attr.make_attribute (sk_type, attr_name, e_class, to_integer_32 (c_tread))
					when Sk_int64 then
						create {DEBUG_BASIC_VALUE [INTEGER_64]} attr.make_attribute (sk_type, attr_name, e_class, to_integer_64 (c_tread))
					when Sk_real32 then
						create {DEBUG_BASIC_VALUE [REAL]} attr.make_attribute (sk_type, attr_name, e_class, to_real_32 (c_tread))
					when Sk_real64 then
						create {DEBUG_BASIC_VALUE [DOUBLE]} attr.make_attribute (sk_type, attr_name, e_class, to_real_64 (c_tread))
					when Sk_pointer then
						create {DEBUG_BASIC_VALUE [POINTER]} attr.make_attribute (sk_type, attr_name, e_class, to_pointer (c_tread))
					when Sk_bit then
						create {BITS_VALUE} attr.make_attribute (attr_name, e_class, c_tread)
					when Sk_exp then
						type_id := to_integer_32 (c_tread) + 1;
						if container_is_special then
							--| If expanded contained in SPECIAL, it doesn't have a specific (hector) address
							--| and is only addressed via the SPECIAL object and the index
							--| Then in this case we receive its attributes right away
							create exp_attr.make_attribute_of_special (attr_name, e_class, type_id)
							attr := exp_attr
							if Eiffel_system.valid_dynamic_id (type_id) then
								recv_attributes (exp_attr.attributes, Eiffel_system.class_of_dynamic_id (type_id, False), False)
							else
								recv_attributes (exp_attr.attributes, Void, False)
							end;
								--| FIXME JFIAT: we need to sort it right away to keep same behavior
							sort_debug_values (exp_attr.attributes)
						else
							p := to_pointer (c_tread)
							create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class, type_id, create {DBG_ADDRESS}.make_from_pointer (p));
						end
					when Sk_ref then
							-- Is this a special object?
						if to_boolean (c_tread) then
								-- Is this a tuple object?
							if to_boolean (c_tread) then
								type_id := to_integer_32 (c_tread) + 1
								create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class,
									type_id, create {DBG_ADDRESS}.make_from_pointer (to_pointer (c_tread)))
							else
								debug("DEBUG_RECV")
									io.error.put_string ("Creating SPECIAL object.%N")
								end
								p := to_pointer (c_tread)
								i1 := to_integer_32 (c_tread)
								i2 := to_integer_32 (c_tread)
								create spec_attr.make_attribute (attr_name, e_class, create {DBG_ADDRESS}.make_from_pointer (p), i1, i2)
								debug("DEBUG_RECV")
									io.error.put_string ("Attribute name: ");
									io.error.put_string (attr_name);
									io.error.put_new_line;
									if e_class /= Void then
										io.error.put_string ("The eiffel class: ");
										io.error.put_string (e_class.name_in_upper);
										io.error.put_new_line
									end
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
								type_id := to_integer_32 (c_tread) + 1
								create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class,
															type_id, create {DBG_ADDRESS}.make_from_pointer (to_pointer (c_tread)))
							else
								create {REFERENCE_VALUE} attr.make_attribute (attr_name, e_class,
															0, create {DBG_ADDRESS}.make_void)
							end
						end
					else
							-- We should never go through this path.
						create {DUMMY_MESSAGE_DEBUG_VALUE} attr.make_with_details (attr_name, "Error while retrieving value's type", 0)
						debug ("DEBUG_RECV")
							io.error.put_string ("Should never go there!!")
						end
					end
					if attr = Void then
						create {DUMMY_MESSAGE_DEBUG_VALUE} attr.make_with_details (attr_name, "Error while retrieving value", 0)
					end

					debug("DEBUG_RECV")
						io.error.put_string ("Putting `attr' in `attr_list'.%N")
					end
					attr.set_item_number (i-1)
					attr_list.put_last (attr);
--					attr_list.forth
					i := i + 1
				end
			else
				debug("DEBUG_RECV")
					io.error.put_string ("Error while retrieving attributes: invalid attribute count representation")
					io.error.put_new_line
				end
			end
		end

feature -- Special object properties

	sp_lower, sp_upper: INTEGER;
			-- Bounds for special object inspection
			-- A negative value for `sp_upper' stands for the
			-- upper bound of the inspected special object

	set_sp_bounds (l, u: INTEGER)
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

	is_tuple: BOOLEAN;
			-- Is object being inspected of type TUPLE?

invariant
	object_address_attached: object_address /= Void and then not object_address.is_void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ATTR_REQUEST
