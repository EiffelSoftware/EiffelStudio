class SAMPLE_OBJECT_COMPARABLE inherit

	COMPARABLE

	SAMPLE_OBJECT
		undefine
			is_equal
		end

create

	make

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN is
			-- Is `Current' less than `other'?

		do
			Result := (item < other.item)
		end
		
end -- class SAMPLE_OBJECT_COMPARABLE
