note
	description: "Error when an expression cannot be used in an instance-free feature."

class VUCR_BODY

inherit
	VUCR
		rename
			make as make_vucr
		end

create
	make_attribute,
	make_current,
	make_feature,
	make_precursor,
	make_inline_agent,
	make_unqualified_agent

feature {NONE} -- Creation

	make (f: FEATURE_I; c: CLASS_C; w: detachable CLASS_C; l: LOCATION_AS)
			-- Create an error for feature `f` of class `c` in the code in class `w` at location `l`.
		require
			f_attached: attached f
			c_attached: attached c
			l_attached: attached l
		do
			make_vucr (f, c, l)
			written_class := if attached w then w else f.written_class end
		ensure
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

	make_current (f: FEATURE_I; c, w: CLASS_C; l: LOCATION_AS)
			-- Create an error for the case when Current is used in an instance-free feature `f` of class `c` in the code in class `w` at location `l`.
		do
			make (f, c, w, l)
		ensure
			not_is_agent: not is_agent
			not_is_attribute: not is_attribute
			not_is_precursor: not is_precursor
			callee_unset: not attached callee
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

	make_attribute (a: FEATURE_I; f: FEATURE_I; c, w: CLASS_C; l: LOCATION_AS)
			-- Create an error for the case when an attribute `a` is used in an instance-free feature `f` of class `c` in the code in class `w` at location `l`.
		do
			make (f, c, w, l)
			callee := a.e_feature
			is_attribute := True
		ensure
			not_is_agent: not is_agent
			is_attribute: is_attribute
			not_is_precursor: not is_precursor
			callee_set: attached callee
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

	make_feature (a: FEATURE_I; f: FEATURE_I; c, w: CLASS_C; l: LOCATION_AS)
			-- Create an error for the case when a non-instance-free feature `a` is used in an instance-free feature `f` of class `c` in the code in class `w` at location `l`.
		do
			make (f, c, w, l)
			callee := a.e_feature
		ensure
			not_is_agent: not is_agent
			not_is_attribute: not is_attribute
			not_is_precursor: not is_precursor
			callee_set: attached callee
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

	make_precursor (a: FEATURE_I; f: FEATURE_I; c, w: CLASS_C; l: LOCATION_AS)
			-- Create an error for the case when a non-instance-free precursor `a` is used in an instance-free feature `f` of class `c` in the code in class `w` at location `l`.
		do
			make (f, c, w, l)
			callee := a.e_feature
			is_precursor := True
		ensure
			not_is_agent: not is_agent
			not_is_attribute: not is_attribute
			is_precursor: is_precursor
			callee_set: attached callee
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

	make_inline_agent (f: FEATURE_I; c, w: CLASS_C; l: LOCATION_AS)
			-- Create an error for the case when an inline agent is used in an instance-free feature `f` of class `c` in the code in class `w` at location `l`.
		do
			make (f, c, w, l)
			is_agent := True
		ensure
			is_agent: is_agent
			not_is_attribute: not is_attribute
			not_is_precursor: not is_precursor
			callee_unset: not attached callee
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

	make_unqualified_agent (a: FEATURE_I; f: FEATURE_I; c, w: CLASS_C; l: LOCATION_AS)
			-- Create an error for the case when an unqualified agent `a` is used in an instance-free feature `f` of class `c` in the code in class `w` at location `l`.
		do
			make (f, c, w, l)
			callee := a.e_feature
			is_agent := True
		ensure
			is_agent: is_agent
			not_is_attribute: not is_attribute
			not_is_precursor: not is_precursor
			callee_set: attached callee
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

feature {NONE} -- Access

	callee: detachable E_FEATURE
			-- A descriptor of an attribute used in the instance-free feature identified by `e_feature`.

	kind: NATURAL

	is_agent: BOOLEAN
			-- Is agent used?

	is_attribute: BOOLEAN
			-- Is attribute used?

	is_precursor: BOOLEAN
			-- Is precursor used?

