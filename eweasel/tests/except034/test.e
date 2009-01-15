

class TEST
inherit
	EXCEPTIONS
	EXCEPTION_MANAGER
		rename
			catch as mgr_catch,
			raise as mgr_raise,
			ignore as mgr_ignore
		export
			{NONE} all
		end

create
	make

feature

	make
		do
			print ("Last exception is Void = " + (last_exception = Void).out); io.new_line
			test_precondition_violation
			show_exception ("Main routine", Precondition_violation)
			print ("Last exception is Void = " + (last_exception = Void).out); io.new_line
		end

	test_precondition_violation
		local
			tried: BOOLEAN
		do
			if not tried then
				violate_precondition
			end
		rescue
			tried := True
			retry
		end

	violate_precondition
		require
			weasel: False
		do
		end

feature {NONE} -- Implementation

	show_exception (where, s: STRING)
		do
			print (s); print (" (" + where + ")%N")
			print ("assertion_violation: " + assertion_violation.out + "%N")
			print ("is_signal: " + is_signal.out + "%N")
			print ("is_system_exception: " + is_system_exception.out + "%N")
			print ("is_developer_exception: " + is_developer_exception.out + "%N")
			print ("developer_exception_name: "); 
			if is_developer_exception then
				print (developer_exception_name)
			end
			print ("%N")
			
			print ("exception: " + exception.out + "%N")
			print ("tag_name: "); print (tag_name); print ("%N")
			print ("recipient_name: "); print (recipient_name); print ("%N")
			print ("class_name: "); print (class_name); print ("%N")
			print ("meaning: "); print (meaning (exception)); print ("%N")
			
			print ("original_exception: " + original_exception.out + "%N")
			print ("original_tag_name: "); print (original_tag_name); print ("%N")
			print ("original_recipient_name: "); print (original_recipient_name); print ("%N")
			print ("original_class_name: "); print (original_class_name); print ("%N")
			print ("original_meaning: "); print (meaning (original_exception)); print ("%N")
		end

	Precondition_violation: STRING = "Precondition Violation"

end
