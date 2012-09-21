﻿note
	description: "Error that occurred within a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class FEATURE_ERROR

inherit
	EIFFEL_ERROR
		redefine
			trace, file_name, trace_primary_context
		end

feature -- Properties

	e_feature: E_FEATURE
			-- Feature involved in the error

	written_class: CLASS_C
			-- Class where the code is originally written.
			-- (Non-void if it differs from `class_c'.)

	file_name: like {ERROR}.file_name
		do
			if written_class = Void then
				Result := class_c.file_name
			else
				Result := written_class.file_name
			end
		ensure then
			file_name_not_void: Result /= Void
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Propertires

	feature_name: STRING
			-- If e_feature is Void then use feature name
			-- (if this is Void then feature occurred in
			-- the invariant)

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER)
			-- Output the error message.
		local
			l_group: CONF_GROUP
			l_feature: like e_feature
		do
			print_error_message (a_text_formatter)
			if is_class_defined then
				l_group := a_text_formatter.context_group
				a_text_formatter.set_context_group (class_c.group)
				a_text_formatter.add ("Class: ")
				class_c.append_signature (a_text_formatter, False)
				a_text_formatter.add_new_line

					-- Display source class only if different.
				if written_class /= Void and then class_c /= written_class then
					a_text_formatter.add ("Source class: ")
					written_class.append_signature (a_text_formatter, False)
					a_text_formatter.add_new_line
				end
			end

			a_text_formatter.add ("Feature: ")
			if is_class_defined and then line > 0 then
				if e_feature /= Void then
						-- Take the feature from source class if different
					if written_class /= Void and then class_c /= written_class then
						l_feature := e_feature.ancestor_version (written_class)
					end
					if l_feature = Void then
						l_feature := e_feature
					end
					a_text_formatter.add_feature_error (l_feature, e_feature.name_32, line)
				elseif feature_name /= Void then
					a_text_formatter.add_feature_error (e_feature, encoding_converter.utf8_to_utf32 (feature_name), line)
				else
					a_text_formatter.add ("inheritance or invariant clause")
				end
			elseif e_feature /= Void then
				e_feature.append_name (a_text_formatter)
			elseif feature_name /= Void then
				a_text_formatter.add (encoding_converter.utf8_to_utf32 (feature_name))
			elseif is_class_defined then
				a_text_formatter.add ("inheritance or invariant clause")
			else
				a_text_formatter.add ("Eiffel Configuration File")
			end
			a_text_formatter.add_new_line
			build_explain (a_text_formatter)
			if is_class_defined and line > 0 then
				if written_class = Void then
					print_context_of_error (class_c, a_text_formatter)
				else
					print_context_of_error (written_class, a_text_formatter)
				end
			end
			a_text_formatter.set_context_group (l_group)
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- Build the primary context string so errors can be navigated to
		local
			l_class: detachable CLASS_C
			l_feature: detachable like e_feature
		do
			l_class := written_class
			if l_class = Void then
				l_class := class_c
			end
			l_feature := e_feature
			if a_text_formatter /= Void and then l_feature /= Void and then l_class /= Void then
				print_context_feature (a_text_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {COMPILER_EXPORTER} -- Implementation

	set_feature (f: FEATURE_I)
			-- Assign `f' to `feature'.
		require
			valid_f: f /= Void
			non_void_class_c: class_c /= Void
		do
			e_feature := f.enclosing_feature.api_feature (class_c.class_id)
		end

	set_written_class (c: CLASS_C)
			-- Set `written_class' to `c'.
		do
			written_class := c
		ensure
			written_class_set: written_class = c
		end

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

end -- class FEATURE_ERROR
