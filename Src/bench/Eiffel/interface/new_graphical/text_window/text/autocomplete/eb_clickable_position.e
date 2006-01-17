indexing
	description	: "Objects that represent a clickable position in the editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Etienne Amodeo"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CLICKABLE_POSITION
inherit
	COMPARABLE
create
	make, make_from_token

feature -- Initialisation

	make(a_beginning: INTEGER; an_end: INTEGER ) is
		do
			start := a_beginning
			stop := an_end
		end

	make_from_token(a_token: EDITOR_TOKEN) is
		do
			start := a_token.position
			stop := a_token.width + start
		end

feature -- Access

	start: INTEGER

	stop: INTEGER	

	is_feature: BOOLEAN

	is_class: BOOLEAN

	class_name: STRING

	feature_name: STRING

feature -- element change

	set_feature (a_class_name, a_feature_name: STRING) is
		require
			valid_class_name: a_class_name /= Void
			valid_feature_feature_name: a_feature_name /= Void
		do
			class_name := a_class_name
			feature_name := a_feature_name
			is_feature := True
			is_class := False
		end

	set_class(a_class_name: STRING) is
		require
			valid_class_name: a_class_name /= Void
		do
			class_name := a_class_name
			feature_name := Void
			is_feature := False
			is_class := True
		end

feature -- comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := start < other.start
		ensure then
			asymmetric: Result implies not (other < Current)
		end

invariant

	coherent_feature: is_feature implies class_name /= Void and feature_name /= Void
	coherent_class: is_class implies class_name /= Void and feature_name = Void
	class_or_feature: not (is_class and is_feature)

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

end -- class EB_CLICKABLE_POSITION
