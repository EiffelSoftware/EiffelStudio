note

	description:

	"Prints list of C declarations"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_DECLARATION_LIST_PRINTER

inherit

	EWG_PRINTER
		rename
			make as make_printer,
			make_string as make_string_printer
		redefine
			make_internal
		end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

create

	make,
	make_string

feature {NONE} -- Initialization

	make (an_output_stream: like output_stream; a_declaration_printer: like declaration_printer)
			-- Create new formatter with `a_output_stream' as output stream.
		require
			an_output_stream_not_void: an_output_stream /= Void
			a_declaration_printer_not_void: a_declaration_printer /= Void
		do
			make_printer (an_output_stream)
			declaration_printer := a_declaration_printer
		ensure
			output_stream_set: output_stream = an_output_stream
			declaration_printer_set: declaration_printer = a_declaration_printer
		end

	make_string (an_output_string: STRING; a_declaration_printer: like declaration_printer)
			-- Create new formatter which appends to `an_output_string'.
		require
			an_output_string_not_void: an_output_string /= Void
			a_declaration_printer_not_void: a_declaration_printer /= Void
		do
			make_string_printer (an_output_string)
			declaration_printer := a_declaration_printer
		ensure
			declaration_printer_set: declaration_printer = a_declaration_printer
		end

	make_internal
		do
			Precursor
			create declarator_prefix.make (0)
		end

feature -- Status

	declarator_prefix: STRING

feature -- Status Setting

	set_declarator_prefix (a_declarator_prefix: like declarator_prefix)
		require
			a_declarator_prefix_not_void: a_declarator_prefix /= Void
		do
			declarator_prefix := a_declarator_prefix
		ensure
			declarator_prefix_set: declarator_prefix = a_declarator_prefix
		end

feature -- Formatting

	print_declaration_list (a_list: DS_LINEAR [EWG_C_AST_DECLARATION])
		require
			a_list_not_void: a_list /= Void
--			a_list_doesnt_have_void: not a_list.has (Void)
		local
			parameter_name_generator: EWG_UNIQUE_NAME_GENERATOR
			cs: DS_LINEAR_CURSOR [EWG_C_AST_DECLARATION]
			declarator: STRING
			string_stream: KL_STRING_OUTPUT_STREAM
		do
			from
				cs := a_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if attached cs.item.declarator as l_declarator then
					declarator := eiffel_parameter_name_from_c_parameter_name (l_declarator)
				else
					check
						is_anonymous: cs.item.is_anonymous
					end
					if parameter_name_generator = Void then
						create parameter_name_generator.make ("anonymous_")
					end
					create declarator.make (parameter_name_generator.prefixx.count + 3)
					create string_stream.make (declarator)
					parameter_name_generator.set_output_stream (string_stream)
					parameter_name_generator.generate_new_name
				end

				declaration_printer.print_declaration_from_type (cs.item.type, declarator_prefix + declarator)
				cs.forth
				if not cs.after then
					output_stream.put_string (", ")
				end
			end
		end

feature {NONE} -- Implementation

	declaration_printer: EWG_ABSTRACT_C_DECLARATION_PRINTER
			-- Declaration printer

invariant

	declaration_printer_not_void: declaration_printer /= Void
	declarator_prefix_not_void: declarator_prefix /= Void

end
