indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	DOC_HTML_COM

inherit

	MENU_SELEC

	ONCES

creation
	make

feature
	
	execute (a: ANY ) is
	do
			if cluster_window.entity/=Void then
			--	!! gener.make
				Windows.create_gene_window(2)
			end
	end

	gener : GENERATE_CLASSES_HTML

end -- class DOC_HTML_COM
