
class TEST1 [G -> detachable ANY]
feature
	try
		do
			print ((agent a).item ([])); io.new_line
		end

	a: G

end
