note
	description: "Summary description for {PREDICATE_L}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class
	PREDICATE_L

feature

	fcmp_false: INTEGER_32 = 0
	fcmp_oeq: INTEGER_32 = 1
	fcmp_ogt: INTEGER_32 = 2
	fcmp_oge: INTEGER_32 = 3
	fcmp_olt: INTEGER_32 = 4
	fcmp_ole: INTEGER_32 = 5
	fcmp_one: INTEGER_32 = 6
	fcmp_ord: INTEGER_32 = 7
	fcmp_uno: INTEGER_32 = 8
	fcmp_ueq: INTEGER_32 = 9
	fcmp_ugt: INTEGER_32 = 10
	fcmp_uge: INTEGER_32 = 11
	fcmp_ult: INTEGER_32 = 12
	fcmp_ule: INTEGER_32 = 13
	fcmp_une: INTEGER_32 = 14
	fcmp_true: INTEGER_32 = 15
	first_fcmp_predicate: INTEGER_32 = 0
	last_fcmp_predicate: INTEGER_32 = 15
	bad_fcmp_predicate: INTEGER_32 = 16
	icmp_eq: INTEGER_32 = 32
	icmp_ne: INTEGER_32 = 33
	icmp_ugt: INTEGER_32 = 34
	icmp_uge: INTEGER_32 = 35
	icmp_ult: INTEGER_32 = 36
	icmp_ule: INTEGER_32 = 37
	icmp_sgt: INTEGER_32 = 38
	icmp_sge: INTEGER_32 = 39
	icmp_slt: INTEGER_32 = 40
	icmp_sle: INTEGER_32 = 41
	first_icmp_predicate: INTEGER_32 = 32
	last_icmp_predicate: INTEGER_32 = 41
	bad_icmp_predicate: INTEGER_32 = 42

end
