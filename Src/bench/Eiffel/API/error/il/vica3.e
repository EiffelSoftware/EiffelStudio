indexing
	description: "Errors when an incorrect named argument is provided in custom attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VICA3

inherit
	VICA
		redefine
			build_explain, subcode
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like context_class; a_feature: FEATURE_I; a_creation_type: like creation_type) is
			-- Create new error because incorrect custom attribute creation
			-- of type `a_creation_type' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_creation_type: a_creation_type /= Void
			a_feature_not_void: a_feature /= Void
		do
			context_class := a_class
			creation_type := a_creation_type
			set_feature (a_feature)
		ensure
			context_class_set: context_class = a_class
			creatiion_type_set: creation_type = a_creation_type
		end

feature -- Access

	creation_type: CL_TYPE_A
			-- Type of custom attribute.

	named_argument_feature: FEATURE_I
			-- Feature being using for named argument setting.

	named_argument_name: STRING
			-- Name of not found `named_argument_feature'.

feature -- Properties

	subcode: INTEGER is 3
			-- Subcode of error.

feature -- Settings

	set_named_argument_feature (a_feat: like named_argument_feature) is
			-- Set feature associated to `named_argument_feature' which is not valid for
			-- custom attriibute creation.
		require
			a_feat_not_void: a_feat /= Void
		do
			named_argument_feature := a_feat
		ensure
			named_argument_set: named_argument_feature = a_feat
		end

	set_named_argument_name (a_name: like named_argument_name) is
			-- Set `named_argument_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			named_argument_name := a_name
		ensure
			named_argument_name_set: named_argument_name = a_name
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Display error message
		do
			a_text_formatter.add ("Incorrect custom attribute specification in ")
			a_text_formatter.add_class (context_class.lace_class)
			a_text_formatter.add (".")
			a_text_formatter.add_new_line
			a_text_formatter.add ("Type of custom attribute being created ")
			a_text_formatter.add_class (creation_type.associated_class.lace_class)
			a_text_formatter.add (".")
			if named_argument_name /= Void then
				a_text_formatter.add_new_line
				a_text_formatter.add ("Could not find feature ")
				a_text_formatter.add (named_argument_name)
				a_text_formatter.add (" in ")
				a_text_formatter.add_class (context_class.lace_class)
				a_text_formatter.add (".")
			else
				if named_argument_feature /= Void then
					a_text_formatter.add_new_line
					a_text_formatter.add ("Name of invalid custom attribute named argument ")
					a_text_formatter.add_feature (
						named_argument_feature.api_feature (creation_type.associated_class.class_id),
						named_argument_feature.feature_name)
					a_text_formatter.add (".")
				end
			end
			a_text_formatter.add_new_line
		end

invariant
	creation_type_not_void: creation_type /= Void

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
