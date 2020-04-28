note

	description:

		"TODO"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_COMPOSITE_DECLARATION_PRINTER

inherit

	EWG_ABSTRACT_C_DECLARATION_PRINTER
		redefine
			can_be_printed_from_type,
			make_internal
		end

create

	make,
	make_string

feature {NONE} -- Implementation

	make_internal
		do
			Precursor
			create {DS_LINKED_LIST[EWG_ABSTRACT_C_DECLARATION_PRINTER]} printer_list.make_default
		end

feature -- Access

	printer_list: DS_LIST [EWG_ABSTRACT_C_DECLARATION_PRINTER]

feature -- Element Change

	add_printer (a_printer: EWG_ABSTRACT_C_DECLARATION_PRINTER)
		require
			a_printer_not_void: a_printer /= Void
		do
			printer_list.force_last (a_printer)
		ensure
			printer_added: printer_list.has (a_printer)
		end

feature -- Status

	can_be_printed_from_type (a_type: EWG_C_AST_TYPE; a_declarator: STRING): BOOLEAN
		local
			cs: DS_LIST_CURSOR [EWG_ABSTRACT_C_DECLARATION_PRINTER]
		do
			Result := True
			from
				cs := printer_list.new_cursor
				cs.start
			until
				cs.off or not Result
			loop
				if not cs.item.can_be_printed_from_type (a_type, a_declarator) then
					Result := False
				else
					cs.forth
				end
			end
		end

feature -- Printing

	print_declaration_from_type (a_type: EWG_C_AST_TYPE; a_declarator: STRING)
		local
			cs: DS_LIST_CURSOR [EWG_ABSTRACT_C_DECLARATION_PRINTER]
		do
			from
				cs := printer_list.new_cursor
				cs.start
			until
				cs.off
			loop
				cs.item.print_declaration_from_type (a_type, a_declarator)
				cs.forth
			end
		end

invariant

	printer_list_not_void: printer_list /= Void
--	printer_list_doesnt_have_void: not printer_list.has (Void)

end
