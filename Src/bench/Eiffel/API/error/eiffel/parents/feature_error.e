indexing
	description: "Error that occurred within a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class FEATURE_ERROR

inherit
	EIFFEL_ERROR
		redefine
			trace, is_defined, file_name
		end

feature -- Properties

	e_feature: E_FEATURE
			-- Feature involved in the error

	feature_name: STRING
			-- If e_feature is Void then use feature name
			-- (if this is Void then feature occurred in
			-- the invariant)

	written_class: CLASS_C
			-- Class where the code is originally written.
			-- (Non-void if it differs from `class_c'.)

	file_name: STRING is
		do
			if written_class = Void then
				Result := class_c.file_name
			else
				Result := written_class.file_name
			end
		ensure then
			file_name_not_void: Result /= Void
		end

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined
		ensure then
			is_feature_defined: Result implies is_feature_defined
		end

	is_feature_defined: BOOLEAN is
			-- Is the feature defined for error?
		do
			Result := True
		ensure
			always_true: Result
		end

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER) is
			-- Output the error message.
		do
			print_error_message (a_text_formatter)
			a_text_formatter.add ("Class: ")
			class_c.append_signature (a_text_formatter, False)
			a_text_formatter.add_new_line
			if written_class /= Void then
				a_text_formatter.add ("Source class: ")
				written_class.append_signature (a_text_formatter, False)
				a_text_formatter.add_new_line
			end
			a_text_formatter.add ("Feature: ")
			if line > 0 then
				if e_feature /= Void then
					a_text_formatter.add_feature_error (e_feature, e_feature.name, line)
				elseif feature_name /= Void then
					a_text_formatter.add_feature_error (e_feature, feature_name, line)
				else
					a_text_formatter.add ("invariant")
				end
			elseif e_feature /= Void then
				e_feature.append_name (a_text_formatter)
			elseif feature_name /= Void then
				a_text_formatter.add (feature_name)
			else
				a_text_formatter.add ("invariant")
			end
			a_text_formatter.add_new_line
			build_explain (a_text_formatter)
			if line > 0 then
				if written_class = Void then
					print_context_of_error (class_c, a_text_formatter)
				else
					print_context_of_error (written_class, a_text_formatter)
				end
			end
		end

feature {COMPILER_EXPORTER} -- Implementation

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'.
		require
			valid_f: f /= Void
			non_void_class_c: class_c /= Void
		do
			e_feature := f.api_feature (class_c.class_id)
		end

	set_written_class (c: CLASS_C) is
			-- Set `written_class' to `c'.
		do
			written_class := c
		ensure
			written_class_set: written_class = c
		end

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

end -- class FEATURE_ERROR
