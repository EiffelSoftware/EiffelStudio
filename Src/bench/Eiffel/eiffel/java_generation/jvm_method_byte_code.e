indexing
	description: "byte code for actual executable code (as opposed to meta data).%
                % this class has all the features neccessary to add %
                %the actual executable code"
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_METHOD_BYTE_CODE

inherit
	
	JVM_BYTE_CODE
		redefine
			make,
			emit
		end
	
	JVM_NAME_CONVERTER
			
	IL_CONST
	
	JVM_OPCODES
	
create
	make

feature
				
	make is
		-- create the object
		do
			Precursor
			create stack.make
			create label_marks.make
			create labels.make (1, 0)
		end
				
	emit (file: RAW_FILE) is
			-- append it to a file
		local
			t: SPECIAL [CHARACTER]
		do
			t := area
			Precursor (file)
		end

feature {ANY} -- Stack
				
	stack: JVM_TYPE_STACK
			-- reflects the stack at any time
			-- but instead of holding the actual values it holds the jvm
			-- type ids instead (JVM_CONSTANS.*_type)
			
feature {ANY} -- Post label processing
 	
	label_marks: LINKED_LIST [JVM_LABEL_MARK]
			-- all the label marks set for this method
				
	labels: ARRAY [JVM_LABEL]
			-- all the labels created for this method
			-- items index = label id

	all_labels_closed: BOOLEAN is
			-- Returns True only if all items in `labels' are closed
		local
			i: INTEGER
		do
			from
				i := labels.lower
				Result := True
			until
				i > labels.upper
			loop
				if
					labels.item (i).is_open
				then
					Result := False
				end
				i := i + 1
			end
		end

	process_label_marks is
			-- since the jump offset of forward jumps cannot be known at 
			-- the time when we should write the offset, we put in only 
			-- a placeholder and remmeber it's position (`label_marks').
			-- after code generation this feature replaces all the marks 
			-- with the actual offset, that now can be computed 
			-- (difference between mark and label)
		require
			labels_closed: all_labels_closed
		local
			offset: INTEGER
		do
			from
				label_marks.start
			until
				label_marks.off
			loop
				-- we add 1 to label_marks.item.byte_code_position
				-- because it it points to the jump instruciton
				-- and not to the offset
				offset := label_marks.item.byte_code_position + 1
				check
					offset_positive: offset >= -32768
					offset_small_enough: offset <= 32767
								-- if one of those checks raises an exception we have
								-- a problem. for some jump instructions we can use a
								-- wide offset, for others we cannot. for now all jump
								-- offsets are 16 bit wide. with any luck this should
								-- never be a problem.
				end
													
				put_sint_16_from_int (label_marks.item.jump_offset, offset)
																																																																											
				label_marks.forth
			end
		end


