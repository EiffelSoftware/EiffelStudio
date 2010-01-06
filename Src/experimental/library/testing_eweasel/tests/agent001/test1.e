class TEST1

create
	make

feature

	make (q: like query) is
		do
			query := q
			query.call (Void)
		end

	query: FUNCTION [ANY, TUPLE, ANY]

end
