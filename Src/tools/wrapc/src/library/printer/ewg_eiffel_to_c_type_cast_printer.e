note

	description:

		"C type cast printer for Eiffel to C glue code"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_EIFFEL_TO_C_TYPE_CAST_PRINTER

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
			Result := Precursor (a_type, a_declarator) or a_type.skip_consts_and_pointers.is_array_type
		end

feature {NONE} -- Implementation

	do_format (a_type: EWG_C_AST_TYPE)
			-- Format the cast for `a_type'.
		require else
			a_type_not_void: a_type /= Void
		local
			type: EWG_C_AST_TYPE
		do
			type := a_type
			if
				a_type.skip_consts_and_aliases.is_struct_type or
					a_type.skip_consts_and_aliases.is_union_type
			then
				create {EWG_C_AST_POINTER_TYPE} type.make (a_type.header_file_name, a_type)
			end
			if not type.skip_consts_aliases_and_pointers.is_array_type then
				Precursor (type)
			end
		end

invariant

	eiffel_compiler_mode_not_void: eiffel_compiler_mode /= Void

end
