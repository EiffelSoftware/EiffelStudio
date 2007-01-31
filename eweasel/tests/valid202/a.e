class A [G -> INTEGER_REF rename item as renamed_item end]
feature
	test (a_g: G)
		do
			print (a_g.renamed_item)
		end
end
