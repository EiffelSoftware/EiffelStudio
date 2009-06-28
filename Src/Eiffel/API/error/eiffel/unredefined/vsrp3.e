note

	description: "Error if root creation procedure is not precondition-free."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VSRP3

inherit

	EIFFEL_ERROR
		redefine
			build_explain,
			subcode,
			trace,
			trace_primary_context
		end

create
	make

feature {NONE} -- Creation

	make (c: CLASS_C; t: CL_TYPE_A; p: FEATURE_I)
		require
			c_attached: c /= Void
			t_attached: t /= Void
			p_attached: p /= Void
		do
			set_class (c)
			root_type := t
			creation_procedure := p.api_feature (p.written_in)
		end

feature -- Properties

	code: STRING = "VSRP"
			-- Error code

	subcode: INTEGER = 3
			-- Sub code of error

	root_type: CL_TYPE_A
			-- Root type involved in the error

	creation_procedure: E_FEATURE
			-- Creation procedure name involved in the error

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			print_error_message (a_text_formatter)
			build_explain (a_text_formatter)
		end

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_text_formatter.add ("Root type: ")
			root_type.append_to  (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Creation feature: ")
			creation_procedure.append_signature (a_text_formatter)
			a_text_formatter.add_new_line
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			if
				a_text_formatter /= Void and then
				attached creation_procedure as f and then
				attached class_c as c
			then
				print_context_feature (a_text_formatter, f, c)
			else
				Precursor (a_text_formatter)
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class VSRT1
