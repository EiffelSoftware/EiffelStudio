indexing

	description:
		"Command to display descendants of `current_class'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_DESCENDANTS

inherit

	E_CLASS_CMD
		redefine
			domain_generator,
			criterion
		end

create
	make, default_create

feature -- Output

	work is
			-- Execute Current command.	
		local
			l_domain_generator: QL_CLASS_DOMAIN_GENERATOR
			l_domain: QL_CLASS_DOMAIN
			l_class: QL_CLASS
		do
			text_formatter.add_new_line
			l_class := query_class_item_from_class_c (current_class)
			l_domain ?= system_target_domain.new_domain (domain_generator)
			check l_domain /= Void end
			l_domain.compare_objects
			l_domain.start
			l_domain.search (l_class)
			check not l_domain.exhausted end
			processed_class.wipe_out
			rec_display_descendants (l_domain.item, 1, text_formatter)
		end

feature {NONE} -- Implementation

	rec_display_descendants (a_class: QL_CLASS; a_tab_count: INTEGER; a_text_formatter: TEXT_FORMATTER) is
			-- Display descendants of `a_class' recursively in `a_text_formatter'.
			-- `a_tab_count' indicates how many tabs should be prepended in each line.
		require
			a_class_attached: a_class /= Void
			a_tab_count_non_negative: a_tab_count >= 0
			a_text_formatter_attached: a_text_formatter /= Void
		local
			l_list: LIST [QL_CLASS]
			l_sorted_list: DS_ARRAYED_LIST [QL_CLASS]
		do
			add_tabs (a_text_formatter, a_tab_count)
			a_class.class_c.append_signature (a_text_formatter, True)
			if processed_class.has (a_class) then
				l_list ?= a_class.data
				if l_list /= Void and then not l_list.is_empty then
					a_text_formatter.add (output_interface_names.ellipse)
				end
				a_text_formatter.add_new_line
			else
				if processed_class.capacity = processed_class.count then
					processed_class.resize (processed_class.count + 50)
				end
				processed_class.put (a_class)
				a_text_formatter.add_new_line
				l_list ?= a_class.data
				if l_list /= Void and then not l_list.is_empty then
					create l_sorted_list.make (l_list.count)
					l_list.do_all (agent l_sorted_list.force_last)
					from
						l_sorted_list.start
					until
						l_sorted_list.after
					loop
						rec_display_descendants (l_sorted_list.item_for_iteration, a_tab_count + 1, a_text_formatter)
						l_sorted_list.forth
					end
				end
			end
		end

	processed_class: DS_HASH_SET [QL_CLASS] is
			-- List of processed classes
		do
			if processed_class_internal = Void then
				create processed_class_internal.make (50)
			end
			Result := processed_class_internal
		ensure
			result_attached: Result /= Void
		end

	processed_class_internal: like processed_class
			-- Implementation of `processed_class'

	criterion: QL_CRITERION is
			-- Criterion used in current command
		do
			create {QL_CLASS_DESCENDANT_RELATION_CRI}Result.make (
				query_class_item_from_class_c (current_class).wrapped_domain,
				class_descendant_relation)
		ensure then
			result_attached: Result /= Void
		end

	domain_generator: QL_DOMAIN_GENERATOR is
			-- Domain generator used in current command
		do
			create {QL_CLASS_DOMAIN_GENERATOR}Result
			Result.set_criterion (criterion)
			Result.enable_fill_domain
		ensure then
			result_attached: Result /= Void
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

end -- class E_SHOW_DESCENDANTS
