note
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
			assigns_to, pre_inlined_code, size,
			need_target, set_is_attachment
		end

create
	make

feature {NONE} -- Initialization

	make (a: FEATURE_I)
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

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_attribute_b (Current)
		end

feature -- Status report

	is_attachment: BOOLEAN
			-- Is attribute used as target of an attachment?

feature -- Status setting

	set_is_attachment
			-- Flag that a feature is used as a target of an attachment operation.
		do
			is_attachment := True
		ensure then
			is_attachment
		end

feature

	type: TYPE_A
			-- Attribute type

	read_only: BOOLEAN = False
			-- Is the access only a read-only one ?

	set_type (t: like type)
			-- Assign `t' to `type'.
		do
			type := t
		end

	need_target: BOOLEAN
			-- Does current call really need a target to be performed?
			-- E.g. not a static external field

	is_attribute: BOOLEAN = True
			-- Is Current an access to an attribute ?

	is_creatable: BOOLEAN = True
			-- Can an access to an attribute be a target for a creation ?

	same (other: ACCESS_B): BOOLEAN
			-- Is `other' the same access as Current ?
		local
			attribute_b: ATTRIBUTE_B
		do
			attribute_b ?= other
			if attribute_b /= Void then
				Result := attribute_id = attribute_b.attribute_id
			end
		end

	wrapper: FEATURE_B
			-- A wrapper to be called for an attribute that may need to be initialized
			-- (Void if none)
		local
			is_initialization_required: BOOLEAN
			p: like parent
		do
				-- No need to wrap a target of an attachment as well as access to an attribute of a basic type that is always initialized
			if not is_attachment and then not type.is_basic then
				if context.workbench_mode then
						-- Attribute may be redeclared to become of an attached type and to have a body.
					is_initialization_required := True
				else
						-- Check if attribute is of an attached type in some descendant
						-- that declares an explicit body for it.
					is_initialization_required := Eiffel_table.poly_table (routine_id).is_initialization_required (context_type, context.context_class_type)
				end
			end
			if is_initialization_required then
					-- Call a wrapper that performs the required initialization.
				create {FEATURE_B} Result.make (context_type.associated_class.feature_of_rout_id (routine_id), type, Void)
				if has_multi_constraint_static then
					Result.set_multi_constraint_static (multi_constraint_static)
				end
				p := parent
				if p /= Void then
					Result.set_parent (p)
					if p.message = Current then
						p.set_message (Result)
					else
						check
							p.target = Current
						end
						p.set_target (Result)
					end
				end
			end
		end

	enlarged: CALL_ACCESS_B
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
			if attached wrapper as f then
					-- Call a wrapper that performs the required initialization.
				if context.final_mode then
					create {FEATURE_BL} Result.fill_from (f)
				else
					create {FEATURE_BW} Result.fill_from (f)
				end
			else
				if context.final_mode then
					create {ATTRIBUTE_BL} Result.fill_from (Current)
				else
					create {ATTRIBUTE_BW} Result.fill_from (Current)
				end
			end
		end

feature -- Byte code generation

	assign_code: CHARACTER
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

	expanded_assign_code: CHARACTER
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

	reverse_code: CHARACTER
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

	assigns_to (i: INTEGER): BOOLEAN
		do
			Result := attribute_id = i
		end

feature -- Inlining

	size: INTEGER
		do
			if False then
				(create {REFACTORING_HELPER}).to_implement ("Check if attribute has to be initialized.")
					-- Inlining will not be done if the attribute has to be initialized
				Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
			end
		end

	pre_inlined_code: ATTRIBUTE_B
		do
				-- Adapt type in current context for better results.
			type := type.instantiated_in (context.current_type)
			if parent /= Void then
				Result := Current
			else
				create {INLINED_ATTR_B} Result.fill_from (Current)
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
