note
	description: "Unknown type."

class
	UNKNOWN_TYPE_A

inherit
	TYPE_A
		redefine
			backward_conform_to,
			has_associated_class,
			is_attached,
			is_computable,
			is_initialization_required,
			is_known,
			same_as
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			-- Not used.
		end

feature -- Status report

	has_associated_class: BOOLEAN = False
			-- <Precursor>

	is_attached: BOOLEAN = True
			-- <Precursor>

	is_initialization_required: BOOLEAN = False
			-- <Precursor>
			-- Pretend that this is a self-initializing type to relax requirements for unknown types.

	is_known: BOOLEAN = False
			-- <Precursor>

	is_computable: BOOLEAN
			-- <Precursor>
		do
			-- False here.
		end

feature -- Access

	base_class: detachable CLASS_C
			-- <Precursor>
		do
			-- Void here.
		end

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := {SHARED_GEN_CONF_LEVEL}.max_dtype
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			-- False by default.
		end

	backward_conform_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- <Precursor>
		do
				-- `Result = true', but type information may be recorded by this call.
			Precursor (a_context_class, other).do_nothing
				-- Assume that the code is correct.
			Result := True
		end

feature -- Comparison

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		do
			-- False by default.
		end

feature -- Generic conformance

	create_info: CREATE_INFO
			-- <Precursor>
		do
		ensure then
			is_generated: False
		end

feature -- Output

	dump: STRING
			-- <Precursor>
		do
			Result := "unknown"
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- <Precursor>
		do
			a_text_formatter.add (once "unknown")
		end

feature {TYPE_A} -- Helpers

	internal_conform_to (a_context_class: CLASS_C; other: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
				-- Assume that the code is correct.
			Result := True
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
