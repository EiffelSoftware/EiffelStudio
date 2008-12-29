note
	description: "[
						This class encapsualtes functionality and data needed to produce a proper
						info report for feature lookup on multi constraint (MC) formal generic type
						parameters.
						G -> {A, B, C} would be an example for our targeted construct.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MC_FEATURE_INFO

inherit

	LINKED_LIST [TUPLE [	feature_i: FEATURE_I;
							e_feature: E_FEATURE;
							cl_type: RENAMED_TYPE_A [TYPE_A];
							formal_position: INTEGER;
							constraint_position: INTEGER]]

create
	make

feature -- Access

	feature_name: STRING
		-- The feature name for which this error report is.

	formal_position: INTEGER
		-- The position of the formal for which we checked the feature named `feature_name'.

	context_class: CLASS_C
		-- Context class, is inter alla used to resolve formal positions into actual objects.

	my_list: LIST [like Current]

feature -- Setters

	set_data (a_feature_name: STRING; a_formal_position: INTEGER; a_context_class: CLASS_C)
			-- Set data
			--
			-- `a_feature_name' is assigned to `feature_name'
			-- `a_formal_position' is assigned to `formal_position'
			-- `a_context_class' is assigned to `context_class'
		require
			a_context_class_not_void: a_context_class /= Void
			valid_generic_position: a_context_class.generics.valid_index (a_formal_position)
		do
			feature_name := a_feature_name
			formal_position := a_formal_position
			context_class := a_context_class
		ensure
			feature_name_set: a_feature_name = feature_name
			formal_position_set: a_formal_position = formal_position
			context_class_set: a_context_class = context_class
		end

feature -- Status

	is_erroneous: BOOLEAN
			-- Is current really erronuous?
		do
			Result := count /= 1
		end

feature -- Command

	append_error_report (a_text_formatter: TEXT_FORMATTER)
			-- Appends an error report
			--
			-- `a_text_formatter' is used to append the error report to.
		require
			is_really_an_error: is_erroneous
			feature_name_not_void: feature_name /= Void
			context_class_not_void: context_class /= Void
		local
			l_output: STRING
		do
			if count > 0 then
					-- Precondition ensures this
				check count_not_one: count /= 1 end
				if feature_name /= Void  then
					l_output := "The feature `" + feature_name + "' occurs in the following set of constraint classes:%N"
				else
					-- This error report might have been computed over a routine id.
					-- That's why feature_name is Void.
				end

				a_text_formatter.add (l_output)
				from
					start
				until
					after
				loop
					a_text_formatter.add_new_line
					a_text_formatter.add_indent
					a_text_formatter.add ("{")
					item.cl_type.type.append_to (a_text_formatter)
					a_text_formatter.add ("}.")
					print_feature_name(a_text_formatter, item.e_feature, item.feature_i)

					a_text_formatter.add_space
					a_text_formatter.add ("from formal")
					a_text_formatter.add_space
					a_text_formatter.process_generic_text (context_class.generics.i_th (item.formal_position).name.name)
					a_text_formatter.add_space
					a_text_formatter.add ("at constraint position #" + item.constraint_position.out + ".")

					forth
				end
				a_text_formatter.add_new_line
			else
				l_output := "The feature `" + feature_name + "' does not occur in any constraint of the following formal:%N"
				a_text_formatter.add (l_output)
				a_text_formatter.process_generic_text (context_class.generics.i_th (formal_position).name.name)
			end
		end

feature {NONE} -- Implementation

	print_feature_name (a_text_formatter: TEXT_FORMATTER; a_e_feature: E_FEATURE; a_feature_i: FEATURE_I)
			-- Prints the feature name to `a_text_formatter'.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			if a_e_feature /= Void then
				a_text_formatter.process_feature_text(a_e_feature.name, a_e_feature, false)
				a_text_formatter.add_space
			elseif a_feature_i /= Void then
				a_text_formatter.add (a_feature_i.feature_name)
				a_text_formatter.add_space
			end
		end

note
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
