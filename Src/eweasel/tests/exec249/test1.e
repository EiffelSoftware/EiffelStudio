deferred class TEST1

feature

	make is
		local
		do
			func := agent can_complete
			if is_editable and then func = Void then
				print ("Impossible%N")
			elseif is_editable and not is_completing and then func.item ([const, bool1, bool2, bool3]) then
				print ("Success%N")
			end
		end

	const: STRING is "string"

	is_completing: BOOLEAN is
		do
			Result := False
		end

	is_editable: BOOLEAN is
		do
			Result := True
		end

	bool1, bool2, bool3: BOOLEAN is
			--
		do
			Result := True
		end

	func: FUNCTION [ANY, TUPLE [STRING, BOOLEAN, BOOLEAN, BOOLEAN], BOOLEAN]

	can_complete (a_key: STRING; b1, b2, b3: BOOLEAN): BOOLEAN is
			--
		deferred
		end

end
