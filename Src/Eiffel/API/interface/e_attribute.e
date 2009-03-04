note

	description:
		"Representation of an eiffel attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_ATTRIBUTE

inherit
	E_FEATURE
		redefine
			assigner_name, is_attribute, type,
			is_attribute_with_body, locals, object_test_locals
		end

create
	make

feature -- Properties

	is_attribute: BOOLEAN = True
			-- Is current an attribute?

	is_attribute_with_body: BOOLEAN
			-- <Precursor>

	type: TYPE_A
			-- Return type

	assigner_name: STRING
			-- Name of the assigner procedure (if any)

feature -- Access

	locals: EIFFEL_LIST [TYPE_DEC_AS]
		local
			routine_as: ROUTINE_AS
		do
			routine_as := associated_routine_as
			if routine_as /= Void then
				Result := routine_as.locals
			end
		end

	object_test_locals: LIST [TUPLE [name: ID_AS; type: TYPE_AS]]
			-- Object test locals mentioned in the routine
		local
			routine_as: ROUTINE_AS
		do
			routine_as := associated_routine_as
			if routine_as /= Void then
				Result := routine_as.object_test_locals
			end
		end

feature {NONE} -- Implementation

	associated_routine_as: ROUTINE_AS
			-- Associated routine as used to find out locals and object test locals
		do
			if body_index > 0 then
				if attached {FEATURE_AS} Body_server.item (body_index) as feat_as then
						--| feature_as can be Void for invariant routine
					Result ?= feat_as.body.content
				end
			end
			if Result /= Void then
				if Result.is_built_in then
					if attached {BUILT_IN_AS} Result.routine_body as built_in_as then
						if attached {FEATURE_AS} built_in_as.body as feature_as then
							Result ?= feature_as.body.content
						end
					end
				end
			end
		end

feature -- Setting

	set_is_attribute_with_body (b: like is_attribute_with_body)
			-- set `is_attribute_with_body' to `b'
		do
			is_attribute_with_body := b
		end

	set_type (t: like type; a: like assigner_name)
			-- Set `type' to `t' and `assigner_name' to `a'.
		require
			valid_t: t /= Void
		do
			type := t
			assigner_name := a
		ensure
			type_set: type = t
			assigner_name_set: assigner_name = a
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

end -- class E_ATTRIBUTE
