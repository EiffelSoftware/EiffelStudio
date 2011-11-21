note
	description: "Command line syntax."
	copyright: "Copyright (c) 2003 Paul Cohen."
	license: "Eiffel Forum License v2 (see license.txt)"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	
class COMMAND_LINE_SYNTAX
	
create
	make
   
feature {NONE} -- Initialization
	
	make (spec: ARRAY [STRING])
			-- Specify a new command line syntax as specified by  
			-- the specifications in `spec'. 
		require
			spec_not_void: spec /= Void
		local
			i: INTEGER
			os: OPTION_SPECIFICATION
			s: STRING
			mes: MUTUAL_EXCLUSIVITY_SPECIFICATION
		do
			set_and_sort_specifications (spec)
			create specified_options.make (specifications.count)
			
			from
				i := specifications.lower
			until
				i > specifications.upper
			loop
				if is_option_specification (specifications @ i) then
					create os.make (specifications @ i)
					if os.is_valid then
						specified_options.put (os, os.name)
					else
						if invalid_specifications = Void then
							create invalid_specifications.make (1)
						end
						s := os.invalid_reason + " beginning at position " + os.invalid_position.out + " in %"" + os.specification + "%""
						invalid_specifications.put (s, os.name)
					end
				elseif is_mutual_exclusivity_specification (specifications @ i) then
					create mes.make (specifications @ i, specified_options)
					if not mes.is_valid then
						if invalid_specifications = Void then
							create invalid_specifications.make (1)
						end
						s := mes.invalid_reason + " beginning at position " + mes.invalid_position.out + " in %"" + mes.specification + "%""
						invalid_specifications.put (s, mes.specification)						
					end
				end
				i := i + 1
			end
		end
	
feature -- Access (Application output messages)
	
	program_usage (program_name: STRING): STRING
			-- Program usage string for presenting to user.
		require
			program_name_not_void: program_name /= Void
			program_name_not_empty: program_name.count > 0
		local
			reqopts: STRING -- Contains required options
			optopts: STRING -- Contains optional options
			os: OPTION_SPECIFICATION
		do
			reqopts := ""
			optopts := ""
			from
				specified_options.start
			until
				specified_options.after
			loop
				os := specified_options.item_for_iteration
				if os.is_required then
					if reqopts.count = 0  then
						reqopts := os.name
					else
						reqopts := reqopts + " " + os.name
					end
					if os.has_optional_argument or os.has_required_argument then
						if os.has_argument_name then
							reqopts := reqopts + "=" + os.argument_name
						else
							reqopts := reqopts + "=ARG"
						end
					end
				else
					if optopts.count = 0 then
						optopts := os.name
					else
						optopts := optopts + " " + os.name
					end
					if os.has_optional_argument then
						if os.has_argument_name then
							optopts := optopts + "=[" + os.argument_name + "]"
						else
							optopts := optopts + "=[ARG]"
						end
					elseif os.has_required_argument then
						if os.has_argument_name then
							optopts := optopts + "=" + os.argument_name
						else
							optopts := optopts + "=ARG"
						end
					end
				end
				specified_options.forth
			end
			Result := "Usage: " + program_name + " "
			if reqopts.count = 0 then
				Result := Result + "[" + optopts + "]"
			else
				Result := Result + reqopts + " [" + optopts + "]"
			end
		end	
	
	program_help (program_name, usage, program_description: STRING): STRING
			-- Program help string for presenting to user. The
			-- `program_name' is mandatory. If no `usage' string is
			-- supplied the value of `program_usage (program_name)'
			-- is used. 
		require
			program_name_not_void: program_name /= Void
			program_name_not_empty: program_name.count > 0
		local
			os: OPTION_SPECIFICATION
			desc_offset, i, pos: INTEGER
			line, s, desc: STRING
			sl: SORTED_TWO_WAY_LIST [OPTION_SPECIFICATION]
		do
			if usage /= Void then
				Result := usage.twin + "%N"
			else
				Result := program_usage (program_name) + "%N%N"
			end
			
			if program_description /= Void then
				Result := Result + program_description + "%N%N"
			end
			
			-- Define the offset to the column position where the
			-- description text will be ouput
			desc_offset := 28
			
			create sl.make
			sl.fill (specified_options.linear_representation)
			
			from 
				sl.start
			until
				sl.after
			loop
				os := sl.item
				if os.has_short_name or os.has_long_name then
					line := "  "
					if os.has_short_name then
						line := line + os.short_name 
						if os.has_long_name then
							line := line + ", "
						end
					end
					if os.has_long_name then
						if not os.has_short_name then
							line := line + "    " + os.long_name
						else
							line := line + os.long_name
						end
					end
					if os.has_optional_argument then
						if os.has_argument_name then
							line := line + "=[" + os.argument_name + "]"
						else
							line := line + "=[ARG]"
						end
					elseif os.has_required_argument then
						if os.has_argument_name then
							line := line + "=" + os.argument_name
						else
							line := line + "=ARG"
						end
					end
				
					if line.count >= desc_offset then
						line := line + "%N"
						create s.make (desc_offset)
						s.fill_blank
					else
						create s.make (desc_offset - line.count)
						s.fill_blank
					end
				
					Result := Result + line + s 
				
					i := os.description.index_of ('%N', 1) 
					if i = 0 then
						desc := os.description
					else
						create s.make (desc_offset)
						s.fill_blank
						s.append ("  ")
						from
							desc := os.description.substring (1, i)
						until
							i = 0
						loop
							pos := i
							i := os.description.index_of ('%N', pos + 1)
							if i = 0 then
								desc := desc + s + os.description.substring (pos + 1, os.description.count)
							else
								desc := desc + s + os.description.substring (pos + 1, i)
							end
						end
					end
				
					Result := Result + desc + "%N"
				end
				sl.forth
			end
		end	
	
feature {COMMAND_LINE_PARSER} -- Access
	
	specified_options: HASH_TABLE [OPTION_SPECIFICATION, STRING]
			-- The specified options hashed by name
	
feature -- Status report
	
	is_valid: BOOLEAN
			-- Is this a valid specification? 
		do
			Result := invalid_specifications = Void
		end
		
	invalid_specifications: HASH_TABLE [STRING, STRING]
			-- Table of invalid option specificationms. Void if
			-- none exists. Hash keys are either a) textual option 
			-- specifications or b) mutual exclusivity
			-- specifications. The hash elements are error
			-- descriptions   
	
feature {NONE} -- Implementation
	
	specifications: ARRAY [STRING]
			-- The original specifications
	
	set_and_sort_specifications (spec: ARRAY [STRING])
			-- Set `specifications' to `spec' and sort the
			-- individual specifications so that all mutual
			-- exclusivity specifications are at the end. This
			-- allows the client to intermix option and exclusivity
			-- specifications without caring about the order!
		require
			spec_not_void: Spec /= Void
		local
			i, j: INTEGER
		do
			create specifications.make (1, spec.count)
			from
				j := 1
				i := spec.lower
			until
				i > spec.upper
			loop
				if is_option_specification (spec @ i) then
					specifications.put (spec @ i, j)
					j := j + 1
				end
				i := i + 1
			end
			from
				i := spec.lower
			until
				i > spec.upper
			loop
				if is_mutual_exclusivity_specification (spec @ i) then
					specifications.put (spec @ i, j)
					j := j + 1
				end
				i := i + 1
			end
		end
		
	is_option_specification (spec: STRING): BOOLEAN
			-- Is `spec' an option specification?
		require
			spec_not_void: spec /= Void
			spec_not_empty: spec.count > 0
		local
			s: STRING
		do
			s := spec.twin
			s.prune_all_leading (' ')
			s.prune_all_trailing (' ')
			Result := (s @ 1 = '-')
		end
	
	is_mutual_exclusivity_specification (spec: STRING): BOOLEAN
			-- Is `spec' an specification of mutual exclusivity?
		require
			spec_not_void: spec /= Void
			spec_not_empty: spec.count > 0
		local
			s: STRING
		do
			s := spec.twin
			s.prune_all_leading (' ')
			s.prune_all_trailing (' ')
			Result := (s @ 1 = '(')
		end
			
end -- class COMMAND_LINE_SYNTAX


