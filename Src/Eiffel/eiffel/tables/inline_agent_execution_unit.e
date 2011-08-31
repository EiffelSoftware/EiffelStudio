note
	description: "Execution unit of an inline agent"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INLINE_AGENT_EXECUTION_UNIT

inherit
	EXECUTION_UNIT
		rename
			make as make_execution_unit
		redefine
			is_valid
		end

create
	make

feature -- Initialization

	make (a_cl_type: CLASS_TYPE; a_enclosing_feature: FEATURE_I)
			-- Initialization
		require
			a_cl_type_not_void: a_cl_type /= Void
			a_enclosing_feature_not_void: a_enclosing_feature /= Void
		do
			enclosing_feature := a_enclosing_feature
			make_execution_unit (a_cl_type)
		end

feature -- Access

	is_valid: BOOLEAN
			-- Is the execution unit still valid ?
		local
			f: FEATURE_I
			l_same_class: BOOLEAN
		do
				-- Verify if classes involved in Current are still in system, and that
				-- `class_type' is still in system and still inherits from the class where
				-- it was originally written.
			l_same_class := written_in = access_in
			if
				(attached {EIFFEL_CLASS_C} system.class_of_id (written_in) as l_written_class and
					(l_same_class or else system.has_class_of_id (access_in))) and then
				System.class_type_of_id (type_id) = class_type and then
				class_type.associated_class.inherits_from (l_written_class) and then
				l_written_class.has_inline_agent_with_body_index (body_index)
			then
				if l_same_class and then class_type.written_type (l_written_class).is_precompiled then
						-- If feature's routine id is generated from the written class
						-- and it is precompiled then it must be valid.
					Result := True
				else
						-- Feature may have disappeared from system and we need to detect it.
					f := system.class_of_id (access_in).feature_of_body_index (enclosing_feature.body_index)
					Result := f /= Void
					if Result then
						if system.execution_table.has_dead_function (enclosing_feature.body_index) then
								-- This is an attribute that was a function before, so
								-- it is not a valid `execution_unit' anymore if after
								-- all recompilation it is still an attribute.
								--
								-- Or if it is a deferred feature that was not
								-- deferred before
							Result := not f.is_attribute and then not f.is_deferred
						end
					else
						Result := class_type.associated_class.invariant_feature = enclosing_feature
					end
				end
			end
		end

feature	{NONE}-- Implementation

	enclosing_feature: FEATURE_I

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
