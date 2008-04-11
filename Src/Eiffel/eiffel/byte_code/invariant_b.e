indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Block of invariant assertions

class INVARIANT_B

inherit
	ASSERT_TYPE

	BYTE_NODE

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

	SHARED_BODY_ID

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_invariant_b (Current)
		end

feature -- Access

	byte_list: BYTE_LIST [BYTE_NODE]
			-- Invariant byte code list

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings in class invariant

	object_test_locals: ARRAY [TYPE_A]
			-- Object test locals indexed with the corresponding object test locals positions

feature {AST_CONTEXT, AST_FEATURE_CHECKER_GENERATOR} -- Modification

	set_byte_list (b: like byte_list) is
			-- Assign `b' to `byte_list'.
		do
			byte_list := b
		ensure
			byte_list_set: byte_list = b
		end

	set_once_manifest_string_count (oms_count: like once_manifest_string_count) is
			-- Set `once_manifest_string_count' to `oms_count'.
		require
			valid_oms_count: oms_count >= 0
		do
			once_manifest_string_count := oms_count
		ensure
			once_manifest_string_count_set: once_manifest_string_count = oms_count
		end

	set_object_test_locals (l: like object_test_locals)
			-- Attach `l' to `object_test_locals'.
		require
			l_attached: l /= Void
			l_normalized: l.lower = 1
		do
			object_test_locals := l
		ensure
			object_test_locals_set: object_test_locals = l
		end

feature

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := System.class_of_id (class_id)
		end

	generate_invariant_routine is
			-- Generate invariant routine
		require
			has_invariant: byte_list /= Void
		local
			i: INTEGER
			body_index: INTEGER
			internal_name: STRING
			buf: GENERATION_BUFFER
			o: like object_test_locals
		do
			buf := buffer

				-- Set the control flag for enlarging the assertions
			context.set_assertion_type (In_invariant);

			o := object_test_locals
			if o /= Void then
				from
					i := o.lower
				until
					i > o.upper
				loop
					context.add_local (context.real_type (o [i]))
					i := i + 1
				end
			end

			byte_list.enlarge_tree;
			byte_list.analyze;
				-- For invariant, we always need the GC hook.
			context.force_gc_hooks

				--| Always mark current as used in all modes
			context.mark_current_used;

				-- Routine's name				
			if context.final_mode then
				body_index := Invariant_body_index;
			else
				body_index := associated_class.invariant_feature.body_index;
			end;
			context.set_original_body_index (body_index)

				-- Generate extern clauses for once manifest strings.
			context.generate_once_manifest_string_import (once_manifest_string_count)

			internal_name := Encoder.feature_name (context.class_type.type_id, body_index)

			buf.generate_function_signature ("void", internal_name,
					True, Context.header_buffer,
					<<"Current", "where">>, <<"EIF_REFERENCE", "int">>);
			buf.generate_block_open
			buf.put_gtcx

			context.generate_local_declaration (0, False)
				-- Generation of temporary variables under the control
				-- of the GC
			context.generate_temporary_ref_variables;
				-- Dynamic type of Current
			if context.dftype_current > 1 then
				buf.put_new_line;
				buf.put_string ("RTCFDT;");
			end;
			if context.dt_current > 1 then
				buf.put_new_line;
				buf.put_string ("RTCDT;");
			end;

				-- Generation of the local variable array
			i := context.ref_var_used;
			if i > 0 then
				buf.put_new_line;
				buf.put_string ("RTLD;");
			end;

				-- Separate declarations and body with a blank line
			buf.put_new_line;

				-- Generate GC hooks
			context.generate_gc_hooks (True);

				-- Generate debug information about object test locals, Current.
			context.generate_push_debug_locals (Void, Void)

				-- Allocate memory for once manifest strings.
			context.generate_once_manifest_string_allocation (once_manifest_string_count)

			byte_list.generate;

				-- Generate the update of the locals stack used to debug.
			context.generate_pop_debug_locals (Void)

				-- Remove gc hooks
			i := context.ref_var_used;
			if i > 0 then
				buf.put_new_line
				buf.put_string ("RTLE;");
			end;

				-- Undefines all macros defined for temporary locals.
			context.generate_temporary_ref_macro_undefintion

				-- End of C routine
			buf.generate_block_close

				-- Separation for formatting
			buf.put_new_line
		end;

invariant
	valid_once_manifest_string_count: once_manifest_string_count >= 0

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
