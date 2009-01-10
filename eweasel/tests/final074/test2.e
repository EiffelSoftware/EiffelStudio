
class TEST2

feature

        Weasel: STRING
                do
                        Result := "Weasel"
                end

	disable_sensitive
		do
			sensitive := False
		end

	sensitive: BOOLEAN
end
