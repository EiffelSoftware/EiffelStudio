indexing
	description: "Byte node representing a call (either call or item) to an agent"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AGENT_CALL_B

inherit
	FEATURE_B
		rename
			make as make_feature
		redefine
			process,
			enlarged,
			is_polymorphic,
			inlined_byte_code
		end

create
	make

feature -- Initialization

	make (f: FEATURE_I; t: like type; p_type: like precursor_type; a_is_item: BOOLEAN) is
			-- Initialization
		do
			make_feature (f, t, p_type)
			is_item := a_is_item
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		local
		do
			v.process_agent_call_b (Current)
		end

feature -- Attributes

	is_item: BOOLEAN
		-- Is it an item call? If false, it is a call to call

	is_result_optimizable: BOOLEAN
			-- Can we optimize the result of an agent call?
		local
			l_type: like context_type
		do
				-- Because in finalized mode, we could have a function whose actual return type is basic
				-- but called via an agent which returns a reference and our code does not perform
				-- the conversion, we have to prevent the optimization (see eweasel test#final067).
			Result := not is_item
			if not Result then
				l_type := context_type
				if l_type.associated_class.eiffel_class_c.class_id = system.predicate_class_id then
					Result := True
				else
					Result := l_type.instantiated_in (context.context_class_type.type).generics.item (3).is_basic
				end
			end
		end

feature -- Access

	enlarged: CALL_ACCESS_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		local
			l_assert: ASSERTION_I
		do
			if context.final_mode then
				if system.keep_assertions then
					l_assert := context_type.associated_class.lace_class.assertion_level
					if (not l_assert.is_precondition and not l_assert.is_invariant) and is_result_optimizable then
						create {AGENT_CALL_BL} Result.init (Current)
					end
				elseif is_result_optimizable then
					create {AGENT_CALL_BL} Result.init (Current)
				end
			end
			if Result = Void then
				Result := Precursor
			end
		end

	is_polymorphic: BOOLEAN is False

	inlined_byte_code: ACCESS_B is
		do
			Result := Current
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
