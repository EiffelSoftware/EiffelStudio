indexing
	description: "Redirects output to COM interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_HTML_DOC_DEGREE_OUTPUT
	
inherit
	DEGREE_OUTPUT
		redefine
			put_string,
			put_header,
			put_class_document_message,
			put_case_class_message,
			put_start_documentation,
			put_initializing_documentation
		end
		
	ERROR_HANDLER
		rename
			make as make_error
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_callback: like callback) is
			-- Initialize structure.
		do
			make_error
			callback := a_callback
		ensure
			callback_set: callback = a_callback
		end

feature -- Access

	interrupted: BOOLEAN
			-- was generation interrupted?		

feature -- Start output features

	put_header (displayed_version_number: STRING) is
			-- output header
		do
			callback.event_output_header (displayed_version_number)
		end
		
	put_string (s: STRING) is
			-- output string `s'
		do
			callback.event_output_string (s)
		end

	put_start_documentation (total_num: INTEGER; type: STRING) is
			-- output start documentation message
		do
			put_string ("Starting Documentation")
			total_number := total_num
		end

	put_initializing_documentation is
			-- output initializing message
		do
			callback.event_notify_initalizing_documentation
		end
		
	put_class_document_message (c: CLASS_C) is
			-- Put the class name to the output
		local
			l_continue: BOOLEAN_REF
		do
			processed := processed + 1
			callback.event_output_class_document_message ("Creating documentation for '" + c.name + "'")
			create l_continue
			callback.event_should_continue (l_continue)
			if not l_continue.item then
				interrupt
			end
			callback.event_notify_percentage_complete (((processed * 100) / (total_number)).floor)
		end
		
	put_case_class_message (c: CLASS_C) is
			-- output class name
		do
			put_class_document_message (c)	
		end
		
feature {NONE} -- Implementation

	callback: CEIFFEL_HTML_DOCUMENTATION_GENERATOR_COCLASS
		-- client to notify

	interrupt is
			-- interrupts generation of HTML documentation
		do
			interrupted := True
			insert_interrupt_error (False)
			put_string ("Generation interrupted!")
		ensure
			is_interrupted: interrupted
		end
		
invariant
	callback_not_void: callback /= Void
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class COM_HTML_DOC_DEGREE_OUTPUT
