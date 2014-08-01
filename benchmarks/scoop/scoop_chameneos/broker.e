class Broker

create make

feature
	n: Integer
	max: Integer
	current_cham: separate Chameneos
	current_c: Integer

	make(max_: Integer)
		do
			current_cham := Void
			max := max_
			n := 0
		end

	register_cham(c: Integer; cham: separate Chameneos): Boolean
		do
			if n <= max then
				if current_cham = Void then
					current_cham := cham
					current_c := c
					Result := False
				else
					Result := True
				end
			else
				Result := False
			end
		end

	clear: Boolean
		do
			current_cham := Void
			n := n + 1
			Result := True
		end
end

