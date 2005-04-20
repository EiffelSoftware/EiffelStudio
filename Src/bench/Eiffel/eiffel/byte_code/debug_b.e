indexing
	description	: "Byte code for the debug instruction."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_B 

inherit
	INSTR_B
		redefine
			make_byte_code, enlarge_tree, analyze, generate,
			assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code,
			generate_il
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
					Result := debug_level.is_yes
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
					buf.put_string (gc_if_l_paran)
					buf.put_new_line
					buf.indent
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
					buf.put_new_line
					buf.exdent
					buf.put_string (") {")
					buf.put_new_line
					buf.indent
								
					compound.generate
	
					buf.exdent
					buf.put_character ('}')
					buf.put_new_line
				end
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for debug clause
		do
			if compound /= Void then
				if is_debug_clause_enabled then
					generate_il_line_info (True)
					compound.generate_il
					check
						end_location_not_void: end_location /= Void
					end
					il_generator.put_silent_debug_info (end_location)
				else
					il_generator.put_ghost_debug_infos (line_number, compound.count)
				end
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a debug clause
		do
			if compound /= Void then
				ba.append (Bc_debug)
				if keys = Void then
					ba.append_integer (0)
				else
					ba.append_integer (keys.count)
					from
						keys.start
					until
						keys.after
					loop
						ba.append_integer (keys.item.count)
						ba.append_raw_string (keys.item)
						keys.forth
					end
				end
				ba.mark_forward
				compound.make_byte_code (ba)
				ba.write_forward
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

end
