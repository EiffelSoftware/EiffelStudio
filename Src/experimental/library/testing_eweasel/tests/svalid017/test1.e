
class TEST1

feature

	Weasel: PARENT

invariant
	valid: ((create {like Weasel}.make).value) = 47

end
