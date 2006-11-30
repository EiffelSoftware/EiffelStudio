expanded class EXPANDED_NAME

inherit

	ANY
		redefine
			copy,
			default_create,
			is_equal
		end

feature

	s: STRING
	i: INTEGER

	set (n: like s) is
		require
			n_attached: n /= Void
		do
			s := n
			i := 1 
		end

	copy (other: like Current) is
			-- Redefined 'copy' feature, which would be called by the 'twin'.
		do
			s := other.s.twin
			i := other.i
		end

	is_equal (other: like Current): BOOLEAN is
			-- Redefined equality feature, which should be called when two 
			-- EXPANDED_NAME objects are compared by "=".
		do
			Result := s.is_equal (other.s) and then i = other.i
		end

	default_create is 
			-- Initialize new object.
		do
			create s.make_empty
		end

end
