indexing
	description	: "Optimized byte code for loops."
	date		: "$Date$"
	revision	: "$Revision$"

class
	OPT_LOOP_BL

inherit
	OPT_LOOP_B
		undefine
			analyze, generate
		end

	LOOP_BL
		undefine
			enlarged, size, pre_inlined_code
		redefine
			fill_from, generate
		end

feature -- Access

	fill_from (l: OPT_LOOP_B) is    
		do
			Precursor {LOOP_BL} (l)
			array_desc := l.array_desc
			generated_offsets := l.generated_offsets
			already_generated_offsets := l.already_generated_offsets
		end

	external_reg_name (id: INTEGER): STRING is
			-- Register name which will be effectively generated at the C level.
		do
			create Result.make (0)
			if id = 0 then
				Result.append ("tmp_result")
			elseif id < 0 then
					-- local
				Result.append ("loc")
				Result.append_integer (-id)
			else
					-- Argument
				Result.append ("arg")
				Result.append_integer (id)
			end
		end

	internal_reg_name (id: INTEGER): STRING is
			-- Same as `external_reg_name' except that for a function returning a
			-- result we need to return `Result' and not `tmp_result' because the
			-- hash_code is based on `Result'.
		do
			create Result.make (0)
			if id = 0 then
				Result.append ("Result")
			elseif id < 0 then
					-- local
				Result.append ("loc")
				Result.append_integer (-id)
			else
					-- Argument
				Result.append ("arg")
				Result.append_integer (id)
			end
		end;

	register_acces (buf: GENERATION_BUFFER; id: INTEGER) is
		do
			if context.byte_code.is_once and then id = 0 then
				buf.put_string ("Result")
			else
				buf.put_string (internal_reg_name (id))
			end
		end

	generate is
		do
			generate_line_info
			generate_assertions
			generate_declarations
			generate_initializations
			generate_loop_body
			generate_free
		end

	generate_declarations is
		local
			id: INTEGER
			r_name: STRING
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if array_desc /= Void then
				buf.put_character ('{')
				buf.put_new_line
				from
					array_desc.start
				until
					array_desc.after
				loop
					buf.put_string ("RTAD(")
					id := array_desc.item
					r_name := external_reg_name (id)
					buf.put_string (r_name)
					buf.put_string (gc_rparan_semi_c)
							-- The Dtype has not been declared before
					if
						already_generated_offsets = Void
					or else 
						not already_generated_offsets.has (id)
					then
						buf.put_string (" RTADTYPE(")
						buf.put_string (r_name)
						buf.put_string (gc_rparan_semi_c)
					end
					buf.put_new_line
					array_desc.forth
				end
				buf.put_new_line
			end
			if generated_offsets /= Void then
				if array_desc = Void then
					buf.put_character ('{')
					buf.put_new_line
				end
				from
					generated_offsets.start
				until
					generated_offsets.after
				loop
					r_name := external_reg_name (generated_offsets.item)
					buf.put_string ("RTADTYPE(")
					buf.put_string (r_name)
					buf.put_string ("); RTADOFFSETS(")
					buf.put_string (r_name)
					buf.put_string (gc_rparan_semi_c)
					buf.put_new_line
					generated_offsets.forth
				end
				buf.put_new_line
			end
		end

	generate_initializations is
		local
			id: INTEGER
			r_name: STRING
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if array_desc /= Void then
				from
					array_desc.start
				until
					array_desc.after
				loop
					id := array_desc.item
					if
						already_generated_offsets = Void
					or else
						not already_generated_offsets.has (id)
					then
						buf.put_string ("RTAI(")
					else
							-- We can use the offset definitions
						buf.put_string ("RTAIOFF(")
					end
					System.remover.array_optimizer.array_item_type (id).
						generate (buf)
					buf.put_string (gc_comma)
					buf.put_string (external_reg_name (id))
					buf.put_string (gc_comma)
					register_acces (buf, id)
					buf.put_string (gc_rparan_semi_c)
					buf.put_new_line

					array_desc.forth
				end
				buf.put_new_line
			end
			if generated_offsets /= Void then
				from
					generated_offsets.start
				until
					generated_offsets.after
				loop
					id := generated_offsets.item
					r_name := external_reg_name (id)
					buf.put_string ("RTAIOFFSETS(")
					buf.put_string (r_name)
					buf.put_string (gc_comma)
					register_acces (buf, id)
					buf.put_string (gc_rparan_semi_c)
					buf.put_new_line
					generated_offsets.forth
				end
				buf.put_new_line
			end
		end

	generate_free is
		local
			id: INTEGER
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if array_desc /= Void then
				from
					array_desc.start
				until
					array_desc.after
				loop
					buf.put_string ("RTAF(")
					id := array_desc.item
					buf.put_string (external_reg_name (id))
					buf.put_string (gc_comma)
					register_acces (buf, id)
					buf.put_string (gc_rparan_semi_c)
					buf.put_new_line
					array_desc.forth
				end
				buf.put_new_line
				buf.put_character ('}')
				buf.put_new_line
			elseif generated_offsets /= Void then
				buf.put_character ('}')
				buf.put_new_line
			end
		end

end
