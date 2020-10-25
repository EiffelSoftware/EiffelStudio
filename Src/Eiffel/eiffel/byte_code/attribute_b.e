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
			enlarged, is_assignable, is_attribute, read_only,
			assigns_to, pre_inlined_code,
			need_target, set_is_attachment, is_writable
		end

create
	make

feature {NONE} -- Initialization

	make (a: ATTRIBUTE_I)
			-- Initialization
		require
			attached a
			system.has_class_of_id (a.access_in)
			attached system.class_of_id (a.access_in) as c
			attached c.feature_of_rout_id (a.rout_id_set.first) as f
			a.rout_id_set.first = f.rout_id_set.first
		do
			attribute_name_id := a.feature_name_id
			routine_id := a.rout_id_set.first
			if System.il_generation then
				attribute_id := a.origin_feature_id
				written_in := a.origin_class_id
			else
				attribute_id := a.feature_id
				written_in := a.access_in
			end
			if attached a.extension as e then
				need_target := e.need_current (e.type)
			else
				need_target := True
			end
		ensure
			attribute_name_id = a.feature_name_id
			routine_id = a.rout_id_set.first
			system.has_class_of_id (written_in)
			attached system.class_of_id (written_in) as c
			attached c.feature_of_rout_id (routine_id) as f
			f.is_attribute
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

	read_only: BOOLEAN = False
			-- Is the access only a read-only one ?

	need_target: BOOLEAN
			-- Does current call really need a target to be performed?
			-- E.g. not a static external field

	is_attribute: BOOLEAN = True
			-- Is Current an access to an attribute ?

	is_assignable: BOOLEAN = True
			-- <Precursor>

	is_writable: BOOLEAN = True
			-- <Precursor>

	same (other: ACCESS_B): BOOLEAN
			-- Is `other' the same access as Current ?
		do
			if attached {ATTRIBUTE_B} other as attribute_b then
				Result := attribute_id = attribute_b.attribute_id
			end
		end

	wrapper: detachable FEATURE_B
			-- A wrapper (if needed) to be called for an attribute that may need to be initialized.
		do
			if is_initialization_required then
					-- Call a wrapper that performs the required initialization.
				create {FEATURE_B} Result.make (context_type.base_class.feature_of_rout_id (routine_id), type, Void, False)
				if has_multi_constraint_static then
					Result.set_multi_constraint_static (multi_constraint_static)
				end
				if attached parent as p then
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
					Result := f.enlarged
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

feature {NONE} -- Status report

	is_initialization_required: BOOLEAN
			-- Is it potentially required to evaluate an associated attribute body before the value can be read?
		do
			if not is_attachment then
					-- No need to wrap a target of an attachment.
				Result :=
						-- Wrap a separate call in workbench mode.
					context.workbench_mode and then context_type.is_separate or else
						-- Do not wrap access to an attribute of a basic type that is always initialized.
					not real_type (type).is_basic and then
							-- Wrap an attribute that may be redeclared to become of an attached type and to have a body.
						(context.workbench_mode or else
						Eiffel_table.poly_table (routine_id).is_initialization_required (context_type, context.context_class_type))
			end
		end

feature -- Byte code generation

	assign_code: CHARACTER
			-- Assignment code to an attribute
		do
			Result := {BYTE_CONST}.bc_assign
		end

	expanded_assign_code: CHARACTER
			-- Expanded assignment code to an attribute
		do
			Result := {BYTE_CONST}.bc_exp_assign
		end

	reverse_code: CHARACTER
			-- Reverse assignment code
		do
			Result := {BYTE_CONST}.bc_reverse
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN
		do
			Result := attribute_id = i
		end

feature -- Inlining

	pre_inlined_code: CALL_B
		do
			if attached parent then
					-- Inlining is performed by adapting the target of the call.
				Result := Current
			elseif not is_initialization_required then
					-- No initialization is required, use inlined attribute access.
				create {INLINED_ATTR_B} Result.fill_from (Current)
			else
					-- Adapt access to the attribute using the standard procedure
					-- that may later wrap the attribute into a function to initialize it accordingly.
				Result := Precursor
			end
		ensure then
			is_attachment implies attached {like {ASSIGN_B}.target} Result
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
