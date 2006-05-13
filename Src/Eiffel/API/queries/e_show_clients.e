indexing

	description:
		"Command to display clients of `current_class'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLIENTS

inherit
	E_CLASS_CMD
		redefine
			criterion,
			domain_generator
		end

create

	make, default_create

feature -- Execution

feature -- Output

	work is
			-- Execute Current command.	
		local
			l_domain: QL_CLASS_DOMAIN
			l_formatter: like text_formatter
		do
			text_formatter.add_new_line;
			l_domain ?= system_target_domain.new_domain (domain_generator)
			check l_domain /= Void end
			if not l_domain.is_empty then
				l_formatter := text_formatter
				l_domain.sort (agent class_name_tester)
				from
					l_domain.start
				until
					l_domain.after
				loop
					l_domain.item.class_c.append_signature (l_formatter, True)
					l_formatter.add_new_line
					l_domain.forth
				end
			end
		end

	criterion: QL_CRITERION is
			-- Criterion used in current command
		do
			create {QL_CLASS_CLIENT_RELATION_CRI}Result.make (
				query_class_item_from_class_c (current_class).wrapped_domain,
				class_client_relation)
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

	class_name_tester (class_a, class_b: QL_CLASS): BOOLEAN is
			-- Compare name of `class_a' and `class_b'.
		require
			class_a_attached: class_a /= Void
			class_b_attached: class_b /= Void
		do
			Result := class_a.name < class_b.name
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

end -- class E_SHOW_CLIENTS