feature {NONE} -- Output

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			if is_agent then
					-- Erroneous use of an agent.
				if attached callee as a then
					format_elements (t, locale.translation_in_context ("[
								Implementation contraint: The class feature {1} uses the agent {2} of an unqualified form.
								What to do: Remove the agent from the code or make the feature a non-class one.
							]", "compiler.error"),
						<<agent e_feature.append_name, agent a.append_name>>)
				else
					format_elements (t, locale.translation_in_context ("[
								Implementation contraint: The class feature {1} uses an inline agent.
								What to do: Remove the inline agent from the code or make the feature a non-class one.
							]", "compiler.error"),
						<<agent e_feature.append_name>>)
				end
			elseif attached callee as a then
				if is_attribute then
						-- Erroneous use of an attribute.
					format_elements (t, locale.translation_in_context ("[
								Error: The class feature {1} uses the attribute {2}.
								What to do: Remove the attribute {2} from the code or make the feature a non-class one.
							]", "compiler.error"),
						<<agent e_feature.append_name, agent a.append_name>>)
				elseif is_precursor then
						-- Erroneous use of a non-instance-free precursor.
					format_elements (t, locale.translation_in_context ("[
								Error: The class feature {1} calls the non-class feature {2}.
								What to do:
									- remove the call to {2} from the code or
									- make {1} a non-class feature or
									- make the precursor {3} a class feature.
							]", "compiler.error"),
						<<
							agent e_feature.append_name,
							agent {TEXT_FORMATTER}.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_precursor_keyword, a),
							agent a.append_name
						>>)
				else
						-- Erroneous use of a non-instance-free feature.
					format_elements (t, locale.translation_in_context ("[
								Error: The class feature {1} calls the non-class feature {2}.
								What to do:
									- remove the call to {2} from the code or
									- make {1} a non-class feature or
									- make {2} a class feature.
							]", "compiler.error"),
						<<agent e_feature.append_name, agent a.append_name>>)
				end
			else
					-- Erroneous use of Current.
				format_elements (t, locale.translation_in_context ("[
							Error: The class feature {1} uses {2}.
							What to do: Remove {2} from the code or make the feature a non-class one.
						]", "compiler.error"),
					<<agent e_feature.append_name, agent {TEXT_FORMATTER}.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_current, Void)>>)
			end
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			if is_agent then
				if attached callee as a then
					format_elements (t, locale.translation_in_context ("The class feature {1} uses the agent {2} of the unqualified form.", "compiler.error"),
						<<agent e_feature.append_name, agent a.append_name>>)
				else
					format_elements (t, locale.translation_in_context ("The class feature {1} uses an inline agent.", "compiler.error"),
						<<agent e_feature.append_name>>)
				end
			elseif attached callee as a then
				if is_attribute then
					format_elements (t, locale.translation_in_context ("The class feature {1} uses the attribute {2}.", "compiler.error"),
						<<agent e_feature.append_name, agent a.append_name>>)
				elseif is_precursor then
					format_elements (t, locale.translation_in_context ("The class feature {1} calls the non-class feature {2}.", "compiler.error"),
						<<agent e_feature.append_name, agent {TEXT_FORMATTER}.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_precursor_keyword, a)>>)
				else
					format_elements (t, locale.translation_in_context ("The class feature {1} uses the non-class feature {2}.", "compiler.error"),
						<<agent e_feature.append_name, agent a.append_name>>)
				end
			else
				format_elements (t, locale.translation_in_context ("The class feature {1} uses {2}.", "compiler.error"),
					<<agent e_feature.append_name, agent {TEXT_FORMATTER}.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_current, Void)>>)
			end
		end

invariant
	consistent_agent: is_agent implies not (is_attribute or is_precursor)
	consistent_attribute: is_attribute implies not (is_agent or is_precursor)
	consistent_precursor: is_precursor implies not (is_agent or is_attribute)
	feature_attached_if_attribute: is_attribute implies attached callee
	feature_attached_if_precursor: is_precursor implies attached callee

note
	ca_ignore: "CA011", "CA011 – too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end
