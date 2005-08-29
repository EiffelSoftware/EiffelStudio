indexing

	description:
		"Platform independent abstraction of a shared library routine"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class SHARED_LIBRARY_ROUTINE

inherit
	SHARED_LIBRARY_CONSTANTS

feature -- Initialization

	make_by_name (lib: SHARED_LIBRARY; f_name: STRING;
				arg_types: ARRAY [INTEGER]; ret_type: INTEGER) is
			-- Connect to the routine `f_name' in library `lib'
		require
			library_exists: lib /= Void
			meaningful: lib.meaningful
			function_name_non_Void: f_name /= Void
			function_name_non_empty: not f_name.is_empty
			valid_argument_array: arg_types /= Void
			valid_argument_types: valid_argument_types (arg_types)
			valid_return_type: valid_return_type (ret_type)
		deferred
		ensure
			consistent_f_name: f_name.is_equal (function_name)
			consistent_lib: lib = shared_library
			routine_not_called: not routine_called
		end

feature -- Basic operations

	call (args: ARRAY [ANY]) is
			-- Call the routine with actual arguments `args'
		require
			meaningful: meaningful
			valid_array: args /= Void
			conformant: conforms_to_signature (args)
		deferred
		ensure
			routine_called: routine_called
		end

feature -- Status report

	argument_count: INTEGER is
			-- Number of arguments required
		do
			Result := argument_types.count
		end

	boolean_result: BOOLEAN is
			-- Value when the routine returns a boolean
		require
			routine_called: routine_called
			valid_return_type: return_type = T_boolean
		deferred
		end

	character_result: CHARACTER is
			-- Value when the routine returns a character
		require
			routine_called: routine_called
			valid_return_type: return_type = T_character
		deferred
		end

	conforms_to_signature (arguments: ARRAY [ANY]): BOOLEAN is
			-- Do the actual arguments `arguments' conform to the signature?
		require
			valid_array: arguments /= Void
		local
			i, j, nb: INTEGER
			arg: ANY
			boolean_ref: BOOLEAN_REF
			character_ref: CHARACTER_REF
			double_ref: DOUBLE_REF
			integer_ref: INTEGER_REF
			real_ref: REAL_REF
			pointer_ref: POINTER_REF
			s: STRING
			s1: ARRAY [INTEGER]
			s2: ARRAY [REAL]
			s3: ARRAY [DOUBLE]
			s4: ARRAY [BOOLEAN]
			s5: ARRAY [CHARACTER]
			s6: ARRAY [POINTER]
			s7: ARRAY [ANY]
		do
			from
				Result := arguments.count = argument_count
				i := arguments.lower
				j := argument_types.lower
				nb := arguments.count
			until
				i > nb or not Result
			loop
				arg := arguments @ i
				inspect
					argument_types @ j
				when T_array then
						-- T_array works only for basic types and references
						-- it won't work for ARRAY [A] where A is defined as:
						-- expanded class A end
					Result := True
					s1 ?= arg
					if s1 = Void then
						s2 ?= arg
						if s2 = Void then
							s3 ?= arg
							if s3 = Void then
								s4 ?= arg
								if s4 = Void then
									s5 ?= arg
									if s5 = Void then
										s6 ?= arg
										if s6 = Void then
											s7 ?= arg
											if s7 = Void then
												Result := False
											end
										end
									end
								end
							end
						end
					end
				when T_boolean then
					boolean_ref ?= arg
					Result := boolean_ref /= Void
				when T_character then
					character_ref ?= arg
					Result := character_ref /= Void
				when T_double then
					double_ref ?= arg
					Result := double_ref /= Void
				when T_integer, T_short_integer then
					integer_ref ?= arg
					Result := integer_ref /= Void
				when T_real then
					real_ref ?= arg
					Result := real_ref /= Void
				when T_pointer then
					pointer_ref ?= arg
					Result := pointer_ref /= Void
				when T_no_type then
					Result := False
				when T_reference then
				when T_string then
					create s.make (0)
					Result := arg.conforms_to (s)
				end
				i := i + 1
				j := j + 1
			end
		end

	double_result: DOUBLE is
			-- Value when the routine returns a double
		require
			routine_called: routine_called
			valid_return_type: return_type = T_double
		deferred
		end

	error_code: INTEGER
			-- Current status of the routine

	integer_result: INTEGER is
			-- Value when the routine returns an integer
		require
			routine_called: routine_called
			valid_return_type: return_type = T_integer or
				return_type = T_short_integer
		deferred
		end

	meaningful: BOOLEAN is
			-- Is the routine currently callable?
		do
			Result := shared_library.meaningful and (error_code = No_error)
		end

	pointer_result: POINTER is
			-- Value when the routine returns a pointer
		require
			routine_called: routine_called
			valid_return_type: return_type = T_pointer
		deferred
		end

	routine_called: BOOLEAN
			-- Has the routine already been called?

	real_result: REAL is
			-- Value when the routine returns a real
		require
			routine_called: routine_called
			valid_return_type: return_type = T_real
		deferred
		end

	reference_result: ANY is
			-- Value when the routine returns a reference
		require
			routine_called: routine_called
			valid_return_type: return_type = T_reference
		deferred
		end

	string_result: STRING is
			-- Value when the routine returns a string
		require
			routine_called: routine_called
			valid_return_type: return_type = T_string
		deferred
		end

	valid_argument_types (args: ARRAY [INTEGER]): BOOLEAN is
			-- Are all the argument types in `args' valid?
		local
			i, nb: INTEGER
			arg_type: INTEGER
		do
			from
				Result := True
				i := args.lower
				nb := args.count
			until
				i > nb or else not Result
			loop
				arg_type := args @ i
					-- False for T_no_type or wrong constant
				Result := arg_type >= 0 and arg_type < T_no_type
				i := i + 1
			end
		end

	valid_return_type (ret_type: INTEGER): BOOLEAN is
			-- Is `ret_type' valid as a return type?
		do
				-- Returns False for T_array or wrong constant
			Result :=
				(ret_type > T_array)
				and then
				(ret_type <= T_no_type)
		end

feature -- Access

	argument_types: ARRAY [INTEGER]
			-- Expected types of the actual arguments

	function_name: STRING
			-- Name of the routine in the library

	library_name: STRING is
			-- Name of the associated library for the routine
		do
			Result := shared_library.library_name
		end

	return_type: INTEGER
			-- Expected return type

	shared_library: SHARED_LIBRARY
			-- Associated library for the routine

invariant

	library_exists: shared_library /= Void
	meaningful_only_if_no_error: meaningful implies (error_code = No_error)
	meaningful_library: meaningful implies shared_library.meaningful

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class SHARED_LIBRARY_ROUTINE


