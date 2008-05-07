indexing
	description: "Warning for inherited routines which call unqualified replicated features but themselves are not replicated"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class REPLICATED_FEATURE_CALL_WARNING

inherit
	EIFFEL_WARNING
		redefine
			trace_primary_context,
			build_explain,
			print_single_line_error_message,
			help_file_name
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like associated_class; a_feature, a_callee: FEATURE_I) is
			-- New instance of replicated feature call in `a_feat' from `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			associated_class := a_class
			associated_feature := a_feature.api_feature (a_feature.written_in)
			callee_feature := a_callee.api_feature (a_feature.written_in)
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Properties

	associated_feature: E_FEATURE
			-- Feature making the replicated call.

	callee_feature: E_FEATURE
			-- Unqualified replicated callee that is incorrectly called my a non-replicated feature.

	code: STRING is "Replicated Feature Call"
			-- Error code

	help_file_name: STRING is "replicated_feature_call_warning"
			-- Name of file with error description

feature -- Output

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		do
			if associated_feature = Void then
				Precursor (a_text_formatter)
			else
				a_text_formatter.add_group (associated_class.group, associated_class.group.name)
				a_text_formatter.add (".")
				associated_class.append_name (a_text_formatter)
				a_text_formatter.add (".")
				associated_feature.append_name (a_text_formatter)
			end
		end

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Class: ")
			associated_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Feature: ")
			associated_feature.append_name (a_text_formatter)
			a_text_formatter.add_new_line
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Displays single line help in `a_text_formatter'.
		do
			Precursor (a_text_formatter)
			a_text_formatter.add_space
			a_text_formatter.add ("The repeatedly inherited routine `")
			associated_feature.append_name (a_text_formatter)
			a_text_formatter.add ("' is not replicated but is calling the unqualified feature `")
			callee_feature.append_name (a_text_formatter)
			a_text_formatter.add ("' that is replicated in the same inheritance branch of ")
			associated_class.append_name (a_text_formatter)
			a_text_formatter.add (".")
		end

invariant
	associated_feature_not_void: associated_feature /= Void

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

end
