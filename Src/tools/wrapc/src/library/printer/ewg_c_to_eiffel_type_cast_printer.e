note

	description:

		"C type cast printer for C to Eiffel glue code"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_TO_EIFFEL_TYPE_CAST_PRINTER

inherit

	EWG_C_TYPE_CAST_PRINTER
		rename
			make as make_printer,
			make_string as make_string_printer
		redefine
			can_be_printed_from_type,
			do_format
		end

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

create

	make,
	make_string

feature {NONE} -- Initialization

	make (an_output_stream: like output_stream; an_eiffel_compiler_mode: like eiffel_compiler_mode)
			-- Create new printer with `a_output_stream' as output stream.
		require
			an_output_stream_not_void: an_output_stream /= Void
			an_eiffel_compiler_mode_not_void: an_eiffel_compiler_mode /= Void
		do
			make_printer (an_output_stream)
			eiffel_compiler_mode := an_eiffel_compiler_mode
		ensure
			output_stream_set: output_stream = an_output_stream
			eiffel_compiler_mode_set: eiffel_compiler_mode = an_eiffel_compiler_mode
		end

	make_string (an_output_string: STRING; an_eiffel_compiler_mode: like eiffel_compiler_mode)
			-- Create new printer which appends to `an_output_string'.
		require
			an_output_string_not_void: an_output_string /= Void
			an_eiffel_compiler_mode_not_void: an_eiffel_compiler_mode /= Void
		do
			make_string_printer (an_output_string)
			eiffel_compiler_mode := an_eiffel_compiler_mode
		ensure
			eiffel_compiler_mode_set: eiffel_compiler_mode = an_eiffel_compiler_mode
		end

feature -- Status

	eiffel_compiler_mode: EWG_EIFFEL_COMPILER_MODE

	can_be_printed_from_type (a_type: EWG_C_AST_TYPE; a_declarator: STRING): BOOLEAN
		do
			Result := Precursor (a_type, a_declarator) or
				(a_type.skip_consts_and_pointers.is_array_type and not
				 a_type.skip_const_pointer_and_array_types.is_anonymous)
		end

feature {NONE} -- Implementation

	do_format (a_type: EWG_C_AST_TYPE)
			-- Format the cast for  `a_type'.
		require else
			a_type_not_void: a_type /= Void
		do
			if eiffel_compiler_mode.is_ise_mode then
				if a_type.based_type_recursive.is_function_type then
					Precursor (a_type)
				end
			end
		end

invariant

	eiffel_compiler_mode_not_void: eiffel_compiler_mode /= Void

end
