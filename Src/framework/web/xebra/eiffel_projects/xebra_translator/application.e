note
	description : "xebra_translator application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization


	make
			-- Run application.
		do
			create translator.make
			print ("%N+++++++++++++++++++ START TRANSLATOR+++++++++++++++++++%N")
			print (translator.process ("../../websites/small_test.html"))
			print ("%N+++++++++++++++++++ END TRANSLATOR++++++++++++++++++++++++++++++++++++++%N")
		end


feature -- Access

	translator: XB_TRANSLATOR





end
