indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	INTEGER_GENERATOR_WINDOWS

creation
        make

feature -- Initialization

        make (a_minimum,a_maximum: INTEGER) is
			-- Make the generator.
                do
                        minimum := a_minimum
                        maximum := a_maximum
                        value := minimum
                ensure
                        minimum_set: minimum = a_minimum
                        maximum_set: maximum = a_maximum
                        value_is_minimum: value = minimum
                end

feature -- Access

        maximum: INTEGER
                    -- Largest possible value for generator

        minimum: INTEGER
                    -- Smallest possible value for generator

        value: INTEGER
                    -- Current value of generator

feature -- Status setting

        next is
                do
                        value := value + 1
                        if value > maximum then value := minimum end
                ensure
                        old value = maximum implies value = minimum
                        old value /= maximum implies value = old value + 1
                end

        reset is
                do
                        value := minimum
                ensure
                        value = minimum
                end

        set_value (a_value: INTEGER) is
                require
                        in_range: minimum <= a_value and then a_value <= maximum
                do
                        value := a_value
                ensure
                        value = a_value
                end

invariant

        minimal: minimum <= value
        maximal: value <= maximum

end -- class INTEGER_GENERATOR


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

