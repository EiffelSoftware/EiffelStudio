indexing

	description: 
		"Dumps features of a class that can be refernced by agents to stdout.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DUMP_FEATURES

inherit

	EWB_CLASS
		rename
			name as externals_cmd_name,
			help_message as externals_help,
			abbreviation as externals_abb
		export
			{ANY} execute
		redefine
			process_compiled_class,
			want_compiled_class,
			make
		end
	
	SHARED_WORKBENCH

creation

	make, make_verbose, do_nothing

feature

	make (a_type_name: STRING) is
			-- Initialize class_name from `a_type_name'.
		local
			i: INTEGER
		do
			i := a_type_name.index_of (' ', 1)
			if i > 0 then
				class_name := a_type_name.substring (1, i - 1)
				dtype := a_type_name.substring (i + 1, a_type_name.count).to_integer
			else
				class_name := clone (a_type_name)
			end
			class_name.to_lower
		end

	make_verbose (s: STRING) is
			-- Make with `operand_dump' set True.
		do
			make (s)
			operand_dump := True
		end

	enable_operand_dump is
			-- Set `operand_dump' True.
		do
			operand_dump := True
		end

feature {NONE} -- Properties

	dtype: INTEGER

	operand_dump: BOOLEAN
			-- Is operand information dumped?
	
	extra_dump: BOOLEAN is True
			-- Is extra information dumped?
			-- Const values etc...

	process_compiled_class (e_class: CLASS_C) is
			-- Process compiled class `e_class'.
		local
			gs: LINEAR [FORMAL_DEC_AS]
			gts: ARRAY [STRING]
			l: LINEAR [FEATURE_I]
			i: INTEGER
			s: STRING
			c: CONSTANT_I
			tl: TYPE_LIST
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
			
			from
				l := e_class.feature_table.linear_representation
				l.start
			until
				l.after
			loop
				if
					not l.item.is_obsolete and
					not l.item.is_deferred and
					not l.item.is_external
				then
					print (l.item.feature_name + ": ")
					if l.item.type /= Void then
						s := l.item.type.dump
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
					print (s+ "%N")
					if extra_dump then
						if l.item.is_attribute then
							print ("attribute%N")
						else
							if e_class.types.count = 1 then
								print (l.item.real_body_id.out + "%N")
							else
								tl := e_class.types
								from tl.start until tl.after loop
									if tl.item.type_id - 1 = dtype then
										print (
											System.Execution_table.real_body_index (l.item.body_index, tl.item).out
											+ "%N"
										)
									end
									tl.forth
								end
							end
						end
						if l.item.is_constant then
							c ?= l.item
							check c /= Void end
							print ("constant " + c.value.dump + "%N")
						end
					end
					if operand_dump then
						(create {EWB_DUMP_OPERANDS}.make (e_class.name, l.item.feature_name, Void)).execute
					end
					if operand_dump or extra_dump then
						print ("%N")
					end
				end
				l.forth
			end
		end

	want_compiled_class (class_i: CLASS_I): BOOLEAN is
			-- We want the class to be compiled.
		do
			Result := True
		end;

end -- class EWB_DUMP_FEATURES
