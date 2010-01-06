deferred class PARENT

feature	
	try
		local
		do
			(agent (a: ANY)
				local
					b: like f
				do
					b := f
					io.put_boolean (b ~ a)
				end ("STRING")).call (Void)
		end

	f: STRING

end
