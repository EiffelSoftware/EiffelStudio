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

feature -- Basic Operations

	enlarge_tree is
			-- Enlarge generation tree
		do
			if compound /= Void then
				compound.enlarge_tree
			end
		end

	analyze is
			-- Analysis of debug compound
		do
			if compound /= Void then
				if context.workbench_mode or else is_debug_clause_enabled then
					compound.analyze;
				end
			end
		end

feature -- C Code generation 

	is_debug_clause_enabled: BOOLEAN is
			-- Has the debug compound to be generated in final mode?
		local
			debug_level: DEBUG_I
		do
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

	generate is
			-- Generation of the C code for debug compound
		local
			static_type: STRING
			buf: GENERATION_BUFFER
		do
			generate_line_info
			if compound /= Void then
				if context.final_mode then
					if is_debug_clause_enabled then
						compound.generate
					end
				else
					buf := buffer
						-- Generation of the debug compound in workbench
						-- mode
					static_type := Encoder.generate_type_id_name (context.current_type.associated_class_type.static_type_id)
					buf.putstring (gc_if_l_paran)
					buf.new_line
					buf.indent
					if keys = Void then
							-- No keys
						buf.putstring ("WDBG(RTUD(")
						buf.putstring (static_type)
						buf.putstring ("), (char *) 0)")
					else
						from
							keys.start
						until
							keys.after
						loop
							buf.putstring ("WDBG(RTUD(")
							buf.putstring (static_type)
							buf.putstring ("),%"")
							buf.putstring (keys.item)
							buf.putstring ("%")")
							keys.forth
							if not keys.after then
								buf.putstring (" ||")
								buf.new_line
							end
						end
					end
					buf.new_line
					buf.exdent
					buf.putstring (") {")
					buf.new_line
					buf.indent
								
					compound.generate
	
					buf.exdent
					buf.putchar ('}')
					buf.new_line
				end
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for debug clause
		do
			if compound /= Void and then is_debug_clause_enabled then
				generate_il_line_info
				compound.generate_il
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
			Result := compound /= Void and then compound.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := compound /= Void and then
						compound.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := compound /= Void and then compound.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			if compound /= Void then
				compound := compound.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			if compound /= Void then
				Result := compound.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if compound /= Void then
				compound := compound.inlined_byte_code
			end
		end

end