feature {ANY} -- Invokeing methods
	
	append_invoke_default_constructor (type_id: INTEGER) is
			-- append code for:
			-- invoking the default constructor of the object referenced
			-- by the top item of the stack
		require
			stack_size: stack.count > 0
			valid_type: repository.has_by_id (type_id)
			stack_consistent: stack.item = object_type
		do
			append_invoke_constructor_by_type_id ("()V", type_id)
			stack.remove -- object ref
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	
	append_invoke_from_written_feature (f: JVM_WRITTEN_FEATURE) is
			-- appends a invoke with index at the end of
			-- the byte code.
		require
			f_not_void: f /= Void
			f_signature_closed: f.is_signature_closed
			f_valid_for_invoke1: not f.is_field
			f_valid_for_invoke2: not f.is_field_setter
			f_valid_for_invoke3: f.is_method
		do
			if
				f.class_.is_interface
			then
				append_invoke_interface_from_written_feature (f)
			elseif
				f.is_constructor
			then
				append_invoke_special_from_written_feature (f)
			elseif
				f.is_static
			then
				append_invoke_static_from_written_feature (f)
			else
				append_invoke_virtual_from_written_feature (f)
			end
		end
			
	append_invoke_virtual_from_written_feature (f: JVM_WRITTEN_FEATURE) is
			-- appends a invoke with index at the end of
			-- the byte code.
		require
			f_not_void: f /= Void
			f_signature_closed: f.is_signature_closed
			f_valid_for_invoke_virtual1: not f.class_.is_interface
			f_valid_for_invoke_virtual2: not f.is_field
			f_valid_for_invoke_virtual3: not f.is_constructor
			f_valid_for_invoke_virtual4: not f.is_field_setter
			f_valid_for_invoke_virtual5: f.is_method
			f_valid_for_invoke_virtual6: not f.is_static
			stack_size: stack.count >= f.parameter_jvm_type_ids.count + 1
			stack_consisten: stack.i_th (f.parameter_jvm_type_ids.count + 1) = object_type
		local
			i: INTEGER
		do
			append_opcode (oc_invokevirtual)
			constant_pool.put_feature_by_object (f)
			append_feature (constant_pool.last_cpe_index)
						-- Stack regulation
						-- remove obj ref
			stack.remove -- obj ref
			from
				i := f.parameter_jvm_type_ids.lower
			until
				i > f.parameter_jvm_type_ids.upper
			loop
				stack.remove -- parameters
				i := i + 1
			end
			if
				f.return_jvm_type_id /= void_type
			then
				stack.extend (jvm_type_to_stack (f.return_jvm_type_id)) -- result value
			end
		ensure
			stack_dec1: not f.has_non_void_return_type implies stack.count + f.parameter_jvm_type_ids.count + 1 = old stack.count
			stack_dec1: f.has_non_void_return_type implies stack.count + f.parameter_jvm_type_ids.count = old stack.count
			stack_consistent: f.has_non_void_return_type implies stack.count >= 1 and then stack.item = jvm_type_to_stack (f.return_jvm_type_id)
		end
			
	append_invoke_special_from_written_feature (f: JVM_WRITTEN_FEATURE) is
			-- appends a invoke special with index at the end of
			-- the byte code.
		require
			f_not_void: f /= Void
			f_signature_closed: f.is_signature_closed
			f_valid_for_invoke_virtual1: not f.class_.is_interface
			f_valid_for_invoke_virtual3: f.is_constructor
			f_valid_for_invoke_virtual2: not f.is_field
			f_valid_for_invoke_virtual5: f.is_method
			f_valid_for_invoke_virtual6: not f.is_static
			stack_size: stack.count >= f.parameter_jvm_type_ids.count + 1
			stack_consisten: stack.i_th (f.parameter_jvm_type_ids.count + 1) = object_type
		local
			i: INTEGER
		do
			append_opcode (oc_invokespecial)
			constant_pool.put_feature_by_object (f)
			append_feature (constant_pool.last_cpe_index)
						-- Stack regulation
						-- remove obj ref
			stack.remove -- obj ref
			from
				i := f.parameter_jvm_type_ids.lower
			until
				i > f.parameter_jvm_type_ids.upper
			loop
				stack.remove -- parameters
				i := i + 1
			end
			if
				f.return_jvm_type_id /= void_type
			then
				stack.extend (jvm_type_to_stack (f.return_jvm_type_id)) -- result value
			end
		ensure
			stack_dec1: not f.has_non_void_return_type implies stack.count + f.parameter_jvm_type_ids.count + 1 = old stack.count
			stack_dec1: f.has_non_void_return_type implies stack.count + f.parameter_jvm_type_ids.count = old stack.count
			stack_consistent: f.has_non_void_return_type implies stack.count >= 1 and then stack.item = jvm_type_to_stack (f.return_jvm_type_id)
		end
			
	append_invoke_static_from_written_feature (f: JVM_WRITTEN_FEATURE) is
			-- appends a invoke static with index at the end of
			-- the byte code.
		require
			f_not_void: f /= Void
			f_signature_closed: f.is_signature_closed
			f_valid_for_invoke_virtual3: not f.is_constructor
			f_valid_for_invoke_virtual1: not f.class_.is_interface
			f_valid_for_invoke_virtual2: not f.is_field
			f_valid_for_invoke_virtual5: f.is_method
			f_valid_for_invoke_virtual6: f.is_static
			stack_size: stack.count >= f.parameter_jvm_type_ids.count
		local
			i: INTEGER
		do
			append_opcode (oc_invokestatic)
			constant_pool.put_feature_by_object (f)
			append_feature (constant_pool.last_cpe_index)
						-- Stack regulation
			from
				i := f.parameter_jvm_type_ids.lower
			until
				i > f.parameter_jvm_type_ids.upper
			loop
				stack.remove -- parameters
				i := i + 1
			end
			if
				f.return_jvm_type_id /= void_type
			then
				stack.extend (jvm_type_to_stack (f.return_jvm_type_id)) -- result value
			end
		ensure
			stack_dec1: not f.has_non_void_return_type implies stack.count + f.parameter_jvm_type_ids.count = old stack.count
			stack_dec1: f.has_non_void_return_type implies stack.count + f.parameter_jvm_type_ids.count - 1= old stack.count
			stack_consistent: f.has_non_void_return_type implies stack.count >= 1 and then stack.item = jvm_type_to_stack (f.return_jvm_type_id)
		end
			
	append_invoke_interface_from_written_feature (f: JVM_WRITTEN_FEATURE) is
			-- appends a invoke static with index at the end of
			-- the byte code.
		require
			f_not_void: f /= Void
			f_signature_closed: f.is_signature_closed
			f_valid_for_invoke_virtual3: not f.is_constructor
			f_valid_for_invoke_virtual1: f.class_.is_interface
			f_valid_for_invoke_virtual2: not f.is_field
			f_valid_for_invoke_virtual5: f.is_method
			f_valid_for_invoke_virtual6: not f.is_static
			stack_size: stack.count >= f.parameter_jvm_type_ids.count + 1
			stack_consisten: stack.i_th (f.parameter_jvm_type_ids.count + 1) = object_type
		local
			i: INTEGER
		do
			append_opcode (oc_invokeinterface)
			constant_pool.put_feature_by_object (f)
			append_feature (constant_pool.last_cpe_index)
			append_uint_8_from_int (f.parameter_jvm_type_ids.count + 1)
			append_uint_8_from_int (0)
						-- Stack regulation
						-- remove obj ref
			stack.remove -- obj ref
			from
				i := 1
			until
				i > f.parameter_jvm_type_ids.count
			loop
				stack.remove -- parameters
				i := i + 1
			end
			if
				f.return_jvm_type_id /= void_type
			then
				stack.extend (jvm_type_to_stack (f.return_jvm_type_id)) -- result value
			end
		ensure
			stack_dec1: not f.has_non_void_return_type implies stack.count + f.parameter_jvm_type_ids.count + 1 = old stack.count
			stack_dec1: f.has_non_void_return_type implies stack.count + f.parameter_jvm_type_ids.count = old stack.count
			stack_consistent: f.has_non_void_return_type implies stack.count >= 1 and then stack.item = jvm_type_to_stack (f.return_jvm_type_id)
		end
						
			
	append_invoke (f: JVM_FEATURE) is
			-- appends a invoke opcode with index at the end of
			-- the byte code.
		require
			f_not_void: f /= Void
		local
			wf: JVM_WRITTEN_FEATURE
			rf: JVM_REFLECTED_FEATURE
		do
			wf ?= f
			if
				wf = Void
			then
				rf ?= f
				check
					rf_not_void: rf /= Void
				end
				wf := rf.written_feature
			end
			check
				wf_not_void: wf /= Void
			end
			append_invoke_from_written_feature (wf)
		end
			
	append_invoke_from_feature_id (type_id, feature_id: INTEGER) is
			-- appends a invoke opcode with index at the end of
			-- the byte code.
			-- based on the information of `type_id' + `feature_id'
			-- either invokevirtual, invokestatic, invokespecial or
			-- invokeinterface will be called. (TODO: for now only
			-- invokevirtual is called)
		require
			valid_type_id: repository.has_by_id (type_id)
			valid_feature_id: repository.is_valid_feature_id (type_id, feature_id)
		do
			append_invoke (repository.item (type_id).features.item (feature_id))
		end
			

feature {ANY} -- Pushing manfest constants on the stack
	append_push_default_value (jvm_type_id: INTEGER) is
			-- append code for
			-- push the default value for the jvm type `jvm_type_id' 
			-- onto the stack
		require
			valid_jvm_type: valid_jvm_type (jvm_type_id)
		do
			inspect
				jvm_type_id
			when void_type then 
				check False end
			when object_type then 
				append_push_null
			when int_type, byte_type, short_type, bool_type, char_type then
				append_push_manifest_int (0)
			when long_type then
				append_push_manifest_long_from_int (0)
			when float_type then
				append_push_manifest_float (0)
			when double_type then
				append_push_manifest_double (0)
			else
				check
					dead_end: False
				end
			end
		ensure
			stack_size: stack.count - 1 = old stack.count
			stack_consistent: stack.item = jvm_type_to_stack (jvm_type_id)
		end

		append_push_null is
			-- appends the code for:
			-- putting null on the top of the stack
		do
			append_opcode (oc_aconst_null)
			stack.extend (object_type)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_type: stack.item = object_type
		end
						
	append_push_manifest_string (s: STRING) is
			-- appends code for:
			-- putting a manifest string on top of the stack
			-- (Actually an index to an entry in the constant pool is pushed)
		require
			s_not_void: s /= Void
		do
			append_opcode (oc_ldc_w)
			append_string_constant_wide_index (s)
			stack.extend (object_type)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_type: stack.item = object_type
		end
			
	append_push_manifest_double (d: DOUBLE) is
			-- appends code for:
			-- putting a manifest double (as defined by java double)  on top of the stack
			-- Note: `append_double_constant' does not seem to work. FIXME
		do
			append_opcode (oc_ldc2_w)
			append_double_constant (d)
			stack.extend (double_type)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_type: stack.item = double_type
		end
			
	append_push_manifest_float (f: REAL) is
			-- appends code for:
			-- putting a manifest float (as defined by java float) on top of the stack
		do
			append_opcode (oc_ldc_w)
			append_float_constant (f)
			stack.extend (float_type)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_type: stack.item = float_type
		end
			
	append_push_manifest_int (i: INTEGER) is
			-- appends code for:
			-- putting a manifest int (as defined by java int)  on top of the stack
		do
			inspect
				i
			when -1 then
				append_opcode (oc_iconst_m1)
			when 0 then
				append_opcode (oc_iconst_0)
			when 1 then
				append_opcode (oc_iconst_1)
			when 2 then
				append_opcode (oc_iconst_2)
			when 3 then
				append_opcode (oc_iconst_3)
			when 4 then
				append_opcode (oc_iconst_4)
			when 5 then
				append_opcode (oc_iconst_5)
			else
				append_opcode (oc_ldc_w)
				append_int_32_constant (i)
			end
			stack.extend (int_type)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_type: stack.item = int_type
		end
			
	append_push_manifest_long_from_int (i: INTEGER) is
			-- appends code for:
			-- putting a manifest long (as defined by java long)  on top of the stack
			-- note: this takes up 2 stack words on the jvm, while on 
			-- the type stack any item is only one entry
		do
			inspect
				i
			when 0 then
				append_opcode (oc_lconst_0)
			when 1 then
				append_opcode (oc_lconst_1)
			else
				append_opcode (oc_ldc2_w)
				append_int_64_constant_from_int (i)
			end
			stack.extend (long_type)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_type: stack.item = long_type
		end

