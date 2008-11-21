indexing
	description: "Representation of an eiffel routine."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class E_ROUTINE

inherit
	E_FEATURE
		redefine
			has_postcondition, has_precondition,
			argument_names, arguments, is_once,
			is_deferred, locals, object_test_locals, obsolete_message,
			is_external, associated_feature_i,
			is_inline_agent, updated_version,
			is_invariant,
			body_id_for_ast
		end
	SHARED_INLINE_AGENT_LOOKUP
		undefine
			is_equal
		end

feature -- Properties

	arguments: E_FEATURE_ARGUMENTS;
			-- Arguments type

	has_precondition: BOOLEAN;
			-- Is the routine declaring some precondition ?

	has_postcondition: BOOLEAN;
			-- Is the routine declaring some postcondition ?

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

	is_deferred: BOOLEAN;
			-- Is the routine deferred?

	is_once: BOOLEAN;
			-- Is the routine declared as a once?

	is_external: BOOLEAN;
			-- Is the routine declared as a once?

	is_inline_agent: BOOLEAN
			-- is the routine an inline angent
		do
			Result := inline_agent_nr /= 0
		end

	is_invariant: BOOLEAN
			-- <Precursor>		

	inline_agent_nr: INTEGER

	enclosing_body_id: INTEGER
			-- The Body id of the enclosing feature of an inline agent

feature -- Access

	argument_names: LIST [STRING] is
			-- Argument names
		do
			Result := arguments.argument_names
		end

	locals: EIFFEL_LIST [TYPE_DEC_AS] is
		local
			routine_as: ROUTINE_AS
		do
			routine_as := associated_routine_as
			if routine_as /= Void then
				Result := routine_as.locals
			end
		end

	object_test_locals: LIST [TUPLE [name: ID_AS; type: TYPE_AS]] is
			-- Object test locals mentioned in the routine
		local
			routine_as: ROUTINE_AS
		do
			routine_as := associated_routine_as
			if routine_as /= Void then
				Result := routine_as.object_test_locals
			end
		end

	updated_version: E_FEATURE
		local
			l_class: EIFFEL_CLASS_C
			l_feat: FEATURE_I
		do
			if is_inline_agent then
				l_class ?= associated_class
				if l_class /= Void and then l_class.is_valid then
					l_feat := l_class.inline_agent_with_nr (enclosing_body_id, inline_agent_nr)
					if l_feat /= Void then
						Result := l_feat.api_feature (l_class.class_id)
					end
				end
			else
				Result := Precursor
			end
		end

feature {NONE} -- Implementation

	associated_routine_as: ROUTINE_AS is
			-- Associated routine as used to find out locals and object test locals
		do
			if is_inline_agent then
				if {inl_agt_feat_as: FEATURE_AS} Body_server.item (enclosing_body_id) then
					Result ?= inline_agent_lookup.lookup_inline_agent_of_feature (
							inl_agt_feat_as, inline_agent_nr).content
				end
			elseif body_index > 0 then
				if {feat_as: FEATURE_AS} Body_server.item (body_index) then
						--| feature_as can be Void for invariant routine
					Result ?= feat_as.body.content
				end
			end
			if Result /= Void then
				if Result.is_built_in then
					if {built_in_as: BUILT_IN_AS} Result.routine_body then
						if {feature_as: FEATURE_AS} built_in_as.body then
							Result ?= feature_as.body.content
						end
					end
				end
			end
		end

feature {FEATURE_I} -- Setting

	set_deferred (b: like is_deferred) is
			-- Set `is_deferred' to `b'.
		do
			is_deferred := b;
		end;

	set_once (b: like is_once) is
			-- Set `is_once' to `b'.
		do
			is_once := b;
		end;

	set_external (b: like is_external) is
			-- Set `is_external' to `b'.
		do
			is_external := b
		end;

	set_arguments (args: like arguments) is
			-- Assign `args' to `arguments'.
		do
			arguments := args;
		end;

	set_has_precondition (b: BOOLEAN) is
			-- Assign `b' to `has_precondition'.
		do
			has_precondition := b;
		end;

	set_has_postcondition (b: BOOLEAN) is
			-- Assign `b' to `has_postcondition'.
		do
			has_postcondition := b;
		end;

	set_obsolete_message (s: STRING) is
			-- Assign `s' to `obsolete_message'
		do
			obsolete_message := s;
		end;

	set_inline_agent_nr (nr: INTEGER) is
			-- Assign `nr' to `inline_agent_nr'
		do
			inline_agent_nr := nr
		end

	set_is_invariant (b: BOOLEAN) is
			-- Assign `b' to `is_invariant'
		do
			is_invariant := b
		end

	set_enclosing_body_id (id: INTEGER) is
			-- Assign `id' to `enclosing_body_id'
		do
			enclosing_body_id := id
		end

feature {COMPILER_EXPORTER} -- Implementation

	body_id_for_ast: INTEGER
		do
			if is_inline_agent then
				Result := enclosing_body_id
			else
				Result := Precursor
			end
		end

	associated_feature_i: FEATURE_I is
			-- Assocated feature_i
		do
			if is_inline_agent then
				Result := associated_class.eiffel_class_c.inline_agent_of_id (feature_id)
			else
				Result := Precursor
			end
		end;

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

end -- class E_ROUTINE
