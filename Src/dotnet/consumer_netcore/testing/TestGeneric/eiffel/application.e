note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			b: BAR
			obj: ANY
		do
			create b.make (321)
			print ("BarOuch")
			obj := "BarOuch"
			test_bargen_t (b)
			test_bargen_tu (b)
			test_bargen_t_str_u (b)
			test_bargen_rt_t (b)

			obj := b.barnogen ("NoGEN")

			if False then
				test_attempted
			end
		end

	test_bargen_t (b: BAR)
		local
			obj: ANY
		do
			obj := b.bargen_t ("Bar")
			obj := b.bargen_t ("Ouch")
			obj := b.bargen_t (101)
			obj := b.bargen_t (True)
			print (b.bargen_t ("BarOuch"))
		end

	test_bargen_tu (b: BAR)
		local
			obj: ANY
		do
			obj := b.bargen_tu ("arg", 321)
			obj := b.bargen_tu (123, "str")
			print (b.bargen_tu (123, "str"))
		end

	test_bargen_t_str_u (b: BAR)
		local
			obj: ANY
		do
			obj := b.bargen_t_str_u (123, "arg2", "arg3")
			obj := b.bargen_t_str_u ("arg1", "arg2", Current)
			print (b.bargen_t_str_u (123, "arg2", "arg3"))
		end

	test_bargen_rt_t (b: BAR)
		local
			obj: ANY
		do
			----obj := b.bargen_rt_t ("string-value")
			obj := b.bargen_rt_t ("string-value")
			print (obj)
		end

	test_attempted
		local
			s: STRING_32
		do
			s := {STRING_32} / "abc"
			s := {STRING_32} / Current
		end


end