feature {ANY} -- local variables
	
	append_pop_into_local (slot, jvm_type: INTEGER) is
			-- appends code for:
			-- pops the top item of the stack into the jvm local variable `slot'
			-- jvm_type is the type variable in the slot
			-- This can either be the same type as stack.item or
			-- a compatible one. In the latter case the top item on the
			-- stack will first be converted to `jvm_type' and then stored
			-- in the slot. In case `jvm_type' is not a first class stack
			-- type (int is one, boolean not i.e.) the value will be
			-- converted (determinded via `jvm_type_to_stack')
		require
			valid_slot: slot >= 0
			stack_size: stack.count > 0
			valid_type: conversion_exists (stack.item, jvm_type_to_stack (jvm_type))
		do
			append_convert_to (jvm_type_to_stack (jvm_type))
												
						-- wide
			append_wide
			inspect
				jvm_type_to_stack (jvm_type)
			when
				object_type
			then
				append_opcode (oc_astore)
			when
				int_type
			then
				append_opcode (oc_istore)
			when
				long_type
			then
				-- lstore
				append_opcode (oc_lstore)
			when
				float_type
			then
				-- fstore
				append_opcode (oc_fstore)
			when
				double_type
			then
				-- dstore
				append_opcode (oc_dstore)
			when
				void_type
			then
				append_opcode (oc_astore)
			else
				check
					dead_end: False
				end
			end
			append_uint_16_from_int (slot)
			stack.remove -- value
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	append_push_from_local (slot, jvm_type: INTEGER) is
			-- appends code for:
			-- pushing the value of the jvm local in slot `slot' onto
			-- the top of the stack
			-- jvm_type is the type of the variable in the slot
		require
			valid_slot: slot >= 0
		do
			-- wide
			append_wide
			inspect
				jvm_type
			when
				object_type
			then
				append_opcode (oc_aload)
				stack.extend (object_type)
			when
				int_type, bool_type
			then
				append_opcode (oc_iload)
				stack.extend (int_type)
			when
				long_type
			then
				append_opcode (oc_lload)
				stack.extend (long_type)
			when
				float_type
			then
				append_opcode (oc_fload)
				stack.extend (float_type)
			when
				double_type
			then
				append_opcode (oc_dload)
				stack.extend (double_type)
			when
				void_type
			then
				check
					cannot_load_void: False
				end
			else
				check
					dead_end: False
				end
			end
			append_uint_16_from_int (slot)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_consistent: stack.item = jvm_type_to_stack (jvm_type)
		end
			
feature {ANY} -- Push and pop fields
	append_pop_field_by_feature_id (type_id, feature_id: INTEGER) is
			-- appends the code for:
			-- poping the top value from the stack into a field (attribute)
			-- of the object referenced by the second topmost value on
			-- the stack
		require
			constant_pool_not_void: constant_pool /= Void
			constant_pool_open: constant_pool.is_open
			valid_type_id: repository.valid_id (type_id)
			valid_feature_type_id: repository.item (type_id).features.valid_index (feature_id)
			feature_is_field: repository.item (type_id).features.item (feature_id).written_feature.is_field
			stack_size_non_static: not repository.item (type_id).features.item (feature_id).written_feature.is_static implies stack.count >= 2
			stack_size_static: repository.item (type_id).features.item (feature_id).written_feature.is_static implies stack.count >= 1
			conversion_exists: conversion_exists (stack.item, repository.item (type_id).features.item (feature_id).written_feature.return_jvm_type_id)
		local
			f: JVM_WRITTEN_FEATURE
		do
			f := repository.item (type_id).features.item (feature_id).written_feature
			if
				f.is_field_setter
			then
				f := f.field
			end
			append_pop_field (f)
		ensure
			stack_dec_static: repository.item (type_id).features.item (feature_id).written_feature.is_static implies stack.count + 1 = old stack.count
			stack_dec_non_static: not repository.item (type_id).features.item (feature_id).written_feature.is_static implies stack.count + 2 = old stack.count
		end
	
	append_pop_field (f: JVM_WRITTEN_FEATURE) is
			-- appends the code for:
			-- poping the top value from the stack into a field (attribute)
			-- of the object referenced by the second topmost value on
			-- the stack
		require
			constant_pool_not_void: constant_pool /= Void
			constant_pool_open: constant_pool.is_open
			f_not_void: f /= Void
			feature_is_field: f.is_field
			stack_size_non_static: f.is_static implies stack.count >= 1
			stack_size_static: not f.is_static implies stack.count >= 2
			conversion_exists: conversion_exists (stack.item, f.return_jvm_type_id)
		do
			-- first we need to check wether the top item on the stack
			-- has the same type as the field we are storing it into.
			-- if that is not the case, we need to do a conversion (if possible)
			append_convert_to (f.return_jvm_type_id)

			if
				f.is_static
			then
				append_opcode (oc_putstatic)
			else
				append_opcode (oc_putfield)
			end
			append_feature_by_object (f)
			stack.remove -- value
			if
				not f.is_static
				then
					stack.remove -- objectref
			end
		ensure
			stack_dec_static: f.is_static implies stack.count + 1 = old stack.count
			stack_dec_non_static: not f.is_static implies stack.count + 2 = old stack.count
		end
	
	append_push_field_by_feature_id (type_id, feature_id: INTEGER) is
			-- appends the code for:
			-- pushing the value (of an object referenced by the topmost
			-- stack item) onto the stack
			-- TODO: handle static fields
		require
			constant_pool_not_void: constant_pool /= Void
			constant_pool_open: constant_pool.is_open
			valid_type_id: repository.valid_id (type_id)
			valid_feature_type_id: repository.item (type_id).features.valid_index (feature_id)
			feature_is_field: repository.item (type_id).features.item (feature_id).written_feature.is_field
		do
			append_push_field (repository.item (type_id).features.item (feature_id).written_feature)
		end
			
	append_push_field (f: JVM_WRITTEN_FEATURE) is
			-- appends the code for:
			-- pushing the value (of an object referenced by the topmost
			-- stack item) onto the stack (only in case of non static fields)
			-- TODO: handle static fields
		require
			constant_pool_not_void: constant_pool /= Void
			constant_pool_open: constant_pool.is_open
			valid_f: f /= Void and then f.is_field
			stack_size_non_static: not f.is_static implies stack.count >= 1
			stack_size_static: f.is_static implies stack.count >= 0
		do
			if
				f.is_static
			then
				append_opcode (oc_getstatic)
			else
				append_opcode (oc_getfield)
			end
			append_feature_by_object (f)
			if
				not f.is_static
			then
				stack.remove -- object ref
			end
			stack.extend (jvm_type_to_stack (f.return_jvm_type_id)) -- value
		ensure
			stack_static: f.is_static implies stack.count - 1 = old stack.count
			stack_non_static: not f.is_static implies stack.count = old stack.count
			stack_type: stack.item = jvm_type_to_stack (f.return_jvm_type_id)
		end

feature {ANY} -- Arithmetics
	append_neg is
			-- append code for
			-- negate the top item on the stack
		require
			stack_size: stack.count > 0
			stack_consistent: stack.item = int_type or stack.item = long_type or
									stack.item = long_type or stack.item = float_type or
									stack.item = double_type
		do
			inspect
				stack.item
			when int_type then
				append_opcode (oc_ineg)
			when long_type then
				append_opcode (oc_lneg)
			when float_type then
				append_opcode (oc_fneg)
			when double_type then
				append_opcode (oc_dneg)
			else
				check False end
			end
		ensure
			stack_size: stack.count = old stack.count
			stack_consistent: stack.item = old stack.item
		end
				
				
	append_ge is
			-- append code for
			-- the >= operator.
			-- a = stack.item
			-- b = stack.i_th (2)
			-- the top two items will be removed from the stack
			-- and an integer will be pushed onto instead.
			-- if a >= b then stack.item = 1
			-- Otherwise stack.item = 0
		require
			stack_size: stack.count > 0
			stack_consistent: stack.item = int_type or stack.item = long_type or
									stack.item = long_type or stack.item = float_type or
									stack.item = double_type
		do
			-- TODO: Optimize using native code
			append_lt
			append_not
		ensure
			stack_size: stack.count + 1 = old stack.count
			stack_consistent: stack.item = int_type
		end

	append_lt is
			-- append code for
			-- the < operator.
			-- a = stack.item
			-- b = stack.i_th (2)
			-- the top two items will be removed from the stack
			-- and an integer will be pushed onto instead.
			-- if a < b then stack.item = 1
			-- Otherwise stack.item = 0
		require
			stack_size: stack.count >= 2
			stack_consistent1: stack.item = int_type or stack.item = long_type or
									 stack.item = long_type or stack.item = float_type or
									 stack.item = double_type
			stack_consistent2: stack.i_th (2) = int_type or stack.i_th (2) = long_type or
									 stack.i_th (2) = long_type or stack.i_th (2) = float_type or
									 stack.i_th (2) = double_type
		do
			-- TODO: Optimize using native code
			-- NOTE: code only works for one word operands FIXME
			-- swap to top elements
			check
				stack_size1: jvm_type_to_stack_size (stack.item) = 1
				stack_size2: jvm_type_to_stack_size (stack.i_th (2)) = 1
			end
			append_opcode (oc_swap)
			append_gt
		ensure
			stack_size: stack.count + 1 = old stack.count
			stack_consistent: stack.item = int_type
		end

	append_and is
			-- append code for
			-- the bitwise and operator.
			-- a = stack.item (int or long)
			-- b = stack.i_th (2) (int or long)
			-- the top two items will be removed from the stack
			-- and an integer (a and b) will be pushed onto instead.
		require
			stack_size: stack.count >= 2
			stack_consistent1: stack.item = int_type or stack.item = long_type
			stack_consistent2: stack.i_th (2) = int_type or stack.i_th (2) = long_type
		do
			-- TODO: Optimize using native code
			-- NOTE: code only works for one word operands FIXME
			-- swap to top elements
			check
				stack_size1: jvm_type_to_stack_size (stack.item) = 1
				stack_size2: jvm_type_to_stack_size (stack.i_th (2)) = 1
			end
			append_opcode (oc_iand)
			stack.remove
			stack.remove
			stack.extend (int_type)
		ensure
			stack_size: stack.count + 1 = old stack.count
			stack_consistent: stack.item = int_type
		end
	
	append_add is
			-- appends code for:
			-- add the two top items on the stack
			-- currently the two items need to be of the same type, but
			-- thats a bug and not a feature. whenever a conversion
			-- makes sense it should be done automaitcally (TODO)
		require
			stack_size: stack.count >= 2
			stack_consistent: stack.i_th (1) = stack.i_th (2)
		do
			check
				cast: stack.item = stack.i_th (2) --TODO cast in that case
							-- and then change preconidtion stack_consistent
			end
			inspect
				stack.item
			when int_type then
				append_opcode (oc_iadd)
			when long_type then
				append_opcode (oc_ladd)
			when float_type then
				append_opcode (oc_fadd)
			when double_type then
				append_opcode (oc_dadd)
			else
				check False end
			end
			stack.remove
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	append_sub is
			-- appends code for:
			-- substacts the two top items on the stack
			-- currently the two items need to be of the same type, but
			-- thats a but and not a feature. whenever a conversion
			-- makes sense it should be done automaitcally (TODO)
		require
			stack_size: stack.count >= 2
			stack_consistent: stack.i_th (1) = stack.i_th (2)
		do
			check
				cast: stack.item = stack.i_th (2) --TODO cast in that case
			end
			inspect
				stack.item
			when int_type then
				append_opcode (oc_isub)
			when long_type then
				append_opcode (oc_lsub)
			when float_type then
				append_opcode (oc_fsub)
			when double_type then
				append_opcode (oc_dsub)
			else
				check False end
			end
			stack.remove
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
	
	append_mul is
			-- appends code for:
			-- multiplies the two top items on the stack
			-- currently the two items need to be of the same type, but
			-- thats a bug and not a feature. whenever a conversion
			-- makes sense it should be done automaitcally (TODO)
		require
			stack_size: stack.count >= 2
			stack_consistent:	stack.i_th (1) = stack.i_th (2)
		do
			check
				cast: stack.item = stack.i_th (2) --TODO cast in that case
							-- and then change preconidtion stack_consistent
			end
			
			inspect
				stack.item
			when int_type then
				append_opcode (oc_imul)
			when long_type then
				append_opcode (oc_lmul)
			when float_type then
				append_opcode (oc_fmul)
			when double_type then
				append_opcode (oc_dmul)
			else
				check False end
			end
			stack.remove
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	append_precise_div is
			-- appends code for:
			-- divides the two top items on the stack
			-- currently the two items need to be of the same type, but
			-- thats a bug and not a feature. whenever a conversion
			-- makes sense it should be done automaitcally (TODO)
		require
			stack_size: stack.count >= 2
			stack_consistent:	stack.i_th (1) = stack.i_th (2)
		do
			check
				cast: stack.item = stack.i_th (2) --TODO cast in that case
							-- and then change preconidtion stack_consistent
			end
			
			inspect
				stack.item
			when int_type then -- convert to double and then divide
				-- convert top integer to double
				append_opcode (oc_i2d)
				-- bring 2nd int to top
				append_opcode (oc_dup2_x1)
				append_opcode (oc_pop2)
				-- convert 2nd int to double
				append_opcode (oc_i2d)
				-- swap two doubles
				append_opcode (oc_dup2_x2)
				append_opcode (oc_pop2)
				-- divide
				append_opcode (oc_ddiv)
				
				-- simulate max stack
				stack.extend (double_type)
				stack.extend (double_type)
				stack.remove
				stack.remove
				
				-- bring stack to real state
				stack.remove
				stack.remove
				stack.extend (double_type)
			when long_type then -- convert to double and then divide
				-- convert first long to double
				append_opcode (oc_l2d)
				-- swap double with long
				append_opcode (oc_dup2_x2)
				append_opcode (oc_pop2)
				-- convert 2nd long
				append_opcode (oc_l2d)
				-- swap 2 top doubles
				append_opcode (oc_dup2_x2)
				append_opcode (oc_pop2)
				-- divide
				append_opcode (oc_ddiv)
				
				-- simulate max stack
				stack.extend (long_type)
				stack.remove
				
				-- bring stack to real state
				stack.remove
				stack.remove
				stack.extend (double_type)
			when float_type then
				append_opcode (oc_fdiv)
				stack.remove
			when double_type then
				append_opcode (oc_ddiv)
				stack.remove
			else
				check False end
			end
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	
	append_div is
			-- appends code for:
			-- divides the two top items on the stack
			-- currently the two items need to be of the same type, but
			-- thats a bug and not a feature. whenever a conversion
			-- makes sense it should be done automaitcally (TODO)
		require
			stack_size: stack.count >= 2
			stack_consistent:	stack.i_th (1) = stack.i_th (2)
		do
			check
				cast: stack.item = stack.i_th (2) --TODO cast in that case
							-- and then change preconidtion stack_consistent
			end
			
			inspect
				stack.item
			when int_type then
				append_opcode (oc_idiv)
				stack.remove
			when long_type then -- convert to double and then divide
				append_opcode (oc_ldiv)
				stack.remove
			when float_type then
				append_opcode (oc_fdiv)
				stack.remove
			when double_type then
				append_opcode (oc_ddiv)
				stack.remove
			else
				check False end
			end
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	append_not is
			-- append code for:
			-- apply the not operator to the top most stack item
			-- the item must be an integer
			-- in case the item is 0 it will be replaced with 1
			-- otherwise it will be replaced with 0
		require
			stack_size: stack.count >= 1
			stack_consistent1: stack.item = int_type
		do
			append_opcode (oc_ifeq)
			append_sint_16_from_int (7) -- branch offset
			append_opcode (oc_iconst_0)
			append_opcode (oc_goto)
			append_sint_16_from_int (4) -- branch offset
			append_opcode (oc_iconst_1)
			append_opcode (oc_nop) -- branch target uncond. jump
		ensure
			stack_dec: stack.count = old stack.count
			stack_item: stack.item = int_type
		end
			
	append_gt is
			-- TODO: beat the guys who specified the JVM
			-- they have not included opcodes for comparsion of all
			-- basic types.
			-- therefore we need to do some stupid workarounds.
			-- this results in highly unoptimized code. optimization would be
			-- possible, but quite tricky (TODO)
			-- what we do for now is quite complex, slow and
			-- highly depends on the type of the values to compare
		require
			stack_size: stack.count >= 2
		do
			-- todo: cast if necessary
							
			-- first let's determine what types of elements we need to compare.
			inspect
				stack.item
			when void_type then
				check False end
			when object_type then
				check False end -- impossible
			when int_type then
				-- use if_icmpgt workaround
				append_int_gt
			when long_type then
				-- use lcmp + ifgt workaround
			when float_type then
				-- use either fcmpl or fcmpg + ifgt (research)
			when double_type then
				-- use either dcmpl or dcmpg + ifgt (research)
				append_double_gt
			when short_type then
				check False end -- shorts become ints before they go on the stack
			when bool_type then
				check False end -- bools become ints before they go on the stack
			when char_type then
				check False end
			when byte_type then
				check False end -- bytes become ints before they go on the stack
			else
				check False end -- unkown type
			end
		ensure
			stack_dec: stack.count + 1 = old stack.count
			stack_item: stack.item = int_type
		end
			
	append_eq is
			-- appends code for:
			-- compares the two top items on the stack for equality
			-- currently the two items need to be of the same type, but
			-- thats a but and not a feature. whenever a conversion
			-- makes sense it should be done automaitcally (TODO)
		require
			stack_size: stack.count >= 2
			stack_consistent: stack.i_th (1) = stack.i_th (2)
		do
			check
				cast: stack.item = stack.i_th (2) --TODO cast in that case
			end
			inspect
				stack.item
			when int_type then
				-- no opcode exists -> if then else workaround
				append_int_eq
			when long_type then
				append_opcode (oc_lcmp)
			when float_type then
				append_opcode (oc_fcmpg)
			when double_type then
				append_opcode (oc_dcmpg)
			when object_type then
				append_obj_eq
			else
				check False end
			end
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	append_ne is
			-- appends code for:
			-- compares the two top items on the stack for equality
			-- currently the two items need to be of the same type, but
			-- thats a but and not a feature. whenever a conversion
			-- makes sense it should be done automaitcally (TODO)
		require
			stack_size: stack.count >= 2
			stack_consistent: stack.i_th (1) = stack.i_th (2)
		do
			check
				cast: stack.item = stack.i_th (2) --TODO cast in that case
			end
			inspect
				stack.item
			when int_type then
				-- TODO: Optimize
				append_int_eq
				append_not
			when long_type then
				-- TODO: Optimize
				append_opcode (oc_lcmp)
				append_not
			when float_type then
				-- TODO: Optimize
				append_opcode (oc_fcmpg)
				append_not
			when double_type then
				-- TODO: Optimize
				append_opcode (oc_dcmpg)
				append_not
			when object_type then
				append_obj_ne
			else
				check False end
			end
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end


feature {ANY} -- Conditionals
	append_branch_on_false_by_label_id (label: INTEGER) is
			-- appends a branch on false
			-- if the top element on the stack is an integer with the
			-- value 0
			-- jump to the position in the bytecode identified with
			-- labels.item (label)
		require
			valid_label: labels.valid_index (label)
			label_not_void: labels.item (label) /= Void
			stack_size: stack.count >= 1
			consisten_stack: stack.item = int_type
		local
			lm: JVM_LABEL_MARK
		do
			create lm.make (labels.item (label), position)
			label_marks.force (lm)
			append_opcode (oc_ifeq)
			append_uint_16_from_int (0x0000) -- to be filled in later
			stack.remove -- value
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	append_branch_on_true_by_label_id (label: INTEGER) is
			-- appends a branch on true
			-- if the top element on the stack is an integer with an
			-- value other than 0
			-- jump to the position in the bytecode identified with
			-- labels.item (label)
		require
			valid_label: labels.valid_index (label)
			label_not_void: labels.item (label) /= Void
			stack_size: stack.count >= 1
			consisten_stack: stack.item = int_type
		local
			lm: JVM_LABEL_MARK
		do
			create lm.make (labels.item (label), position)
			label_marks.force (lm)
			append_opcode (oc_ifne)
			append_uint_16_from_int (0x0000) -- to be filled in later
			stack.remove -- value
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
			
feature {ANY} -- Unconditionals
	
	append_branch_by_label_id (label: INTEGER) is
			-- appends a unconditional branch (jump, goto)
			-- jump to the position in the bytecode identified with
			-- labels.item (label)
		require
			valid_label: labels.valid_index (label)
			label_not_void: labels.item (label) /= Void
		local
			lm: JVM_LABEL_MARK
		do
			create lm.make (labels.item (label), position)
			label_marks.force (lm)
			append_opcode (oc_goto)
			append_uint_16_from_int (0x0000) -- to be filled in later
		end
						
	append_return (jvm_type: INTEGER) is
			-- appends an instruction that returns from the current method
			-- what opcode is used depends on the top of the stack
		require
			valid_jvm_type: valid_jvm_type (jvm_type)
						--			result_void_stack_empty:  jvm_type = void_type implies stack.count = 0
						-- cannot really assume that, because of 
						-- tricky ifs and exception throwings
			result_type_non_void_stack_1: jvm_type /= void_type implies stack.count >= 1
			result_type_non_void_stack_cons: jvm_type /= void_type implies jvm_type_to_stack (jvm_type) >= stack.item
		do
			inspect
				jvm_type_to_stack (jvm_type)
			when
				object_type
			then
				append_opcode (oc_areturn)
			when
				int_type
			then
				append_opcode (oc_ireturn)
			when
				long_type
			then
				append_opcode (oc_lreturn)
			when
				float_type
			then
				append_opcode (oc_freturn)
			when
				double_type
			then
				append_opcode (oc_dreturn)
			when
				void_type
			then
				append_opcode (oc_return)
			else
				check
					dead_end: False
				end
			end
			if
				jvm_type /= void_type
			then
				stack.remove
			end
--		ensure
--			stack_size: stack.count = 0
		end
			
feature {ANY} -- Arrays
	append_push_array_count is
			-- appends code for
			-- remove the array object (which must be the top item on
			-- the stack) and push it's size onto instead
		require
			stack_size: stack.count > 0
			stack_consistent: stack.item = object_type
		do
			append_opcode (oc_arraylength)
			stack.remove
			stack.extend (int_type)
		ensure
			stack_size: stack.count = old stack.count
			stack_consistent: stack.item = int_type
		end
			
	append_push_from_array (kind: INTEGER) is
			-- append code for:
			-- read value from array (which is of kind `kind') and push
			-- it on the stack.
			-- the top most stack item must be the item offset
			-- and the second top most item must be a refernce to an array
		require
			valid_type_kind: valid_type_kind (kind)
			stack_size: stack.count >= 2
			stack_consistent1: stack.item = int_type
			stack_consistent2: stack.i_th (2) = object_type
		do
			stack.remove
			stack.remove
			inspect
				kind
			when il_i1 then
				append_opcode (oc_baload) -- used for bytes or booleans
				stack.extend (int_type) -- value gets expanded to an int
			when il_i2 then
				append_opcode (oc_saload)
				stack.extend (int_type)
			when il_i4 then
				append_opcode (oc_iaload)
				stack.extend (int_type)
			when il_i8 then
				append_opcode (oc_laload)
				stack.extend (long_type)
			when il_r4 then
				append_opcode (oc_faload)
				stack.extend (float_type)
			when il_r8 then
				append_opcode (oc_daload)
				stack.extend (double_type)
			when il_ref then
				append_opcode (oc_aaload)
				stack.extend (object_type)
			else
				check False end
			end
		ensure
			stack_size: stack.count + 1 = old stack.count
		end
			
			
	append_pop_into_array (kind: INTEGER) is
			-- append code for:
			-- pop value from top of the stack and writen it into an array
			-- the position in the array where the value will be written
			-- to is taken from the second top most stack item
			-- the array reference itself must be the 3rd top most item
		require
			valid_type_kind: valid_type_kind (kind)
			stack_size: stack.count >= 3
			stack_consistent1: stack.item = il_kind_to_jvm_type (kind)
			stack_consistent2: stack.i_th (2) = int_type
			stack_consistent2: stack.i_th (3) = object_type
		do
			stack.remove
			stack.remove
			stack.remove
			inspect
				kind
			when il_i1 then
				append_opcode (oc_bastore) -- used for bytes or booleans
			when il_i2 then
				append_opcode (oc_sastore)
			when il_i4 then
				append_opcode (oc_iastore)
			when il_i8 then
				append_opcode (oc_lastore)
			when il_r4 then
				append_opcode (oc_fastore)
			when il_r8 then
				append_opcode (oc_dastore)
			when il_ref then
				append_opcode (oc_aastore)
			else
				check False end
			end
		ensure
			stack_size: stack.count + 3 = old stack.count
		end
			
