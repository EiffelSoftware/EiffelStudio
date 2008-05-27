indexing
	description: "Access to an Eiffel attribute"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ATTRIBUTE_B

inherit

	CALL_ACCESS_B
		rename
			feature_id as attribute_id,
			feature_name_id as attribute_name_id,
			feature_name as attribute_name
		redefine
			reverse_code, expanded_assign_code, assign_code,
			enlarged, is_creatable, is_attribute, read_only,
			assigns_to, pre_inlined_code,
			need_target
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_attribute_b (Current)
		end

feature

	type: TYPE_A
			-- Attribute type

	read_only: BOOLEAN is False
			-- Is the access only a read-only one ?

	set_type (t: like type) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	init (a: FEATURE_I) is
			-- Initialization
		require
			good_argument: a /= Void
			is_attribute: a.is_attribute
		local
			l_attr: ATTRIBUTE_I
		do
			l_attr ?= a
			attribute_name_id := l_attr.feature_name_id
			routine_id := l_attr.rout_id_set.first
			if System.il_generation then
				attribute_id := l_attr.origin_feature_id
				written_in := l_attr.origin_class_id
			else
				attribute_id := l_attr.feature_id
				written_in := l_attr.written_in
			end
			if l_attr.extension /= Void then
				need_target := l_attr.extension.need_current (l_attr.extension.type)
			else
				need_target := True
			end
		end

	need_target: BOOLEAN
			-- Does current call really need a target to be performed?
			-- E.g. not a static external field

	is_attribute: BOOLEAN is True
			-- Is Current an access to an attribute ?

	is_creatable: BOOLEAN is True
			-- Can an access to an attribute be a target for a creation ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			attribute_b: ATTRIBUTE_B
		do
			attribute_b ?= other
			if attribute_b /= Void then
				Result := attribute_id = attribute_b.attribute_id
			end
		end

	enlarged: ATTRIBUTE_B is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		local
			attr_bl: ATTRIBUTE_BL
		do
			if context.final_mode then
				create attr_bl
			else
				create {ATTRIBUTE_BW} attr_bl
			end
			attr_bl.fill_from (Current)
			Result := attr_bl
		end

feature -- Byte code generation

	assign_code: CHARACTER is
			-- Assignment code to an attribute
		local
			cl_type: CL_TYPE_A
		do
			cl_type ?= context_type
			if cl_type /= Void and then cl_type.associated_class.is_precompiled then
				Result := {BYTE_CONST}.bc_passign
			else
				Result := {BYTE_CONST}.bc_assign
			end
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code to an attribute
		local
			cl_type: CL_TYPE_A
		do
			cl_type ?= context_type
			if cl_type /= Void and then cl_type.associated_class.is_precompiled then
				Result := {BYTE_CONST}.bc_pexp_assign
			else
				Result := {BYTE_CONST}.bc_exp_assign
			end
		end

	reverse_code: CHARACTER is
			-- Reverse assignment code
		local
			cl_type: CL_TYPE_A
		do
			cl_type ?= context_type
			if cl_type /= Void and then cl_type.associated_class.is_precompiled then
				Result := {BYTE_CONST}.bc_preverse
			else
				Result := {BYTE_CONST}.bc_reverse
			end
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := attribute_id = i
		end

feature -- Inlining

	pre_inlined_code: ATTRIBUTE_B is
		local
			inlined_attr_b: INLINED_ATTR_B
		do
				-- Adapt type in current context for better results.
			type := type.instantiated_in (context.current_type)
			if parent /= Void then
				Result := Current
			else
				create inlined_attr_b
				inlined_attr_b.fill_from (Current)
				Result := inlined_attr_b
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

end
