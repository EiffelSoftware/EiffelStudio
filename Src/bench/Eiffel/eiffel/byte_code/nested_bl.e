-- Enlarged byte code for nested call

class NESTED_BL 

inherit
	NESTED_B
		redefine
			print_register, free_register,
			stored_register, has_call, has_gcable_variable, c_type,
			set_register, register, set_parent, parent, propagate,
			unanalyze, generate_creation_call, generate, analyze,
			allocates_memory
		end
	
feature 

	register: REGISTRABLE
			-- In which register the expression is stored

	set_register (r: REGISTRABLE) is
			-- Set current register to `r'
		do
			register := r
		end

	parent: NESTED_BL
			-- Parent of current node
	
	set_parent (p: NESTED_BL) is
			-- Set `parent' to `p'
		do
			parent := p
		end

	c_type: TYPE_C is
			-- Current C type (used by `get_register')
		do
			Result := local_type.c_type
		end

	local_type: TYPE_I is
			-- Type of the current call
		require
			valid_message: message /= Void
		do
			Result := real_type (message.target.type)
		end

	has_gcable_variable: BOOLEAN is
			-- Is the current call using a GCable variable ?
			-- Only the last dot is important for us.
		do
			if message.target = message then
					-- We are the last call
				Result := target.has_gcable_variable or
					message.has_gcable_variable
			else
					-- Propagate the request
				Result := message.has_gcable_variable
			end
		end

	propagate (r: REGISTRABLE) is
			-- Propagates register to calls in expression whose type matches
			-- the one of the propagated entity. Anyway, the last call catches
			-- it, so that No_register may be caught too...
		do
			if message.target = message then
					-- We are the last call, hence we grab the register when
					-- the type of the target is NOT a simple type (as it will
					-- be metamorphosed and that is not an operation which can
					-- be inlined).
				if 	register = Void
					and
					local_type.c_type.same_class_type (r.c_type)
					and
					(r = No_register implies not target.type.is_basic)
					and
					(r = No_register implies context.propagate_no_register)
					and 
					not context.has_invariant
				then
					register := r
					context.set_propagated
				end
			else
					-- Grab register only if it has the same type as ours
					-- and if it is not used later in the expression.
					-- We never grab temporary registers in the middle of a
					-- multidot expression.
				if not (r.is_temporary or used (r)) then
					if local_type.c_type.same_class_type (r.c_type) then
							-- Don't bother calling set_propagated, because we
							-- know it'll be done at the end of the call anyway.
						if register = Void and not context.has_invariant then
							register := r
						end
					end
						-- We may safely propagate register to our target only
						-- when that register is not used further in the call.
						-- If r is No_register, make sure the target is NOT an
						-- attribute. then that it is not polymorphic, otherwise
						-- we would call an Eiffel function to evaluate the
						-- Current AND the Dtype of the expression, which we
						-- cannot do--RAM.
					if 	r /= No_register
						or else
							(	(not target.is_attribute)
								and
								(not target.is_polymorphic)
								and
								context.propagate_no_register)
					then
						target.propagate (r)
					end
				end
					-- Recursively propagate register on the whole call tree
				message.propagate (r)
			end
		end

	stored_register: REGISTRABLE is
			-- Register in which the call is stored (last one)
		do
			if message.target = message then
					-- We are in the last multidot cal
				Result := register
			else
				Result := message.stored_register
			end
		end

	print_register is
			-- Print register or generate if there are no register.
			-- This is the last register in a multidot expression. When
			-- register is No_register, the call is not meant to be put in
			-- a temporary register, which means we have to expand the call
			-- itself.
		do
			if message.target = message then
					-- We reached the last call
				if register /= No_register then
						-- There is a register, hence the call has already
						-- been generated and the result is in the register.
					register.print_register
				else
						-- There is no register, which means the call has not
						-- been generated yet.
					if parent = Void then
							-- This is the first call.
						message.target.generate_on (target)
					else
							-- This is part of a dot call. Generate a call on
							-- the entity stored in the parent's register.
						message.target.generate_on (parent.register)
					end
				end
			else
					-- Simply propagate the request (it is impossible for a
					-- call which is part of a multidot expression to have
					-- its register set to No_register).
				message.print_register
			end
		end

	free_register is
			-- Free register used by last call expression. If No_register was
			-- propagated, also frees the registers used by target and
			-- last message.
		do
			if message.target = message then
					-- Reached last call
				{NESTED_B} precursor
					-- Free those registers which where kept because No_register
					-- was propagated, hence call was meant to be expanded
					-- in-line.
				if register = No_register then
					target.free_register
					message.free_register
				end
			else
					-- Propagate the request
				message.free_register
			end
		end

	free_target_register is
			-- Free the register used by the message target
		local
			msg_target: ACCESS_B
		do
			msg_target := message.target
			if msg_target /= message and message.register /= No_register
			then
					-- Last call was not reached. Free the next target
					-- iff not to be stored in No_register
				msg_target.free_register
			elseif msg_target = message and register /= No_register then
				msg_target.free_register
			end
		end

	unanalyze is
			-- Undo the analysis of the expression
		local
			void_register: REGISTER
		do
			if parent = Void then
					-- At the top of the tree.
				target.unanalyze
			end
			message.target.unanalyze
			register := void_register
			if message.target /= message then
					-- We are not the last call on the chain.
				message.unanalyze
			end
		end

	analyze is
			-- Analyze expression
		local
			msg_target: ACCESS_B
		do
debug
io.error.putstring ("In nested_bl%N")
end
			msg_target := message.target
			if parent = Void then
					-- If we are at the top of the tree hierarchy, then
					-- this has never been analyzed. If the access has
					-- no parameters, then it will be expanded in-line.
				if target.parameters = Void
						-- Make sure the target is NOT an attribute. then that
						-- it is not polymorphic, otherwise we would call an
						-- Eiffel function to evaluate the Current AND the Dtype
						-- of the expression, which we cannot do--RAM. This
						-- of course applies only when the current call is a
						-- polymorphic one...
				and then
					-- This test leads to an optimization for t.f (ref).
					-- The generated_code was E_f (E_t (l[0]), ref)
					-- Possible problems for the GC depending on the order
					-- of evaluation of the parameters of a C function
					-- The C standard doesn't specify anything
					-- Problem discovered during the DOS port.
					-- The optimization can still be done for calls like t.f:
					-- E_f (E_t (l[0])) is valid and does not need a register
					-- Xavier

					message.target.parameters = Void
				and then not
					(target.is_attribute
					or
					target.is_polymorphic
					or
					msg_target.is_polymorphic)
				then
					context.init_propagation
					target.propagate (No_register)
				end
				target.analyze
			end
				-- Analyze the next target
			msg_target.analyze_on (target)
				-- These register will be freed by a call to free_register if
				-- register = No_register (remember: this is NOT possible in
				-- the middle of a nested call).
			if context.has_invariant then
					-- If there is some invariant checking, then we MUST take a
					-- register BEFORE freeing those used by the dot call,
					-- otherwise we would not be able to check the invariant
					-- after the call (as the variable playing 'Current' might
					-- get overwritten if re-used now).
				get_register
			end
debug
io.error.putstring ("TARGET REGISTER%N")
if target.register /= Void then
	io.error.putstring (target.register.out)
else
	io.error.putstring ("%TVOID%N")
end
io.error.putstring ("MESSAGE TARGET REGISTER%N")
if msg_target.register /= Void then
	io.error.putstring (msg_target.register.out)
else
	io.error.putstring ("%TVOID%N")
end
io.error.putstring ("CURRENT REGISTER%N")
if register /= Void then
	io.error.putstring (register.out)
else
	io.error.putstring ("%TVOID%N")
end
end
			if register /= No_register then
				if (parent = Void) then
						-- First call. Otherwise, target is freed by parent.
					target.free_register
				else
						-- The register used by our parent is no longer needed.
					parent.register.free_register
				end
					-- Free the register used by the message target
				free_target_register
			end
				-- Take a register if none has been propagated
				-- The register will be freed later on (this may well be
				-- part of a parameter list).
			if not context.has_invariant then
				get_register
			end
			if msg_target /= message then
					-- We are not the last call on the chain.
				message.analyze
			end
debug
io.error.putstring ("Out nested_bl%N")
end
		end

	generate is
			-- Generate expression
		local
			with_inv: BOOLEAN
		do
			with_inv := context.has_invariant
			if parent = Void then
					-- This is the first call. Generate the target.
				target.generate
					-- generate a hook
				if target.is_feature then 
					generate_frozen_debugger_hook_nested
				end
						-- Generate a call on an entity stored in `target'
				generate_call (target, with_inv)
			else
					-- This is part of a dot call. Generate a call on the
					-- entity stored in the parent's register.
				generate_call (parent.register, with_inv)
			end
			if message.target /= message then
					-- generate a hook
				generate_frozen_debugger_hook_nested
					-- We are not the last call on the chain.
				message.generate
			end
		end

	generate_creation_call is
			-- Generate creation call
		do
			target.generate
				-- generate a hook
			if target.is_feature then 
				generate_frozen_debugger_hook_nested
			end
			generate_call (target, False)
		end

	generate_call (reg: REGISTRABLE; with_inv: BOOLEAN) is
			-- Generate a call on entity held in `reg'
		local
			message_target: ACCESS_B
			value_type: TYPE_I
			buf: GENERATION_BUFFER
		do
			buf := buffer
			message_target := message.target
				-- Put parameters, if any, in temporary registers
			message_target.generate_parameters (reg)
				-- Now if there is a result for the call and the result
				-- has to be stored in a real register, do generate the
				-- assignment.
			if system.has_separate then
					-- generated directly by a call to `print_register'.
					-- Otherwise, we have to generate it now.
				if register /= Void and register /= No_register	and not real_type(target.type).is_separate then
					register.print_register
					buf.putstring (" = ")
				end
					-- If register is No_register, then the call will be
					-- generated directly by a call to `print_register'.
					-- Otherwise, we have to generate it now.
				if register /= No_register then
					message_target.generate_on (reg)
					if not real_type(target.type).is_separate then
						buf.putchar (';')
						buf.new_line
					end
				end
					-- Now, we process separate feature call which return a basic data
					-- or separate object.
				if register /= Void and register /= No_register and real_type(target.type).is_separate then
					register.print_register
					buf.putstring (" = ")
					value_type := context.real_type(message.target.type)
--					value_type := message.target.context_type
--					value_type := context.real_type(message.type)
--					value_type := context.real_type(type)
					if value_type.is_boolean then
						buf.putstring ("CURGB(0);")
					elseif value_type.is_char then
						buf.putstring ("CURGC(0);")
					elseif value_type.is_double then
						buf.putstring ("CURGD(0);")
					elseif value_type.is_float then
						buf.putstring ("CURGR(0);")
					elseif value_type.is_long then
						buf.putstring ("CURGI(0);")
					elseif value_type.is_feature_pointer then
						buf.putstring ("CURGP(0);")
					elseif value_type.is_true_expanded then
						buf.putstring ("CURGO(0);")
					else
					-- if value_type.is_separate or value_type.is_reference then
						buf.putstring ("CURGSO(0);")
					end	
					
					buf.new_line
				end
			else
				if register /= Void and register /= No_register then
					register.print_register
					buf.putstring (" = ")
				end
					-- If register is No_register, then the call will be
					-- generated directly by a call to `print_register'.
					-- Otherwise, we have to generate it now.
				if register /= No_register then
					message_target.generate_on (reg)
					buf.putchar (';')
					buf.new_line
				end
			end
			message_target.reset_added_gc_hooks
		end

	has_call: BOOLEAN is True
			-- The expression has at least one call

	allocates_memory: BOOLEAN is True

end