feature {ANY} -- Object creation
	append_new_class (type_id: INTEGER) is
			-- appends the code for:
			-- create a new object (initialized only with default values
			--  - no constructor called yet) and push a reference to it on the stack
		require
			valid_type_id: repository.has_by_id (type_id)
		do
			append_opcode (oc_new)
			append_class_by_type_id (type_id)
			stack.extend (eiffel_type_id_to_jvm_type_id (type_id))
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_consistent: stack.item = object_type
		end
			
	append_new_class_by_name (name: STRING) is
			-- appends the code for:
			-- create a new object (initialized only with default values
			--  - no constructor called yet) and push a reference to it on the stack
		require
			name_valid: name /= Void and then not name.is_empty
		do
			append_opcode (oc_new)
			append_class_by_name (name)
			stack.extend (object_type)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_consistent: stack.item = object_type
		end
			
	append_new_array_by_type_id (type_id: INTEGER) is
			-- appends code for:
			-- creates a new array object of type `type_id'
			-- and pushes it on top of the stack
		require
			valid_type_id: repository.valid_id (type_id)
			stack_size: stack.count > 0
			stack_consistent: stack.item = int_type
		local
			i: INTEGER
		do
			if
				repository.item (type_id).is_basic_type
			then
				-- newarray
				-- the top item of the stack must be the initial size of the
				-- array!
				append_opcode (oc_newarray)
				inspect
					repository.item (type_id).qualified_name.item (1)
				when 'Z' then i := 4
				when 'C' then i := 5
				when 'F' then i := 6
				when 'D' then i := 7
				when 'B' then i := 8
				when 'S' then i := 9
				when 'I' then i := 10
				when 'L' then i := 11
				else
					check False end
				end
				append_uint_8_from_int (i) -- array type
			else
				-- anewarray
				append_opcode (oc_anewarray)
				append_class_by_type_id (type_id)
			end
			stack.remove -- array size
			stack.extend (object_type) -- reference to new array object
		ensure
			stack_size: stack.count = old stack.count
			stack_consistent: stack.item = object_type
		end
			
feature {ANY} -- Misc. Stack operations
				
			
			
			
	append_pop is
			-- pops the top most item from the stack into the nirvana
		require
			stack_size: stack.count > 0
		do
			-- TODO: based on the top object of the type stack
			-- do a pop 2 word etc.
			append_opcode (oc_pop)
			stack.remove
		ensure
			stack_dec: stack.count + 1 = old stack.count
		end
			
	append_dup is
			-- duplicates the item on top of the stack
		require
			stack_size: stack.count > 0
		do
			-- TODO: based on the top object of the type stack
			-- do a dup 2 word etc.
			append_opcode (oc_dup)
			stack.extend (stack.item)
		ensure
			stack_inc: stack.count - 1 = old stack.count
			stack_consistent: stack.item = stack.i_th (2)
		end
			
feature {ANY} -- Exceptions
	
	append_throw_exception is
			-- append code for
			-- throw exeption
		require
			stack_size: stack.count >= 1
			stack_consistent1: stack.item = object_type
		do
			append_opcode (oc_athrow)
			stack.remove -- exception
		ensure
			stack_size: stack.count + 1 = old stack.count
		end

feature {ANY} -- Introspection
			
			
			
	append_is_instance_of_by_type_id (type_id: INTEGER) is
			-- append code for
			-- look (and remove) at the top item of the stack
			-- (which must be an object) and see wether it is an
			-- instance of `type_id'. It will then push 1 on the stack
			-- if stack.item is an insance of `type_id' otherwise it
			-- will push 0. If the top item on the stack is null, it
			-- will always push 0
		require
			stack_size: stack.count > 0
			stack_consistent: stack.item = object_type
		do
			append_opcode (oc_instanceof)
			append_class_by_type_id (type_id)
			stack.remove
			stack.extend (int_type)
		ensure
			stack_size: stack.count = old stack.count
			stack_consistent: stack.item = int_type
		end
			
	append_check_cast_by_type_id (type_id: INTEGER) is
			-- append code for
			-- check if the top stack item is of type `type_id' or null
			-- if so, leave it alone, otherwise throw a runtime
			-- exception (ClassCastException)
		require
			stack_size: stack.count > 0
			stack_consistent: stack.item = object_type
		do
			append_opcode (oc_checkcast)
			append_class_by_type_id (type_id)
		ensure
			stack_size: stack.count = old stack.count
			stack_consistent: stack.item = object_type
		end


