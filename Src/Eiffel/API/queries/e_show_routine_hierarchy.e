indexing
	description: "Command to display feature hierarchy"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E_SHOW_ROUTINE_HIERARCHY

inherit
	E_FEATURE_CMD
		redefine
			domain_generator
		end

feature -- Execution

	work is
			-- Perform current command.
		local
			l_domain: QL_FEATURE_DOMAIN
			l_formatter: like text_formatter
			l_feature: QL_FEATURE
			l_last_branch_id: INTEGER
			l_branch_id: INTEGER_REF
			l_is_written_class_displayed: BOOLEAN
			l_is_branch_displayed: BOOLEAN
		do
			l_domain ?= system_target_domain.new_domain (domain_generator)
			check l_domain /= Void end
			if not l_domain.is_empty then
				l_formatter := text_formatter
				l_domain.sort (agent feature_name_tester)
				l_is_written_class_displayed := is_written_class_displayed
				l_is_branch_displayed := is_branch_displayed
				from
					l_last_branch_id := -1
					l_domain.start
				until
					l_domain.after
				loop
					l_feature := l_domain.item
					if l_is_branch_displayed then
						l_branch_id ?= l_feature.data
						check l_branch_id /= Void end
						if l_last_branch_id /= l_branch_id.item then
							l_last_branch_id := l_branch_id.item
							l_formatter.add_new_line
							l_formatter.add (output_interface_names.history_branch)
							l_formatter.add_int (l_last_branch_id)
							l_formatter.add_new_line
							l_formatter.add (output_interface_names.separator)
							l_formatter.add_new_line
						end
					end
					l_feature.class_c.append_name (l_formatter)
					l_formatter.add (ti_Space)
					if l_feature.is_real_feature then
						l_feature.e_feature.append_signature (l_formatter)
					else
						l_formatter.add_string (l_feature.name)
					end
					if l_is_written_class_displayed then
						l_formatter.add_new_line
						l_formatter.add_indent
						l_formatter.add (output_interface_names.version_from_class)
						l_formatter.add_space
						l_feature.written_class.append_name (text_formatter)
					else
						if l_feature.written_class.class_id = current_feature.written_class.class_id then
							l_formatter.add_space
							l_formatter.add (output_interface_names.version_from)
						end
					end
					text_formatter.add_new_line
					l_domain.forth
				end
			end
		end

feature -- Status report

	is_written_class_displayed: BOOLEAN is
			-- Is current a command to display feature implementors?
		do
			Result := True
		end

	is_branch_displayed: BOOLEAN is
			-- Is branch information displayed?
		do
			Result := True
		end

feature{NONE} -- Implemenation

	domain_generator: QL_DOMAIN_GENERATOR is
			-- Domain generator used in current command
		do
			create {QL_FEATURE_DOMAIN_GENERATOR}Result
			Result.set_criterion (criterion)
			Result.enable_fill_domain
		ensure then
			result_attached: Result /= Void
		end

	feature_name_tester (feature_a, feature_b: QL_FEATURE): BOOLEAN is
			-- Compare name of `feature_a' and `feature_b'.
		require
			feature_a_attached: feature_a /= Void
			feature_b_attached: feature_b /= Void
		local
			l_a_branch_id: INTEGER_REF
			l_b_branch_id: INTEGER_REF
		do
			l_a_branch_id ?= feature_a.data
			l_b_branch_id ?= feature_b.data
			check
				l_a_branch_id /= Void
				l_b_branch_id /= Void
			end
			if l_a_branch_id.item = l_b_branch_id.item then
				Result := feature_a.class_c.topological_id < feature_b.class_c.topological_id
			else
				Result := l_a_branch_id.item < l_b_branch_id.item
			end
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
