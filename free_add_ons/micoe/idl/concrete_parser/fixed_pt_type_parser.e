indexing

description: "Parses production <fixed_pt_type>(96[2.3])";
keywords: "fixed_pt_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FIXED_PT_TYPE_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : FIXED_PT_TYPE

    parse (scan : SCANNER) is

        do
            create value

            scan.advance -- Eat the "fixed"

            if scan.token /= Left_angle then
                error (<<"Expecting a '<'">>)
            end
            scan.advance -- Eat the '<'

            if scan.token /= Integer_literal then
                error (<<"Expecting a positive integer constant">>)
            elseif scan.integer_value <= 0 then
                error (<<"The number of digits must be positive">>)
            else
                value.set_digits (scan.integer_value)
                scan.advance -- Eat the constant
            end -- if scan.token /= Integer_literal then ...

            if scan.token /= Comma then
                error (<<"Expecting a `,'">>)
            else
                scan.advance -- Eat the ','
            end

            if scan.token /= Integer_literal then
                error (<<"Expecting an integer constant">>)
            else
                value.set_scale (scan.integer_value)
                scan.advance -- Eat the constant
            end

            if scan.token /= Right_angle then
                error (<<"Expecting a '>'">>)
            else
                scan.advance -- Eat the '>'
            end
        end

end -- class FIXED_PT_TYPE_PARSER



