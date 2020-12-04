note
    description: "Days of the week with predefine messages."

once class
    WEEK_DAYS

create
    Sunday,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday

feature {NONE} -- Creation

    Sunday once greeting := "Funday Sunday"; is_weekend := True end
    Monday once greeting := "Ok Monday let's do this" end
    Tuesday once greeting := "To much Tuesday, not enough coffee" end
    Wednesday once greeting := "Wednesday is like small Friday" end
    Thursday once greeting := "Try it Thursday" end
    Friday once greeting := "Oh Friday let me hug you" end
    Saturday once Sunday end

feature -- Access

    instances: ITERABLE [WEEK_DAYS]
            -- All known days of the week.
        once
            Result := <<
                {WEEK_DAYS}.Sunday,
                {WEEK_DAYS}.Monday,
                {WEEK_DAYS}.Tuesday,
                {WEEK_DAYS}.Wednesday,
                {WEEK_DAYS}.Thursday,
                {WEEK_DAYS}.Friday,
                {WEEK_DAYS}.Saturday
                >>
        ensure
            instance_free: class
        end

feature -- Access

    greeting: STRING

    is_weekend: BOOLEAN

feature -- Access

    name: STRING
        do
            Result :=
                inspect Current
                when {WEEK_DAYS}.Sunday then
                    "Sunday"
                when {WEEK_DAYS}.Monday then
                    "Monday"
                when {WEEK_DAYS}.Tuesday then
                    "Tuesday"
                when {WEEK_DAYS}.Wednesday then
                    "Wednesday"
                when {WEEK_DAYS}.Thursday then
                    "Thursday"
                when {WEEK_DAYS}.Friday then
                    "Friday"
                when {WEEK_DAYS}.Saturday then
                    "Saturday"
                else
                    "Unkown"
                end
        end

end