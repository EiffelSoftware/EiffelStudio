indexing
	description: "Display warning message for obsolete tags."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBSOLETE_INDEXING_TAG

inherit
	EIFFEL_WARNING
		redefine
			trace
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_class: like associated_class; a_old_tag, a_new_tag: STRING; a_location: LOCATION_AS) is
			-- Create new instance of `OBSOLETE_INDEXING_TAG'.
		require
			a_class_not_void: a_class /= Void
			a_old_tag_not_void: a_old_tag /= Void
			a_new_tag_not_void: a_new_tag /= Void
			a_location_not_void: a_location /= Void
		do
			associated_class := a_class
			old_tag := a_old_tag
			new_tag := a_new_tag
			location := a_location
		ensure
			associated_class_set: associated_class = a_class
			old_tag_set: old_tag = a_old_tag
			new_tag_set: new_tag = a_new_tag
			location_set: location = a_location
		end
		
feature -- Properties

	code: STRING is "Obsolete indexing tag"
			-- Error code

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
		end

	trace (a_text_formatter: TEXT_FORMATTER) is
			-- Debug purpose
		do
			a_text_formatter.add (create {ERROR_TEXT}.make (Current, "Obsolete"))
			a_text_formatter.add (" indexing tag used in class ")
				-- Error happened in a class
			associated_class.append_signature (a_text_formatter, False)
			a_text_formatter.add (" at line ")
			a_text_formatter.add (location.line.out)
			a_text_formatter.add (".")
			a_text_formatter.add_new_line
			a_text_formatter.add ("It uses obsolete indexing tag `")
			a_text_formatter.add (old_tag)
			a_text_formatter.add ("'.")
			a_text_formatter.add_new_line
			a_text_formatter.add ("Use new indexing tag `")
			a_text_formatter.add (new_tag)
			a_text_formatter.add ("' instead.")
			a_text_formatter.add_new_line
		end

feature {NONE} -- Implementation

	old_tag, new_tag: STRING
			-- Old obsolete tag and new tag
			
	location: LOCATION_AS
			-- Location of indexing clause.

invariant
	associated_class_not_void: associated_class /= Void
	old_tag_not_void: old_tag /= Void
	new_tag_not_void: new_tag /= Void
	location_not_void: location /= Void

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

end -- class OBSOLETE_INDEXING_TAG
