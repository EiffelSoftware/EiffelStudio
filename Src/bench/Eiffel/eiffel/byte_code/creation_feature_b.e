indexing
	description: "Generation of call to creation generation"
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_FEATURE_B

inherit
	FEATURE_B
		redefine
			generate, enlarged, is_first, context_type
		end

feature -- C code generation

	enlarged: CREATION_FEATURE_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		local
			creation_feature_bl: CREATION_FEATURE_BL
		do
			if context.final_mode then
				!! creation_feature_bl
			else
				!CREATION_FEATURE_BW! creation_feature_bl.make
			end
			creation_feature_bl.fill_from (Current)
			Result := creation_feature_bl
		end

feature -- Code generation

	is_first: BOOLEAN is False
			-- A creation expression is like a nested call without real
			-- first paramenter

	generate is
			-- Generate C code for the access.
		local
			buf: GENERATION_BUFFER
		do
			generate_parameters (current_register)
			if register /= No_register then
				buf := buffer
						-- Procedures have a void return type
				if register /= Void then
					info.generate_start (Current)
					info.generate_gen_type_conversion (Current)

					register.print_register
					buf.putstring (" = RTLN(")
					info.generate
						-- Generate creation information
					buf.putstring (");")
					buf.new_line
					info.generate_end (Current)

--					if register.is_separate and then
--						not context.real_type(type).is_separate then
--						buf.putstring ("CURLTS(")
--					end
				end
				do_generate (register)
--				if  register /= Void and then register.is_separate and then
--					not context.real_type(type).is_separate then
--					buf.putstring (")")
--				end
				buf.putchar (';')
				buf.new_line

				if
					context.workbench_mode
					or else context.assertion_level.check_invariant
				then
					buf.putstring ("RTCI(")
					register.print_register
					buf.putstring (gc_rparan_comma)
					buf.new_line
				end

				if System.has_separate then
					reset_added_gc_hooks
				end
			end
		end

feature -- Access

	info: CREATE_TYPE

	set_info (i: CREATE_TYPE) is
		do
			info := i
		end

	context_type: TYPE_I is
			-- Context type of the access (properly instantiated)
		do
			Result := info.type
		end

feature -- Copy

	fill_from (f: FEATURE_B) is
			-- Fill in node with feature `f'
		do
			feature_name := f.feature_name
			feature_id := f.feature_id
			type := f.type
			parameters := f.parameters
			precursor_type := f.precursor_type
		end

end -- class CREATION_FEATURE_B
