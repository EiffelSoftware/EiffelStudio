class ROSE_DATE

inherit

	MISMATCH_CORRECTOR
		redefine
			correct_mismatch
		end

feature

	foo: STRING

	bar: STRING

	correct_mismatch
		do
			if 1 = 1 then
--				print ("sss ROSE_DATE%N")
			end
		end

end
