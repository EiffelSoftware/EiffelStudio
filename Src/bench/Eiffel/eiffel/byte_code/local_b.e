indexing
	description: "Info about access to a local variable of a feature"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_B 

inherit
	ACCESS_B
		redefine
			enlarged, read_only, is_local, is_creatable,
			make_byte_code, register_name,
			creation_access, print_register,
			assign_code, expanded_assign_code, reverse_code,
			make_end_assignment, make_end_reverse_assignment,
			bit_assign_code, assigns_to, array_descriptor,
			pre_inlined_code, is_separate, generate_il_call_access
		end
	
feature 

	position: INTEGER
			-- Position of the local in the list `locals' of the root 
			-- byte code

	read_only: BOOLEAN is false
			-- Is the access only a read-only one ?

	type: TYPE_I is
			-- Local type
		do
			Result := context.byte_code.locals.item (position)
		end

	is_local: BOOLEAN is
			-- Is Current an access to a local variable ?
		do
			Result := True
		end

	is_creatable: BOOLEAN is True
			-- Can an access to a local variable be the target for
			-- a creation ?

	creation_access (t: TYPE_I): LOCAL_CR_B is
			-- Creation access for a local variable
		do
			!!Result.make (t)
			Result.set_position (position)
		end

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			local_b: LOCAL_B
		do
			local_b ?= other
			if local_b /= Void then
				Result := position = local_b.position
			end
		end

	enlarged: LOCAL_B is
			-- Enlarge current node
		local
			loc_bl: LOCAL_BL
		do
			!!loc_bl
			loc_bl.fill_from (Current)
			Result := loc_bl
		end

	register_name: STRING is
			-- The "loc<num>" string
		do
			!! Result.make (10)
			Result.append ("loc")
			Result.append (position.out)
		end

	print_register is
			-- Print local
		do
			buffer.putstring (register_name)
		end

feature -- IL code generation

	generate_il_call_access (is_target_of_call: BOOLEAN) is
			-- Generate IL code for an access to a local variable.
		do
			if is_target_of_call and then real_type (type).is_expanded then
				il_generator.generate_local_address (position)
			else
				il_generator.generate_local (position)
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an access to a local variable.
		do
			ba.append (Bc_local)
			ba.append_short_integer (position)
		end

	make_end_assignment (ba: BYTE_ARRAY) is
			-- Finish the assignment to the current access
		do
			ba.append_short_integer (position)
		end

	bit_assign_code: CHARACTER is
			-- Bits assignment code 
		do
			Result := Bc_lbit_assign
		end

	assign_code: CHARACTER is
			-- Simple assignment code
		do
			Result := Bc_lassign
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code
		do
			Result := Bc_lexp_assign
		end

	make_end_reverse_assignment (ba: BYTE_ARRAY) is
			-- Generate reverse assignment byte code
		do
			ba.append_short_integer (position)
		end

	reverse_code: CHARACTER is
			-- Reverse assignment code
		do
			Result := Bc_lreverse
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := position = - i
		end

	array_descriptor: INTEGER is
		do
			Result := -position
		end

feature -- Inlining

	pre_inlined_code: INLINED_LOCAL_B is
		do
			!!Result
			Result.fill_from (Current)
		end

feature -- Concurrent Eiffel

	is_separate: BOOLEAN is
			-- Local type
		do
			Result := context.byte_code.locals.item(position).is_separate
		end

feature -- Setting

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		require
			valid_index: i > 0
		do
			position := i
		ensure
			position_set: position = i
		end

end
