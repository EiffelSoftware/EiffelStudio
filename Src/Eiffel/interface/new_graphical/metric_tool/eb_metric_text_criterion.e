indexing
	description: "Criterion related to name (use a STRING and two BOOLEAN as arguments)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TEXT_CRITERION

inherit
	EB_METRIC_CRITERION
		redefine
			make,
			process,
			is_text_criterion
		end

create
	make,
	make_with_setting

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING) is
			-- Initialize `scope' with `a_scope' and `name' with `a_name'.
		do
			Precursor (a_scope, a_name)
			text := ""
		ensure then
			name_text_attached: text /= Void
		end

feature -- Access

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION is
			-- QL_CRITERION representing current criterion
		do
			check text /= Void end
			Result := criterion_factory_table.item (scope).criterion_with_name (name, [text, is_case_sensitive, is_identical_comparison_used])
			if Result /= Void and then is_negation_used then
				Result := not Result
			end
		end

	text: STRING
			-- Name text used in criterion

	is_case_sensitive: BOOLEAN
			-- Is `text' case-sensitive?

	is_identical_comparison_used: BOOLEAN
			-- Is identical comparison used?
			-- Override `is_case_sensitive'.

	is_parameter_valid: BOOLEAN is
			-- Is parameters of current criterion valid?
		do
			Result := not text.is_empty
		end

feature -- Setting

	set_text (a_name_text: STRING) is
			-- Set `text' with `a_name_text'.
		require
			a_name_text_attached: a_name_text /= Void
		do
			if text /= Void then
				text.wipe_out
				text.append (a_name_text)
			else
				create text.make_from_string (a_name_text)
			end
		ensure
			name_text_set: text /= Void and then text.is_equal (a_name_text)
		end

	enable_case_sensitive is
			-- Enable case sensitive.
		do
			is_case_sensitive := True
		ensure
			case_sensitive_enabled: is_case_sensitive
		end

	disable_case_sensitive is
			-- disable case sensitive.
		do
			is_case_sensitive := False
		ensure
			case_sensitive_disabled: not is_case_sensitive
		end

	enable_identical_comparison is
			-- Enable identical comparison.
		do
			is_identical_comparison_used := True
		ensure
			identical_comparison_enabled: is_identical_comparison_used
		end

	disable_identical_comparison is
			-- disable identical comparison.
		do
			is_identical_comparison_used := False
		ensure
			identical_comparison_disabled: not is_identical_comparison_used
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_text_criterion (Current)
		end

feature -- Status report

	is_text_criterion: BOOLEAN is True
			-- Is current a text criterion?

invariant
	name_text_attached: text /= Void

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
