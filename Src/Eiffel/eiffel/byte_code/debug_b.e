indexing
	description	: "Byte code for the debug instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_B

inherit
	INSTR_B
		redefine
			enlarge_tree, analyze, generate,
			assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_debug_b (Current)
		end

feature -- Access

	compound: BYTE_LIST [BYTE_NODE]
			-- Debug compound {list of INSTR_B]: can be Void

	keys: ARRAYED_LIST [STRING]
			-- Keys if any

	end_location: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Status setting

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c
		end

	set_keys (k: like keys) is
			-- Assign `k' to `keys'.
		do
			keys := k
		end

	set_end_location (e: like end_location) is
			-- Set `end_location' with `e'.
		require
			e_not_void: e /= Void
		do
			end_location := e
		ensure
			end_location_set: end_location = e
		end

feature -- Basic Operations

	enlarge_tree is
			-- Enlarge generation tree
		do
			if compound /= Void and then is_debug_clause_enabled then
				compound.enlarge_tree
			end
		end

	analyze is
			-- Analysis of debug compound
		do
			if compound /= Void and then is_debug_clause_enabled then
				compound.analyze
			end
		end

feature -- C Code generation

	is_debug_clause_enabled: BOOLEAN is
			-- Has the debug compound to be generated in final mode?
		local
			debug_level: DEBUG_I
		do
			Result := context.workbench_mode and not system.il_generation
			if not Result then
				debug_level := context.current_type.base_class.debug_level
				if keys = Void then
					Result := debug_level.has_unnamed
				else
					from
						keys.start
					until
						keys.after or else Result
					loop
						Result := debug_level.is_debug (keys.item)
						keys.forth
					end
				end
			end
		end

	generate is
			-- Generation of the C code for debug compound
		local
			static_type: STRING
			buf: GENERATION_BUFFER
		do
			generate_line_info
			if compound /= Void and then is_debug_clause_enabled then
				if context.final_mode then
					compound.generate
				else
					buf := buffer
						-- Generation of the debug compound in workbench
						-- mode
					static_type := Encoder.generate_type_id_name (context.class_type.static_type_id)
					buf.put_new_line
					buf.put_string (gc_if_l_paran)
					buf.indent
					buf.put_new_line
					if keys = Void then
							-- No keys
						buf.put_string ("WDBG(RTUD(")
						buf.put_string (static_type)
						buf.put_string ("), (char *) 0)")
					else
						from
							keys.start
						until
							keys.after
						loop
							buf.put_string ("WDBG(RTUD(")
							buf.put_string (static_type)
							buf.put_string ("),%"")
							buf.put_string (keys.item)
							buf.put_string ("%")")
							keys.forth
							if not keys.after then
								buf.put_string (" ||")
								buf.put_new_line
							end
						end
					end
					buf.exdent
					buf.put_new_line
					buf.put_string (") {")
					buf.indent
					compound.generate
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
				end
			end
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := (compound /= Void and then is_debug_clause_enabled) and then
				compound.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (compound /= Void and then is_debug_clause_enabled) and then
						compound.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := (compound /= Void and then is_debug_clause_enabled) and then
				compound.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			if compound /= Void and then is_debug_clause_enabled then
				compound := compound.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			if compound /= Void and then is_debug_clause_enabled then
				Result := compound.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if compound /= Void and then is_debug_clause_enabled then
				compound := compound.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if compound /= Void and then is_debug_clause_enabled then
				compound := compound.inlined_byte_code
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
