indexing
	description: "Warning for inherited routines which call unqualified replicated features but themselves are not replicated"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class REPLICATED_FEATURE_CALL_WARNING

inherit
	COMPILER_WARNING
		undefine
			has_associated_file,
			is_defined,
			trace,
			trace_primary_context,
			process
		end

	FEATURE_ERROR
		undefine
			error_string
		redefine
			build_explain
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
			class_c ?= a_class
			associated_class := a_class
			e_feature := a_feature.api_feature (a_feature.written_in)
			callee_feature := a_callee.api_feature (a_feature.written_in)
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Properties

	callee_feature: E_FEATURE
			-- Unqualified replicated callee that is incorrectly called my a non-replicated feature.

	code: STRING is "VMCS"
			-- Error code

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Unqualified Call of Replicated Feature: ")
			callee_feature.append_name (a_text_formatter)
			a_text_formatter.add_new_line
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

end
