indexing

	description:

	"[
		Eiffel class type validity fourth pass status checkers.
		Check whether all classes that appear in a type have their
		interface already successfully checked.
	]"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2007-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_CLASS_TYPE_STATUS_CHECKER4

inherit

	ET_AST_NULL_PROCESSOR
		redefine
			process_bit_feature,
			process_bit_n,
			process_class,
			process_class_type,
			process_generic_class_type,
			process_qualified_like_braced_type,
			process_qualified_like_type,
			process_tuple_type
		end

create

	make

feature -- Status report

	has_fatal_error: BOOLEAN
			-- Has a fatal error occurred?

feature -- Validity checking

	check_type_validity (a_type: ET_TYPE) is
			-- Check whether all classes that appear in `a_type'
			-- have their interface already successfully checked.
			-- Set `has_fatal_error' to True otherwise.
		require
			a_type_not_void: a_type /= Void
		do
			has_fatal_error := False
			a_type.process (Current)
		end

feature {NONE} -- Type validity

	check_bit_type_validity (a_type: ET_BIT_TYPE) is
			-- Check whether all classes that appear in `a_type'
			-- have their interface already successfully checked.
			-- Set `has_fatal_error' to True otherwise.
		require
			a_type_not_void: a_type /= Void
		local
			l_class: ET_CLASS
		do
			l_class := a_type.base_class
			if not l_class.interface_checked or else l_class.has_interface_error then
				set_fatal_error
			end
		end

	check_class_type_validity (a_type: ET_CLASS_TYPE) is
			-- Check whether all classes that appear in `a_type'
			-- have their interface already successfully checked.
			-- Set `has_fatal_error' to True otherwise.
		require
			a_type_not_void: a_type /= Void
		local
			l_class: ET_CLASS
			i, nb: INTEGER
			l_actuals: ET_ACTUAL_PARAMETER_LIST
		do
			l_class := a_type.base_class
			if not l_class.interface_checked or else l_class.has_interface_error then
				set_fatal_error
			else
				l_actuals := a_type.actual_parameters
				if l_actuals /= Void then
					nb := l_actuals.count
					from i := 1 until i > nb loop
						l_actuals.type (i).process (Current)
						if has_fatal_error then
							i := nb + 1 -- Jump out of the loop.
						end
						i := i + 1
					end
				end
			end
		end

	check_qualified_like_identifier_validity (a_type: ET_QUALIFIED_LIKE_IDENTIFIER) is
			-- Check whether all classes that appear in `a_type'
			-- have their interface already successfully checked.
			-- Set `has_fatal_error' to True otherwise.
		require
			a_type_not_void: a_type /= Void
		do
			a_type.target_type.process (Current)
		end

	check_tuple_type_validity (a_type: ET_TUPLE_TYPE) is
			-- Check whether all classes that appear in `a_type'
			-- have their interface already successfully checked.
			-- Set `has_fatal_error' to True otherwise.
		require
			a_type_not_void: a_type /= Void
		local
			l_class: ET_CLASS
			i, nb: INTEGER
			l_parameters: ET_ACTUAL_PARAMETER_LIST
		do
			l_class := a_type.base_class
			if not l_class.interface_checked or else l_class.has_interface_error then
				set_fatal_error
			else
				l_parameters := a_type.actual_parameters
				if l_parameters /= Void then
					nb := l_parameters.count
					from i := 1 until i > nb loop
						l_parameters.type (i).process (Current)
						if has_fatal_error then
							i := nb + 1 -- Jump out of the loop.
						end
						i := i + 1
					end
				end
			end
		end

feature {ET_AST_NODE} -- Type dispatcher

	process_bit_feature (a_type: ET_BIT_FEATURE) is
			-- Process `a_type'.
		do
			check_bit_type_validity (a_type)
		end

	process_bit_n (a_type: ET_BIT_N) is
			-- Process `a_type'.
		do
			check_bit_type_validity (a_type)
		end

	process_class (a_class: ET_CLASS) is
			-- Process `a_class'.
		do
			process_class_type (a_class)
		end

	process_class_type (a_type: ET_CLASS_TYPE) is
			-- Process `a_type'.
		do
			check_class_type_validity (a_type)
		end

	process_generic_class_type (a_type: ET_GENERIC_CLASS_TYPE) is
			-- Process `a_type'.
		do
			process_class_type (a_type)
		end

	process_qualified_like_braced_type (a_type: ET_QUALIFIED_LIKE_BRACED_TYPE) is
			-- Process `a_type'.
		do
			check_qualified_like_identifier_validity (a_type)
		end

	process_qualified_like_type (a_type: ET_QUALIFIED_LIKE_TYPE) is
			-- Process `a_type'.
		do
			check_qualified_like_identifier_validity (a_type)
		end

	process_tuple_type (a_type: ET_TUPLE_TYPE) is
			-- Process `a_type'.
		do
			check_tuple_type_validity (a_type)
		end

feature {NONE} -- Error handling

	set_fatal_error is
			-- Report a fatal error.
		do
			has_fatal_error := True
		ensure
			has_fatal_error: has_fatal_error
		end

end
