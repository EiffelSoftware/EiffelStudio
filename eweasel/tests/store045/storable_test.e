class
	STORABLE_TEST

create
	make

feature

	make
		do
			r := agent print({STRING} ?)
			p := agent print({STRING} ?)
			f := agent func
			pr := agent pred
		end

	r: ROUTINE [STRING]
	p: PROCEDURE [STRING]
	f: FUNCTION [STRING, INTEGER]
	pr: PREDICATE [STRING]

	func (s: STRING): INTEGER
		do
			Result := 1
		end

	pred (s: STRING): BOOLEAN
		do
			Result := s.count > 0
		end

end
