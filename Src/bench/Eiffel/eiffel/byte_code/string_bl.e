-- Enlarged byte code for Eiffel string (allocated each time).

class STRING_BL 

inherit
	STRING_B
		redefine
			register, set_register,
			analyze, generate,
			propagate, print_register,
			is_simple_expr, unanalyze,
			allocates_memory
		end
	
feature 

	register: REGISTRABLE
			-- Where string is kept to ensure it is GC safe

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'
		do
			register := r
		end

	propagate (r: REGISTRABLE) is
			-- Propagate `r'
		do
			if not context.propagated then
				if r = No_register or r.c_type.same_class_type (c_type) then
					register := r
					context.set_propagated
				end
			end
		end

	unanalyze is
			-- Undo analysis work.
		do
			register := Void
		end

	analyze is
			-- Analyze the string
		do
				-- We get a register to store the string because of the garbage
				-- collector: assume we write f("one", "two"), then the GC
				-- could be invoked while allocating "two" and move "one" right
				-- under the back of the C (without notifying it, how could I?).
			get_register
		end

	generate is
			-- Generate the string
		local
			buf: GENERATION_BUFFER
		do
			if register /= No_register then
				buf := buffer
				register.print_register
				buf.putstring (" = ")
				generate_string
				buf.putchar (';')
				buf.new_line
			end
		end

	print_register is
			-- Print the string (or the register in which it is held)
		do
			if register = No_register then
				generate_string
			else
				register.print_register
			end
		end

	generate_string is
			-- Generate the string (created Eiffel object)
		local
			buf: GENERATION_BUFFER
		do
				-- RTMS_EX is the macro used to create Eiffel strings from C ones
			buf := buffer
			buf.putstring ("RTMS_EX(%"")
			buf.escape_string (buffer,value)
			buf.putchar('"')
			buf.putchar(',')
			buf.putint(value.count)
			buf.putchar(')')
		end

	is_simple_expr: BOOLEAN is True
			-- A string is a simple expression

	allocates_memory: BOOLEAN is True

end
