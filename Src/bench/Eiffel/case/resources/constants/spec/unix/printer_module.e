indexing
	description: "Class responsible to ensure the printing"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PRINTER_MODULE

inherit

	ONCES

	CONSTANTS

feature -- Operations

    initialize(win: TOP_SHELL)  is
        do
        end

    restore is
        do
        end

	print_text (text: TEXT; title: STRING) is
			-- Print a text
		do
		end

    print_from_file (file: PLAIN_TEXT_FILE; title: STRING) is
		do
        end

    print_graph_to_file ( cl : CLUSTER_DATA; fi : PLAIN_TEXT_FILE ) is
        do
        end



end -- class PRINTER_MODULE
