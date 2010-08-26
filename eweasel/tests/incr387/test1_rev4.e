
class TEST1 [G -> ANY create default_create end]
feature
	try
		do
		end
	
invariant
	valid: (agent: ANY do rescue retry end).item ([]) = Void
end

