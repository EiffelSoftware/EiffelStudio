note
	description: "Factrory to create optional fixes for detected issues."

class
	FIX_FACTORY

inherit
	COMPILER_ERROR_VISITOR

create
	make

feature {NONE} -- Creation

	make
		do
		end

feature -- Basic operation

	fix_option (e: COMPILER_ERROR): detachable ITERABLE [FIX [TEXT_FORMATTER]]
			-- Available fixes for the issue `e'.
		do
			fix := Void
			e.process (Current)
			Result := fix
		end

feature {NONE} -- Access

	fix: detachable SPECIAL [FIX [TEXT_FORMATTER]]
			-- A collection of fixes to be returned by `fix_option'.

feature {COMPILER_ERROR} -- Visitor

	process_missing_local_type (e: MISSING_LOCAL_TYPE_ERROR)
			-- Visit `e'.
		do
			if attached e.suggested_type and then not e.written_class.lace_class.is_read_only then
				record_fix (create {FIX_MISSING_LOCAL_TYPE}.make (e))
			end
		end

	process_unused_local (e: UNUSED_LOCAL_WARNING)
			-- Visit `e'.
		do
			if not e.associated_class.lace_class.is_read_only then
				record_fix (create {FIX_UNUSED_LOCAL}.make (e))
			end
		end

feature {ERROR} -- Visitor

	process_bad_character (a_value: BAD_CHARACTER)
			-- <Precursor>
		do
		end

	process_basic_gen_type_err (a_value: BASIC_GEN_TYPE_ERR)
			-- <Precursor>
		do
		end

	process_error (a_value: ERROR)
			-- <Precursor>
		do
		end

	process_string_extension (a_value: STRING_EXTENSION)
			-- <Precursor>
		do
		end

	process_string_uncompleted (a_value: STRING_UNCOMPLETED)
			-- <Precursor>
		do
		end

	process_syntax_error (a_value: SYNTAX_ERROR)
			-- <Precursor>
		do
		end

	process_syntax_warning (a_value: SYNTAX_WARNING)
			-- <Precursor>
		do
		end

	process_user_defined_error (a_value: USER_DEFINED_ERROR)
			-- <Precursor>
		do
		end

	process_verbatim_string_uncompleted (a_value: VERBATIM_STRING_UNCOMPLETED)
			-- <Precursor>
		do
		end

	process_viin (a_value: VIIN)
			-- <Precursor>
		do
		end

	process_vvok (a_value: VVOK)
			-- <Precursor>
		do
		end

feature {NONE} -- Helper

	record_fix (f: FIX_FEATURE)
			-- Make `f' available via `fix_option'.
		do
				-- TODO: Support multiple fix options.
			create fix.make_filled (f, 1)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
