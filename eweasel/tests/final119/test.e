
class TEST
create
	make
feature
	make
		do
			create center
			Current.do_nothing
		end

	x: INTEGER
		do
			print ("x in TEST%N")
			center.set_x (1)
			Result := center.x
		end

	center: CENTER
	
invariant
	set: x = center.x

end
