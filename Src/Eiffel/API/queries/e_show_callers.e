indexing

	description:
		"Command to display the senders of `current_feature'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CALLERS

inherit
	E_FEATURE_CMD
		redefine
			criterion,
			domain_generator
		end

	QL_SHARED_FEATURE_INVOKE_RELATION_TYPES

create
	make, default_create

feature -- Access

	features: QL_FEATURE_DOMAIN is
			-- Features as result of Current formatter
		do
			if {lt_result: QL_FEATURE_DOMAIN}system_target_domain.new_domain (domain_generator) then
				Result := lt_result
			else
				check Result /= Void end
			end
				-- We don't do `Result.distinct' here. For the reason:
				-- The distinct filter was to remove duplications
				-- when the source of the query contains duplications, but it
				-- is not the case here, because the source is single, which is
				-- `system_target_domain'.
		end

feature -- Status report

	to_show_all_callers: BOOLEAN;
			-- Is the format going to show all callers?

	flag: NATURAL_16
			-- Type of callers we are looking for.

	is_callee_displayed: BOOLEAN
			-- Does current command display callees?
			-- If not, callers are displayed.

feature -- Status setting

	set_all_callers (b: BOOLEAN) is
			-- Set `to_show_all_callers' with `b';
		do
			to_show_all_callers := b
		ensure
			show_all_callers_set: to_show_all_callers = b
		end

	set_flag (a_flag: like flag) is
			-- Set `flag' with `a_flag'.
		do
			flag := a_flag
		ensure
			flag_set: flag = a_flag
		end

	show_callers is
			-- Show callers.
		do
			is_callee_displayed := False
		ensure
			callers_displayed: not is_callee_displayed
		end

	show_callees is
			-- Show callees.
		do
			is_callee_displayed := True
		ensure
			callees_displayed: is_callee_displayed
		end

	set_current_feature (a_feature: like current_feature) is
			-- Set `current_feature' with `a_feature'.
		do
			current_feature := a_feature
		ensure
			current_feature_set: current_feature = a_feature
		end

feature -- Execution

	work is
			-- Execute the display of callers.
		local
			l_domain: QL_FEATURE_DOMAIN
			l_formatter: like text_formatter
			l_callee: QL_FEATURE
			l_caller: QL_FEATURE
			l_last_callee_written_class_id: INTEGER
			l_last_caller_class_id: INTEGER
			l_changed: BOOLEAN
		do
			l_domain := features
			if not l_domain.is_empty then
				l_domain.sort (agent feature_name_tester)
				l_formatter := text_formatter
				from
					l_domain.start
				until
					l_domain.after
				loop
					l_caller := l_domain.item
					l_callee ?= l_caller.data
					check
						l_callee /= Void
					end
					l_changed := False
					if l_callee.class_c.class_id /= l_last_callee_written_class_id then
						l_changed := True
						l_last_callee_written_class_id := l_callee.class_c.class_id
						if l_callee.is_real_feature then
							l_callee.e_feature.append_full_name (l_formatter)
						else
							l_formatter.add (l_callee.name)
						end
						l_formatter.add_space
						l_formatter.add (output_interface_names.from_word)
						l_formatter.add_space
						l_callee.class_c.append_name (l_formatter)
						l_formatter.add_new_line
					end
					if l_changed or else l_caller.class_c.class_id /= l_last_caller_class_id then
						l_last_caller_class_id := l_caller.class_c.class_id
						l_formatter.add_indent
						l_caller.class_c.append_name (l_formatter)
						l_formatter.add_new_line
					end
					l_formatter.add_indent
					l_formatter.add_indent
					if l_caller.is_real_feature then
						l_caller.e_feature.append_full_name (l_formatter)
					else
						l_formatter.add (l_caller.name)
					end
					l_formatter.add_new_line
					l_domain.forth
				end
			end
		end

feature {NONE} -- Implementation

	criterion: QL_CRITERION is
			-- Criterion used in current command
		local
			l_caller_type: like flag
			l_callee_type: like flag
		do
			if flag = {DEPEND_UNIT}.is_in_assignment_flag then
				l_caller_type := assigner_caller_type
				l_callee_type := assigner_callee_type
			elseif flag = {DEPEND_UNIT}.is_in_creation_flag then
				l_caller_type := creator_caller_type
				l_callee_type := creator_callee_type
			else
				l_caller_type := normal_caller_type
				l_callee_type := normal_callee_type
			end
			if is_callee_displayed then
				create {QL_FEATURE_CALLER_IS_CRI}Result.make (
					query_feature_item_from_e_feature (current_feature).wrapped_domain,
					l_callee_type, not to_show_all_callers)
			else
				create {QL_FEATURE_CALLERS_OF_CRI}Result.make (
					query_feature_item_from_e_feature (current_feature).wrapped_domain,
					l_caller_type, not to_show_all_callers)
			end
		ensure then
			result_attached: Result /= Void
		end

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
		local
			l_callee_a: QL_FEATURE
			l_callee_b: QL_FEATURE
		do
			l_callee_a ?= feature_a.data
			l_callee_b ?= feature_b.data
			check
				l_callee_a /= Void
				l_callee_b /= Void
			end
			if l_callee_a.class_c.topological_id /= l_callee_b.class_c.topological_id then
				Result := l_callee_a.class_c.topological_id < l_callee_b.class_c.topological_id
			else
				if not feature_a.class_c.name.is_equal (feature_b.class_c.name) then
					Result := feature_a.class_c.name < feature_b.class_c.name
				else
					Result := feature_a.name < feature_b.name
				end
			end
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
