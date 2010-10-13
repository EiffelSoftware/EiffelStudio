note
	description: "Summary description for {CONC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONC

create
	make

feature

	x : attached separate S
	y : attached separate S

	make (a_x, a_y : attached separate S)
		do
			x := a_x
			y := a_y
		end

	f
		do
			g (x)
		end

	g (a_x : attached separate S)
		do
			busy
			h (y)
		end

	h (a_y : attached separate S)
		do
		end

	busy
		do
			print ("Busy start")
			(create {EXECUTION_ENVIRONMENT}).sleep (100*1000*1000)
			print ("Busy end")
		end
end
