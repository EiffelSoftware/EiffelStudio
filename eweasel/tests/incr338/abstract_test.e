
deferred class ABSTRACT_TEST

feature

	try
		local
			child: CHILD
		do
			child.cancel_actions.extend (agent child.do_something)
		end
			
end
