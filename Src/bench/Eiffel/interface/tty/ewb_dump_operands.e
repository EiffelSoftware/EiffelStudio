indexing

	description: 
		"Dumps operands of a feature to stdout.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DUMP_OPERANDS

inherit

	EWB_FEATURE
		rename
			name as text_cmd_name,
			help_message as r_text_help,
			abbreviation as text_abb
		export
			{ANY} execute
		redefine
			process_feature
		end

creation

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_FEATURE_CMD is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
		end

	process_feature (e_feature: E_FEATURE; e_class: CLASS_C) is
			-- Process `e_feature' defined in `e_class'.
		local
			gs: LINEAR [FORMAL_DEC_AS]
			gts: ARRAY [STRING]
			types: LINEAR [TYPE_A]
			names: LINEAR [STRING]
			i: INTEGER
			s: STRING
		do	
			if e_class.generics /= Void then
				from
					gs := e_class.generics
					create gts.make (1, e_class.generics.count)
					gs.start
					i := 1
				until
					gs.after
				loop
					if gs.item.constraint /= Void then
						gts.put (gs.item.constraint.dump, i)
					else
						gts.put ("ANY", i)
					end
					i := i + 1
					gs.forth
				end
			end
			
			if e_feature.arguments /= Void and  e_feature.arguments.argument_names /= Void then
				types := e_feature.arguments.linear_representation
				names := e_feature.arguments.argument_names.linear_representation

				from
					types.start
					names.start
				until
					types.after
				loop
					print (names.item + ": ")
					if types.item /= Void then
						s := types.item.dump
					else
						s := "Void"
					end
					if gts /= Void then
						from
							i := gts.lower
						until
							i > gts.upper
						loop
							s.replace_substring_all ("Generic #" + i.out, gts.item (i))
							i := i + 1
						end
					end
					if s.item (1) = '[' then
						s.replace_substring ("", 1, s.index_of (']', 1) + 1)
					end
					types.forth
					names.forth
					print (s+ "%N")
				end
			end
		end

end -- class EWB_DUMP_FEATURES
