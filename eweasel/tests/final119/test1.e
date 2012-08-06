deferred class TEST1
feature
	make
		do
			create center
		end

	is_center_valid: BOOLEAN

	x: INTEGER
		do
			if not is_center_valid then
				set_center
			end
			Result := center.x
		end

	set_center
		deferred
		ensure
			center_valid: is_center_valid
		end

	center: CENTER
	
invariant
	center_exists: center /= Void
	set: x = center.x

end
