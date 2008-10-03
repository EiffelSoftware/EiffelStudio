class
	TEST1 [G]

feature

	foundation_widget: !G
		do
		ensure
			result_attached: Result /= Void
			result_consistent: Result = foundation_widget
		end

	execute
        local
            l_widget: like foundation_widget
        do
        	l_widget := foundation_widget
		rescue
			if l_widget /= Void then
				l_widget.do_nothing
			end
		end

end
