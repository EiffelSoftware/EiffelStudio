indexing

	description:
		"Abstract description for a class format command which%
		%displays features of `current_class' that follow `criterium'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_CLASS_FORMAT_CMD

inherit
	SHARED_EIFFEL_PROJECT

	E_CLASS_CMD
		redefine
			domain_generator
		end

feature -- Access

	display_feature (f: E_FEATURE; st: TEXT_FORMATTER) is
			-- Display feature `f' defined in class `c'
			-- to `st'.
		require
			f_not_void: f /= Void
			st_not_void: st /= Void
		do
			f.append_signature (st)
		end

feature -- Execution

	work is
			-- Execute Current command.	
		local
			l_domain: QL_FEATURE_DOMAIN
			l_formatter: like text_formatter
			l_last_class: CLASS_C
			l_feature: QL_FEATURE
			l_is_first: BOOLEAN
		do
			text_formatter.add_new_line;
			l_domain ?= query_class_item_from_class_c (current_class).wrapped_domain.new_domain (domain_generator)
			check l_domain /= Void end
			if not l_domain.is_empty then
				l_formatter := text_formatter
				l_domain.sort (agent class_name_tester)
				from
					l_is_first := True
					l_domain.start
				until
					l_domain.after
				loop
					l_feature := l_domain.item
					if l_last_class = Void or else l_last_class.class_id /= l_feature.written_class.class_id then
						l_last_class := l_feature.written_class
						if not l_is_first then
							text_formatter.add_new_line
						else
							l_is_first := False
						end
						text_formatter.add (output_interface_names.class_word)
						text_formatter.add_space
						l_last_class.append_signature (text_formatter, True)
						text_formatter.add (output_interface_names.colon)
						text_formatter.add_new_line
						text_formatter.add_new_line
					end
					l_formatter.add_indent
					if l_feature.is_real_feature then
						display_feature (l_feature.e_feature, l_formatter)
					else
						l_formatter.add (l_feature.name)
					end
					l_formatter.add_new_line
					l_domain.forth
				end
			end
		end

feature {NONE} -- Implementation

	any_class: CLASS_C is
		once
			Result := Eiffel_system.any_class.compiled_class
		end;

	domain_generator: QL_DOMAIN_GENERATOR is
			-- Domain generator used in current command
		do
			create {QL_FEATURE_DOMAIN_GENERATOR}Result
			Result.set_criterion (criterion)
			Result.enable_fill_domain
		ensure then
			result_attached: Result /= Void
		end

	class_name_tester (feature_a, feature_b: QL_FEATURE): BOOLEAN is
			-- Compare name of `feature_a' and `feature_b'.
		require
			feature_a_attached: feature_a /= Void
			feature_b_attached: feature_b /= Void
		local
			l_written_name_a: STRING
			l_written_name_b: STRING
		do
			l_written_name_a := feature_a.written_class.name
			l_written_name_b := feature_b.written_class.name
			if l_written_name_a.is_equal (l_written_name_b) then
				Result := feature_a.name < feature_b.name
			else
				Result := l_written_name_a < l_written_name_b
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

end -- class E_CLASS_FORMAT_CMD
