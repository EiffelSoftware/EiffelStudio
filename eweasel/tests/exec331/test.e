
class TEST

create
	make

feature
	make
		do
		     print (once "Weasel"); io.new_line;
		     (agent do end).call ([])
		end

end

