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
			{LOOP_BL} Precursor (l)
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
				buf.putstring ("Result")
			else
				buf.putstring (internal_reg_name (id))
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
				buf.putchar ('{')
				buf.new_line
				from
					array_desc.start
				until
					array_desc.after
				loop
					buf.putstring ("RTAD(")
					id := array_desc.item
					r_name := external_reg_name (id)
					buf.putstring (r_name)
					buf.putstring (gc_rparan_comma)
							-- The Dtype has not been declared before
					if
						already_generated_offsets = Void
					or else 
						not already_generated_offsets.has (id)
					then
						buf.putstring (" RTADTYPE(")
						buf.putstring (r_name)
						buf.putstring (gc_rparan_comma)
					end
					buf.new_line
					array_desc.forth
				end
				buf.new_line
			end
			if generated_offsets /= Void then
				if array_desc = Void then
					buf.putchar ('{')
					buf.new_line
				end
				from
					generated_offsets.start
				until
					generated_offsets.after
				loop
					r_name := external_reg_name (generated_offsets.item)
					buf.putstring ("RTADTYPE(")
					buf.putstring (r_name)
					buf.putstring ("); RTADOFFSETS(")
					buf.putstring (r_name)
					buf.putstring (gc_rparan_comma)
					buf.new_line
					generated_offsets.forth
				end
				buf.new_line
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
						buf.putstring ("RTAI(")
					else
							-- We can use the offset definitions
						buf.putstring ("RTAIOFF(")
					end
					System.remover.array_optimizer.array_item_type (id).
						generate (buf)
					buf.putstring (gc_comma)
					buf.putstring (external_reg_name (id))
					buf.putstring (gc_comma)
					register_acces (buf, id)
					buf.putstring (gc_rparan_comma)
					buf.new_line

					array_desc.forth
				end
				buf.new_line
			end
			if generated_offsets /= Void then
				from
					generated_offsets.start
				until
					generated_offsets.after
				loop
					id := generated_offsets.item
					r_name := external_reg_name (id)
					buf.putstring ("RTAIOFFSETS(")
					buf.putstring (r_name)
					buf.putstring (gc_comma)
					register_acces (buf, id)
					buf.putstring (gc_rparan_comma)
					buf.new_line
					generated_offsets.forth
				end
				buf.new_line
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
					buf.putstring ("RTAF(")
					id := array_desc.item
					buf.putstring (external_reg_name (id))
					buf.putstring (gc_comma)
					register_acces (buf, id)
					buf.putstring (gc_rparan_comma)
					buf.new_line
					array_desc.forth
				end
				buf.new_line
				buf.putchar ('}')
				buf.new_line
			elseif generated_offsets /= Void then
				buf.putchar ('}')
				buf.new_line
			end
		end

end
