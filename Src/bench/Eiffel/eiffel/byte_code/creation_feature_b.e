indexing
	description: "Generation of call to creation generation"
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_FEATURE_B

inherit
	FEATURE_B
		redefine
			generate, enlarged, is_first
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
			f: INDENT_FILE
		do
			generate_parameters (current_register)
			if register /= No_register then
				f := generated_file
						-- Procedures have a void return type
				if register /= Void then
					register.print_register
					f.putstring (" = RTLN(")
					info.generate
						-- Generate creation information
					f.putstring (");")
					f.new_line
--					if register.is_separate and then
--						not context.real_type(type).is_separate then
--						f.putstring ("CURLTS(")
--					end
				end
				do_generate (register)
--				if  register /= Void and then register.is_separate and then
--					not context.real_type(type).is_separate then
--					f.putstring (")")
--				end
				f.putchar (';')
				f.new_line

				if
					context.workbench_mode
					or else context.assertion_level.check_invariant
				then
					f.putstring ("RTCI(")
					register.print_register
					f.putstring (gc_rparan_comma)
					f.new_line
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
