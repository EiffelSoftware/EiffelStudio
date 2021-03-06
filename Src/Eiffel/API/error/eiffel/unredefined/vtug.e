﻿note
	description: "Error when a generic type has not the exact number of generic parameters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class VTUG

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined, trace_primary_context
		end

feature -- Properties

	code: STRING = "VTUG"

	e_feature: E_FEATURE

	type: TYPE_A
			-- Type violating the rule.

	base_class: CLASS_C

	is_in_class_constraint: BOOLEAN
			-- Did the invalid type appeared in a constraint of a generic class?

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	entity_name: STRING
			-- I-th argument of the involved feature?

feature -- Access

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := Precursor and then
				type /= Void and then
				base_class /= Void
		ensure then
			valid_type: Result implies type /= Void;
			valid_base_class: Result implies base_class /= Void;
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			if e_feature /= Void then
				a_text_formatter.add ("In feature: ")
				e_feature.append_name (a_text_formatter)
			elseif is_class_defined then
				if is_in_class_constraint then
					a_text_formatter.add ("In generic constraint")
				else
					a_text_formatter.add ("In inheritance clause")
				end
			else
				a_text_formatter.add ("In Eiffel Configuration File")
			end
			a_text_formatter.add_new_line
			if entity_name /= Void then
				a_text_formatter.add ("Entity name: ")
				a_text_formatter.add (encoding_converter.utf8_to_utf32 (entity_name))
				a_text_formatter.add_new_line
			end
			a_text_formatter.add ("Invalid type: ")
			type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Base class: ")
			base_class.append_signature (a_text_formatter, False)
			a_text_formatter.add_new_line
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- Build the primary context string so errors can be navigated to
		do
			if
				a_text_formatter /= Void and then
				attached e_feature as l_feature and then
				attached class_c as l_class
			then
				print_context_feature (a_text_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {COMPILER_EXPORTER}

	set_base_class (c: CLASS_C)
		require
			valid_c: c /= Void
		do
			base_class := c
		end

	set_type (t: TYPE_A)
			-- Assign `t' to `type'.
		require
			valid_t: t /= Void
		do
			type := t
		end

	set_feature (f: FEATURE_I)
		do
			if f /= Void then
				e_feature := f.enclosing_feature.api_feature (f.written_in)
			end
		end

	set_entity_name (i: STRING)
			-- Assign `i' to `entity_name'?
		do
			entity_name := i
		end

	set_is_in_class_constraint (v: like is_in_class_constraint)
			-- Assign `v' to `is_in_class_constraint'.
		do
			is_in_class_constraint := v
		ensure
			is_in_class_constraint_set: is_in_class_constraint = v
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
