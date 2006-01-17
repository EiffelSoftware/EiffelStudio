indexing
	description: "A feature to be inserted into the auto-complete list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EB_FEATURE_FOR_COMPLETION

inherit
	EB_NAME_FOR_COMPLETION
		redefine
			icon,
			tooltip_text,
			is_class,
			full_insert_name
		end

	PREFIX_INFIX_NAMES
		undefine
			out, copy, is_equal
		end

create
	make

create {EB_FEATURE_FOR_COMPLETION}
	make_string

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE) is
			-- Create and initialize a new completion feature using `a_feature'
		require
			a_feature_not_void: a_feature /= Void
		do
			if a_feature.is_infix then
				make_with_name (extract_symbol_from_infix(a_feature.name))
			else
				make_with_name (a_feature.name)
			end

			associated_feature := a_feature
			return_type := a_feature.type

			if show_signature then
				append (feature_signature)
			end
			if show_type then
				append (completion_type)
			end
		ensure
			associated_feature_set: associated_feature = a_feature
			return_type_set: return_type = a_feature.type
		end

feature -- Access

	is_class: BOOLEAN is False
			-- Is completion feature a class, of course not.	

	full_insert_name: STRING is
			-- Full name to insert in editor
		do
			create Result.make (associated_feature.name.count + feature_signature.count)
			Result.append (associated_feature.name)
			Result.append (feature_signature)
		end

	icon: EV_PIXMAP is
			-- Associated icon based on data
		do
			Result := pixmap_from_e_feature (associated_feature)
		end

	tooltip_text: STRING is
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		do
			create Result.make (Current.count + feature_signature.count + completion_type.count)
			Result.append (Current)
			Result.append (feature_signature)
			Result.append (completion_type)
		end

feature -- Query

	has_arguments: BOOLEAN is
			-- Does `associated_feature' have arguments?
		do
			Result := associated_feature.has_arguments
		end

feature {NONE} -- Implementation

	associated_feature: E_FEATURE
			-- Feature associated with completion item

	feature_signature: STRING is
			-- The signature of `associated_feature'
		require
			associated_feature_not_void: associated_feature /= Void
		do
			if internal_feature_signature = Void then
				if associated_feature.has_arguments then
					create Result.make (110)
					associated_feature.append_arguments_to (Result)
				else
					create Result.make_empty
				end
				internal_feature_signature := Result
			else
				Result := internal_feature_signature
			end
		ensure
			result_not_void: Result /= Void
		end

	internal_feature_signature: STRING
			-- cache `feature_signature'

invariant
	associated_feature_not_void: associated_feature /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_FEATURE_FOR_COMPLETION