feature {NONE} -- Implementation
			
	append_int_32_constant (i: INTEGER) is
		do
			constant_pool.put_int_32_constant (i)
			append_uint_16_from_int (constant_pool.last_cpe_index)
		end
			
	append_int_64_constant_from_int (i: INTEGER) is
		do
			constant_pool.put_int_64_constant_from_int (i)
			append_uint_16_from_int (constant_pool.last_cpe_index)
		end
			
	append_double_constant (d: DOUBLE) is
			-- Note: `put_double_constant' does not seem to work. FIXME
		do
			constant_pool.put_double_constant (d)
			append_uint_16_from_int (constant_pool.last_cpe_index)
		end
			
	append_float_constant (f: REAL) is
		do
			constant_pool.put_float_constant (f)
			append_uint_16_from_int (constant_pool.last_cpe_index)
		end
			
	append_string_constant_wide_index (str: STRING) is
			-- puts a CPE_UTF8 with the `str' as content in the constant
			-- pool and appends it's cp index in the byte code. the
			-- index will be written as a 2 byte index (so use *_w opcodes!)
		require
			str_not_void: str /= Void
		do
			constant_pool.put_string_constant (str)
			append_uint_16_from_int (constant_pool.last_cpe_index)
		end
			
	append_wide is
		do
			append_opcode (oc_wide)
		end
			

	append_opcode (opcode: INTEGER) is
			-- appends the opcode `opcode'
		require
			valid_opcode: opcode >= 0 and opcode < 256
		do
			append_uint_8_from_int (opcode)
		end
			
	append_invoke_virtual (method_name, method_signature, written_class: STRING) is
			-- appends a invoke virtual opcode with index at the end of
			-- the byte code.
			-- does not modify or check the stack!
		require
			method_name_not_void: method_name /= Void
			method_signature_not_void: method_signature /= Void
			written_class_not_void: written_class /= Void
		do
			append_opcode (oc_invokevirtual)
			constant_pool.put_method_ref (method_name, method_signature, written_class)
			append_feature (constant_pool.last_cpe_index)
		end
	
feature {ANY} --
	append_invoke_special (method_name, method_signature, written_class: STRING) is
			-- invoke special
			-- note: stack consistency must be ensured by caller !!
		require
			method_name_not_void: method_name /= Void
			method_signature_not_void: method_signature /= Void
			written_class_not_void: written_class /= Void
		do
			append_opcode (oc_invokespecial) -- invoke special <init>()V
			constant_pool.put_method_ref (method_name, method_signature, written_class)
			append_feature (constant_pool.last_cpe_index)
		end
feature {NONE}						
	append_invoke_constructor_by_type_id (signature: STRING; type_id: INTEGER) is
		require
			valid_type_id: repository.has_by_id (type_id)
			signature_not_void: signature /= Void
		do
			append_invoke_special ("<init>", signature, repository.item (type_id).qualified_name_wo_l)
		end
			
	append_int_gt is
			-- append code for:
			-- compare to integers
			-- a = stack.i_th (2)
			-- b = stack.item
			-- if a > b the top element on the stack will be the int 1
			-- if a <= b the top element on the stack will be the int 0
		require
			stack_size: stack.count >= 2
			stack_consistent1: stack.item = int_type
			stack_consistent1: stack.item = stack.i_th (2)
		do
			append_opcode (oc_if_icmpgt)
			append_sint_16_from_int (7) -- branch offset
			append_opcode (oc_iconst_0)
			append_opcode (oc_goto)
			append_sint_16_from_int (4) -- branch offset
			append_opcode (oc_iconst_1)
			append_opcode (oc_nop) -- branch target uncond. jump
							
			stack.remove
			stack.remove
			stack.extend (int_type)
		ensure
			stack_dec: stack.count + 1 = old stack.count
			stack_item: stack.item = int_type
		end
			
	append_int_eq is
			-- append code for:
			-- compare to integers
			-- a = stack.i_th (2)
			-- b = stack.item
			-- if a = b the top element on the stack will be the int 1
			-- if a /= b the top element on the stack will be the int 0
		require
			stack_size: stack.count >= 2
			stack_consistent1: stack.item = int_type
			stack_consistent1: stack.item = stack.i_th (2)
		do
			append_opcode (oc_if_icmpeq)
			append_sint_16_from_int (7) -- branch offset
			append_opcode (oc_iconst_0)
			append_opcode (oc_goto)
			append_sint_16_from_int (4) -- branch offset
			append_opcode (oc_iconst_1)
			append_opcode (oc_nop) -- branch target uncond. jump
							
			stack.remove
			stack.remove
			stack.extend (int_type)
		ensure
			stack_dec: stack.count + 1 = old stack.count
			stack_item: stack.item = int_type
		end
			
	append_obj_eq is
			-- append code for:
			-- compare to object references
			-- a = stack.i_th (2)
			-- b = stack.item
			-- if a = b the top element on the stack will be the int 1
			-- if a /= b the top element on the stack will be the int 0
		require
			stack_size: stack.count >= 2
			stack_consistent1: stack.item = object_type
			stack_consistent1: stack.item = stack.i_th (2)
		do
			append_opcode (oc_if_acmpeq)
			append_sint_16_from_int (7) -- branch offset
			append_opcode (oc_iconst_0)
			append_opcode (oc_goto)
			append_sint_16_from_int (4) -- branch offset
			append_opcode (oc_iconst_1)
			append_opcode (oc_nop) -- branch target uncond. jump
							
			stack.remove
			stack.remove
			stack.extend (int_type)
		ensure
			stack_dec: stack.count + 1 = old stack.count
			stack_item: stack.item = int_type
		end
			
	append_obj_ne is
			-- append code for:
			-- compare to object references
			-- a = stack.i_th (2)
			-- b = stack.item
			-- if a = b the top element on the stack will be the int 0
			-- if a /= b the top element on the stack will be the int 1
		require
			stack_size: stack.count >= 2
			stack_consistent1: stack.item = object_type
			stack_consistent1: stack.item = stack.i_th (2)
		do
			append_opcode (oc_if_acmpeq)
			append_sint_16_from_int (7) -- branch offset
			append_opcode (oc_iconst_1)
			append_opcode (oc_goto)
			append_sint_16_from_int (4) -- branch offset
			append_opcode (oc_iconst_0)
			append_opcode (oc_nop) -- branch target uncond. jump
							
			stack.remove
			stack.remove
			stack.extend (int_type)
		ensure
			stack_dec: stack.count + 1 = old stack.count
			stack_item: stack.item = int_type
		end
			
	append_double_gt is
			-- append code for:
			-- compare to doubles
			-- a = stack.i_th (2)
			-- b = stack.item
			-- if a > b the top element on the stack will be the int 1
			-- if a <= b the top element on the stack will be the int 0
		require
			stack_size: stack.count >= 2
			stack_consistent1: stack.item = double_type
			stack_consistent1: stack.item = stack.i_th (2)
		do
			append_opcode (oc_dcmpl)
			append_opcode (oc_ifgt)
			append_sint_16_from_int (7) -- branch offset
			append_opcode (oc_iconst_0)
			append_opcode (oc_goto)
			append_sint_16_from_int (4) -- branch offset
			append_opcode (oc_iconst_1)
			append_opcode (oc_nop) -- branch target uncond. jump
							
			stack.remove
			stack.remove
			stack.extend (int_type)
		ensure
			stack_dec: stack.count + 1 = old stack.count
			stack_item: stack.item = int_type
		end
			
			
	append_convert_to (jvm_type: INTEGER) is
			-- convert the top stack value (which is of type `stack.item')
			-- to `jvm_type'.
			-- The source type and target type may be the same, in that
			-- case nothing will be done.
		require
			stack_size: stack.count >= 1
			valid_type: valid_jvm_type (jvm_type)
			conversion_exists: conversion_exists (stack.item, jvm_type)
		do
			if
				stack.item /= jvm_type
			then
										
				inspect
					stack.item -- souce type
				when int_type then
					inspect
						jvm_type -- target type
					when long_type then
						-- i2l
						append_opcode (oc_i2l)
					when float_type then
						-- i2f
						append_opcode (oc_i2f)
					when double_type then
						-- i2d	
						append_opcode (oc_i2d)
					when byte_type then
						-- i2b
						append_opcode (oc_i2b)
					when char_type then
						-- i2c
						append_opcode (oc_i2c)
					when short_type then
						-- i2s
						append_opcode (oc_i2s)
					when bool_type then
						-- nothing to do
					else
						check False end
					end
				when long_type then
					inspect
						jvm_type -- target type
					when int_type then
						-- l2i
						append_opcode (oc_l2i)
					when double_type then
						-- l2d
						append_opcode (oc_l2d)
					when float_type then
						-- l2f
						append_opcode (oc_l2f)
					else
						check False end
					end
				when float_type then
					inspect
						jvm_type -- target type
					when int_type then
						-- f2i
						append_opcode (oc_f2i)
					when long_type then
						-- f2l
						append_opcode (oc_f2l)
					when double_type then
						-- f2d
						append_opcode (oc_f2d)
					else
						check False end
					end
				when double_type then
					inspect
						jvm_type -- target type
					when int_type then
						-- d2i
						append_opcode (oc_d2i)
					when long_type then
						-- d2l
						append_opcode (oc_d2l)
					when float_type then
						-- d2f
						append_opcode (oc_d2f)
					else
						check False end
					end
				else
					check False end
				end
				stack.remove
				stack.extend (jvm_type)
			end
		ensure
			stack_size: stack.count = old stack.count
			stack_item: stack.item = jvm_type
		end
feature
			
	conversion_exists (source_jvm_type, target_jvm_type: INTEGER): BOOLEAN is
			-- tells you wether there is a opcode for a conversion of a
			-- value from `source_jvm_type' ot `target_jvm_type'
			-- Gives you ture also for the case that `source_jvm_type' = `target_jvm_type'
		require
			valid_source: valid_jvm_type (source_jvm_type)
			valid_target: valid_jvm_type (target_jvm_type)
		do
			if
				source_jvm_type = target_jvm_type
			then
				Result := True
			else
				inspect
					source_jvm_type
				when int_type then
					inspect
						target_jvm_type -- target type
					when long_type then
						Result := True
					when float_type then
						Result := True
					when double_type then
						Result := True
					when byte_type then
						Result := True
					when char_type then
						Result := True
					when short_type then
						Result := True
					when bool_type then
						Result := True
					else
					end
				when long_type then
					inspect
						target_jvm_type -- target type
					when int_type then
						Result := True
					when double_type then
						Result := True
					when float_type then
						Result := True
					else
					end
				when float_type then
					inspect
						target_jvm_type -- target type
					when int_type then
						Result := True
					when long_type then
						Result := True
					when double_type then
						Result := True
					else
					end
				when double_type then
					inspect
						target_jvm_type -- target type
					when int_type then
						Result := True
					when long_type then
						Result := True
					when float_type then
						Result := True
					else
					end
				else
				end
			end
		end
			
	jvm_type_to_stack (a_jvm_type: INTEGER): INTEGER is
			-- takes a valid jvm_type and returns it's corresponding jvm
			-- type on the stack. This is in most cases the same type,
			-- but not in all. Booleans for example are stores as
			-- integers on the stack (0 = False, otherise = True)
		require
			valid_jvm_type: valid_jvm_type (a_jvm_type)
		do
			inspect
				a_jvm_type
			when bool_type, short_type, byte_type then
				Result := int_type
			else
				Result := a_jvm_type
			end
		end
			

invariant
	
	lables_not_void: labels /= Void
	label_marks_not_void: label_marks /= Void
			
end
							
							


