indexing
	description: "Representation of the invariant of a class which is internally stored%
		%as a procedure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INVARIANT_FEAT_I

inherit
	DYN_PROC_I
		redefine
			melt, generate_il
		end

	SHARED_BN_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		end

create
	make

feature

	make (a_class: CLASS_C) is
		do
			set_feature_name_id (Names_heap.internal_invariant_name_id, 0)
			create rout_id_set.make
			rout_id_set.put (System.routine_id_counter.invariant_rout_id)
			written_in := a_class.class_id
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for current feature.
		local
			byte_code: INVARIANT_B
		do
			byte_code := Inv_byte_server.item (written_in)
			byte_context.set_byte_code (create {STD_BYTE_CODE})
			byte_context.set_current_feature (Current)
			cil_node_generator.generate_il_node (il_generator, byte_code)
			byte_context.clear_feature_data
		end

feature -- Byte Code generation

	melt (exec: EXECUTION_UNIT) is
			-- Generate byte code for the current feature
		local
			byte_code: INVARIANT_B
			melted_feature: MELT_FEATURE
		do
			byte_code := Inv_byte_server.item (written_in)

			Byte_array.clear
			melted_generator.generate (byte_array, byte_code)

			melted_feature := Byte_array.melted_feature
			melted_feature.set_real_body_id (exec.real_body_id)
			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature)
			end

			Execution_table.mark_melted (exec)
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
