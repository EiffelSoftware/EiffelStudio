class SAMPLE_TRAVERSAL_ACTION2

inherit

    TRAVERSAL_ACTION
        rename
            normal_object_action as default_normal_object_action
        end

    TRAVERSAL_ACTION
        redefine
            normal_object_action
        select
            normal_object_action
        end

feature -- Action

    r : RANDOM is once create Result.make end

    normal_object_action (object: ANY; is_exp: BOOLEAN) is
        -- Perform action on object inspected
	local
    do   
        default_normal_object_action(object, TRUE)
        r.forth io.putstring(r.item.out)
    end


end -- class SAMPLE_TRAVERSAL_ACTION2


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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

