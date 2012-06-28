indexing
	description: "[
		Objects representing delayed calls to a routine,
		with some operands possibly still open
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end]

inherit
	HASHABLE

feature -- Access

	target: ANY is
			-- Target of call, if already known
		do
			if is_target_closed then
				Result := closed_operands.item (1)
			end
		end

	hash_code: INTEGER is
			-- Hash code value.
		do
			Result := 1
		end

	precondition (args: OPEN_ARGS): BOOLEAN is
			-- Do `args' satisfy routine's precondition
			-- in current state?
		do
			Result := True
			--| FIXME compiler support needed!
		end

	postcondition (args: OPEN_ARGS): BOOLEAN is
			-- Does current state satisfy routine's
			-- postcondition for `args'?
		do
			Result := True
			--| FIXME compiler support needed!
		end

	empty_operands: OPEN_ARGS is
			-- Empty tuple matching open operands
		do
			create Result
		ensure
			empty_operands_not_void: Result /= Void
		end

feature -- Status report

	callable: BOOLEAN is
			-- Can routine be called on current object?
		do
			Result := True
		end

	valid_operands (args: TUPLE): BOOLEAN is
			-- Are `args' valid operands for this routine?
		local
			l_expected_args: OPEN_ARGS
			i, nb: INTEGER
			l_arg_type_code: INTEGER
			l_arg: ANY
		do
			create l_expected_args
			if args = Void then
					-- Void operands are only allowed
					-- if object has no open operands.
				Result := l_expected_args.count = 0
			elseif args.count >= l_expected_args.count then
				Result := True
				nb := l_expected_args.count
				from i := 1 until i > nb loop
					l_arg_type_code := args.item_code (i)
					if l_arg_type_code = l_expected_args.item_code (i) then
						if l_arg_type_code = {TUPLE}.reference_code then
							l_arg := args.item (i)
							if l_arg /= Void and then not l_arg.generating_type.conforms_to (l_expected_args.generating_type.generic_parameter (i)) then
								Result := False
								i := nb + 1
							end
						end
						i := i + 1
					else
						Result := False
						i := nb + 1
					end
				end
			end
		end

	is_target_closed: BOOLEAN
			-- Is target for current agent closed, i.e. specified at creation time?

feature -- Setting

	set_target (a_target: like target) is
			-- Set `a_target' as the next `target' for remaining calls to Current.
		require
			a_target_not_void: a_target /= Void
			is_target_closed: is_target_closed
			target_not_void: target /= Void
			same_target_type: target.same_type (a_target)
		do
			closed_operands.put (a_target, 1)
		ensure
			target_set: target = a_target
		end

feature -- Basic operations

	call (args: OPEN_ARGS) is
			-- Call routine with operands `args'.
		require
			valid_operands: valid_operands (args)
			callable: callable
		deferred
		end

feature {ROUTINE} -- Implementation

	frozen closed_operands: TUPLE
			-- All closed arguments provided at creation time

end
