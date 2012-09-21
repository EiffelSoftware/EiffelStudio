note
	description: "Warning in an Eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_WARNING

inherit
	COMPILER_WARNING
		redefine
			has_associated_file, trace_primary_context, associated_class
		end

	ERROR_CONTEXT_PRINTER
		export
			{NONE} all
		end

feature -- Properties

	associated_class: CLASS_C
			-- Class where the error is encountered

	file_name: like {ERROR}.file_name
			-- File where error is encountered
		do
			Result := associated_class.file_name
		end

	has_associated_file: BOOLEAN = True
			-- Current is associated to a file/class

feature -- Output

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- Build the primary context string so errors can be navigated to
		do
			if
				a_text_formatter /= Void and then
				attached associated_class as l_class
			then
				print_context_class (a_text_formatter, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

invariant
	associated_class_not_void: associated_class /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
