indexing

	description: "Lace parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LACE_PARSER

inherit

	LACE_PARSER_SKELETON

creation

	make


feature {NONE} -- Implementation

	yy_build_parser_tables is
			-- Build parser tables.
		do
			yytranslate := yytranslate_template
			yyr1 := yyr1_template
			yytypes1 := yytypes1_template
			yytypes2 := yytypes2_template
			yydefact := yydefact_template
			yydefgoto := yydefgoto_template
			yypact := yypact_template
			yypgoto := yypgoto_template
			yytable := yytable_template
			yycheck := yycheck_template
		end

	yy_create_value_stacks is
			-- Create value stacks.
		do
		end

	yy_init_value_stacks is
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
			yyvsp3 := -1
			yyvsp4 := -1
			yyvsp5 := -1
			yyvsp6 := -1
			yyvsp7 := -1
			yyvsp8 := -1
			yyvsp9 := -1
			yyvsp10 := -1
			yyvsp11 := -1
			yyvsp12 := -1
			yyvsp13 := -1
			yyvsp14 := -1
			yyvsp15 := -1
			yyvsp16 := -1
			yyvsp17 := -1
			yyvsp18 := -1
			yyvsp19 := -1
			yyvsp20 := -1
			yyvsp21 := -1
			yyvsp22 := -1
			yyvsp23 := -1
			yyvsp24 := -1
			yyvsp25 := -1
			yyvsp26 := -1
			yyvsp27 := -1
			yyvsp28 := -1
			yyvsp29 := -1
		end

	yy_clear_value_stacks is
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			if yyvs1 /= Void then
				yyvs1.clear_all
			end
			if yyvs2 /= Void then
				yyvs2.clear_all
			end
			if yyvs3 /= Void then
				yyvs3.clear_all
			end
			if yyvs4 /= Void then
				yyvs4.clear_all
			end
			if yyvs5 /= Void then
				yyvs5.clear_all
			end
			if yyvs6 /= Void then
				yyvs6.clear_all
			end
			if yyvs7 /= Void then
				yyvs7.clear_all
			end
			if yyvs8 /= Void then
				yyvs8.clear_all
			end
			if yyvs9 /= Void then
				yyvs9.clear_all
			end
			if yyvs10 /= Void then
				yyvs10.clear_all
			end
			if yyvs11 /= Void then
				yyvs11.clear_all
			end
			if yyvs12 /= Void then
				yyvs12.clear_all
			end
			if yyvs13 /= Void then
				yyvs13.clear_all
			end
			if yyvs14 /= Void then
				yyvs14.clear_all
			end
			if yyvs15 /= Void then
				yyvs15.clear_all
			end
			if yyvs16 /= Void then
				yyvs16.clear_all
			end
			if yyvs17 /= Void then
				yyvs17.clear_all
			end
			if yyvs18 /= Void then
				yyvs18.clear_all
			end
			if yyvs19 /= Void then
				yyvs19.clear_all
			end
			if yyvs20 /= Void then
				yyvs20.clear_all
			end
			if yyvs21 /= Void then
				yyvs21.clear_all
			end
			if yyvs22 /= Void then
				yyvs22.clear_all
			end
			if yyvs23 /= Void then
				yyvs23.clear_all
			end
			if yyvs24 /= Void then
				yyvs24.clear_all
			end
			if yyvs25 /= Void then
				yyvs25.clear_all
			end
			if yyvs26 /= Void then
				yyvs26.clear_all
			end
			if yyvs27 /= Void then
				yyvs27.clear_all
			end
			if yyvs28 /= Void then
				yyvs28.clear_all
			end
			if yyvs29 /= Void then
				yyvs29.clear_all
			end
		end

	yy_push_last_value (yychar1: INTEGER) is
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				if yyvs1 = Void then
					debug ("GEYACC")
						std.error.put_line ("Create yyvs1")
					end
					create yyspecial_routines1
					yyvsc1 := yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.make (yyvsc1)
				else
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
				end
			end
			yyvs1.put (last_any_value, yyvsp1)
		end

	yy_push_error_value is
			-- Push semantic value associated with token 'error'
			-- on top of corresponding value stack.
		local
			yyval1: ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				if yyvs1 = Void then
					debug ("GEYACC")
						std.error.put_line ("Create yyvs1")
					end
					create yyspecial_routines1
					yyvsc1 := yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.make (yyvsc1)
				else
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
				end
			end
			yyvs1.put (yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER) is
			-- Pop semantic value from stack when in state `yystate'.
		local
			yy_type_id: INTEGER
		do
			yy_type_id := yytypes1.item (yystate)
			inspect yy_type_id
			when 1 then
				yyvsp1 := yyvsp1 - 1
			when 2 then
				yyvsp2 := yyvsp2 - 1
			when 3 then
				yyvsp3 := yyvsp3 - 1
			when 4 then
				yyvsp4 := yyvsp4 - 1
			when 5 then
				yyvsp5 := yyvsp5 - 1
			when 6 then
				yyvsp6 := yyvsp6 - 1
			when 7 then
				yyvsp7 := yyvsp7 - 1
			when 8 then
				yyvsp8 := yyvsp8 - 1
			when 9 then
				yyvsp9 := yyvsp9 - 1
			when 10 then
				yyvsp10 := yyvsp10 - 1
			when 11 then
				yyvsp11 := yyvsp11 - 1
			when 12 then
				yyvsp12 := yyvsp12 - 1
			when 13 then
				yyvsp13 := yyvsp13 - 1
			when 14 then
				yyvsp14 := yyvsp14 - 1
			when 15 then
				yyvsp15 := yyvsp15 - 1
			when 16 then
				yyvsp16 := yyvsp16 - 1
			when 17 then
				yyvsp17 := yyvsp17 - 1
			when 18 then
				yyvsp18 := yyvsp18 - 1
			when 19 then
				yyvsp19 := yyvsp19 - 1
			when 20 then
				yyvsp20 := yyvsp20 - 1
			when 21 then
				yyvsp21 := yyvsp21 - 1
			when 22 then
				yyvsp22 := yyvsp22 - 1
			when 23 then
				yyvsp23 := yyvsp23 - 1
			when 24 then
				yyvsp24 := yyvsp24 - 1
			when 25 then
				yyvsp25 := yyvsp25 - 1
			when 26 then
				yyvsp26 := yyvsp26 - 1
			when 27 then
				yyvsp27 := yyvsp27 - 1
			when 28 then
				yyvsp28 := yyvsp28 - 1
			when 29 then
				yyvsp29 := yyvsp29 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
			when 1 then
					--|#line <not available> "lace.y"
				yy_do_action_1
			when 2 then
					--|#line <not available> "lace.y"
				yy_do_action_2
			when 3 then
					--|#line <not available> "lace.y"
				yy_do_action_3
			when 4 then
					--|#line <not available> "lace.y"
				yy_do_action_4
			when 5 then
					--|#line <not available> "lace.y"
				yy_do_action_5
			when 6 then
					--|#line <not available> "lace.y"
				yy_do_action_6
			when 7 then
					--|#line <not available> "lace.y"
				yy_do_action_7
			when 8 then
					--|#line <not available> "lace.y"
				yy_do_action_8
			when 9 then
					--|#line <not available> "lace.y"
				yy_do_action_9
			when 10 then
					--|#line <not available> "lace.y"
				yy_do_action_10
			when 11 then
					--|#line <not available> "lace.y"
				yy_do_action_11
			when 12 then
					--|#line <not available> "lace.y"
				yy_do_action_12
			when 13 then
					--|#line <not available> "lace.y"
				yy_do_action_13
			when 14 then
					--|#line <not available> "lace.y"
				yy_do_action_14
			when 15 then
					--|#line <not available> "lace.y"
				yy_do_action_15
			when 16 then
					--|#line <not available> "lace.y"
				yy_do_action_16
			when 17 then
					--|#line <not available> "lace.y"
				yy_do_action_17
			when 18 then
					--|#line <not available> "lace.y"
				yy_do_action_18
			when 19 then
					--|#line <not available> "lace.y"
				yy_do_action_19
			when 20 then
					--|#line <not available> "lace.y"
				yy_do_action_20
			when 21 then
					--|#line <not available> "lace.y"
				yy_do_action_21
			when 22 then
					--|#line <not available> "lace.y"
				yy_do_action_22
			when 23 then
					--|#line <not available> "lace.y"
				yy_do_action_23
			when 24 then
					--|#line <not available> "lace.y"
				yy_do_action_24
			when 25 then
					--|#line <not available> "lace.y"
				yy_do_action_25
			when 26 then
					--|#line <not available> "lace.y"
				yy_do_action_26
			when 27 then
					--|#line <not available> "lace.y"
				yy_do_action_27
			when 28 then
					--|#line <not available> "lace.y"
				yy_do_action_28
			when 29 then
					--|#line <not available> "lace.y"
				yy_do_action_29
			when 30 then
					--|#line <not available> "lace.y"
				yy_do_action_30
			when 31 then
					--|#line <not available> "lace.y"
				yy_do_action_31
			when 32 then
					--|#line <not available> "lace.y"
				yy_do_action_32
			when 33 then
					--|#line <not available> "lace.y"
				yy_do_action_33
			when 34 then
					--|#line <not available> "lace.y"
				yy_do_action_34
			when 35 then
					--|#line <not available> "lace.y"
				yy_do_action_35
			when 36 then
					--|#line <not available> "lace.y"
				yy_do_action_36
			when 37 then
					--|#line <not available> "lace.y"
				yy_do_action_37
			when 38 then
					--|#line <not available> "lace.y"
				yy_do_action_38
			when 39 then
					--|#line <not available> "lace.y"
				yy_do_action_39
			when 40 then
					--|#line <not available> "lace.y"
				yy_do_action_40
			when 41 then
					--|#line <not available> "lace.y"
				yy_do_action_41
			when 42 then
					--|#line <not available> "lace.y"
				yy_do_action_42
			when 43 then
					--|#line <not available> "lace.y"
				yy_do_action_43
			when 44 then
					--|#line <not available> "lace.y"
				yy_do_action_44
			when 45 then
					--|#line <not available> "lace.y"
				yy_do_action_45
			when 46 then
					--|#line <not available> "lace.y"
				yy_do_action_46
			when 47 then
					--|#line <not available> "lace.y"
				yy_do_action_47
			when 48 then
					--|#line <not available> "lace.y"
				yy_do_action_48
			when 49 then
					--|#line <not available> "lace.y"
				yy_do_action_49
			when 50 then
					--|#line <not available> "lace.y"
				yy_do_action_50
			when 51 then
					--|#line <not available> "lace.y"
				yy_do_action_51
			when 52 then
					--|#line <not available> "lace.y"
				yy_do_action_52
			when 53 then
					--|#line <not available> "lace.y"
				yy_do_action_53
			when 54 then
					--|#line <not available> "lace.y"
				yy_do_action_54
			when 55 then
					--|#line <not available> "lace.y"
				yy_do_action_55
			when 56 then
					--|#line <not available> "lace.y"
				yy_do_action_56
			when 57 then
					--|#line <not available> "lace.y"
				yy_do_action_57
			when 58 then
					--|#line <not available> "lace.y"
				yy_do_action_58
			when 59 then
					--|#line <not available> "lace.y"
				yy_do_action_59
			when 60 then
					--|#line <not available> "lace.y"
				yy_do_action_60
			when 61 then
					--|#line <not available> "lace.y"
				yy_do_action_61
			when 62 then
					--|#line <not available> "lace.y"
				yy_do_action_62
			when 63 then
					--|#line <not available> "lace.y"
				yy_do_action_63
			when 64 then
					--|#line <not available> "lace.y"
				yy_do_action_64
			when 65 then
					--|#line <not available> "lace.y"
				yy_do_action_65
			when 66 then
					--|#line <not available> "lace.y"
				yy_do_action_66
			when 67 then
					--|#line <not available> "lace.y"
				yy_do_action_67
			when 68 then
					--|#line <not available> "lace.y"
				yy_do_action_68
			when 69 then
					--|#line <not available> "lace.y"
				yy_do_action_69
			when 70 then
					--|#line <not available> "lace.y"
				yy_do_action_70
			when 71 then
					--|#line <not available> "lace.y"
				yy_do_action_71
			when 72 then
					--|#line <not available> "lace.y"
				yy_do_action_72
			when 73 then
					--|#line <not available> "lace.y"
				yy_do_action_73
			when 74 then
					--|#line <not available> "lace.y"
				yy_do_action_74
			when 75 then
					--|#line <not available> "lace.y"
				yy_do_action_75
			when 76 then
					--|#line <not available> "lace.y"
				yy_do_action_76
			when 77 then
					--|#line <not available> "lace.y"
				yy_do_action_77
			when 78 then
					--|#line <not available> "lace.y"
				yy_do_action_78
			when 79 then
					--|#line <not available> "lace.y"
				yy_do_action_79
			when 80 then
					--|#line <not available> "lace.y"
				yy_do_action_80
			when 81 then
					--|#line <not available> "lace.y"
				yy_do_action_81
			when 82 then
					--|#line <not available> "lace.y"
				yy_do_action_82
			when 83 then
					--|#line <not available> "lace.y"
				yy_do_action_83
			when 84 then
					--|#line <not available> "lace.y"
				yy_do_action_84
			when 85 then
					--|#line <not available> "lace.y"
				yy_do_action_85
			when 86 then
					--|#line <not available> "lace.y"
				yy_do_action_86
			when 87 then
					--|#line <not available> "lace.y"
				yy_do_action_87
			when 88 then
					--|#line <not available> "lace.y"
				yy_do_action_88
			when 89 then
					--|#line <not available> "lace.y"
				yy_do_action_89
			when 90 then
					--|#line <not available> "lace.y"
				yy_do_action_90
			when 91 then
					--|#line <not available> "lace.y"
				yy_do_action_91
			when 92 then
					--|#line <not available> "lace.y"
				yy_do_action_92
			when 93 then
					--|#line <not available> "lace.y"
				yy_do_action_93
			when 94 then
					--|#line <not available> "lace.y"
				yy_do_action_94
			when 95 then
					--|#line <not available> "lace.y"
				yy_do_action_95
			when 96 then
					--|#line <not available> "lace.y"
				yy_do_action_96
			when 97 then
					--|#line <not available> "lace.y"
				yy_do_action_97
			when 98 then
					--|#line <not available> "lace.y"
				yy_do_action_98
			when 99 then
					--|#line <not available> "lace.y"
				yy_do_action_99
			when 100 then
					--|#line <not available> "lace.y"
				yy_do_action_100
			when 101 then
					--|#line <not available> "lace.y"
				yy_do_action_101
			when 102 then
					--|#line <not available> "lace.y"
				yy_do_action_102
			when 103 then
					--|#line <not available> "lace.y"
				yy_do_action_103
			when 104 then
					--|#line <not available> "lace.y"
				yy_do_action_104
			when 105 then
					--|#line <not available> "lace.y"
				yy_do_action_105
			when 106 then
					--|#line <not available> "lace.y"
				yy_do_action_106
			when 107 then
					--|#line <not available> "lace.y"
				yy_do_action_107
			when 108 then
					--|#line <not available> "lace.y"
				yy_do_action_108
			when 109 then
					--|#line <not available> "lace.y"
				yy_do_action_109
			when 110 then
					--|#line <not available> "lace.y"
				yy_do_action_110
			when 111 then
					--|#line <not available> "lace.y"
				yy_do_action_111
			when 112 then
					--|#line <not available> "lace.y"
				yy_do_action_112
			when 113 then
					--|#line <not available> "lace.y"
				yy_do_action_113
			when 114 then
					--|#line <not available> "lace.y"
				yy_do_action_114
			when 115 then
					--|#line <not available> "lace.y"
				yy_do_action_115
			when 116 then
					--|#line <not available> "lace.y"
				yy_do_action_116
			when 117 then
					--|#line <not available> "lace.y"
				yy_do_action_117
			when 118 then
					--|#line <not available> "lace.y"
				yy_do_action_118
			when 119 then
					--|#line <not available> "lace.y"
				yy_do_action_119
			when 120 then
					--|#line <not available> "lace.y"
				yy_do_action_120
			when 121 then
					--|#line <not available> "lace.y"
				yy_do_action_121
			when 122 then
					--|#line <not available> "lace.y"
				yy_do_action_122
			when 123 then
					--|#line <not available> "lace.y"
				yy_do_action_123
			when 124 then
					--|#line <not available> "lace.y"
				yy_do_action_124
			when 125 then
					--|#line <not available> "lace.y"
				yy_do_action_125
			when 126 then
					--|#line <not available> "lace.y"
				yy_do_action_126
			when 127 then
					--|#line <not available> "lace.y"
				yy_do_action_127
			when 128 then
					--|#line <not available> "lace.y"
				yy_do_action_128
			when 129 then
					--|#line <not available> "lace.y"
				yy_do_action_129
			when 130 then
					--|#line <not available> "lace.y"
				yy_do_action_130
			when 131 then
					--|#line <not available> "lace.y"
				yy_do_action_131
			when 132 then
					--|#line <not available> "lace.y"
				yy_do_action_132
			when 133 then
					--|#line <not available> "lace.y"
				yy_do_action_133
			when 134 then
					--|#line <not available> "lace.y"
				yy_do_action_134
			when 135 then
					--|#line <not available> "lace.y"
				yy_do_action_135
			when 136 then
					--|#line <not available> "lace.y"
				yy_do_action_136
			when 137 then
					--|#line <not available> "lace.y"
				yy_do_action_137
			when 138 then
					--|#line <not available> "lace.y"
				yy_do_action_138
			when 139 then
					--|#line <not available> "lace.y"
				yy_do_action_139
			when 140 then
					--|#line <not available> "lace.y"
				yy_do_action_140
			when 141 then
					--|#line <not available> "lace.y"
				yy_do_action_141
			when 142 then
					--|#line <not available> "lace.y"
				yy_do_action_142
			when 143 then
					--|#line <not available> "lace.y"
				yy_do_action_143
			when 144 then
					--|#line <not available> "lace.y"
				yy_do_action_144
			when 145 then
					--|#line <not available> "lace.y"
				yy_do_action_145
			when 146 then
					--|#line <not available> "lace.y"
				yy_do_action_146
			when 147 then
					--|#line <not available> "lace.y"
				yy_do_action_147
			when 148 then
					--|#line <not available> "lace.y"
				yy_do_action_148
			when 149 then
					--|#line <not available> "lace.y"
				yy_do_action_149
			when 150 then
					--|#line <not available> "lace.y"
				yy_do_action_150
			when 151 then
					--|#line <not available> "lace.y"
				yy_do_action_151
			when 152 then
					--|#line <not available> "lace.y"
				yy_do_action_152
			when 153 then
					--|#line <not available> "lace.y"
				yy_do_action_153
			when 154 then
					--|#line <not available> "lace.y"
				yy_do_action_154
			when 155 then
					--|#line <not available> "lace.y"
				yy_do_action_155
			when 156 then
					--|#line <not available> "lace.y"
				yy_do_action_156
			when 157 then
					--|#line <not available> "lace.y"
				yy_do_action_157
			when 158 then
					--|#line <not available> "lace.y"
				yy_do_action_158
			when 159 then
					--|#line <not available> "lace.y"
				yy_do_action_159
			when 160 then
					--|#line <not available> "lace.y"
				yy_do_action_160
			when 161 then
					--|#line <not available> "lace.y"
				yy_do_action_161
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_1 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

ast := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_2 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

ast := yyvs4.item (yyvsp4) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_3 is
			--|#line <not available> "lace.y"
		local
			yyval2: ACE_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval2.initialize (yyvs9.item (yyvsp9), yyvs15.item (yyvsp15), yyvs22.item (yyvsp22), yyvs20.item (yyvsp20), yyvs21.item (yyvsp21), yyvs26.item (yyvsp26)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp2 := yyvsp2 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp15 := yyvsp15 -1
	yyvsp22 := yyvsp22 -1
	yyvsp20 := yyvsp20 -1
	yyvsp21 := yyvsp21 -1
	yyvsp26 := yyvsp26 -1
	yyvsp1 := yyvsp1 -2
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_4 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_5 is
			--|#line <not available> "lace.y"
		local
			yyval15: ROOT_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval15.initialize (yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp9 := yyvsp9 -3
	if yyvsp15 >= yyvsc15 then
		if yyvs15 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs15")
			end
			create yyspecial_routines15
			yyvsc15 := yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.make (yyvsc15)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs15")
			end
			yyvsc15 := yyvsc15 + yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.resize (yyvs15, yyvsc15)
		end
	end
	yyvs15.put (yyval15, yyvsp15)
end
		end

	yy_do_action_6 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp9 := yyvsp9 + 1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_7 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_8 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp9 := yyvsp9 + 1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_9 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_10 is
			--|#line <not available> "lace.y"
		local
			yyval20: LACE_LIST [CLUSTER_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval20 := yyvs20.item (yyvsp20) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_11 is
			--|#line <not available> "lace.y"
		local
			yyval20: LACE_LIST [CLUSTER_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval20 := Void 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp20 >= yyvsc20 then
		if yyvs20 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs20")
			end
			create yyspecial_routines20
			yyvsc20 := yyInitial_yyvs_size
			yyvs20 := yyspecial_routines20.make (yyvsc20)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs20")
			end
			yyvsc20 := yyvsc20 + yyInitial_yyvs_size
			yyvs20 := yyspecial_routines20.resize (yyvs20, yyvsc20)
		end
	end
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_12 is
			--|#line <not available> "lace.y"
		local
			yyval20: LACE_LIST [CLUSTER_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval20.make (10)
				yyval20.extend (yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp6 := yyvsp6 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp20 >= yyvsc20 then
		if yyvs20 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs20")
			end
			create yyspecial_routines20
			yyvsc20 := yyInitial_yyvs_size
			yyvs20 := yyspecial_routines20.make (yyvsc20)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs20")
			end
			yyvsc20 := yyvsc20 + yyInitial_yyvs_size
			yyvs20 := yyspecial_routines20.resize (yyvs20, yyvsc20)
		end
	end
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_13 is
			--|#line <not available> "lace.y"
		local
			yyval20: LACE_LIST [CLUSTER_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval20 := yyvs20.item (yyvsp20)
				yyval20.extend (yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 -1
	yyvsp1 := yyvsp1 -1
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_14 is
			--|#line <not available> "lace.y"
		local
			yyval6: CLUSTER_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval6.initialize (yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9), Void, False, False) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp6 := yyvsp6 + 1
	yyvsp9 := yyvsp9 -3
	yyvsp1 := yyvsp1 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyvs6.put (yyval6, yyvsp6)
end
		end

	yy_do_action_15 is
			--|#line <not available> "lace.y"
		local
			yyval6: CLUSTER_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval6.initialize (yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9), Void, True, False) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp9 := yyvsp9 -3
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyvs6.put (yyval6, yyvsp6)
end
		end

	yy_do_action_16 is
			--|#line <not available> "lace.y"
		local
			yyval6: CLUSTER_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval6.initialize (yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9), Void, True, True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp9 := yyvsp9 -3
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyvs6.put (yyval6, yyvsp6)
end
		end

	yy_do_action_17 is
			--|#line <not available> "lace.y"
		local
			yyval6: CLUSTER_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval6.initialize (yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9), yyvs4.item (yyvsp4), False, False) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp6 := yyvsp6 + 1
	yyvsp9 := yyvsp9 -3
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyvs6.put (yyval6, yyvsp6)
end
		end

	yy_do_action_18 is
			--|#line <not available> "lace.y"
		local
			yyval6: CLUSTER_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval6.initialize (yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9), yyvs4.item (yyvsp4), True, False) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp9 := yyvsp9 -3
	yyvsp4 := yyvsp4 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyvs6.put (yyval6, yyvsp6)
end
		end

	yy_do_action_19 is
			--|#line <not available> "lace.y"
		local
			yyval6: CLUSTER_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval6.initialize (yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9), yyvs4.item (yyvsp4), True, True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp9 := yyvsp9 -3
	yyvsp4 := yyvsp4 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyvs6.put (yyval6, yyvsp6)
end
		end

	yy_do_action_20 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp9 := yyvsp9 + 1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_21 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_22 is
			--|#line <not available> "lace.y"
		local
			yyval4: CLUST_PROP_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval4.initialize (yyvs29.item (yyvsp29), yyvs9.item (yyvsp9), yyvs25.item (yyvsp25 - 1), yyvs25.item (yyvsp25), yyvs19.item (yyvsp19), yyvs22.item (yyvsp22), yyvs27.item (yyvsp27), yyvs18.item (yyvsp18)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp4 := yyvsp4 + 1
	yyvsp29 := yyvsp29 -1
	yyvsp9 := yyvsp9 -1
	yyvsp25 := yyvsp25 -2
	yyvsp19 := yyvsp19 -1
	yyvsp22 := yyvsp22 -1
	yyvsp27 := yyvsp27 -1
	yyvsp18 := yyvsp18 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_23 is
			--|#line <not available> "lace.y"
		local
			yyval4: CLUST_PROP_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval4.initialize (Void, yyvs9.item (yyvsp9), yyvs25.item (yyvsp25 - 1), yyvs25.item (yyvsp25), yyvs19.item (yyvsp19), yyvs22.item (yyvsp22), yyvs27.item (yyvsp27), yyvs18.item (yyvsp18)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp4 := yyvsp4 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp25 := yyvsp25 -2
	yyvsp19 := yyvsp19 -1
	yyvsp22 := yyvsp22 -1
	yyvsp27 := yyvsp27 -1
	yyvsp18 := yyvsp18 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_24 is
			--|#line <not available> "lace.y"
		local
			yyval4: CLUST_PROP_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval4.initialize (Void, Void, yyvs25.item (yyvsp25 - 1), yyvs25.item (yyvsp25), yyvs19.item (yyvsp19), yyvs22.item (yyvsp22), yyvs27.item (yyvsp27), yyvs18.item (yyvsp18)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 + 1
	yyvsp25 := yyvsp25 -2
	yyvsp19 := yyvsp19 -1
	yyvsp22 := yyvsp22 -1
	yyvsp27 := yyvsp27 -1
	yyvsp18 := yyvsp18 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_25 is
			--|#line <not available> "lace.y"
		local
			yyval4: CLUST_PROP_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval4.initialize (Void, Void, Void, yyvs25.item (yyvsp25), yyvs19.item (yyvsp19), yyvs22.item (yyvsp22), yyvs27.item (yyvsp27), yyvs18.item (yyvsp18)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 + 1
	yyvsp25 := yyvsp25 -1
	yyvsp19 := yyvsp19 -1
	yyvsp22 := yyvsp22 -1
	yyvsp27 := yyvsp27 -1
	yyvsp18 := yyvsp18 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_26 is
			--|#line <not available> "lace.y"
		local
			yyval4: CLUST_PROP_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval4.initialize (Void, Void, Void, Void, yyvs19.item (yyvsp19), yyvs22.item (yyvsp22), yyvs27.item (yyvsp27), yyvs18.item (yyvsp18)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 + 1
	yyvsp19 := yyvsp19 -1
	yyvsp22 := yyvsp22 -1
	yyvsp27 := yyvsp27 -1
	yyvsp18 := yyvsp18 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_27 is
			--|#line <not available> "lace.y"
		local
			yyval4: CLUST_PROP_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval4.initialize (Void, Void, Void, Void, Void, yyvs22.item (yyvsp22), yyvs27.item (yyvsp27), yyvs18.item (yyvsp18)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 + 1
	yyvsp22 := yyvsp22 -1
	yyvsp27 := yyvsp27 -1
	yyvsp18 := yyvsp18 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_28 is
			--|#line <not available> "lace.y"
		local
			yyval4: CLUST_PROP_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval4.initialize (Void, Void, Void, Void, Void, Void, yyvs27.item (yyvsp27), yyvs18.item (yyvsp18)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp27 := yyvsp27 -1
	yyvsp18 := yyvsp18 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_29 is
			--|#line <not available> "lace.y"
		local
			yyval4: CLUST_PROP_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval4.initialize (Void, Void, Void, Void, Void, Void, Void, yyvs18.item (yyvsp18)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp18 := yyvsp18 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_30 is
			--|#line <not available> "lace.y"
		local
			yyval29: LACE_LIST [DEPEND_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval29 := yyvs29.item (yyvsp29) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs29.put (yyval29, yyvsp29)
end
		end

	yy_do_action_31 is
			--|#line <not available> "lace.y"
		local
			yyval29: LACE_LIST [DEPEND_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp29 := yyvsp29 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp29 >= yyvsc29 then
		if yyvs29 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs29")
			end
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs29")
			end
			yyvsc29 := yyvsc29 + yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.resize (yyvs29, yyvsc29)
		end
	end
	yyvs29.put (yyval29, yyvsp29)
end
		end

	yy_do_action_32 is
			--|#line <not available> "lace.y"
		local
			yyval29: LACE_LIST [DEPEND_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval29.make (10)
				yyval29.extend (yyvs17.item (yyvsp17))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp29 := yyvsp29 + 1
	yyvsp17 := yyvsp17 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp29 >= yyvsc29 then
		if yyvs29 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs29")
			end
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs29")
			end
			yyvsc29 := yyvsc29 + yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.resize (yyvs29, yyvsc29)
		end
	end
	yyvs29.put (yyval29, yyvsp29)
end
		end

	yy_do_action_33 is
			--|#line <not available> "lace.y"
		local
			yyval29: LACE_LIST [DEPEND_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval29 := yyvs29.item (yyvsp29)
				yyval29.extend (yyvs17.item (yyvsp17))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp17 := yyvsp17 -1
	yyvsp1 := yyvsp1 -1
	yyvs29.put (yyval29, yyvsp29)
end
		end

	yy_do_action_34 is
			--|#line <not available> "lace.y"
		local
			yyval17: DEPEND_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval17.initialize (yyvs23.item (yyvsp23), yyvs9.item (yyvsp9)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp17 := yyvsp17 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp1 := yyvsp1 -1
	yyvsp9 := yyvsp9 -1
	if yyvsp17 >= yyvsc17 then
		if yyvs17 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs17")
			end
			create yyspecial_routines17
			yyvsc17 := yyInitial_yyvs_size
			yyvs17 := yyspecial_routines17.make (yyvsc17)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs17")
			end
			yyvsc17 := yyvsc17 + yyInitial_yyvs_size
			yyvs17 := yyspecial_routines17.resize (yyvs17, yyvsc17)
		end
	end
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_35 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp9 := yyvsp9 + 1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_36 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_37 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_38 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp25 := yyvsp25 + 1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_39 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval25 := yyvs25.item (yyvsp25) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_40 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval25 := yyvs25.item (yyvsp25) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_41 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_42 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp25 := yyvsp25 + 1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_43 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval25 := yyvs25.item (yyvsp25) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_44 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval25 := yyvs25.item (yyvsp25) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_45 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_46 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval25.make (10)
				yyval25.extend (create {FILE_NAME_SD}.initialize (yyvs9.item (yyvsp9)))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_47 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval25 := yyvs25.item (yyvsp25)
				yyval25.extend (create {FILE_NAME_SD}.initialize (yyvs9.item (yyvsp9)))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_48 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval25.make (10)
				yyval25.extend (create {FILE_NAME_SD}.initialize (yyvs9.item (yyvsp9)))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_49 is
			--|#line <not available> "lace.y"
		local
			yyval25: LACE_LIST [FILE_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval25 := yyvs25.item (yyvsp25)
				yyval25.extend (create {FILE_NAME_SD}.initialize (yyvs9.item (yyvsp9)))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_50 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval23.make (10)
				yyval23.extend (yyvs9.item (yyvsp9))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp23 := yyvsp23 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp23 >= yyvsc23 then
		if yyvs23 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs23")
			end
			create yyspecial_routines23
			yyvsc23 := yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.make (yyvsc23)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs23")
			end
			yyvsc23 := yyvsc23 + yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
		end
	end
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_51 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval23 := yyvs23.item (yyvsp23)
				yyval23.extend (yyvs9.item (yyvsp9))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp9 := yyvsp9 -1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_52 is
			--|#line <not available> "lace.y"
		local
			yyval19: LACE_LIST [CLUST_ADAPT_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp19 := yyvsp19 + 1
	if yyvsp19 >= yyvsc19 then
		if yyvs19 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs19")
			end
			create yyspecial_routines19
			yyvsc19 := yyInitial_yyvs_size
			yyvs19 := yyspecial_routines19.make (yyvsc19)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs19")
			end
			yyvsc19 := yyvsc19 + yyInitial_yyvs_size
			yyvs19 := yyspecial_routines19.resize (yyvs19, yyvsc19)
		end
	end
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_53 is
			--|#line <not available> "lace.y"
		local
			yyval19: LACE_LIST [CLUST_ADAPT_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval19 := yyvs19.item (yyvsp19) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_54 is
			--|#line <not available> "lace.y"
		local
			yyval19: LACE_LIST [CLUST_ADAPT_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval19 := yyvs19.item (yyvsp19) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_55 is
			--|#line <not available> "lace.y"
		local
			yyval19: LACE_LIST [CLUST_ADAPT_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp19 >= yyvsc19 then
		if yyvs19 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs19")
			end
			create yyspecial_routines19
			yyvsc19 := yyInitial_yyvs_size
			yyvs19 := yyspecial_routines19.make (yyvsc19)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs19")
			end
			yyvsc19 := yyvsc19 + yyInitial_yyvs_size
			yyvs19 := yyspecial_routines19.resize (yyvs19, yyvsc19)
		end
	end
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_56 is
			--|#line <not available> "lace.y"
		local
			yyval19: LACE_LIST [CLUST_ADAPT_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval19.make (10)
				yyval19.extend (yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp19 >= yyvsc19 then
		if yyvs19 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs19")
			end
			create yyspecial_routines19
			yyvsc19 := yyInitial_yyvs_size
			yyvs19 := yyspecial_routines19.make (yyvsc19)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs19")
			end
			yyvsc19 := yyvsc19 + yyInitial_yyvs_size
			yyvs19 := yyspecial_routines19.resize (yyvs19, yyvsc19)
		end
	end
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_57 is
			--|#line <not available> "lace.y"
		local
			yyval19: LACE_LIST [CLUST_ADAPT_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval19 := yyvs19.item (yyvsp19)
				yyval19.extend (yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_58 is
			--|#line <not available> "lace.y"
		local
			yyval5: CLUST_ADAPT_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create {CLUST_IGN_SD} yyval5.initialize (yyvs9.item (yyvsp9)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
		end

	yy_do_action_59 is
			--|#line <not available> "lace.y"
		local
			yyval5: CLUST_ADAPT_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create {CLUST_REN_SD} yyval5.initialize (yyvs9.item (yyvsp9), yyvs28.item (yyvsp28)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp5 := yyvsp5 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -2
	yyvsp28 := yyvsp28 -1
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
		end

	yy_do_action_60 is
			--|#line <not available> "lace.y"
		local
			yyval28: LACE_LIST [TWO_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval28.make (10)
				yyval28.extend (yyvs16.item (yyvsp16))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp28 >= yyvsc28 then
		if yyvs28 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs28")
			end
			create yyspecial_routines28
			yyvsc28 := yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.make (yyvsc28)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs28")
			end
			yyvsc28 := yyvsc28 + yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.resize (yyvs28, yyvsc28)
		end
	end
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_61 is
			--|#line <not available> "lace.y"
		local
			yyval28: LACE_LIST [TWO_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval28 := yyvs28.item (yyvsp28)
				yyval28.extend (yyvs16.item (yyvsp16))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp16 := yyvsp16 -1
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_62 is
			--|#line <not available> "lace.y"
		local
			yyval16: TWO_NAME_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval16.initialize (yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp16 := yyvsp16 + 1
	yyvsp9 := yyvsp9 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp16 >= yyvsc16 then
		if yyvs16 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs16")
			end
			create yyspecial_routines16
			yyvsc16 := yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.make (yyvsc16)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs16")
			end
			yyvsc16 := yyvsc16 + yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.resize (yyvs16, yyvsc16)
		end
	end
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_63 is
			--|#line <not available> "lace.y"
		local
			yyval22: LACE_LIST [D_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp22 := yyvsp22 + 1
	if yyvsp22 >= yyvsc22 then
		if yyvs22 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs22")
			end
			create yyspecial_routines22
			yyvsc22 := yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.make (yyvsc22)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs22")
			end
			yyvsc22 := yyvsc22 + yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.resize (yyvs22, yyvsc22)
		end
	end
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_64 is
			--|#line <not available> "lace.y"
		local
			yyval22: LACE_LIST [D_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval22 := yyvs22.item (yyvsp22) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_65 is
			--|#line <not available> "lace.y"
		local
			yyval22: LACE_LIST [D_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval22 := yyvs22.item (yyvsp22) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_66 is
			--|#line <not available> "lace.y"
		local
			yyval22: LACE_LIST [D_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp22 >= yyvsc22 then
		if yyvs22 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs22")
			end
			create yyspecial_routines22
			yyvsc22 := yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.make (yyvsc22)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs22")
			end
			yyvsc22 := yyvsc22 + yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.resize (yyvs22, yyvsc22)
		end
	end
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_67 is
			--|#line <not available> "lace.y"
		local
			yyval27: LACE_LIST [O_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp27 := yyvsp27 + 1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_68 is
			--|#line <not available> "lace.y"
		local
			yyval27: LACE_LIST [O_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_69 is
			--|#line <not available> "lace.y"
		local
			yyval27: LACE_LIST [O_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_70 is
			--|#line <not available> "lace.y"
		local
			yyval27: LACE_LIST [O_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp27 := yyvsp27 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_71 is
			--|#line <not available> "lace.y"
		local
			yyval22: LACE_LIST [D_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval22.make (10)
				yyval22.extend (yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 + 1
	yyvsp8 := yyvsp8 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp22 >= yyvsc22 then
		if yyvs22 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs22")
			end
			create yyspecial_routines22
			yyvsc22 := yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.make (yyvsc22)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs22")
			end
			yyvsc22 := yyvsc22 + yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.resize (yyvs22, yyvsc22)
		end
	end
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_72 is
			--|#line <not available> "lace.y"
		local
			yyval22: LACE_LIST [D_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval22 := yyvs22.item (yyvsp22)
				yyval22.extend (yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp8 := yyvsp8 -1
	yyvsp1 := yyvsp1 -1
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_73 is
			--|#line <not available> "lace.y"
		local
			yyval8: D_OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create {D_PRECOMPILED_SD} yyval8.initialize (Precompiled_keyword, yyvs13.item (yyvsp13), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp8 >= yyvsc8 then
		if yyvs8 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs8")
			end
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs8")
			end
			yyvsc8 := yyvsc8 + yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
		end
	end
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_74 is
			--|#line <not available> "lace.y"
		local
			yyval8: D_OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create {D_PRECOMPILED_SD} yyval8.initialize (Precompiled_keyword, yyvs13.item (yyvsp13), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp13 := yyvsp13 -1
	if yyvsp8 >= yyvsc8 then
		if yyvs8 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs8")
			end
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs8")
			end
			yyvsc8 := yyvsc8 + yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
		end
	end
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_75 is
			--|#line <not available> "lace.y"
		local
			yyval8: D_OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create {D_PRECOMPILED_SD} yyval8.initialize (Precompiled_keyword, yyvs13.item (yyvsp13), yyvs28.item (yyvsp28)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp13 := yyvsp13 -1
	yyvsp28 := yyvsp28 -1
	if yyvsp8 >= yyvsc8 then
		if yyvs8 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs8")
			end
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs8")
			end
			yyvsc8 := yyvsc8 + yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
		end
	end
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_76 is
			--|#line <not available> "lace.y"
		local
			yyval8: D_OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval8.initialize (yyvs14.item (yyvsp14), yyvs13.item (yyvsp13)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp8 := yyvsp8 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp8 >= yyvsc8 then
		if yyvs8 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs8")
			end
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs8")
			end
			yyvsc8 := yyvsc8 + yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
		end
	end
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_77 is
			--|#line <not available> "lace.y"
		local
			yyval14: OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval14 := Assertion_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp14 := yyvsp14 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp14 >= yyvsc14 then
		if yyvs14 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs14")
			end
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs14")
			end
			yyvsc14 := yyvsc14 + yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
		end
	end
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_78 is
			--|#line <not available> "lace.y"
		local
			yyval14: OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval14 := Debug_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp14 := yyvsp14 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp14 >= yyvsc14 then
		if yyvs14 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs14")
			end
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs14")
			end
			yyvsc14 := yyvsc14 + yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
		end
	end
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_79 is
			--|#line <not available> "lace.y"
		local
			yyval14: OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval14 := Disabled_debug_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp14 := yyvsp14 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp14 >= yyvsc14 then
		if yyvs14 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs14")
			end
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs14")
			end
			yyvsc14 := yyvsc14 + yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
		end
	end
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_80 is
			--|#line <not available> "lace.y"
		local
			yyval14: OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval14 := Optimize_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp14 := yyvsp14 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp14 >= yyvsc14 then
		if yyvs14 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs14")
			end
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs14")
			end
			yyvsc14 := yyvsc14 + yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
		end
	end
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_81 is
			--|#line <not available> "lace.y"
		local
			yyval14: OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval14 := Trace_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp14 := yyvsp14 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp14 >= yyvsc14 then
		if yyvs14 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs14")
			end
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs14")
			end
			yyvsc14 := yyvsc14 + yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
		end
	end
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_82 is
			--|#line <not available> "lace.y"
		local
			yyval14: OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create {FREE_OPTION_SD} yyval14.initialize (yyvs9.item (yyvsp9))
				if not yyval14.is_valid then
					raise_error
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp14 := yyvsp14 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp14 >= yyvsc14 then
		if yyvs14 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs14")
			end
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs14")
			end
			yyvsc14 := yyvsc14 + yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
		end
	end
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_83 is
			--|#line <not available> "lace.y"
		local
			yyval27: LACE_LIST [O_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval27.make (10)
				yyval27.extend (yyvs12.item (yyvsp12))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp27 := yyvsp27 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_84 is
			--|#line <not available> "lace.y"
		local
			yyval27: LACE_LIST [O_OPTION_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval27 := yyvs27.item (yyvsp27)
				yyval27.extend (yyvs12.item (yyvsp12))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_85 is
			--|#line <not available> "lace.y"
		local
			yyval12: O_OPTION_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval12.initialize (yyvs14.item (yyvsp14), yyvs13.item (yyvsp13), yyvs23.item (yyvsp23)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp13 := yyvsp13 -1
	yyvsp23 := yyvsp23 -1
	if yyvsp12 >= yyvsc12 then
		if yyvs12 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs12")
			end
			create yyspecial_routines12
			yyvsc12 := yyInitial_yyvs_size
			yyvs12 := yyspecial_routines12.make (yyvsc12)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs12")
			end
			yyvsc12 := yyvsc12 + yyInitial_yyvs_size
			yyvs12 := yyspecial_routines12.resize (yyvs12, yyvsc12)
		end
	end
	yyvs12.put (yyval12, yyvsp12)
end
		end

	yy_do_action_86 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp23 := yyvsp23 + 1
	if yyvsp23 >= yyvsc23 then
		if yyvs23 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs23")
			end
			create yyspecial_routines23
			yyvsc23 := yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.make (yyvsc23)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs23")
			end
			yyvsc23 := yyvsc23 + yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
		end
	end
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_87 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval23 := yyvs23.item (yyvsp23) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_88 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval23.make (10)
				yyval23.extend (yyvs9.item (yyvsp9))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp23 := yyvsp23 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp23 >= yyvsc23 then
		if yyvs23 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs23")
			end
			create yyspecial_routines23
			yyvsc23 := yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.make (yyvsc23)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs23")
			end
			yyvsc23 := yyvsc23 + yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
		end
	end
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_89 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval23 := yyvs23.item (yyvsp23)
				yyval23.extend (yyvs9.item (yyvsp9))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp9 := yyvsp9 -1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_90 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp13 := yyvsp13 + 1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_91 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_92 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_93 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_94 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval13.make (yyvs9.item (yyvsp9)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_95 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := Yes_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_96 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := No_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_97 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := All_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_98 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := Require_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_99 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := Ensure_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_100 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := Invariant_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_101 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := Loop_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_102 is
			--|#line <not available> "lace.y"
		local
			yyval13: OPT_VAL_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval13 := Check_keyword 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_103 is
			--|#line <not available> "lace.y"
		local
			yyval21: LACE_LIST [ASSEMBLY_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp21 := yyvsp21 + 1
	if yyvsp21 >= yyvsc21 then
		if yyvs21 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs21")
			end
			create yyspecial_routines21
			yyvsc21 := yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.make (yyvsc21)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs21")
			end
			yyvsc21 := yyvsc21 + yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.resize (yyvs21, yyvsc21)
		end
	end
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_104 is
			--|#line <not available> "lace.y"
		local
			yyval21: LACE_LIST [ASSEMBLY_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval21 := yyvs21.item (yyvsp21) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_105 is
			--|#line <not available> "lace.y"
		local
			yyval21: LACE_LIST [ASSEMBLY_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp21 := yyvsp21 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp21 >= yyvsc21 then
		if yyvs21 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs21")
			end
			create yyspecial_routines21
			yyvsc21 := yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.make (yyvsc21)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs21")
			end
			yyvsc21 := yyvsc21 + yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.resize (yyvs21, yyvsc21)
		end
	end
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_106 is
			--|#line <not available> "lace.y"
		local
			yyval21: LACE_LIST [ASSEMBLY_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval21.make (5)
				yyval21.extend (yyvs7.item (yyvsp7))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp21 := yyvsp21 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp21 >= yyvsc21 then
		if yyvs21 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs21")
			end
			create yyspecial_routines21
			yyvsc21 := yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.make (yyvsc21)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs21")
			end
			yyvsc21 := yyvsc21 + yyInitial_yyvs_size
			yyvs21 := yyspecial_routines21.resize (yyvs21, yyvsc21)
		end
	end
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_107 is
			--|#line <not available> "lace.y"
		local
			yyval21: LACE_LIST [ASSEMBLY_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval21 := yyvs21.item (yyvsp21)
				yyval21.extend (yyvs7.item (yyvsp7))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_108 is
			--|#line <not available> "lace.y"
		local
			yyval7: ASSEMBLY_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

					-- name: "assembly_name"
				create yyval7.initialize (yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9), Void, Void, Void)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -3
	yyvsp1 := yyvsp1 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyvs7.put (yyval7, yyvsp7)
end
		end

	yy_do_action_109 is
			--|#line <not available> "lace.y"
		local
			yyval7: ASSEMBLY_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

					-- name: "assembly_name", "version", "culture", "public_key_token"
				create yyval7.initialize (yyvs9.item (yyvsp9 - 5), yyvs9.item (yyvsp9 - 4), yyvs9.item (yyvsp9), yyvs9.item (yyvsp9 - 3), yyvs9.item (yyvsp9 - 2), yyvs9.item (yyvsp9 - 1))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 10
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -6
	yyvsp1 := yyvsp1 -4
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyvs7.put (yyval7, yyvsp7)
end
		end

	yy_do_action_110 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp9 := yyvsp9 + 1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_111 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_112 is
			--|#line <not available> "lace.y"
		local
			yyval26: LACE_LIST [LANG_TRIB_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp26 := yyvsp26 + 1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
		end

	yy_do_action_113 is
			--|#line <not available> "lace.y"
		local
			yyval26: LACE_LIST [LANG_TRIB_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval26 := yyvs26.item (yyvsp26) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
		end

	yy_do_action_114 is
			--|#line <not available> "lace.y"
		local
			yyval26: LACE_LIST [LANG_TRIB_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
		end

	yy_do_action_115 is
			--|#line <not available> "lace.y"
		local
			yyval26: LACE_LIST [LANG_TRIB_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval26.make (10)
				yyval26.extend (yyvs10.item (yyvsp10))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp10 := yyvsp10 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
		end

	yy_do_action_116 is
			--|#line <not available> "lace.y"
		local
			yyval26: LACE_LIST [LANG_TRIB_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval26 := yyvs26.item (yyvsp26)
				yyval26.extend (yyvs10.item (yyvsp10))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp10 := yyvsp10 -1
	yyvsp1 := yyvsp1 -1
	yyvs26.put (yyval26, yyvsp26)
end
		end

	yy_do_action_117 is
			--|#line <not available> "lace.y"
		local
			yyval10: LANG_TRIB_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval10.initialize (yyvs11.item (yyvsp11), yyvs23.item (yyvsp23)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp10 := yyvsp10 + 1
	yyvsp11 := yyvsp11 -1
	yyvsp1 := yyvsp1 -1
	yyvsp23 := yyvsp23 -1
	if yyvsp10 >= yyvsc10 then
		if yyvs10 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs10")
			end
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs10")
			end
			yyvsc10 := yyvsc10 + yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.resize (yyvs10, yyvsc10)
		end
	end
	yyvs10.put (yyval10, yyvsp10)
end
		end

	yy_do_action_118 is
			--|#line <not available> "lace.y"
		local
			yyval11: LANGUAGE_NAME_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval11.initialize (yyvs9.item (yyvsp9)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyvs11.put (yyval11, yyvsp11)
end
		end

	yy_do_action_119 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_120 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_121 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_122 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

--		create $$.make (10)
--		$$.extend ($1)
	
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_123 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

--		$$ := $1
--		$$.extend ($2)
	
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_124 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp11 := yyvsp11 -1
	yyvsp9 := yyvsp9 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_125 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_126 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_127 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_128 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_129 is
			--|#line <not available> "lace.y"
		local
			yyval18: LACE_LIST [CLAS_VISI_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp18 := yyvsp18 + 1
	if yyvsp18 >= yyvsc18 then
		if yyvs18 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs18")
			end
			create yyspecial_routines18
			yyvsc18 := yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.make (yyvsc18)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs18")
			end
			yyvsc18 := yyvsc18 + yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.resize (yyvs18, yyvsc18)
		end
	end
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_130 is
			--|#line <not available> "lace.y"
		local
			yyval18: LACE_LIST [CLAS_VISI_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval18 := yyvs18.item (yyvsp18) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_131 is
			--|#line <not available> "lace.y"
		local
			yyval18: LACE_LIST [CLAS_VISI_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval18 := yyvs18.item (yyvsp18) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_132 is
			--|#line <not available> "lace.y"
		local
			yyval18: LACE_LIST [CLAS_VISI_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp18 := yyvsp18 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp18 >= yyvsc18 then
		if yyvs18 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs18")
			end
			create yyspecial_routines18
			yyvsc18 := yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.make (yyvsc18)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs18")
			end
			yyvsc18 := yyvsc18 + yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.resize (yyvs18, yyvsc18)
		end
	end
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_133 is
			--|#line <not available> "lace.y"
		local
			yyval18: LACE_LIST [CLAS_VISI_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval18.make (10)
				yyval18.extend (yyvs3.item (yyvsp3))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp18 := yyvsp18 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp18 >= yyvsc18 then
		if yyvs18 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs18")
			end
			create yyspecial_routines18
			yyvsc18 := yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.make (yyvsc18)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs18")
			end
			yyvsc18 := yyvsc18 + yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.resize (yyvs18, yyvsc18)
		end
	end
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_134 is
			--|#line <not available> "lace.y"
		local
			yyval18: LACE_LIST [CLAS_VISI_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval18 := yyvs18.item (yyvsp18)
				yyval18.extend (yyvs3.item (yyvsp3))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_135 is
			--|#line <not available> "lace.y"
		local
			yyval3: CLAS_VISI_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval3.initialize (yyvs9.item (yyvsp9), Void, Void, Void, Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp3 := yyvsp3 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp3 >= yyvsc3 then
		if yyvs3 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs3")
			end
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs3")
			end
			yyvsc3 := yyvsc3 + yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
		end
	end
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_136 is
			--|#line <not available> "lace.y"
		local
			yyval3: CLAS_VISI_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval3.initialize (yyvs9.item (yyvsp9), Void, Void, Void, Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		if yyvs3 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs3")
			end
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs3")
			end
			yyvsc3 := yyvsc3 + yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
		end
	end
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_137 is
			--|#line <not available> "lace.y"
		local
			yyval3: CLAS_VISI_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval3.initialize (yyvs9.item (yyvsp9), Void, Void, Void, yyvs28.item (yyvsp28)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp28 := yyvsp28 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		if yyvs3 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs3")
			end
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs3")
			end
			yyvsc3 := yyvsc3 + yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
		end
	end
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_138 is
			--|#line <not available> "lace.y"
		local
			yyval3: CLAS_VISI_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval3.initialize (yyvs9.item (yyvsp9), Void, Void, yyvs23.item (yyvsp23), yyvs28.item (yyvsp28)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp3 := yyvsp3 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp23 := yyvsp23 -1
	yyvsp28 := yyvsp28 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		if yyvs3 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs3")
			end
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs3")
			end
			yyvsc3 := yyvsc3 + yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
		end
	end
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_139 is
			--|#line <not available> "lace.y"
		local
			yyval3: CLAS_VISI_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval3.initialize (yyvs9.item (yyvsp9), Void, yyvs23.item (yyvsp23 - 1), yyvs23.item (yyvsp23), yyvs28.item (yyvsp28)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp3 := yyvsp3 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp23 := yyvsp23 -2
	yyvsp28 := yyvsp28 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		if yyvs3 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs3")
			end
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs3")
			end
			yyvsc3 := yyvsc3 + yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
		end
	end
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_140 is
			--|#line <not available> "lace.y"
		local
			yyval3: CLAS_VISI_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval3.initialize (yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9), yyvs23.item (yyvsp23 - 1), yyvs23.item (yyvsp23), yyvs28.item (yyvsp28)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp3 := yyvsp3 + 1
	yyvsp9 := yyvsp9 -2
	yyvsp23 := yyvsp23 -2
	yyvsp28 := yyvsp28 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		if yyvs3 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs3")
			end
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs3")
			end
			yyvsc3 := yyvsc3 + yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
		end
	end
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_141 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_142 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp23 := yyvsp23 + 1
	if yyvsp23 >= yyvsc23 then
		if yyvs23 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs23")
			end
			create yyspecial_routines23
			yyvsc23 := yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.make (yyvsc23)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs23")
			end
			yyvsc23 := yyvsc23 + yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
		end
	end
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_143 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval23 := yyvs23.item (yyvsp23) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_144 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval23 := yyvs23.item (yyvsp23) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_145 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp23 := yyvsp23 + 1
	if yyvsp23 >= yyvsc23 then
		if yyvs23 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs23")
			end
			create yyspecial_routines23
			yyvsc23 := yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.make (yyvsc23)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs23")
			end
			yyvsc23 := yyvsc23 + yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
		end
	end
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_146 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval23 := yyvs23.item (yyvsp23) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_147 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval23 := yyvs23.item (yyvsp23) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_148 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp23 := yyvsp23 + 1
	if yyvsp23 >= yyvsc23 then
		if yyvs23 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs23")
			end
			create yyspecial_routines23
			yyvsc23 := yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.make (yyvsc23)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs23")
			end
			yyvsc23 := yyvsc23 + yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
		end
	end
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_149 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval23.make (10)
				yyval23.extend (yyvs9.item (yyvsp9))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp23 := yyvsp23 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp23 >= yyvsc23 then
		if yyvs23 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs23")
			end
			create yyspecial_routines23
			yyvsc23 := yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.make (yyvsc23)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs23")
			end
			yyvsc23 := yyvsc23 + yyInitial_yyvs_size
			yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
		end
	end
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_150 is
			--|#line <not available> "lace.y"
		local
			yyval23: LACE_LIST [ID_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval23 := yyvs23.item (yyvsp23)
				yyval23.extend (yyvs9.item (yyvsp9))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp9 := yyvsp9 -1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_151 is
			--|#line <not available> "lace.y"
		local
			yyval28: LACE_LIST [TWO_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp28 := yyvsp28 + 1
	if yyvsp28 >= yyvsc28 then
		if yyvs28 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs28")
			end
			create yyspecial_routines28
			yyvsc28 := yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.make (yyvsc28)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs28")
			end
			yyvsc28 := yyvsc28 + yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.resize (yyvs28, yyvsc28)
		end
	end
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_152 is
			--|#line <not available> "lace.y"
		local
			yyval28: LACE_LIST [TWO_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval28 := yyvs28.item (yyvsp28) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_153 is
			--|#line <not available> "lace.y"
		local
			yyval28: LACE_LIST [TWO_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval28 := yyvs28.item (yyvsp28) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_154 is
			--|#line <not available> "lace.y"
		local
			yyval28: LACE_LIST [TWO_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				create yyval28.make (10)
				yyval28.extend (yyvs16.item (yyvsp16))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp28 >= yyvsc28 then
		if yyvs28 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs28")
			end
			create yyspecial_routines28
			yyvsc28 := yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.make (yyvsc28)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs28")
			end
			yyvsc28 := yyvsc28 + yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.resize (yyvs28, yyvsc28)
		end
	end
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_155 is
			--|#line <not available> "lace.y"
		local
			yyval28: LACE_LIST [TWO_NAME_SD]
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

				yyval28 := yyvs28.item (yyvsp28)
				yyval28.extend (yyvs16.item (yyvsp16))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp16 := yyvsp16 -1
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_156 is
			--|#line <not available> "lace.y"
		local
			yyval16: TWO_NAME_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp16 := yyvsp16 + 1
	if yyvsp16 >= yyvsc16 then
		if yyvs16 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs16")
			end
			create yyspecial_routines16
			yyvsc16 := yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.make (yyvsc16)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs16")
			end
			yyvsc16 := yyvsc16 + yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.resize (yyvs16, yyvsc16)
		end
	end
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_157 is
			--|#line <not available> "lace.y"
		local
			yyval16: TWO_NAME_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

create yyval16.initialize (yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp16 := yyvsp16 + 1
	yyvsp9 := yyvsp9 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp16 >= yyvsc16 then
		if yyvs16 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs16")
			end
			create yyspecial_routines16
			yyvsc16 := yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.make (yyvsc16)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs16")
			end
			yyvsc16 := yyvsc16 + yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.resize (yyvs16, yyvsc16)
		end
	end
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_158 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := new_id_sd (token_buffer, False) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_159 is
			--|#line <not available> "lace.y"
		local
			yyval9: ID_SD
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end

yyval9 := new_id_sd (token_buffer, True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_160 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_161 is
			--|#line <not available> "lace.y"
		local
			yyval1: ANY
		do
--|#line <not available> "lace.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'lace.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_error_action (yy_act: INTEGER) is
			-- Execute error action.
		do
			if yy_act <= 199 then
				yy_do_error_action_0_199 (yy_act)
			elseif yy_act <= 399 then
				yy_do_error_action_200_399 (yy_act)
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_0_199 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_200_399 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			when 285 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    1,    2,    3,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,

			   45, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,  112,  112,   46,   58,   70,   59,   59,   60,   60,
			   80,   80,   81,   81,   50,   50,   50,   50,   50,   50,
			   57,   57,   48,   48,   48,   48,   48,   48,   48,   48,
			  111,  111,  110,  110,   73,   56,   56,   55,   99,   99,
			   98,   98,   96,   96,   95,   95,  100,  100,   97,   97,
			   94,   94,   78,   78,   77,   77,   79,   79,   49,   49,
			  109,  109,   72,   86,   86,   85,   85,  105,  105,  104,
			  104,   84,   84,   52,   52,   52,   52,   69,   69,   69,
			   69,   69,   69,  103,  103,   64,   92,   92,   93,   93,
			   65,   65,   66,   66,   66,   67,   67,   67,   68,   68,

			   68,   68,   68,   82,   82,   82,   83,   83,   51,   51,
			   61,   61,  101,  101,  101,  102,  102,   62,   63,  113,
			  113,  113,  115,  115,  116,  117,  117,  118,  118,   76,
			   76,   75,   75,   74,   74,   47,   47,   47,   47,   47,
			   47,   54,   91,   91,   90,   89,   89,   88,   87,   87,
			   87,  108,  108,  107,  106,  106,   71,   71,   53,   53,
			  114,  114, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    2,    4,    9,    9,   18,   19,   22,   25,   25,   27,
			   29,    1,    1,    1,    3,    9,   18,    1,    9,    9,
			    1,    1,    1,    1,    1,    9,   12,   14,   27,    1,
			    9,   25,    1,    9,   17,   23,   29,    1,    9,   25,
			    1,    1,    8,   14,   22,    1,    5,    9,   19,    1,
			   25,   25,    1,   15,   22,   22,   27,   27,   19,   19,
			   25,   25,   18,   18,    9,    9,    1,    1,    1,    1,
			    1,    1,    9,   23,   23,   28,    3,    1,    1,   13,
			   12,    1,    9,    1,    1,    1,   17,    1,    9,   13,

			    1,   13,    8,    1,    1,    5,   25,    9,   22,   27,
			   18,   22,   19,   25,    9,   16,   28,    9,   23,   23,
			    9,   23,   23,   28,   28,   23,   23,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    9,   13,   13,
			   13,    1,   23,    1,    1,    9,    9,    1,    1,    1,
			   28,    1,    1,    1,    1,   19,    1,    9,    1,   20,
			   18,   27,   22,   25,    1,    1,    1,   23,    1,   28,
			    1,    9,   23,    1,    9,   16,   28,   22,    9,    1,
			    9,    1,    1,    6,    9,   20,    1,    1,   21,   18,
			   27,   19,    9,   16,    9,   28,    1,    1,    1,    1,

			   27,    1,    9,    9,    9,    1,    1,    9,    6,    7,
			    9,   21,    1,    1,   26,   18,   22,    1,    9,    9,
			   16,   18,    9,    9,    9,    1,    1,    1,    1,    7,
			    9,   10,   11,   26,    1,    1,    1,   27,    1,    1,
			    1,    9,    9,    1,    1,    1,   10,   11,    1,    1,
			    1,    1,   18,    9,    9,    4,    1,    1,    9,   23,
			    1,    1,    1,    1,    1,    4,    4,    1,    9,    9,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    9,    9,    1,    9,    9,    1,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,  160,    0,    0,  160,  160,  160,  160,  160,  160,
			    1,    2,   38,    0,   29,   63,   67,   52,   42,  129,
			   35,  159,  161,  158,  160,  135,  131,  132,   37,    4,
			   81,   80,   79,   78,   77,   82,  160,   90,   69,   70,
			  160,   40,   41,   50,  160,    0,   30,   31,  160,   44,
			   45,   90,  160,   90,   65,   66,  160,    0,   54,   55,
			   39,   42,    0,   63,   64,   67,   68,  129,   53,   63,
			   43,   52,  130,   28,   36,   38,  133,  156,  148,  136,
			  148,    0,  142,  151,  145,    0,  160,   83,    0,   86,
			  160,   46,  160,   32,    0,    0,  160,   48,  160,   73,

			   71,   76,  160,   56,    0,  160,   52,    6,    0,  129,
			   27,   67,   63,   42,    0,  154,  153,  149,  147,  144,
			  141,  143,  145,  152,    0,  146,  151,  137,  134,   95,
			   98,   96,  101,  100,   99,  102,   97,   94,    0,   92,
			   93,    0,   85,   84,   47,   51,   34,   33,   49,   74,
			    0,   72,    0,   58,   57,   63,    0,    8,  160,  103,
			   26,  129,   67,   52,    0,  156,    0,  151,  138,    0,
			   91,   88,   87,   75,    0,   60,   59,   67,    0,    0,
			    5,    0,    0,  160,   20,   10,   11,  160,  112,   25,
			  129,   63,  157,  155,  150,    0,  139,    0,    0,    0,

			  129,    7,    9,   20,   20,   12,    0,    0,  160,  160,
			    0,  104,  105,  160,  119,   24,   67,  140,   89,   62,
			   61,   23,    0,    0,    0,    0,   13,  106,    0,  160,
			  118,  160,    0,  113,  114,  160,    0,  129,    0,    0,
			   21,   14,  110,  107,  115,    0,  160,  125,  121,  120,
			  160,    3,   22,   16,   15,    0,    0,    0,  108,  117,
			  116,    0,    0,  160,  122,    0,    0,   17,    0,    0,
			  127,  128,    0,    0,  123,   19,   18,  111,    0,  126,
			  124,    0,    0,  110,  109,    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   10,   24,   11,   56,  183,  209,   52,   35,   82,   12,
			   75,  207,   13,  157,  180,  258,  231,  232,   36,   89,
			  138,  139,  140,   37,   63,  115,  175,   44,   26,   72,
			   73,   15,   69,   58,  159,  185,  188,  211,   54,   64,
			   65,  118,  125,  126,   84,  122,  142,  172,   45,   17,
			   71,   49,   18,   61,   41,  214,  233,   38,   66,   67,
			  116,  123,  124,  176,   46,   20,  285,  236,   27,  249,
			  250,  262,  272, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			  106,   59,    3,    3,   45,   59,   59,   59,  283,   59,
			 -32768, -32768,  167,  166, -32768,  133,  103,  159,  161,   79,
			  165, -32768, -32768, -32768,   78,   19,    3, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,   78,  168,  297, -32768,
			   78,    3, -32768, -32768,   78,   27,    3, -32768,   78,    3,
			 -32768,  168,   78,  168,  261, -32768,   78,  183,    3, -32768,
			 -32768,  161,    3,  133, -32768,  103, -32768,   79, -32768,  133,
			 -32768,  159, -32768, -32768, -32768,  167, -32768,    3,    3, -32768,
			    3,    3,  178,  126,  151,  172,   78, -32768,   84,  177,
			   78, -32768,   78, -32768,    3,    3,   78, -32768,   78,    7,

			 -32768, -32768,   78, -32768,   61,   78,  159,  164,  176,   79,
			 -32768,  103,  133,  161,  170, -32768,  163, -32768,  162,  162,
			 -32768, -32768,  151, -32768,  153, -32768,  126, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  134, -32768,
			 -32768,    3, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  152, -32768,    3, -32768, -32768,  133,    3,  157,   24,  160,
			 -32768,   79,  103,  159,    3,    3,    3,  126, -32768,  143,
			 -32768, -32768,  147, -32768,  145, -32768,  132,  103,  117,    3,
			 -32768,    3,    3,   78,  115,   28, -32768,   59,  131, -32768,
			   79,  133, -32768, -32768, -32768,  125, -32768,    3,    3,    3,

			   79, -32768, -32768,  115,  115, -32768,    3,  129,   78,   78,
			  128,    3, -32768,   59,  114, -32768,  103, -32768, -32768, -32768,
			 -32768, -32768,  123,  122,   94,    3, -32768, -32768,    3,   78,
			 -32768,   78,  119,    3, -32768,   59,  111,   79,    3,    3,
			 -32768,  158,   10, -32768, -32768,    3,   78,   99, -32768,    3,
			   78, -32768, -32768,  158,  158,  102,    3,    3, -32768,  110,
			 -32768,    0,  107,   78, -32768,   98,   95, -32768,   80,   63,
			 -32768, -32768,   36,    3, -32768, -32768, -32768, -32768,    3, -32768,
			 -32768,   48,    3,   -6, -32768,   33,   30, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			 -32768,  202, -163,  181,   46,   15,  175,   -1, -32768,  203,
			 -32768,  -99, -32768, -32768, -32768,  -61,   -8, -179,  173,  -17,
			 -32768, -32768, -32768,   12, -32768,   43,   22,  174, -32768,   17,
			  -55,   -7,  -60, -32768, -32768, -32768, -32768, -32768, -32768,   13,
			  -47,  139,  184,   82,  124, -32768, -32768, -32768,  -51,  -11,
			  -42, -32768,    6,  127, -32768, -32768, -32768, -32768,    9,  -62,
			 -32768,  -10, -112, -32768, -32768, -32768, -32768, -32768,  209, -32768,
			  -50, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   25,   28,   29,  109,   40,   43,   48,   70,   57,   19,
			   68,  112,  110,   16,  169,   85,  108,   14,   60,  106,
			   53,  257,  111,  149,   81,   25,   23,  256,  182,  271,
			  287,   80,  182,  286,   99,   79,  101,   95,   94,   78,
			   92,   77,   21,  256,  270,   43,  155,   23,   98,  161,
			   70,   23,   34,   77,  160,  195,  247,   57,   33,  282,
			   32,  107,   22,   21,   68,  162,   53,   21,   23,  181,
			  247,  163,  279,  181,  278,   31,  114,  117,  255,  117,
			  120,   60,   23,   22,   21,  153,   30,  137,  136,  150,
			  265,  266,  135,  145,  146,  152,  277,   22,   21,   68,

			  190,  134,   70,  191,  222,  223,  189,   23,  177,    9,
			  133,  276,  132,  131,  275,  200,   22,  273,  267,  130,
			    8,   94,    1,   21,    7,    6,  261,  251,  129,  245,
			  240,    5,  239,  238,    4,  215,  235,    4,  228,  225,
			  171,  217,  206,  199,  216,  221,    3,    8,    2,    1,
			  198,  174,  213,  201,  237,  178,   68,  184,  197,  196,
			   77,    9,    9,  192,  114,  194,  187,  179,  173,  168,
			  170,   78,    8,  166,  165,  164,    7,    6,  202,    7,
			  203,  204,  252,    5,  184,  158,  210,  141,  127,    4,
			   80,  156,    5,  104,  259,   88,  218,  219,  174,  263,

			    2,    1,  113,   62,  167,  224,  121,    2,  193,   83,
			  210,   90,  230,   39,   42,   47,   50,   55,   59,  119,
			   96,  220,  284,   74,  241,  246,  229,  242,   86,  102,
			    0,  208,  230,   76,  230,    0,    0,  253,  254,  105,
			    0,    0,    0,    0,   43,   87,    0,    0,  230,   91,
			   19,    0,    0,   93,   16,  268,  269,   97,   14,    0,
			    0,  100,   19,   19,    0,  103,   16,   16,   34,    0,
			   14,   14,  280,    0,   33,    0,   32,  281,    0,    0,
			    0,  283,    0,    0,   23,    0,    0,    0,    0,    0,
			   34,   31,    0,   51,    0,  128,   33,    0,   32,  143,

			   21,  144,   30,    0,   34,  147,   23,  148,    0,    0,
			   33,  151,   32,   31,  154,   51,    0,    0,    0,    0,
			   23,   22,   21,    0,   30,    0,    0,   31,    0,    0,
			    0,    0,    0,    0,    0,    0,   21,    0,   30,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  186,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  205,    0,    0,    0,  212,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  226,  227,    0,
			    0,    0,  234,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  243,    0,
			  244,    0,    0,    0,  248,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  260,    0,    0,    0,  264,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  274, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    2,    3,   65,    5,    6,    7,   18,    9,    0,
			   17,   71,   67,    0,  126,   25,   63,    0,   12,   61,
			    8,   11,   69,   16,    5,   26,   23,   33,    4,   29,
			    0,   12,    4,    0,   51,   16,   53,   10,   11,   20,
			   41,   34,   39,   33,   44,   46,  106,   23,   49,  111,
			   61,   23,    7,   34,  109,  167,  235,   58,   13,   11,
			   15,   62,   38,   39,   71,  112,   54,   39,   23,   45,
			  249,  113,   36,   45,   11,   30,   77,   78,  241,   80,
			   81,   75,   23,   38,   39,   24,   41,   88,    4,   99,
			  253,  254,    8,   94,   95,   34,   16,   38,   39,  106,

			  162,   17,  113,  163,  203,  204,  161,   23,  155,    3,
			   26,   16,   28,   29,   16,  177,   38,   10,   16,   35,
			   14,   11,   43,   39,   18,   19,   27,   16,   44,   10,
			   36,   25,   10,   10,   31,  190,   22,   31,   10,   10,
			  141,   16,   27,   11,  191,  200,   40,   14,   42,   43,
			    5,  152,   21,   36,  216,  156,  163,  158,   11,   16,
			   34,    3,    3,  164,  165,  166,    6,   10,   16,   16,
			   36,   20,   14,   11,   11,    5,   18,   19,  179,   18,
			  181,  182,  237,   25,  185,    9,  187,   10,   16,   31,
			   12,   27,   25,   10,  245,   27,  197,  198,  199,  249,

			   42,   43,   75,   37,  122,  206,   82,   42,  165,   25,
			  211,   38,  213,    4,    5,    6,    7,    8,    9,   80,
			   46,  199,  283,   20,  225,  233,  211,  228,   26,   54,
			   -1,  185,  233,   24,  235,   -1,   -1,  238,  239,   58,
			   -1,   -1,   -1,   -1,  245,   36,   -1,   -1,  249,   40,
			  241,   -1,   -1,   44,  241,  256,  257,   48,  241,   -1,
			   -1,   52,  253,  254,   -1,   56,  253,  254,    7,   -1,
			  253,  254,  273,   -1,   13,   -1,   15,  278,   -1,   -1,
			   -1,  282,   -1,   -1,   23,   -1,   -1,   -1,   -1,   -1,
			    7,   30,   -1,   32,   -1,   86,   13,   -1,   15,   90,

			   39,   92,   41,   -1,    7,   96,   23,   98,   -1,   -1,
			   13,  102,   15,   30,  105,   32,   -1,   -1,   -1,   -1,
			   23,   38,   39,   -1,   41,   -1,   -1,   30,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   39,   -1,   41,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  158,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  183,   -1,   -1,   -1,  187,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  208,  209,   -1,
			   -1,   -1,  213,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  229,   -1,
			  231,   -1,   -1,   -1,  235,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  246,   -1,   -1,   -1,  250,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  263, yyDummy>>)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [ANY]
			-- Stack for semantic values of type ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [ANY]
			-- Routines that ought to be in SPECIAL [ANY]

	yyvs2: SPECIAL [ACE_SD]
			-- Stack for semantic values of type ACE_SD

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [ACE_SD]
			-- Routines that ought to be in SPECIAL [ACE_SD]

	yyvs3: SPECIAL [CLAS_VISI_SD]
			-- Stack for semantic values of type CLAS_VISI_SD

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [CLAS_VISI_SD]
			-- Routines that ought to be in SPECIAL [CLAS_VISI_SD]

	yyvs4: SPECIAL [CLUST_PROP_SD]
			-- Stack for semantic values of type CLUST_PROP_SD

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [CLUST_PROP_SD]
			-- Routines that ought to be in SPECIAL [CLUST_PROP_SD]

	yyvs5: SPECIAL [CLUST_ADAPT_SD]
			-- Stack for semantic values of type CLUST_ADAPT_SD

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [CLUST_ADAPT_SD]
			-- Routines that ought to be in SPECIAL [CLUST_ADAPT_SD]

	yyvs6: SPECIAL [CLUSTER_SD]
			-- Stack for semantic values of type CLUSTER_SD

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [CLUSTER_SD]
			-- Routines that ought to be in SPECIAL [CLUSTER_SD]

	yyvs7: SPECIAL [ASSEMBLY_SD]
			-- Stack for semantic values of type ASSEMBLY_SD

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [ASSEMBLY_SD]
			-- Routines that ought to be in SPECIAL [ASSEMBLY_SD]

	yyvs8: SPECIAL [D_OPTION_SD]
			-- Stack for semantic values of type D_OPTION_SD

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [D_OPTION_SD]
			-- Routines that ought to be in SPECIAL [D_OPTION_SD]

	yyvs9: SPECIAL [ID_SD]
			-- Stack for semantic values of type ID_SD

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [ID_SD]
			-- Routines that ought to be in SPECIAL [ID_SD]

	yyvs10: SPECIAL [LANG_TRIB_SD]
			-- Stack for semantic values of type LANG_TRIB_SD

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [LANG_TRIB_SD]
			-- Routines that ought to be in SPECIAL [LANG_TRIB_SD]

	yyvs11: SPECIAL [LANGUAGE_NAME_SD]
			-- Stack for semantic values of type LANGUAGE_NAME_SD

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [LANGUAGE_NAME_SD]
			-- Routines that ought to be in SPECIAL [LANGUAGE_NAME_SD]

	yyvs12: SPECIAL [O_OPTION_SD]
			-- Stack for semantic values of type O_OPTION_SD

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [O_OPTION_SD]
			-- Routines that ought to be in SPECIAL [O_OPTION_SD]

	yyvs13: SPECIAL [OPT_VAL_SD]
			-- Stack for semantic values of type OPT_VAL_SD

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [OPT_VAL_SD]
			-- Routines that ought to be in SPECIAL [OPT_VAL_SD]

	yyvs14: SPECIAL [OPTION_SD]
			-- Stack for semantic values of type OPTION_SD

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [OPTION_SD]
			-- Routines that ought to be in SPECIAL [OPTION_SD]

	yyvs15: SPECIAL [ROOT_SD]
			-- Stack for semantic values of type ROOT_SD

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [ROOT_SD]
			-- Routines that ought to be in SPECIAL [ROOT_SD]

	yyvs16: SPECIAL [TWO_NAME_SD]
			-- Stack for semantic values of type TWO_NAME_SD

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [TWO_NAME_SD]
			-- Routines that ought to be in SPECIAL [TWO_NAME_SD]

	yyvs17: SPECIAL [DEPEND_SD]
			-- Stack for semantic values of type DEPEND_SD

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [DEPEND_SD]
			-- Routines that ought to be in SPECIAL [DEPEND_SD]

	yyvs18: SPECIAL [LACE_LIST [CLAS_VISI_SD]]
			-- Stack for semantic values of type LACE_LIST [CLAS_VISI_SD]

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: KL_SPECIAL_ROUTINES [LACE_LIST [CLAS_VISI_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [CLAS_VISI_SD]]

	yyvs19: SPECIAL [LACE_LIST [CLUST_ADAPT_SD]]
			-- Stack for semantic values of type LACE_LIST [CLUST_ADAPT_SD]

	yyvsc19: INTEGER
			-- Capacity of semantic value stack `yyvs19'

	yyvsp19: INTEGER
			-- Top of semantic value stack `yyvs19'

	yyspecial_routines19: KL_SPECIAL_ROUTINES [LACE_LIST [CLUST_ADAPT_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [CLUST_ADAPT_SD]]

	yyvs20: SPECIAL [LACE_LIST [CLUSTER_SD]]
			-- Stack for semantic values of type LACE_LIST [CLUSTER_SD]

	yyvsc20: INTEGER
			-- Capacity of semantic value stack `yyvs20'

	yyvsp20: INTEGER
			-- Top of semantic value stack `yyvs20'

	yyspecial_routines20: KL_SPECIAL_ROUTINES [LACE_LIST [CLUSTER_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [CLUSTER_SD]]

	yyvs21: SPECIAL [LACE_LIST [ASSEMBLY_SD]]
			-- Stack for semantic values of type LACE_LIST [ASSEMBLY_SD]

	yyvsc21: INTEGER
			-- Capacity of semantic value stack `yyvs21'

	yyvsp21: INTEGER
			-- Top of semantic value stack `yyvs21'

	yyspecial_routines21: KL_SPECIAL_ROUTINES [LACE_LIST [ASSEMBLY_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [ASSEMBLY_SD]]

	yyvs22: SPECIAL [LACE_LIST [D_OPTION_SD]]
			-- Stack for semantic values of type LACE_LIST [D_OPTION_SD]

	yyvsc22: INTEGER
			-- Capacity of semantic value stack `yyvs22'

	yyvsp22: INTEGER
			-- Top of semantic value stack `yyvs22'

	yyspecial_routines22: KL_SPECIAL_ROUTINES [LACE_LIST [D_OPTION_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [D_OPTION_SD]]

	yyvs23: SPECIAL [LACE_LIST [ID_SD]]
			-- Stack for semantic values of type LACE_LIST [ID_SD]

	yyvsc23: INTEGER
			-- Capacity of semantic value stack `yyvs23'

	yyvsp23: INTEGER
			-- Top of semantic value stack `yyvs23'

	yyspecial_routines23: KL_SPECIAL_ROUTINES [LACE_LIST [ID_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [ID_SD]]

	yyvs24: SPECIAL [FILE_NAME_SD]
			-- Stack for semantic values of type FILE_NAME_SD

	yyvsc24: INTEGER
			-- Capacity of semantic value stack `yyvs24'

	yyvsp24: INTEGER
			-- Top of semantic value stack `yyvs24'

	yyspecial_routines24: KL_SPECIAL_ROUTINES [FILE_NAME_SD]
			-- Routines that ought to be in SPECIAL [FILE_NAME_SD]

	yyvs25: SPECIAL [LACE_LIST [FILE_NAME_SD]]
			-- Stack for semantic values of type LACE_LIST [FILE_NAME_SD]

	yyvsc25: INTEGER
			-- Capacity of semantic value stack `yyvs25'

	yyvsp25: INTEGER
			-- Top of semantic value stack `yyvs25'

	yyspecial_routines25: KL_SPECIAL_ROUTINES [LACE_LIST [FILE_NAME_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [FILE_NAME_SD]]

	yyvs26: SPECIAL [LACE_LIST [LANG_TRIB_SD]]
			-- Stack for semantic values of type LACE_LIST [LANG_TRIB_SD]

	yyvsc26: INTEGER
			-- Capacity of semantic value stack `yyvs26'

	yyvsp26: INTEGER
			-- Top of semantic value stack `yyvs26'

	yyspecial_routines26: KL_SPECIAL_ROUTINES [LACE_LIST [LANG_TRIB_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [LANG_TRIB_SD]]

	yyvs27: SPECIAL [LACE_LIST [O_OPTION_SD]]
			-- Stack for semantic values of type LACE_LIST [O_OPTION_SD]

	yyvsc27: INTEGER
			-- Capacity of semantic value stack `yyvs27'

	yyvsp27: INTEGER
			-- Top of semantic value stack `yyvs27'

	yyspecial_routines27: KL_SPECIAL_ROUTINES [LACE_LIST [O_OPTION_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [O_OPTION_SD]]

	yyvs28: SPECIAL [LACE_LIST [TWO_NAME_SD]]
			-- Stack for semantic values of type LACE_LIST [TWO_NAME_SD]

	yyvsc28: INTEGER
			-- Capacity of semantic value stack `yyvs28'

	yyvsp28: INTEGER
			-- Top of semantic value stack `yyvs28'

	yyspecial_routines28: KL_SPECIAL_ROUTINES [LACE_LIST [TWO_NAME_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [TWO_NAME_SD]]

	yyvs29: SPECIAL [LACE_LIST [DEPEND_SD]]
			-- Stack for semantic values of type LACE_LIST [DEPEND_SD]

	yyvsc29: INTEGER
			-- Capacity of semantic value stack `yyvs29'

	yyvsp29: INTEGER
			-- Top of semantic value stack `yyvs29'

	yyspecial_routines29: KL_SPECIAL_ROUTINES [LACE_LIST [DEPEND_SD]]
			-- Routines that ought to be in SPECIAL [LACE_LIST [DEPEND_SD]]

feature {NONE} -- Constants

	yyFinal: INTEGER is 287
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 46
			-- Number of tokens

	yyLast: INTEGER is 472
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 300
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 119
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end -- class LACE_PARSER


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
