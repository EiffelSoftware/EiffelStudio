note
	description: "[
		Enumeration class for the different strategies of declaring objects 
		as a garbage collection root.
		]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	PS_ROOT_OBJECT_STRATEGY

inherit
	COMPARABLE

create
	make_preserve,
	make_argument_of_insert,
	make_argument_of_write,
	make_everything

feature -- Status report

	is_preserve: BOOLEAN
			-- Is `Current' the `preserve' strategy?
			-- Definition of `preserve' strategy: Never declare a root automatically
			-- and preserve the previous status.
		do
			Result := internal_strategy = preserve
		end

	is_argument_of_insert: BOOLEAN
			-- Is `Current' the `argument_of_insert' strategy?
			-- Definition of `argument_of_insert' strategy: Declare only the object
			-- that is used as an argument in an insert operation as root.
			-- Do not touch the root status of any referenced objects.
		do
			Result := internal_strategy = argument_of_insert
		end


	is_argument_of_write: BOOLEAN
			-- Is `Current' the `argument_of_write' strategy?
			-- Definition of `argument_of_write' strategy: Declare only the object that
			-- is used as an argument in an insert or update operation as root.
			-- Do not touch the root status of any referenced objects.
		do
			Result := internal_strategy = argument_of_write
		end

	is_everything: BOOLEAN
			-- Is `Current' the `everything' strategy?
			-- Definition of `everything' strategy: Declare the argument object and
			-- all transitively referenced objects as root.
		do
			Result := internal_strategy = everything
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is `Current' a weaker strategy than `other'?
		do
			Result:= internal_strategy < other.internal_strategy
		end

feature -- Factory functions

	new_preserve: PS_ROOT_OBJECT_STRATEGY
			-- Create a new strategy with `is_preserve'.
		do
			create Result.make_preserve
		ensure
			correct: Result.is_preserve
		end

	new_argument_of_insert: PS_ROOT_OBJECT_STRATEGY
			-- Create a new strategy with `is_argument_of_insert'.
		do
			create Result.make_argument_of_insert
		ensure
			correct: Result.is_argument_of_insert
		end

	new_argument_of_write: PS_ROOT_OBJECT_STRATEGY
			-- Create a new strategy with `is_argument_of_write'.
		do
			create Result.make_argument_of_write
		ensure
			correct: Result.is_argument_of_write
		end

	new_everything: PS_ROOT_OBJECT_STRATEGY
			-- Create a new strategy with `everything'.
		do
			create Result.make_everything
		ensure
			correct: Result.is_everything
		end

feature {NONE} -- Initialization

	make_preserve
			-- Initialize to `is_preserve'.
		do
			internal_strategy := preserve
		ensure
			correct: is_preserve
		end

	make_argument_of_insert
			-- Initialize to `is_argument_of_insert'.
		do
			internal_strategy := argument_of_insert
		ensure
			correct: is_argument_of_insert
		end

	make_argument_of_write
			-- Initialize to `is_argument_of_write'.
		do
			internal_strategy := argument_of_write
		ensure
			correct: is_argument_of_write
		end

	make_everything
			-- Initialize to `is_everyting'.
		do
			internal_strategy := everything
		ensure
			correct: is_everything
		end

feature {PS_ROOT_OBJECT_STRATEGY} -- Implementation

	internal_strategy: NATURAL_8
			-- The internal strategy.

feature {NONE} -- Constants

	preserve: NATURAL_8 = 1
			-- Representation for `is_preserve'.

	argument_of_insert: NATURAL_8 = 2
			-- Representation for `is_argument_of_insert'.

	argument_of_write: NATURAL_8 = 3
			-- Representation for `is_argument_of_write'.

	everything: NATURAL_8 = 4
			-- Representation for `is_everything'.

invariant
	valid_internal_strategy: 1 <= internal_strategy and internal_strategy <= 4

end
